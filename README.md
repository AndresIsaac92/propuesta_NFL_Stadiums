# Proyecto BD: NFL Stadium Attendance

## Integrantes
Mikel Loret de Mola Yaber, CU: 218645, https://github.com/loretmikel

Regina Quevedo López de Cárdenas, CU: 220225, https://github.com/

Andrés Isaac de la Cruz Sosa, CU:222998, https://github.com/AndresIsaac92

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
5. El resto de las instrucciones asumen que el directorio de trabajo para `psql` es la raíz de este proyecto.


## Carga inicial

En primer lugar, se deberá crear una base de datos exclusiva para este proyecto. Para ello se puede ejecutar el siguiente 
Comando en `psql`:

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

Como el análisis preliminar no encontró errores graves en los datos, la limpieza consistió principalmente en ajustes necesarios para que todo funcionara correctamente al cargar la información al nuevo esquema. A continuación explicamos qué hicimos y por qué.

### La columna `playoffs` venía como texto, no como verdadero/falso

En el CSV, la columna `playoffs` no decía simplemente `true` o `false`, sino cosas como `'Yes'`, `'TRUE'` o `'1'` dependiendo del registro. Para que la base de datos lo entendiera como un valor de sí/no, tuvimos que convertirlo manualmente:

```sql
CASE 
    WHEN st.playoffs = 'Yes' OR st.playoffs = 'TRUE' OR st.playoffs = '1' THEN TRUE 
    ELSE FALSE 
END AS made_playoffs
```

Lo hicimos así porque si hubiéramos dejado el texto tal cual, no podríamos hacer consultas sencillas como "dame todos los equipos que sí llegaron a playoffs".

### Las semanas sin asistencia se dejaron vacías a propósito

Algunos registros de asistencia semanal no tenían valor. Eso no significa que el dato esté mal: simplemente esa semana el equipo no jugó en casa. Por eso decidimos no incluir esas filas en lugar de poner un 0 o inventar un número. Poner 0 hubiera hecho parecer que el estadio estuvo vacío, cuando en realidad no hubo partido.

### Las fechas y horas se guardaron como texto

Los campos de fecha y hora del CSV no tenían un formato consistente, lo que hacía difícil convertirlos directamente a un formato de fecha real. Para no perder información, los guardamos tal como venían (como texto). Si en el futuro se necesita operar con ellos como fechas reales, se puede hacer la conversión en ese momento.

### Tuvimos que quitar una regla que no dejaba guardar rankings de 0

Al diseñar la tabla, pusimos una regla que decía que los rankings debían ser mayores o iguales a 1. Sin embargo, los datos reales tenían algunos valores de 0, lo que hacía que el sistema rechazara esos registros. Tuvimos que eliminar esa restricción para poder cargar todos los datos:

```sql
ALTER TABLE Standing DROP CONSTRAINT IF EXISTS ranking_positive;
```

El 0 en este caso es un valor válido del dataset original, no un error.

### Los nombres de equipos se limpiaron antes de hacer los joins

Al relacionar los datos de partidos con la tabla de equipos, nos dimos cuenta de que algunos nombres tenían espacios de más o diferencias entre mayúsculas y minúsculas. Para evitar que eso rompiera la conexión entre tablas, aplicamos `TRIM()` (quitar espacios) y `LOWER()` (convertir a minúsculas) en ambos lados de la comparación:

```sql
INNER JOIN Team home_team ON TRIM(LOWER(home_team.full_name)) = TRIM(LOWER(g.home_team_name))
```

Sin esto, partidos con nombres como `"New England Patriots "` (con espacio al final) no hubieran encontrado su equipo correspondiente y se habrían perdido.

### Los partidos con ganador `'NA'` se excluyeron

Algunos registros en la columna `winner` tenían el valor `'NA'`, que no significa empate ni ningún equipo real: es simplemente un valor vacío mal codificado en el CSV. Esos registros se filtraron para no meter basura en la tabla de partidos. Los empates reales sí están contemplados en la columna `is_tie`.

### Los Rams y Chargers se tratan como equipos distintos según su ciudad

Al cargar los equipos nos dimos cuenta de que había 34 equipos en lugar de 32. Esto se debe a que los Rams jugaron en St. Louis y luego se mudaron a Los Ángeles, y lo mismo pasó con los Chargers (de San Diego a Los Ángeles). Decidimos tratarlos como equipos separados porque sus estadísticas e historial de asistencia corresponden a ciudades, estadios y contextos completamente distintos. Juntarlos hubiera mezclado datos que no son comparables.


## Normalización

La base de datos original constaba de tres tablas principales: staging (asistencia), games (partidos) y standings (clasificaciones). Debido a que los datos estaban muy limpios, sustituimos la parte del proyecto de limpieza por normalización hasta Cuarta Forma Normal. La base de datos original presentaba redundancias y dependencias funcionales y multivaluadas que podían causar anomalías en las operaciones de inserción, actualización y eliminación. 

Las tablas originales ya cumplían con 1FN, ya que no había grupos repetitivos ni listas dentro de las celdas. Por ejemplo, cada asistencia semanal estaba en una fila separada, y cada partido tenía sus propias estadísticas en una fila individual.
	
Dentro de la tabla staging encontramos dependencias funcionales que no dependían únicamente de la clave completa, lo que hacía que se repitieran en cada fila de la misma temporada, generando mucha redundancia. Para pasar a 2FN, separamos estos atributos en una nueva tabla llamada SeasonalAttendance, cuyas llaves son (team_id, season_id). 
	
También detectamos dependencias transitivas. Por ejemplo, en la tabla staging original, team_name dependía de team, que a su vez era parte de la clave. También en games, atributos como home_team_name y home_team_city dependían transitivamente de home_team. Por lo que creamos una tabla independiente Team que contiene id, full_name y city. De esta forma, los nombres y ciudades de los equipos se almacenan una sola vez, eliminando la redundancia y las dependencias transitivas. Hicimos lo mismo para una tabla Season con id y year, para evitar la redundancia: el año se repetiría en todas las tablas relacionadas; season_id es una única referencia.
	
Para la BCNF, verificamos que todo determinante fuera una clave candidata. En nuestras tablas, las dependencias funcionales restantes cumplían esta condición, por lo que ya estábamos en BCNF.
	
Para llegar a la 4FN, identificamos dependencias multivaluadas (DMV) en la tabla staging. Observamos que para un par (team, year), existía un conjunto independiente de valores para week y weekly_attendance. Por lo que creamos weekly_attendance y seasonal_attendance. Al separarlas, cada tabla contiene una sola "faceta" de la información. No quedan dependencias multivaluadas cruzadas entre ambas tablas, ya que representan conceptos independientes. La tabla games presentaba redundancias similares. Separamos esta en game y en gamestats para evitar repetir las estadísticas si hubiera sido necesario duplicar información del partido. Por último, notamos que en la standings se encontraba sb_winner que en la mayoría de las tuplas era "No Superbowl", lo cual era redundante, por lo que creamos una última tabla con solo los ganadores de cada año. 


```{psql}
\i pipeline_scripts/03_data_normalization.sql
```

>  Aquí es una buena sección para documentar la descomposición intuitiva de las tablas.
> También un ERD del diseño final debe ser incluido.
