# Instrucciones paso a paso para la replicación

## Paso 1: Descargar los archivos del repositorio
Desde [la página principal del repositorio](https://github.com/AndresIsaac92/propuesta_NFL_Stadiums), presionamos <> Code (el botón verde al lado izquierdo de la descripción) y escogemos la opción Download ZIP. O, si tenemos instalado git, desde la terminal de `psql`, ejecutamos el comando:
```
git clone https://github.com/AndresIsaac92/propuesta_NFL_Stadiums.git
```

Esto descargará un archivo comprimido con todos los archivos del repositorio. A continuación, debemos extraer todos los documentos a una misma carpeta (no comprimida).

## Paso 2: Descargar los datos originales
De [la fuente de datos](https://www.kaggle.com/datasets/sujaykapadnis/nfl-stadium-attendance-dataset) descargamos los archivos CSV que contienen las tres relaciones originales.
Estos tres archivos deben estar almacenados bajo los nombres `./data/attendance.csv`, `./data/games.csv` y `./data/standings.csv`.
Es decir, deben de estar guardados en la misma carpeta que los archivos del repositorio, los tres en una carpeta llamada `data`.

Esta carpeta con los archivos del repositorio y los datos guardados se debería de ver algo así:

<img width="669" height="191" alt="Captura de pantalla 2026-05-11 232915" src="https://github.com/user-attachments/assets/5d3b3b20-7fa5-4eb8-8903-f4843bd84593" />



## Paso 3: Preparación en `psql` antes de ejecutar los scripts de SQL
Abrimos la aplicación `psql` y tras ingresar, primero revisaremos si ya hay alguna base de datos llamada `nfl` con:
```
\l
```

Si nos muestra que ya existe una base de datos llamada `nfl`, hay que borrarla con:
```
DROP DATABASE nfl;
```
Si no hay ninguna base de datos `nfl`, podemos omitir este último paso.

A continuación creamos la base de datos con:
```
CREATE DATABASE nfl;
```

Y nos conectamos a ella con:
```
\c nfl
```

Ahora, nos aseguramos de que el directorio de trabajo para `psql` sea la raíz del proyecto. Esto lo hacemos con:
```
\cd <path>
```
Aquí, `<path>` es la ruta de acceso de la carpeta con los archivos y los datos. Si esta ruta contiene símbolos backslash `\`, se les debe cambiar por slash `/`.

## Paso 4: Ejecutar los scripts
Ahora sí, ejecutamos el script de carga con:
```
\i pipeline_scripts/raw-nfl.sql
```

El script de limpieza con:
```
\i pipeline_scripts/limpieza.sql
```

Y el script de normalización con:
```
\i pipeline_scripts/Normalizacion.sql
```

## Paso 5 (opcional): Visualización con una herramienta con mejor UI como TablePlus
Ahora, podemos abrir TablePlus (o alguna otra herramienta) y crear una nueva conexión con el mismo usuario y contraseña que en `psql`, y la base de datos `nfl`.
Ahora tenemos, finalmente, los datos cargados y listos para ser visualizados o realizar consultas con ellos. Se recomienda abrir y ejecutar los scripts de los análisis con TablePlus, DataGrip, u otra herramienta para la visualización.
