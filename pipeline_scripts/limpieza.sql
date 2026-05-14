--LIMPIEZA - estandarizar weekly_attendance
--Quitar NAs en weekly_attendance
DELETE FROM raw.attendance
    WHERE weekly_attendance LIKE 'NA';
--Crear columna con el tipo de dato correcto, poblarla, borrar la anterior y renombrar la nueva
ALTER TABLE raw.attendance ADD COLUMN weekly_att_temp BIGINT;
UPDATE raw.attendance SET weekly_att_temp = CAST(weekly_attendance AS BIGINT);

ALTER TABLE raw.attendance DROP COLUMN weekly_attendance;
ALTER TABLE raw.attendance RENAME weekly_att_temp TO weekly_attendance;

--LIMPIEZA - revisar coherencia de los datos
-- Ver NULLs en asistencia
SELECT COUNT(*) FROM raw.attendance WHERE weekly_attendance IS NULL;
-- Ver asistencias negativas o cero
SELECT * FROM raw.attendance WHERE weekly_attendance <= 0;
SELECT * FROM raw.attendance WHERE home <= 0 OR away <= 0 OR total <= 0;
-- Ver puntos negativos
SELECT * FROM raw.games WHERE pts_win < 0 OR pts_loss < 0;
-- Ver años inválidos
SELECT DISTINCT year FROM raw.attendance WHERE year < 1920 OR year > 2025;
SELECT DISTINCT year FROM raw.games WHERE year < 1920 OR year > 2025;
-- Ver partidos donde home = away
SELECT * FROM raw.games WHERE home_team_name = away_team_name;
