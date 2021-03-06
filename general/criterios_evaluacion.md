---
title: Criterios de evaluación PVLI (BORRADOR)
author: Carlos León
date: 'Última actualización: 27/09/2016'
vim: spelllang=es
...

Dado el carácter práctico de la asignatura de *Programación de Videojuegos en
Lenguajes Interpretados*, la evaluación se llevará a cabo mediante entregas
prácticas (código) que serán entregadas a través del Campus Virtual en las
fechas que se vaya señalando.

Para la evaluación, el alumno entregará cinco prácticas, y realizará dos
exámenes (uno parcial y uno final en febrero o septiembre). Además, en la
evaluación habrá una presentación de proyectos, y tanto la asistencia como la
contribución durante el desarrollo de la asignatura serán tenidas en cuenta.

La evaluación en PVLI se hará en función de la fórmula en @eq:formulaeval:

```include
formula_evaluacion.md
```

Todas las notas serán mantenidas hasta el final de la evaluación. Es decir, si
se suspende en la convocatoria de febrero, todo aquello que haya tenido más de
un 5 será mantenido como parte de la nota final, siempre y cuando no haya una
entrega adicional posterior, en cuyo caso se corregirá esta última y *se
mantendrá la última nota, incluso si esta es más baja que la primera*.

- Todas las correcciones tendrán una parte de evaluación automática basada en
  análisis automático de código y tests, y una parte de evaluación cualitativa
  manual.
- Si se supera la parte de la evaluación automática, se procederá a la manual.
  En caso contrario, se habrá suspendido la entrega (examen o práctica).
- En la publicación de cada práctica se detallará el peso de cada parte de la práctica.
- Si una entrega (práctica o examen) no carga correctamente o no se puede
  ejecutar completamente **sin errores**, la entrega se considerará suspensa.
- Si no se siguen **exactamente** los criterios de envío (número de archivos,
  formato de envío, carpetas, tipo de compresión, nombres de archivos), la
  entrega estará suspensa.

En la convocatoria de septiembre no se repetirán ni el examen parcial ni la
presentación, al ser obligatorias durante la evaluación continua.

Si alguna de las prácticas o el examen final tienen menos de un $5,0$, la
evaluación se considerará suspensa.

La nota de $contribución$ es un valor basado en la percepción de los docentes
sobre la implicación y la colaboración del alumno en la asignatura. Si bien se
intentará ser completamente objetivo, en esta parte de la nota es inevitable
una parte de subjetividad. Por tanto, si bien el valor de esta parte podrá ser
discutido por el alumno, queda a discreción del profesor la evaluación en este
aspecto.

## Copias

**Copiar cualquier entrega no está permitido y supondrá una falta grave,
acarreando el suspenso de la convocatoria actual**. Se llevará a cabo un examen
exhaustivo de copias.

## Grupos

Todas las entregas serán en parejas, a excepción de los exámenes, que se
realizarán de manera individual. Los alumnos pueden crear parejas. Aquellos
alumnos que no estén en pareja serán asignados por el profesor si no hay una
causa que lo impida.

La nota de cada miembro de la pareja será individual (aunque, por supuesto,
podrá coincidir).

## Entregas

Todo el material entregado debe estar alojado en un repositorio *git*
a elección de los alumnos. Este repositorio puede ser público o privado, pero
se tiene que asegurar el acceso a los profesores. 

Por ejemplo, si el repositorio es privado, se tiene que dar de alta el usuario
de los profesores.

### Cómo entregar

Las entregas consistirán en un texto corto con:

- Un enlace al repositorio (commit **exacto**) 
- Los miembros del equipo
- Lo que ha hecho cada miembro
- Una descripción de todo lo *relevante* (por favor, sólo lo *relevante*)
- En el repositorio git todo estará en [UTF-8](http://stackoverflow.com/questions/2241348/what-is-unicode-utf-8-utf-16), a no ser que haya una buena razón (que habrá que explicar en el texto)

En las entregas, que serán de tipo texto (es decir, no se podrán subir
archivos), se deberá incluir un texto de este tipo:

    entrega: Proyecto 4
    miembros: Alan Turing y Alonzo Church
    repo: github.com/lambda/pr4
    commit: a0bcf435d55135bf218a504cd8e45fd85b845de5

    Alonzo cree que todo es lambda y ha escrito mucho sobre ello.

    Alan, por su parte, ha creado una máquina teórica. 

    Nos hemos dado cuenta de que que ambas soluciones son equivalentes.
    Se puede probar con el script:

    $ node entscheidungsproblem.js

    Y se verá que sale el mismo resultado.

