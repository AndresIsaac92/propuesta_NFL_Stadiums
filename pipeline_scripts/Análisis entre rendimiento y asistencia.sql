-- 1. Asistencia local promedio por rango de victorias en la temporada
-- Agrupa equipos por su rendimiento (victorias) y calcula asistencia promedio

WITH team_season_performance AS (
    SELECT 
        st.team_id,
        st.season_id,
        st.wins,
        CASE 
            WHEN st.wins <= 4 THEN 'Malo (0-4 wins)'
            WHEN st.wins <= 8 THEN 'Regular (5-8 wins)'
            WHEN st.wins <= 12 THEN 'Bueno (9-12 wins)'
            ELSE 'Excelente (13+ wins)'
        END AS performance_group
    FROM Standing st
),
attendance_by_performance AS (
    SELECT 
        tsp.performance_group,
        AVG(wa.weekly_attendance) AS avg_attendance,
        COUNT(*) AS n_games
    FROM WeeklyAttendance wa
    JOIN team_season_performance tsp ON tsp.team_id = wa.team_id AND tsp.season_id = wa.season_id
    WHERE wa.weekly_attendance IS NOT NULL
    GROUP BY tsp.performance_group
)
SELECT 
    performance_group,
    ROUND(avg_attendance, 0) AS avg_attendance,
    n_games
FROM attendance_by_performance
ORDER BY 
    CASE performance_group
        WHEN 'Malo (0-4 wins)' THEN 1
        WHEN 'Regular (5-8 wins)' THEN 2
        WHEN 'Bueno (9-12 wins)' THEN 3
        WHEN 'Excelente (13+ wins)' THEN 4
    END;

-- 2. Asistencia de local promedio vs victorias en la temporada (por equipo-año)
-- Relación directa: ¿Los equipos con más victorias atraen más público?

SELECT 
    t.full_name,
    s.year,
    st.wins,
    sa.home_attendance_total,
    RANK() OVER (ORDER BY st.wins DESC) AS wins_rank,
    RANK() OVER (ORDER BY sa.home_attendance_total DESC) AS attendance_rank
FROM SeasonalAttendance sa
JOIN Standing st ON st.team_id = sa.team_id AND st.season_id = sa.season_id
JOIN Team t ON t.id = sa.team_id
JOIN Season s ON s.id = sa.season_id
WHERE sa.home_attendance_total IS NOT NULL
ORDER BY s.year, st.wins DESC;

