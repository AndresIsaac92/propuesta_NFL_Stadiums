# Proyecto BD: NFL Stadium Attendance

## Integrantes
Mikel Loret de Mola Yaber, CU: 218645, https://github.com/loretmikel

Regina Quevedo Lopez de Cardenas, CU: 220225, https://github.com/

Andres Isaac de la Cruz Sosa, CU:222998, https://github.com/AndresIsaac92

Arie Goldzweig Perez, CU: 221746, https://github.com/goldzweigarie-bit

Carmen Sofía Delgado, CU: 208655, https://github.com/melyDelgado


## Introducción

La base de datos NFL Stadium Attendance contiene información sobre la asistencia a los estadios de la NFL a lo largo de múltiples temporadas. 
Está compuesto por 3 tablas principales: games, attendance y standings, que se relacionan con los atributos team, year y week.  

Los datos fueron recopilados a partir de fuentes públicas de estadísticas deportivas, principalmente de plataformas como Pro Football Reference y de datos abiertos disponibles en Kaggle. 
Se espera una actualización anual, aunque la última fue hace 2 años.

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


El objetivo de estos datos es realizar un análisis de cómo la asistencia al estadio y el rendimiento se afectan. ¿Una buena asistencia causa un buen rendimiento, o el buen rendimiento de un equipo produce mejor asistencia? ¿Cuáles son los equipos que más llenan su estadio? Este análisis puede ser aplicado en predicciones deportivas y análisis de datos interno de los equipos. 

Las implicaciones éticas que conlleva este análisis incluyen pero no se limitan a su uso para hacer apuestas deportivas o los efectos que su uso en el análisis interno de los equipos puedan tener en el precio o disponibilidad de los boletos para los juegos. 


### Fuente de datos

Para este proyecto se utilizan los datos que fueron subidos a Kaggle por Sunjay Kapadnis y están disponibles en https://www.kaggle.com/datasets/sujaykapadnis/nfl-stadium-attendance-dataset. 
No se incluyó un propósito explícito para su recolección. 

Las instrucciones de replicación del proyecto asumen que los datos se encuentran almacenados en formato
`CSV` bajo el nombre `./data/attendance.csv`, `./data/games.csv` y `./data/standings.csv`

## Documentación

### Estructura del repositorio

```
├── README.md                                         <- Documentación para desarrolladores de este proyecto (i.e., reporte escrito)
├── data
│   ├── .gitignore
│   └── raw_data.csv                                  <- Datos en formato CSV como vienen de la fuente original
│
├── pipeline_scripts                                  <- Scripts de SQL para ejecución del pipeline de datos
│   ├── raw-nfl.sql      <- Script de carga inicial (i.e., actividad B)
│   ├── 02_data_cleaning.sql                          <- Script de limpieza de datos (i.e., actividad C)
│   ├── 03_data_normalization.sql                     <- Script de normalización de relaciones (i.e., actividad D)
│   └── 04_analytical_attributes_creation.sql         <- Script de creación de atributos analíticos (i.e., actividad E)
│
└── exploration_queries                               <- Scripts de SQL para exploración de datos
    ├── 01_raw_data_exploration.sql                   <- Consultas de exploración de datos en bruto (i.e., soporte de actividad B)
    ├── ⋅⋅⋅                                           <- Otras consultas en caso de ser requeridas
    └── 0N_analytical_queries.sql                     <- Consultas de interés sobre los datos normalizados (i.e., soporte de actividad E)
```

### Requerimientos para replicación del proyecto

