# Análisis Estacional de Calendario

Nuestra segunda idea de análisis fue estudiar cómo el calendario afecta la ventaja de jugar en casa y el nivel de juego a lo largo de la temporada.

El primer comando analiza la ventaja local por día de la semana. Clasifica cada partido según el día en que se jugó (domingo, lunes, jueves, etc.), cuenta cuántos ganó el equipo local y calcula el porcentaje de victorias locales por día. Por último asigna un ranking de mayor a menor ventaja local usando una función de ventana.

```sql
COUNT(CASE WHEN winner_id = home_team_id THEN 1 END) * 100.0 / COUNT(*) AS porcentaje_victoria_local,
RANK() OVER (ORDER BY ... DESC) AS ranking
```

El segundo comando busca identificar si hay semanas donde se anota más en toda la liga. Para cada semana de la temporada (incluyendo playoffs), calcula el promedio de puntos totales por partido sumando los puntos del ganador y del perdedor. Asigna un ranking de mayor a menor promedio usando una función de ventana y ordena las semanas cronológicamente, poniendo los playoffs al final.

```sql
ROUND(AVG(gs.pts_win + gs.pts_loss), 2) AS promedio_puntos_partido,
JOIN gamestats gs ON gs.game_id = g.id
```

El tercer comando analiza si la ventaja de jugar en casa cambia según el momento de la temporada. Para cada semana calcula el porcentaje de victorias del equipo local y asigna un ranking, permitiendo identificar en qué semanas la ventaja local es mayor o menor.

```sql
COUNT(CASE WHEN winner_id = home_team_id THEN 1 END) * 100.0 / COUNT(*) AS porcentaje_victoria_local,
RANK() OVER (ORDER BY ... DESC) AS ranking
GROUP BY week
```

Nuestros resultados muestran que la ventaja local existe consistentemente en todos los días de la semana (entre 55% y 58%), pero es ligeramente menor en los partidos de primetime del lunes (55.75%) comparado con los sábados y jueves (~58%). En cuanto a puntos, los playoffs concentran los promedios más altos de toda la temporada, con el SuperBowl como el partido con más puntos en promedio (47.90). La ventaja local durante la temporada regular no es constante: alcanza su pico en la semana 8 (61.68%) y su punto más bajo en la semana 10 (51.94%), sugiriendo que el calendario y el cansancio acumulado afectan la dinámica de los partidos. Para ver el código SQL refiérase a __[Análisis estacional de calendario](https://github.com/AndresIsaac92/propuesta_NFL_Stadiums/blob/main/appendix/pipeline_scripts/analisis_estacional_1.sql)__.
