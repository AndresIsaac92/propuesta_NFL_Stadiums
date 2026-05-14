# Estructura de las entidades originales

La entidad `attendance` contiene aproximadamente 10,849 tuplas y 8 atributos. 
La entidad `standings` tiene aproximadamente 638 registros y 15 atributos.
La entidad `games` tiene aproximadamente 7,800 tuplas y 19 atributos.

La entidad `attendance` contiene los siguientes atributos, con los tipos de datos originales:
| **Atributo**        | **Descripción**                    | **Tipo** |
|---------------------|------------------------------------|----------|
| `team`              | Ciudad en la que se basa el equipo | texto    |
| `team_name`         | Nombre del equipo                  | texto    |
| `year`              | Temporada                          | numérico |
| `total`             | Asistencia total de las 17 semanas | numérico |
| `home`              | Asistencia como equipo local       | numérico |
| `away`              | Asistencia como equipo visitante   | numérico |
| `week`              | Número de semana                   | texto    |
| `weekly_attendance` | Asistencia en la respectiva semana | numérico |  

La entidad `standings` contiene los siguientes atributos, con los tipos de datos originales:
| **Atributo**           | **Descripción**                                                                  | **Tipo** |
|------------------------|----------------------------------------------------------------------------------|----------|
| `team`                 | Ciudad en la que se basa el equipo                                               | texto    |
| `team_name`            | Nombre del equipo                                                                | texto    |
| `year`                 | Temporada                                                                        | numérico |
| `wins`                 | Número de victorias en la temporada regular                                      | numérico |
| `loss`                 | Número de derrotas en la temporada regular                                       | numérico |
| `points_for`           | Total de puntos a favor                                                          | numérico |
| `points_against`       | Total de puntos en contra                                                        | numérico |
| `points_differential`  | Diferencia de puntos (`points_for` - `points_against`)                           | numérico |
| `margin_of_victory`    | Margen de victoria (`points_differential` / número de juegos)                    | numérico |
| `strength_of_schedule` | Calidad promedio del oponente, medida con el SRS (Simple Rating System)          | numérico |
| `simple_rating`        | Calidad del equipo relativa al promedio (0.0), medida con el SRS                 | numérico |
| `offensive_ranking`    | Calidad de la ofensiva del equipo relativa al promedio (0.0), medida con el SRS  | numérico |
| `defensive_ranking`    | Calidad de la defensiva del equipo relativa al promedio (0.0), medida con el SRS | numérico |
| `playoffs`             | El equipo avanzó a los playoffs, o no                                            | texto    |
| `sb_winner`            | El equipo ganó el Super Bowl                                                     | texto    |

La entidad `games` contiene los siguientes atributos, con los tipos de datos originales:
| **Atributo**     | **Descripción**                           | **Tipo** |
|------------------|-------------------------------------------|----------|
| `year`           | Temporada                                 | numérico |
| `week`           | Número de semana (1-17, más los playoffs) | texto    |
| `home_team`      | Equipo local                              | texto    |
| `away_team`      | Equipo visitante                          | texto    |
| `winner`         | Equipo ganador                            | texto    |
| `tie`            | Si hay un empate, el equipo "perdedor"    | texto    |
| `day`            | Día de la semana                          | texto    |
| `date`           | Fecha, sin el año                         | texto    |
| `time`           | Hora a la que empezó el juego             | texto    |
| `pts_win`        | Puntos anotados por el equipo ganador     | numérico |
| `pts_loss`       | Puntos anotados por el equipo perdedor    | numérico |
| `yds_win`        | Yardas del equipo ganador                 | numérico |
| `turnovers_win`  | Pérdidas del balón del equipo ganador     | numérico |
| `yds_loss`       | Yardas del equipo perdedor                | numérico |
| `turnovers_loss` | Pérdidas del balón del equipo perdedor    | numérico |
| `home_team_name` | Nombre del equipo local                   | texto    |
| `home_team_city` | Ciudad del equipo local                   | texto    |
| `away_team_name` | Nombre del equipo visitante               | texto    |
| `away_team_city` | Ciudad del equipo visitante               | texto    |

