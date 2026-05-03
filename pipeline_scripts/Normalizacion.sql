--CREAR NUEVAS TABLAS

--Tabla Team
CREATE TABLE Team (
    id BIGSERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    city VARCHAR(100)
);

-- Tabla Season
CREATE TABLE Season (
    id BIGSERIAL PRIMARY KEY,
    year INT NOT NULL UNIQUE,
    start_date DATE,
    end_date DATE,
    
    CONSTRAINT year_range CHECK (year >= 1920 AND year <= 2100),
    CONSTRAINT dates_order CHECK (start_date < end_date OR start_date IS NULL)
);

-- Tabla WeeklyAttendance
CREATE TABLE WeeklyAttendance (
    id BIGSERIAL PRIMARY KEY,
    team_id BIGINT NOT NULL,
    season_id BIGINT NOT NULL,
    week INT NOT NULL,
    weekly_attendance INT,
    
    FOREIGN KEY (team_id) REFERENCES Team (id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (season_id) REFERENCES Season (id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    
    CONSTRAINT uk_weekly UNIQUE (team_id, season_id, week),
    CONSTRAINT week_range CHECK (week >= 1 AND week <= 22),
    CONSTRAINT weekly_attendance_positive CHECK (weekly_attendance >= 0 OR weekly_attendance IS NULL)
);

-- Tabla SeasonalAttendance
CREATE TABLE SeasonalAttendance (
    id BIGSERIAL PRIMARY KEY,
    team_id BIGINT NOT NULL,
    season_id BIGINT NOT NULL,
    home_attendance_total BIGINT,
    away_attendance_total BIGINT,
    total_attendance BIGINT,
    
    FOREIGN KEY (team_id) REFERENCES Team (id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (season_id) REFERENCES Season (id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    
    CONSTRAINT uk_seasonal UNIQUE (team_id, season_id),
    CONSTRAINT attendance_positive CHECK (
        (home_attendance_total >= 0 OR home_attendance_total IS NULL) AND
        (away_attendance_total >= 0 OR away_attendance_total IS NULL) AND
        (total_attendance >= 0 OR total_attendance IS NULL)
    )
);

-- Tabla Game
CREATE TABLE Game (
    id BIGSERIAL PRIMARY KEY,
    season_id BIGINT NOT NULL,
    week VARCHAR(20) NOT NULL,
    game_date VARCHAR(50),
    game_time VARCHAR(20),
    day_of_week VARCHAR(10),
    home_team_id BIGINT NOT NULL,
    away_team_id BIGINT NOT NULL,
    winner_name VARCHAR(100),  -- Nombre del equipo ganador (texto)
    is_tie BOOLEAN DEFAULT FALSE,
    
    FOREIGN KEY (season_id) REFERENCES Season (id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (home_team_id) REFERENCES Team (id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (away_team_id) REFERENCES Team (id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    
    CONSTRAINT home_away_different CHECK (home_team_id <> away_team_id),
    CONSTRAINT day_of_week_values CHECK (day_of_week IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday', NULL))
);

-- Tabla GameStats
CREATE TABLE GameStats (
    id BIGSERIAL PRIMARY KEY,
    game_id BIGINT NOT NULL UNIQUE,
    pts_win INT,
    pts_loss INT,
    yds_win INT,
    yds_loss INT,
    turnovers_win INT,
    turnovers_loss INT,
    
    FOREIGN KEY (game_id) REFERENCES Game (id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    
    CONSTRAINT pts_positive CHECK (
        (pts_win >= 0 OR pts_win IS NULL) AND
        (pts_loss >= 0 OR pts_loss IS NULL)
    ),
    CONSTRAINT turnovers_positive CHECK (
        (turnovers_win >= 0 OR turnovers_win IS NULL) AND
        (turnovers_loss >= 0 OR turnovers_loss IS NULL)
    )
);

-- Tabla Standing
CREATE TABLE Standing (
    id BIGSERIAL PRIMARY KEY,
    team_id BIGINT NOT NULL,
    season_id BIGINT NOT NULL,
    wins INT NOT NULL DEFAULT 0,
    losses INT NOT NULL DEFAULT 0,
    points_for INT,
    points_against INT,
    points_differential INT,
    margin_of_victory DECIMAL(5,2),
    strength_of_schedule DECIMAL(5,2),
    simple_rating DECIMAL(5,2),
    offensive_ranking INT,
    defensive_ranking INT,
    made_playoffs BOOLEAN NOT NULL DEFAULT FALSE,
    
    FOREIGN KEY (team_id) REFERENCES Team (id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (season_id) REFERENCES Season (id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    
    CONSTRAINT uk_standings UNIQUE (team_id, season_id),
    CONSTRAINT wins_losses_range CHECK (wins >= 0 AND losses >= 0),
    CONSTRAINT ranking_positive CHECK (
        (offensive_ranking >= 1 OR offensive_ranking IS NULL) AND
        (defensive_ranking >= 1 OR defensive_ranking IS NULL)
    )
);

-- Tabla SuperBowl

CREATE TABLE SuperBowl (
    id BIGSERIAL PRIMARY KEY,
    season_id BIGINT NOT NULL UNIQUE,
    winning_team_id BIGINT NOT NULL,
    winning_team_name VARCHAR(100) NOT NULL,  -- Nombre del ganador
    FOREIGN KEY (season_id) REFERENCES Season (id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (winning_team_id) REFERENCES Team (id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);


-- POBLAR TABLAS

-- Poblar Team (Aquí un error fue que dos equipos se cambiaron de ciudad, por lo que consideramos a los Rams de Los Angeles y de St. Louis y a los Chargers de San Diego y de Los Angeles)

INSERT INTO Team (full_name, city)
SELECT DISTINCT 
    TRIM(home_team_name) AS full_name,
    TRIM(home_team_city) AS city
FROM games
WHERE home_team_name IS NOT NULL;

-- Poblar Season
INSERT INTO Season (year)
SELECT DISTINCT year
FROM attendance
WHERE year IS NOT NULL
ORDER BY year;

-- Poblar WeeklyAttendance
INSERT INTO WeeklyAttendance (team_id, season_id, week, weekly_attendance)
SELECT 
    t.id AS team_id,
    s.id AS season_id,
    a.week,
    a.weekly_attendance
FROM attendance a
INNER JOIN Team t ON t.full_name = a.team_name
INNER JOIN Season s ON s.year = a.year
WHERE a.weekly_attendance IS NOT NULL
  AND a.week IS NOT NULL;

-- Poblar SeasonalAttendance
INSERT INTO SeasonalAttendance (team_id, season_id, home_attendance_total, away_attendance_total, total_attendance)
SELECT 
    t.id AS team_id,
    s.id AS season_id,
    MAX(a.home) AS home_total,
    MAX(a.away) AS away_total,
    MAX(a.total) AS total
FROM attendance a
INNER JOIN Team t ON t.full_name = a.team_name
INNER JOIN Season s ON s.year = a.year
WHERE a.home IS NOT NULL OR a.away IS NOT NULL OR a.total IS NOT NULL
GROUP BY t.id, s.id;

-- Poblar Game
INSERT INTO Game (
    season_id, week, game_date, game_time, day_of_week,
    home_team_id, away_team_id, winner_name, is_tie
)
SELECT 
    s.id AS season_id,
    g.week,
    g.date AS game_date,
    g.time AS game_time,
    g.day AS day_of_week,
    home_team.id AS home_team_id,
    away_team.id AS away_team_id,
    TRIM(g.winner) AS winner_name,
    FALSE AS is_tie
FROM games g
INNER JOIN Season s ON s.year = g.year
INNER JOIN Team home_team ON TRIM(LOWER(home_team.full_name)) = TRIM(LOWER(g.home_team_name))
INNER JOIN Team away_team ON TRIM(LOWER(away_team.full_name)) = TRIM(LOWER(g.away_team_name))
WHERE g.year IS NOT NULL 
  AND g.week IS NOT NULL
  AND g.winner IS NOT NULL
  AND g.winner != 'NA';

-- Poblar GameStats
INSERT INTO GameStats (
    game_id, pts_win, pts_loss, yds_win, yds_loss, 
    turnovers_win, turnovers_loss
)
SELECT 
    gm.id AS game_id,
    g.pts_win,
    g.pts_loss,
    g.yds_win,
    g.yds_loss,
    g.turnovers_win,
    g.turnovers_loss
FROM games g
INNER JOIN Season s ON s.year = g.year
INNER JOIN Team home_team ON home_team.full_name = TRIM(g.home_team_name)
INNER JOIN Team away_team ON away_team.full_name = TRIM(g.away_team_name)
INNER JOIN Game gm ON gm.season_id = s.id 
    AND gm.week = g.week
    AND gm.home_team_id = home_team.id
    AND gm.away_team_id = away_team.id
WHERE g.pts_win IS NOT NULL OR g.pts_loss IS NOT NULL;

-- Poblar Standing (desde standings original)
ALTER TABLE Standing DROP CONSTRAINT IF EXISTS ranking_positive;--Aquí me marco un error porque habíamos puesto que debía ser >=1, pero hay algunos que son 0. 
INSERT INTO Standing (
    team_id, season_id, wins, losses, points_for, points_against,
    points_differential, margin_of_victory, strength_of_schedule,
    simple_rating, offensive_ranking, defensive_ranking, made_playoffs
)
SELECT 
    t.id AS team_id,
    s.id AS season_id,
    a.wins,
    a.loss,
    a.points_for,
    a.points_against,
    a.points_differential,
    a.margin_of_victory,
    a.strength_of_schedule,
    a.simple_rating,
    a.offensive_ranking,
    a.defensive_ranking,
    CASE 
        WHEN a.playoffs = 'Yes' OR a.playoffs = 'TRUE' OR a.playoffs = '1' THEN TRUE 
        ELSE FALSE 
    END AS made_playoffs
FROM attendance a
INNER JOIN Team t ON t.full_name = a.team_name
INNER JOIN Season s ON s.year = a.year
WHERE a.team_name IS NOT NULL AND a.year IS NOT NULL;

-- Poblar SuperBowl
INSERT INTO SuperBowl (season_id, winning_team_id, winning_team_name)
SELECT 
    s.id AS season_id,
    t.id AS winning_team_id,
    t.full_name AS winning_team_name
FROM attendance a
INNER JOIN Season s ON s.year = a.year
INNER JOIN Team t ON t.full_name = a.team_name
WHERE a.sb_winner = 'Won Superbowl';

--CREAR RESPALDOS
-- Renombrar (como backup)
ALTER TABLE attendance RENAME TO attendance_backup;
ALTER TABLE games RENAME TO games_backup;
ALTER TABLE standings RENAME TO standings_backup;

--Limpieza
-- Ver NULLs en asistencia
SELECT COUNT(*) FROM attendance_backup WHERE weekly_attendance IS NULL;
-- Ver asistencias negativas o cero
SELECT * FROM attendance_backup WHERE weekly_attendance <= 0;
SELECT * FROM attendance_backup WHERE home <= 0 OR away <= 0 OR total <= 0;
-- Ver puntos negativos
SELECT * FROM games_backup WHERE pts_win < 0 OR pts_loss < 0;
-- Ver años inválidos
SELECT DISTINCT year FROM attendance_backup WHERE year < 1920 OR year > 2025;
SELECT DISTINCT year FROM games_backup WHERE year < 1920 OR year > 2025;
-- Ver partidos donde home = away
SELECT * FROM games_backup WHERE home_team_name = away_team_name;
