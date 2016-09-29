# El modelo de datos de JavaScript



Lenguaje de programación = sintaxis + modelo de datos + modelo de ejecución



(+ jerga)



Lo que vamos a hacer ahora es codificar el modelo de Space Invaders [que creamos
anteriormente](./0201-oop-programming). No todos los lenguajes permiten una
transcripción 1 a 1 de los conceptos que recogemos en el modelo.



Por ejemplo, JavaScript no tiene un mecanismo para crear tipos nuevos pero
tiene otros mecanismos que permiten codificar una funcionalidad similar.



## Experimentando con JavaScript


Vamos a experimentar con JavaScript así que necesitamos una forma rápida de
inspeccionar expresiones y obtener feedback de lo que estamos haciendo. La mejor
forma es utilizar la consola de _node_. Por ejemplo:

```sh
$ node
```


Ahora puedes probar a introducir algunas expresiones:

```sh
> 40 + 2
42
> var point = { x: 1, y: 1 };
undefined
> point
{ x: 1, y: 1 }
> point.x
1
```

Para salir de _node_, presiona `ctrl+c` dos veces seguidas.


Si no quieres lidiar con la consola de _node_, siempre puedes escribir un
programa y usar `console.log()` para mostrar expresiones por pantalla.


```js
// en prueba.js
console.log(40 + 2);
var point = { x: 1, y: 1 };
console.log(point);
console.log('Coordenada X:', point.x);
```


Y ahora ejecutar el programa con node:

```sh
$ node prueba.js                                                                                             2.2.3
42
{ x: 1, y: 1 }
Coordenada X 1
```


La lección asume que cada ejemplo es una sesión **distinta** (a menos que se
indique lo contrario) de la consola de _node_.


Para la mayoría de los ejemplos, puedes mantener la misma sesión abierta pero
si te encuentras con algo inesperado, antes de nada prueba a reiniciar la
consola. Para reiniciar la consola tienes que **salir y volver a entrar**.



## Tipos primitivos


Se llama **tipos primitivos** a aquellos que vienen con el lenguaje y que
permiten la creación de nuevos tipos más complejos. En JavaScript, los tipos
primitivos son: **booleanos**, **números**, **cadenas**, **objetos** y
**funciones**.


```js
// en los comentarios hay más valores posibles para cada uno de los tipos
var bool = true; // false
var number = 1234.5; // 42, -Infinity, +Infinity
var text = 'I want to be a pirate!'; // "I want to be a pirate"
var object = {}; // [], null
var code = function () { return 42; };
```


Los puedes reconocer porque responden de manera distinta al operador `typeof`:

```js
typeof true;
typeof 1234.5;
typeof 'I want to be a pirate!';
typeof {};
typeof function () { return 42; };
```


En JavaScript podemos declarar una variable y no asignarle ningún valor. En
este caso el tipo de la variable será `undefined`.

```js
var x;
typeof x;
x = 5; // tan pronto como le demos un valor, el tipo dejará de ser undefined
typeof x;
```



## Objetos


De entre todos los tipos primitivos, vamos a prestar atención a aquellos que
permiten la composición de objetos

```js
true.toString();
3.1415.toFixed(2);
'I want to be a pirate!'.split(' ');
({}).hasOwnProperty('x');
(function (parameter) { return parameter; }).length;
```


Un mensaje se envía especificando el destinatario, seguido de un punto, seguido
del nombre del mensaje.
