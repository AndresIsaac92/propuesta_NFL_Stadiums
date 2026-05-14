-- -------------------------------------------------------------
-- TablePlus 6.8.2(656)
--
-- https://tableplus.com/
--
-- Database: nfl
-- Generation Time: 2026-04-30 11:22:15.2150
-- -------------------------------------------------------------
--Creación del esquema
DROP SCHEMA IF EXISTS raw CASCADE;
CREATE SCHEMA IF NOT EXISTS raw;

--Creamos las tablas
DROP TABLE IF EXISTS raw.attendance;
CREATE TABLE raw.attendance (
    team varchar(100),
    team_name varchar(100),
    "year" int2,
    total int8,
    home int4,
    away int4,
    week int4,
    weekly_attendance varchar(12)
);

DROP TABLE IF EXISTS raw.games;
CREATE TABLE raw.games (
    "year" int4,
    week varchar(10),
    home_team varchar(100),
    away_team varchar(100),
    winner varchar(100),
    tie varchar(100),
    "day" varchar(20),
    date varchar(20),
    time varchar(20),
    pts_win numeric(10,2),
    pts_loss numeric(10,2),
    yds_win numeric(10,2),
    turnovers_win numeric(10,2),
    yds_loss numeric(10,2),
    turnovers_loss numeric(10,2),
    home_team_name varchar(100),
    home_team_city varchar(100),
    away_team_name varchar(100),
    away_team_city varchar(100)
);

DROP TABLE IF EXISTS raw.standings;
CREATE TABLE raw.standings (
    team varchar(100),
    team_name varchar(100),
    "year" int4,
    wins numeric(10,2),
    loss numeric(10,2),
    points_for numeric(10,2),
    points_against numeric(10,2),
    points_differential numeric(10,2),
    margin_of_victory numeric(10,2),
    strength_of_schedule numeric(10,2),
    simple_rating numeric(10,2),
    offensive_ranking numeric(10,2),
    defensive_ranking numeric(10,2),
    playoffs varchar(50),
    sb_winner varchar(50)
);

--Cargamos los datos de los CSV
\COPY raw.attendance (team, team_name, year, total, home, away, week, weekly_attendance) FROM './data/attendance.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');
\COPY raw.games (year, week, home_team, away_team, winner, tie, day, date, time, pts_win, pts_loss, yds_win, turnovers_win, yds_loss, turnovers_loss, home_team_name, home_team_city, away_team_name, away_team_city) FROM './data/games.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');
\COPY raw.standings (team, team_name, year, wins, loss, points_for, points_against, points_differential, margin_of_victory, strength_of_schedule, simple_rating, offensive_ranking, defensive_ranking, playoffs, sb_winner) FROM './data/standings.csv' WITH (FORMAT CSV, HEADER true, DELIMITER ',');


--ANALISIS PRELIMINAR
--No. de tuplas
SELECT COUNT(*)
FROM raw.attendance;

SELECT COUNT(*)
FROM raw.games;

SELECT COUNT(*)
FROM raw.standings;

--No. de valores nulos
SELECT COUNT(*)
FROM raw.attendance
WHERE weekly_attendance LIKE 'NA';

SELECT COUNT(*)
FROM raw.standings
WHERE wins IS NULL OR loss IS NULL OR points_for IS NULL OR points_against IS NULL OR points_differential IS NULL OR margin_of_victory IS NULL OR strength_of_schedule IS NULL OR simple_rating IS NULL OR offensive_ranking IS NULL OR defensive_ranking IS NULL;

--mínimos, maximos y promedios
--puntos a favor, en contra, y diferencia
SELECT MIN(points_for) AS min_points_for,
       AVG(points_for) AS avg_points_for,
       MAX(points_for) AS max_points_for,
       MIN(points_against) AS min_points_against,
       AVG(points_against) AS avg_points_against,
       MAX(points_against) AS max_points_against,
       MIN(points_differential) AS min_points_diff,
       AVG(points_differential) AS avg_points_diff,
       MAX(points_differential) AS max_points_diff
FROM raw.standings;
