# Análisis predictivo
Realizamos este pequeño script en Python, desde Jupyter Notebook para mostrar posibles aplicaciones de nuestro proyecto. Aquí se muestran sólo pequeños fragmentos del código, pero se incluyen instrucciones para cargar el script completo.
Esta pequeña muestra consiste en crear un modelo de regresión múltiple que dadas algunas estadísticas generales de la temporada de un equipo, pueda predecir la asistencia total de la temporada.

Decidimos usar como datos de entrenamiento las primeras 17 temporadas (2000 - 2016) y como datos de prueba las últimas tres (2017 - 2019).

## Exportar datos y abrir Jupyter
Este Notebook se desarrolló en Jupyter Notebook, lanzado desde Anaconda, en Python 3.12.7.
Ocupamos las librerías `pandas`, `numpy`, `matplotlib`, y `sklearn`.

Para poder exportar los archivos CSV necesarios para cargar el script, ejecute los siguientes comandos en la consola de `psql`:
```
\copy (SELECT * FROM standing INNER JOIN seasonalattendance ON standing.team_id = seasonalattendance.team_id AND standing.season_id = seasonalattendance.season_id WHERE standing.season_id <= 17) TO 'aplicacion/train.csv' WITH (FORMAT CSV, HEADER);
```

```
\copy (SELECT * FROM standing INNER JOIN seasonalattendance ON standing.team_id = seasonalattendance.team_id AND standing.season_id = seasonalattendance.season_id WHERE standing.season_id > 17) TO 'aplicacion/test.csv' WITH (FORMAT CSV, HEADER);
```
Esto exporta los archivos de entrenamiento y prueba directamente a la carpeta `aplicacion` en la carpeta raíz.

Ahora, abrimos Jupyter Notebook y abrimos el script, guardado como `./aplicacion/Aplicacion.ipynb`. Es decir, esta guardado en la carpeta `aplicacion` de la carpeta raíz.

## Análisis predictivo
Nuestro simple modelo de regresión múltiple predice la asistencia total de la temporada basado en el número de victorias, puntos a favor, margen de victoria, ranking ofensivo y defensivo y si llegó a los playoffs o no:
```
# Creamos dataframes de variable independiente y dependiente:
X_train = df_train[["wins", "points_for", "margin_of_victory", "offensive_ranking", "defensive_ranking", "made_playoffs"]]
y_train = df_train["total_attendance"]
```

Tras aplicar limpieza y normalización (de escala, no descomposición de relaciones), entrenamos al modelo:
```
# Creamos y entrenamos el modelo de regresión:
reg = LinearRegression()
reg.fit(X_train, y_train)
```

Posteriormente, hacemos la predicción con los datos de prueba:
```
# Realizamos las predicciones:
y_pred = reg.predict(X_test)
y_pred
```

El modelo tiene un error absoluto promedio de ~67000 asistentes al año (aproximadamente 6.1%), lo cual es bastante decente considerando que el modelo no distingue entre equipos y no considera otros factores externos; aquí está un histograma de los residuos (el error de predicción):
```
# Graficamos los residuos, el error por predicción
residuos = y_test - y_pred
plt.figure(figsize = (6, 4))
plt.hist(residuos, bins = 20, edgecolor = "black")
plt.axhline(0, color = "red", linestyle = "--")
plt.xlabel("Residuos")
plt.ylabel("Frecuencia")
plt.title("Histograma de residuos")
plt.show()
```
<img width="1031" height="708" alt="Captura de pantalla 2026-05-11 223145" src="https://github.com/user-attachments/assets/66b6440a-e798-456e-bf00-7a6ac4dc65ac" />

Notamos un outlier muy evidente: 6 instancias de la predicción quedándose corta en un 35%. Estas se atribuyen a una disminución drástica en la asistencia del 2017 por  [la relocación de los Chargers de un estadio con capacidad de 70000 a uno con capacidad de 28000](https://www.nfl.com/news/chargers-announce-decision-to-relocate-to-los-angeles-0ap3000000773179).

Así, este proyecto se puede aplicar para hacer análisis predictivo y otros similares.