1. Descargar los datos en bruto del proyecto de acuerdo a las instrucciones del apartado de [Fuente de datos](#fuente-de-datos).
2. Contar con `postgres 16` o superior instalado en la computadora o servidor donde se replicará el proyecto.
3. Contar con una base de datos exclusiva para este proyecto. Todas las instrucciones del proyecto asumen que la sesión está conectada a la misma base de datos.
4. ...
5. El resto de las intrucciones asumen que el directorio de trabajo para `psql` es la raíz de este proyecto.


## Carga inicial

En primer lugar se deberá crear una base de datos exclusiva para este proyecto. Para ello se puede ejecutar el siguiente 
comando en `psql`:

```{psql}
CREATE DATABASE nfl;
```

Posteriormente, debemos conectarnos a dicha base de datos:

```{psql}
\c nfl
```

Finalmente, para cargar los datos en bruto se debe ejecutar el siguiente comando en una sesión de línea de comandos `psql`:

```{psql}
\i pipeline_scripts/nfl-raw.sql
```

## Análisis preliminar

En nuestra primera revisión de la base de datos, encontramos muy pocos errores de limpieza. De hecho, intentamos "romper" la base de datos de varias formas:

    -- Ver NULLs en asistencia
    SELECT COUNT(*) FROM staging WHERE weekly_attendance IS NULL;

    -- Ver asistencias negativas o cero
    SELECT * FROM staging WHERE weekly_attendance <= 0;
    SELECT * FROM staging WHERE home <= 0 OR away <= 0 OR total <= 0;

    -- Ver puntos negativos
    SELECT * FROM games WHERE pts_win < 0 OR pts_loss < 0;

    -- Ver años inválidos
    SELECT DISTINCT year FROM staging WHERE year < 1920 OR year > 2025;
    SELECT DISTINCT year FROM games WHERE year < 1920 OR year > 2025;

    -- Ver partidos donde home = away
    SELECT * FROM games WHERE home_team_name = away_team_name;

Sin embargo, no encontramos ningún error. Aún así notamos ciertas cosas interesantes. Por ejemplo, no sabíamos que ciertos equipos se cambian de ciudad, por lo que los equipos (que deberían ser 32) resultaron ser 34. Por lo que consideramos a los Rams de Los Ángeles y de St. Louis y los Chargers de San Diego y de Los Ángeles como equipos diferentes. Por otro lado, el ranking debía ser positivo, por lo que tuvimos que agregar una condición que permitiera esta modificación. Más allá de esto, no encontramos ninguna otra cosa que necesitáramos limpiar.  

## Limpieza de datos

Después de nuestra primera revisión de la base de datos, encontramos muy pocos errores de limpieza. De hecho, intentamos "romper" la base de datos de varias formas:

    -- Ver NULLs en asistencia
    SELECT COUNT(*) FROM staging WHERE weekly_attendance IS NULL;

    -- Ver asistencias negativas o cero
    SELECT * FROM staging WHERE weekly_attendance <= 0;
    SELECT * FROM staging WHERE home <= 0 OR away <= 0 OR total <= 0;

    -- Ver puntos negativos
    SELECT * FROM games WHERE pts_win < 0 OR pts_loss < 0;

    -- Ver años inválidos
    SELECT DISTINCT year FROM staging WHERE year < 1920 OR year > 2025;
    SELECT DISTINCT year FROM games WHERE year < 1920 OR year > 2025;

    -- Ver partidos donde home = away
    SELECT * FROM games WHERE home_team_name = away_team_name;

Sin embargo, no encontramos ningún error.Aún así notamos ciertas cosas interesantes. Por ejemplo, no sabíamos que ciertos equipos se cambian de ciudad, por lo que los equipos (que deberían ser 32) resultaron ser 34. Por lo que consideramos a los Rams de Los Ángeles y de St. Louis y los Chargers de San Diego y de Los Ángeles como equipos diferentes. Por otro lado, el ranking debía ser positivo, por lo que tuvimos que agregar una condición que permitiera esta modificación. Más allá de esto, no encontramos ninguna otra cosa que necesitáramos limpiar.



## Normalización

La normalización se realiza también mediante la estrategia de refresh destructivo. Para ejecutar el proceso de
normalización se puede emplear el siguiente comando en `psql`:

```{psql}
\i pipeline_scripts/03_data_normalization.sql
```

>  Aquí es una buena sección para documentar la descomposición intuitiva de las tablas.
> También un ERD del diseño final debe ser incluido.
