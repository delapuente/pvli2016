# Batalla RPG

El ejercicio consiste en modelar un combate RPG por turnos en formato
conversacional.

Un grupo de héroes se enfrentará a un grupo de enemigos. Los combatientes
actuarán en orden, turno por turno hasta que uno de los bandos haya sido
completamente derrotado. Los héroes serán controlados por el jugador quien
podrá elegir qué hacer de entre un menú de acciones. Los enemigos acutarán
automáticamente.

Si el grupo de héroes es derrotado, el juego termina con _Game Over_.
Si el grupo de enemigos es aniquilado, comienza un siguiente combate.

## Consideraciones iniciales

Todos los personajes, héroes o monstruos tienen las mismas características:
vitalidad, puntos de magia, agilidad y resistencia.

La resistencia es un número del 1 al 100.

Los puntos de magia, la vitalidad y la agilidad son enteros positivos, tienen
un máximo pero este puede crecer sin límite mediante el uso de objetos.

Además, héroes y monstruos tienen un nombre y una descripción, con su trasfondo
o su apariencia física, por ejemplo.

También tienen un arma, que es un [objeto](#objetos).

Los héroes tienen un libro de hechizos y un inventario común.

Puedes crear algunos tipos de enemigos, unos más ágiles, otros más fuertes
y otros más resistentes. Mínimo 3 tipos.

Para los héroes, crea 3, uno con mucha resistencia y un arma muy poderosa.
Otro con muchos puntos de magia y otro con una agilidad elevada.

## Fases del combate

Las fases del combate son:

  1. Reposo
  2. Configuración inicial
  3. Ordenación por turnos
  4. Turnos...
  5. Resolución del combate
  6. Adquisición de objetos
  7. Subida de nivel
  8. Fin del juego

### Reposo

El jugador puede optar por comenzar una batalla, en tal caso pasará al estado
[configuración inicial](#configuracion-inicial) o utilizar objetos del
inventario.

### Configuración inicial

Durante la configuración inicial se seleccionan de uno a tres monstruos al azar
que lucharán siempre contra los tres héroes. Los héroes comienzan con la
vitalidad y la magia al 150% de su vitalidad anterior, nunca por encima del
máximo. Si un héroe estaba muerto, comienza con un 10% de su vitalidad máxima.

Se asigna un premio a la batalla consistente en un objeto por enemigo y se
pasa al estado de [ordenación por turnos](#ordenacion-por-turnos).

### Ordenación por turnos

Al comienzo de la partida se creará una lista de jugadores y monstruos conjunta
ordenada por la agilidad de cada personaje. Se pasa al estado [turnos](#turnos).

### Turnos...

El juego comenzará por el primer personaje de la lista. El turno varía en
función de si se trata de un enemigo o de un héroe:

#### Turno de enemigos

El enemigo elige un oponente al azar y utiliza las [reglas de efecto](
#reglas-de-efecto) con su arma contra el oponente seleccionado.

#### Turno del héroe

El jugador puede elegir entre [atacar](#atacar), [lanzar un hechizo](
#lanzar-hechizo) o [usar el inventario](#objeto-del-inventario).

### Resolución del combate

Tras cada turno, se comprueba que los bandos siguen teniendo integrantes vivos.
Si el bando enemigo ha sido derrotado, el juego pasa al estado de [adquisición
de objetos](#adquisicion-de-objetos). Si el bando amigo ha sido derrotado el
juego pasa al estado [fin de juego](#fin-de-juego).

### Adquisición de objetos

Los objetos que portasen los enemigos pasan al inventario y luego pasamos al
estado [reposo](#reposo).

### Fin del juego

La partida termina y se muestra el número de combates superados.

## Interacciones

### Atacar

Si el jugador elige atacar, elegirá un oponente y usará las [reglas
de efecto](#reglas-de-efect) con su arma contra el oponente seleccionado.

### Lanzar hechizo

Si el jugador elige lanzar un hechizo, habrá de elegir qué hechizo del libro de
hechizos común.

El personaje sólo puede elegir hechizos que pueda pagar con sus puntos de magia
actuales. Cuando haya elegido, habrá de elegir un objetivo.

Sólo cuando haya elegido un objetivo consumirá los puntos de magia del coste del
hechizo y utilizará las [reglas de efecto](#reglas-de-efecto) con el hechizo y
el objetivo.

### Objeto del inventario

Si elige utilizar el inventario, habrá de elegir un objeto del inventario.

A continuación elegirá un objetivo. Sólo cuando elija el objetivo, el objeto
será retirado del inventario.

De nuevo, recurrirá a las [reglas de efecto](#reglas-de-efecto) con el objeto
y el objetivo.

## Reglas de efecto

Las reglas de efecto esperan un objeto, un objetivo y un flag que indica si
el objeto fue empleado por un miembro del mismo bando o del contrario. El objeto
debe tener un efecto asociado. El efecto recoge las modificaciones sobre las
características del personaje como un valor entero positivo o negativo.

El procedimiento es el siguiente:

  1. Si el flag indica que el objeto fue empleado por un miembro del otro bando:
    1. Genera un número al azar del 1 al 100.
    2. Si el resultado se encuentra por debajo de la resistencia del objetivo,
    suspende estos pasos.
  2. Por cada característica afectada por el efecto
    1. Súmalo el valor actual de la característica con el valor del efecto.
    2. Si el valor tiene asociado un máximo y éste es superado, cambia el valor
    del efecto por el máximo.
    3. Si el valor es inferior a cero, cambia el valor por 0.

## Objetos

Eres libre de especificar los objetos que desees. Recuerda que deben llevar
un efecto asociado. Algunas sugerencias:

  * Armas como espadas para los héroes o garras para los enemigos.
  * Elixires para aumentar en 1, 2, 3... los niveles máximos de resistencia,
  agilidad, vitalidad o puntos de magia.
  * Pociones para recuperar vida.
  * Venenos para reducir la vida en un porcentaje.

Además del efecto asociado, los objetos pueden tener un nombre y una
descripción.

## Hechizos

Los hechizos, además de un nombre y una descripción, se parecen mucho a las
armas pero incluyen un coste en puntos de magia que se debe pagar para usar
el hechizo.

##  Otras consideraciones

Sois libres de interpretar como queráis los aspectos del juego no definidos en
esta guía y de introducir cuantas mejoras creais necesarias para hacer el
combate más interesante pero **implementad esto primero**.
