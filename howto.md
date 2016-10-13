---
title: HOW-TO para PVLI
author: Carlos León
date: 10/10/2016
vim: spelllang=es
...

# Introducción

Este documento resume cómo añadir material a PVLI

# Temas

Cada tema irá en su carpeta correspondiente.

# Exámenes

# Prácticas

Para las prácticas se generarán, por práctica:

- Enunciado, con criterios de evaluación claros, por apartados
- Todos los envíos consistirán en **un único archivo `.zip`** con esta
  estructura de directorios:
        - `/`
            - `/img`
            - `/snd`
            - `/src`
            - `README.md`
            - `gulpfile.js`
            - `package.json`
- Tests automáticos (entrada/salida, `jlint`...)
- 

# Correcciones

- Para corregir, se pasarán los tests automáticos. Si pasan todos, se pondrá la
  nota base y se hará una evaluación general del funcionamiento (si hace "lo
  que tiene que hacer"). Esto será una parte de la nota.
- Después se evaluará la *corrección* del código.
- Se evaluará cuánto se ajusta *funcionalmente* al enunciado. No es
  obligatorio, pero es posible considerar positivamente todos los extras que el
  alumno haya querido incluir.
- Se evaluará el *estilo* del código. Tendremos en cuenta que son estudiantes
  de segundo.

# Tools

En la asignatura se usará:

- `node.js`. Hay que fijar versión.
- `npm`. Hay que fijar versión.
- `Firefox`. Hay que fijar versión.
- `gulp`. Hay que fijar versión (aunque `npm` debería encargarse de eso).
- TODO: plugin para reloading
- `phaser`. Hay que fijar versión.

# Plantillas

# Licencia

Todo el material quedará publicado con licencia libre (CC o equivalentes, por
determinar).

# Publicación

Para hacer una publicación directa del contenido en Moodle, el directorio
`compartido/` se hará público para los estudiantes a través del Google Drive de
Carlos <cleon@ucm.es>, y se enlazarán como URL.

# Crear un juego

#. Copiar la carpeta `plantilla-juego`
#. Poner en `package.json` el *autor*, el *repo git* y demás datos (además de
mantener la versión.
#. Seguir las instrucciones que hay en README
