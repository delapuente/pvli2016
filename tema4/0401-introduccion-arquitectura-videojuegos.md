---
title: Introducción a la arquitectura de videojuegos
author: Carlos León
date: 18/10/2016
vim: spelllang=es
...

# Qué es la arquitectura de un juego

---


Los videojuegos son, normalmente, sistemas complejos y grandes

---

<!-- TODO [Carlos, 19-10-2016 12:32]: foto de subsistemas -->

---

La complejidad puede crecer tanto, que carecer de un diseño global coherente
*puede hacer inmanejable el desarrollo*

---

<!-- TODO [Carlos, 19-10-2016 12:34]: foto de Unity -->

---

¿Podríais implementar Unity?

---

Unity es un motor de juego entero

<p class="fragment">(y, además, un editor)<p>

---

Cada parte de un motor de juego como Unity tiene que:

- Ser modificable
- Ser ampliable
- Ser independiente
- Comunicarse con las demás
- Hacer todo esto de forma que los *programadores* empleen el mínimo esfuerzo


# Por qué pensar en la arquitectura

La arquitectura software de un videojuego no es para la *máquina*, es para el
*programador*

Pensad en un juego cuyo código comunique los módulos de varias maneras
distintas

Cuando se tienen 6 subsistemas distintos, la organización del código es
*indispensable*

Además, puede tener impacto en la eficiencia


# Repaso de programación orientada a objetos

Un paradigma de programación muy usado para sistemas software que requieren
arquitecturas complejas es la *programación orientada a objetos* basada en clases

## Clases

Las clases son los tipos, las estructuras de las que se crean instancias

![Ejemplo de clases](imgs/inherit_graph_0.png)

```plantuml
Entity <|-- Movable
Entity <|-- Weapon
Movable <|-- Player
abstract Movable <|-- Enemy
Game "1" *-- "*" Entity
Player o-- Weapon : aggregation
hide members
```



## Instancias

Las instancias son cada uno de los elementos 

Aquí, `player`{.cpp} y `enemy`{.cpp} son instancias de `Player`{.cpp} y
`Enemy`{.cpp} respectivamente:

```cpp
Player player("player", 10, 10, 0, 0, 100);
Enemy enemy("enemy", 15, 15, 0, 0, &player);
```

## Relaciones

Las clases, como módulos, se relacionan en un sistema

Hay muchos tipos de relaciones y muchas maneras de usarlas, aquí sólo
comentamos algunas

### Herencia


Las clases pueden *heredarse*, de forma que una clase *hija* **es-una**
(`is-a`) clase padre también

![Clases para estructurar un juego](imgs/classEntity__inherit__graph.png)

### Uso

Las clases pueden *usarse* unas a otras, de forma que se *pasen mensajes*

<!-- TODO [Carlos, 19-10-2016 14:16]: player->arma --><`0`>

### Composición

Las clases pueden *componerse*, de forma que 

## Arquitecturas basadas en herencia

# Sistemas de componentes

## Qué es un componente

## Entidades

## Blueprints

## Arquetipos

# Sistemas de entidades

# Comparativa (ventajas e inconvenientes)


------------------------------

# Enlaces interesantes

No es JavaScript, pero muestra todo bastante claro

<https://www.raywenderlich.com/24878/introduction-to-component-based-architecture-in-games>
