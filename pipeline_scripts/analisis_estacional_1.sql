-- ANÁLISIS ESTACIONAL DE CALENDARIO
-- Este script analiza cómo el calendario afecta el rendimiento de los equipos
-- y la ventaja de jugar en casa a lo largo de la temporada.

-- CONSULTA 1: Ventaja local por día de la semana
-- Analiza si el equipo local gana más dependiendo del día que juega.
-- Incluye un ranking de mayor a menor ventaja local por día.

SELECT 
    day_of_week,                    -- día de la semana
    COUNT(*) AS total_partidos,     -- total de partidos jugados ese día
    COUNT(CASE 
        WHEN winner_id = home_team_id  -- si el ganador es el equipo local
        THEN 1 END) AS victorias_local, -- cuenta 1, si no no cuenta nada
    ROUND(
        COUNT(CASE WHEN winner_id = home_team_id THEN 1 END) * 100.0 
        / COUNT(*), 2               -- divide victorias locales entre total * 100
    ) AS porcentaje_victoria_local,
    RANK() OVER (                   -- función de ventana: asigna un ranking
        ORDER BY COUNT(CASE WHEN winner_id = home_team_id THEN 1 END) 
        * 100.0 / COUNT(*) DESC     -- ordena de mayor a menor porcentaje
    ) AS ranking
FROM game
WHERE is_tie = FALSE                -- ignora los empates
GROUP BY day_of_week                -- agrupa por día
ORDER BY ranking;                   -- muestra de mayor a menor ventaja local


-- CONSULTA 2: Promedio de puntos anotados por semana
-- Analiza si hay semanas donde consistentemente se anota más en toda la liga.
-- Incluye playoffs para comparar contra la temporada regular.

SELECT 
    week,                           -- número o nombre de la semana
    ROUND(AVG(
        gs.pts_win + gs.pts_loss    -- suma puntos de ambos equipos por partido
    ), 2) AS promedio_puntos_partido, -- promedio de todos los partidos esa semana
    RANK() OVER (                   -- función de ventana: asigna ranking
        ORDER BY AVG(gs.pts_win + gs.pts_loss) DESC -- de más a menos puntos
    ) AS ranking_puntos
FROM game g
JOIN gamestats gs ON gs.game_id = g.id  -- conecta game con sus estadísticas
GROUP BY week                       -- agrupa por semana
ORDER BY CASE 
    WHEN week ~ '^\d+$'             -- si la semana es un número
    THEN week::INT                  -- conviértelo a entero para ordenar bien
    ELSE 99                         -- si es texto (WildCard, SuperBowl) va al final
END;


-- CONSULTA 3: Ventaja local por semana de la temporada
-- Analiza si la ventaja de jugar en casa cambia según el momento de la temporada.
-- Incluye playoffs para ver si la ventaja local se mantiene en juegos eliminatorios.

SELECT 
    week,                           -- número o nombre de la semana
    COUNT(*) AS total_partidos,     -- total de partidos esa semana
    COUNT(CASE 
        WHEN winner_id = home_team_id  -- si ganó el equipo local
        THEN 1 END) AS victorias_local,
    ROUND(
        COUNT(CASE WHEN winner_id = home_team_id THEN 1 END) * 100.0 
        / COUNT(*), 2               -- porcentaje de victorias locales
    ) AS porcentaje_victoria_local,
    RANK() OVER (                   -- función de ventana: ranking por semana
        ORDER BY COUNT(CASE WHEN winner_id = home_team_id THEN 1 END) 
        * 100.0 / COUNT(*) DESC     -- de mayor a menor ventaja local
    ) AS ranking
FROM game
WHERE is_tie = FALSE                -- ignora empates
GROUP BY week                       -- agrupa por semana
ORDER BY CASE 
    WHEN week ~ '^\d+$'             -- si es número ordena como entero
    THEN week::INT 
    ELSE 99                         -- playoffs van al final
END;
