---
title: 'Tema 1: Programación de aplicaciones en HTML5'
author: Carlos León
date: 22/09/16
vim: spelllang=es
...

# Lenguajes interpretados

## Qué son lenguajes interpretados

Los lenguajes interpretados son lenguajes que se eje

![Esquema de lenguaje interpretado](interpretes.svg){height=30%}

## ECMAScript

ECMAScript/JavaScript es el lenguaje de los navegadores.

Comenzó como un pequeño lenguaje que se interpretaba dentro de
[Netscape](https://es.wikipedia.org/wiki/Netscape_Navigator).

![Logo
Netscape](https://upload.wikimedia.org/wikipedia/commons/6/66/Netscape_logo.svg)\


## JavaScript

JavaScript es un dialecto de
[ECMAScript](https://es.wikipedia.org/wiki/ECMAScript).

```javascript
var variable = 6;

if(variable === 5) {
    console.log("Sí, es igual a 5.")
}
else {
    console.log("Pues no, vale " + variable + ".")
}
```

## Node.js

[Node.js](https://nodejs.org/) es un *intérprete* de JavaScript:

#. Recibe código JS como entrada 
#. Lo analiza (hace *parsing*) 
#. Crea una representación intermedia → ¡no lo compila!
#. Ejecuta esa representación intermedia

## Node.js como máquina virtual

Por lo tanto, `Node.js` contiene una máquina virtual capaz de leer, entender y
ejecutar JS.

Esta máquina^[una MV es sólo código, un programa que "simula" ser un ordenador] se llama [V8](https://en.wikipedia.org/wiki/V8_(JavaScript_engine)).

## Usando Node.js

`Node.js` se puede usar desde línea de comandos:

```bash
node script.js

# Pues no, vale 6. 
```

## Git

[Git](https://git-scm.com/) es el sistema de control de versiones que usaremos para la asignatura.

- [Guía sencilla](http://rogerdudler.github.io/git-guide/index.es.html)
- [Git in Couples](https://github.com/delapuente/gitincouples)

## Git y copias

Usar `git` no significa copiar.

Copiar sigue siendo ilegal en la asignatura


