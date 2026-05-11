[ERD_nfl.pdf](https://github.com/user-attachments/files/27613637/ERD_nfl.pdf)

# Tablas normlaizadas 

## Tabla staging (attendance)
Dividimos la tabla staging en 3 tablas para eliminar dependencias parciales y multivaluadas. Originalmente para un mismo equipo y año, existían múltiples semanas y múltiples registros de asistencia que no dependían entre sí, lo que violaba la 4NF. Al separar {team, year} de los registros semanales, se eliminó la duplicidad masiva de datos. Además, aislamos la relación {team_name} → {team} para evitar que la ciudad de un equipo se repitiera innecesariamente en cada fila de asistencia normalizando la entidad del equipo. 

## Tabla Games
Cambiamos la tabla games principalmente por las dependencias funcionales parciales y transitivas. Los nombres y ciudades de los equipos dependían de los IDs de los equipos y no del game_id en sí mismo. Al aplicar la normalización, lo que hicimos fue extraer el nombre y la ciudad del equipo en la tabla Team, dejando 2 tablas, una de Games, con los resultados del partido, y otra GameStats con las estadísticas del partido.

## Tabla Standings
La tabla de standings tenía una dependencia transitiva. El ganador del Super Bowl dependía únicmanete del año {year} → {sb_winner}, por lo cual, separamos estos datos en otra tabla, para evitar inconsistencias. Al igual que en otras tablas, el nombre y la ciudad del equipo s emovieron a otra tabla. 


### Tabla Team

| **Team**            | **Descripción**                      | **Tipo** |
|---------------------|--------------------------------------|----------|
| `id`                | id del equipo                        | numérico |  
| `name`              | Nombre del equipo                    | texto    |
| `city`              | Nombre de la ciudad                  | texto    |
| `full_name`         | Nombre completo del equipo + ciudad  | texto    |


### Tabla Season 

| **Season**          | **Descripción**                      | **Tipo** |
|---------------------|--------------------------------------|----------|
| `id`                | id de la temporada                   | numérico |  
| `year`              | El año en el que se llevo a cabo     | numérico |


### Tabla Weekly Attendance

| **WeeklyAttendance**   | **Descripción**                   | **Tipo** |
|------------------------|-----------------------------------|----------|
| `id`                   | id de la asistencia por semana    | numérico |  
| `team_id`              | id del equipo                     | numérico |
| `season_id`            | id de la temporada                | numérico |
| `week`                 | Número de la semana (entre 1-16)  | numérico |
| `weekly_attendance     | Número de asistencia por semana   | numérico |


### Tabla Seasonal Attendance

| **SeasonalAttendance** | **Descripción**                   | **Tipo** |
|------------------------|-----------------------------------|----------|
| `id`                   | id de la asistencia por temporada | numérico |  
| `team_id`              | id del equipo                     | numérico |
| `season_id`            | id de la temporada                | numérico |
| `home_attendance_total`| Número de asistencia de local     | numérico |
| `away_attendance_total`| Número de asistencia de visitante | numérico |
| `total_attendance`     | Número de asistencia total        | numérico |


### Tabla Game

| **Game**               | **Descripción**                   | **Tipo** |
|------------------------|-----------------------------------|----------|
| `id`                   | id del partido                    | numérico |  
| `season_id`            | id de la temporada                | numérico |
| `week`                 | Número de la semana (del 1-16)    | numérico |
| `game_date`            | Fecha del partido                 | numérico |
| `game_time`            | Hora a la que empezó el partido   | numérico |
| `home_team_id`         | id del equipo local               | numérico |
| `away_team_id`         | id del equipo visitante           | numérico |
| `winner_id`            | id del equipo ganador             | numérico |
| `is_tie`               | Indica si el partido fue un empate| boolean  |


### Tabla GameStats

| **Gamestats**    | **Descripción**                         | **Tipo** |
|------------------|-----------------------------------------|----------|
| `id`             | id de los stats del partido             | numérico |  
| `game_id`        | id del partido                          | numérico |
| `pts_win`        | Puntos anotados por el equipo ganador   | numérico |
| `pts_loss`       | Puntos anotados por el equipo perdedor  | numérico |
| `yds_win`        | Yardas del equipo ganador               | numérico |
| `yds_loss`       | Yardas del equipo perdedor              | numérico |
| `turnovers_win`  | Pérdidas del balón del equipo ganador   | numérico |
| `turnovers_loss` | Pérdidas del balón del equipo perdedor  | numérico |


### Tabla Standings 

| **Standings**         | **Descripción**                                                                  | **Tipo** |
|-----------------------|----------------------------------------------------------------------------------|----------|
| `id`                  | id de los standings                                                              | numérico |
| `team_id`             | id del equipo                                                                    | numérico |
| `season_id`           | id de la temporada                                                               | numérico |
| `wins`                | Número de victorias en la temporada regular                                      | numérico |
| `losses`              | Número de derrotas en la temporada regular                                       | numérico |
| `points_for`          | Total de puntos a favor                                                          | numérico |
| `points_against`      | Total de puntos en contra                                                        | numérico |
| `points_differential` | Diferencia de puntos (`points_for` - `points_against`)                           | numérico |
| `margin_of_victory`   | Margen de victoria (`points_differential` / número de juegos)                    | numérico |
| `strength_of_schedule`| Calidad promedio del oponente, medida con el SRS (Simple Rating System)          | numérico |
| `simple_rating`       | Calidad del equipo relativa al promedio (0.0), medida con el SRS                 | numérico |
| `offensive_ranking`   | Calidad de la ofensiva del equipo relativa al promedio (0.0), medida con el SRS  | numérico |
| `defensive_ranking`   | Calidad de la defensiva del equipo relativa al promedio (0.0), medida con el SRS | numérico |
| `made_playoffs`       | Indica si el equipo avanzó a los playoffs                                        | boolean  |


### Tabla Super Bowl

| **SuperBowl**          | **Descripción**                   | **Tipo** |
|------------------------|-----------------------------------|----------|
| `id`                   | id del superbowl                  | numérico |  
| `season_id`            | id de la temporada                | numérico |
| `winning_team_id`      | id del equipo ganador             | numérico |
| `winning_team_name`    | Nombre del equipo ganador         | texto    |




