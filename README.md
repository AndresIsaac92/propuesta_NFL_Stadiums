# Proyecto BD: NFL Stadium Attendance

## Integrantes
Mikel Loret de Mola Yaber, CU: 218645, https://github.com/loretmikel

Regina Quevedo Lopez de Cardenas, CU: 220225 , https://github.com/

Andres Isaac de la Cruz Sosa, CU: , https://github.com/AndresIsaac92

Arie Goldzweig Perez, CU: 221746, https://github.com/goldzweigarie-bit

Carmen Sofía Delgado, CU: 208655 , https://github.com/melyDelgado


## Introducción

> Esta es una buena sección para el el inciso A:
> Introducción al conjunto de datos y al problema a estudiar considerando aspectos éticos del conjunto de datos empleado.

La base de datos NFL Stadium Attendance contiene información sobre la asistencia a los estadios de la NFL a lo largo de múltiples temporadas. 
Está compuesto por 3 tablas principales: games, attendance y standings, que se relacionan con los atributos team, year y week.  

Los datos fueron recopilados a partir de fuentes públicas de estadísticas deportivas, principalmente de plataformas como Pro Football Reference y de datos abiertos disponibles en Kaggle. 
Se espera una actualización anual, aunque la última fue hace 2 años.

La entidad attendance contiene aproximadamente 10,849 tuplas y 8 atributos. El atributo 'team' es la abreviatura del equipo, 'team_name' es el nombre completo, 'year' es el año de la temporada, 'week' es el número de semana de la temporada, 'weekly_attendance' es la asistencia en esa semana, 'home' asistencia total en juegos de local, 'away' asistencia total en juegos de visitante y 'total' asistecnia total general. Los atributos numéricos: son 'year', 'week', 'weekly_attendance', 'home', 'away', 'total'. Los atributos 'team' y 'team_name' son categóricos, el atributo 'team_name' es de texto y los atributos 'year' y 'week' son temporales.  

La entidad games tiene aproximadamente 7,800 tuplas y 19 atributos. El atributo 'year' es el año de la temporada, 'week' es el número de semana de la temporada, 'home_team' es el nombre completo del equipo que juega de local, 'away_team' es el nombre completo del equipo que visita, 'winner' es el ganador, 'tie' si hubo un empate, 'day' en que día de la semana jugaron, 'date' es la fecha del partido, 'time' es la hora del partido, 'pts_win' los puntos ganados, 'pts_loss' los puntos perdidos, 'yds_win' las yardas ganadas, 'turnovers_win' cuantas veces recuperaron el balón sin que haya sido por patada, 'yds_loss' yardas perdidas, 'turnovers_loss' cuantas veces perdieorn el balón sin que haya sifo por patada, 'home_team_name'nombre del equipo local, 'home_team_city' nombre de la ciudad del equipo local, 'away_team_name' el nombre del equipo que no es local y 'away_team_city' el nombre de la ciudad del equipo no local. Los atributos numéricos son: 'week', 'pts_win', 'pts_loss', 'yds_win', 'turnovers_win', 'yds_loss' y 'turnovers_loss'. Los atributos categóricos son: 'home_team', 'away_team', 'winner', 'tie', 'home_team_name', 'home_team_city', 'away_team_name' y 'away_team_city'. Los atributos de tipo texto son: 'home_team', 'away_team', 'winner', 'home_team_name', 'home_team_city', 'day', 'away_team_name' y 'away_team_city'. Los atributos temporales son: 'year' 'date' y 'time'. 

La entidad standings tiene aproximadamaente 638 registros y 15 atributos. El atirbuto 'team' es el nombre de la ciudad del equipo, 'team_name' el nombre del equipo, 'year' el año de la temporada, 'wins' cuántos partidos ganaron, 'loss' cuántos partidos perdieron, 'points_for' cuántos puntos anotaron en toda la temporada, 'points_against' cuántos puntos le anotaron en contra, 'points_differential' la resta de puntos anotados y puntos anotados en contra, 'margin_of_victory' e margen de las victorias, 'strenght_of_schedule' mide la complejidad de los equipos a los que se enfrentará, 'simple rating' mide la calidad del equipo, 'offensive ranking' rankea a la ofensiva, 'defensive_ranking' rankea a la defensiva, 'playoffs' te dice si el equipo califico a playoffs, 'sb_winner' te dice si pasaron al superbowl. Los atirubutos numéricos son: 'wins', 'loss', 'points_for', 'points_differential', 'margin_of_victory', 'strenght_of_schedule', 'simple rating', 'offensive ranking' y 'defensive_ranking'. Los atirbutos categóricos son: 'team', 'team_name', 'playoffs', y 'sb_winner'. El único atributo temporal es 'year'. Los atributos de tipo texto son: 'team' y 'team_name'.  

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

> Esta es una buena sección para documentar los hallazgos del inciso B:
> Carga inicial y análisis preliminar.

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

Sin embargo, cuando estábamos editando la base de datos, encontramos ciertas inconsistencias. Por ejemplo, no sabíamos que ciertos equipos se cambian de ciudad, por lo que los equipos (que pensé que eran 32) resultaron ser 34. Tuvimos que considerar a los Rams y a los Chargers de las dos ciudades como equipos diferentes. Por otro lado, el ranking debía ser positivo, por lo que tuvimos que agregar una condición que permitiera esta modificación.


## Normalización

La normalización se realiza también mediante la estrategia de refresh destructivo. Para ejecutar el proceso de
normalización se puede emplear el siguiente comando en `psql`:

```{psql}
\i pipeline_scripts/03_data_normalization.sql
```

>  Aquí es una buena sección para documentar la descomposición intuitiva de las tablas.
> También un ERD del diseño final debe ser incluido.
