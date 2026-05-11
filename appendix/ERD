# Tablas normlaizadas 

Tabla staging (attendance)
Dividimos la tabla staging en 3 tablas para eliminar dependencias parciales y multivaluadas. Originalmente para un mismo equipo y año, existían múltiples semanas y múltiples registros de asistencia que no dependían entre sí, lo que violaba la 4NF. 

Tabla Team
| **Team**            | **Descripción**                      | **Tipo** |
|---------------------|--------------------------------------|----------|
| `id`                | id del equipo                        | numérico |  
| `name`              | Nombre del equipo                    | texto    |
| `city`              | Nombre de la ciudad                  | texto    |
| `full_name`         | Nombre completo del equipo + ciudad  | texto    |


Tabla Season 
| **Season**          | **Descripción**                      | **Tipo** |
|---------------------|--------------------------------------|----------|
| `id`                | id de la temporada                   | numérico |  
| `year`              | El año en el que se llevo a cabo     | numérico |


Tabla Weekly Attendance
| **WeeklyAttendance**   | **Descripción**                   | **Tipo** |
|------------------------|-----------------------------------|----------|
| `id`                   | id de la asistencia por semana    | numérico |  
| `team_id`              | id del equipo                     | numérico |
| `season_id`            | id de la temporada                | numérico |
| `week`                 | Número de la semana (entre 1-16)  | numérico |
| `weekly_attendance     | Número de asistencia por semana   | numérico |


Tabla Seasonal Attendance
| **SeasonalAttendance** | **Descripción**                   | **Tipo** |
|------------------------|-----------------------------------|----------|
| `id`                   | id de la asistencia por temporada | numérico |  
| `team_id`              | id del equipo                     | numérico |
| `season_id`            | id de la temporada                | numérico |
| `home_attendance_total`| Número de asistencia de local     | numérico |
| `away_attendance_total`| Número de asistencia de visitante | numérico |
| `total_attendance`     | Número de asistencia total        | numérico |


Tabla Game
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


Tabla GameStats
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

Tabla Standings 
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

Tabla Super Bowl
| **SuperBowl**          | **Descripción**                   | **Tipo** |
|------------------------|-----------------------------------|----------|
| `id`                   | id del superbowl                  | numérico |  
| `season_id`            | id de la temporada                | numérico |
| `winning_team_id`      | id del equipo ganador             | numérico |
| `winning_team_name`    | Nombre del equipo ganador         | texto    |




