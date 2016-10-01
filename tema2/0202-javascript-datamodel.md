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


### Objetos en JavaScript


De entre todos los tipos, vamos a prestar atención a aquel cuyosa valores
permiten la composición con otros. Es decir, los de tipos `'object'`.


En JavaScript, los objetos son colecciones de valores etiquetados. Por ejemplo,
si queremos representar el punto `(10, 15)` del plano XY podemos etiquetar el
valor en el eje X con la cadena `'x'` y el valor en el eje Y con la cadena
`'Y'`.


```js
var point = { 'x': 10, 'y': 15 };
```


Si las etiquetas de los datos, llamadas normalmente **propiedades del objeto**,
se escriben siguiendo las [reglas de formación de identificadores](
) en JavaScript, las comillas no son necesarias.


```js
var point = { x: 10, y: 10 }; // mucho más conveniente
```


Este es el caso **más normal y el recomendado** y a lo largo del curso usaremos
este pero conviene saber que por detrás, **la etiqueta es una cadena**.


Para acceder a las propiedades de un objeto usamos los corchetes con la cadena
de la propiedad en medio:

```js
point['x'];
point['y'];
```


De nuevo, si seguimos las reglas de formación de identificadores, podemos usar
la notación punto para acceder a la propiedad, mucho más rápida de escribir:

```js
point.x;
point.y;
```


Para cambiar el valor de una propiedad usamos el operador de asignación:

```js
point.x = 0;
point.y = 0;
point['x'] = 0;
point['y'] = 0;
```


### Arrays


Las **listas** o **arrays** son colecciones de datos ordenados.


### `null`


Existe un último valor para el tipo objeto que es `null`. Este valor representa
la **ausencia de objeto** y se suele utilizar para:

  + En funciones en las que se pregunta por un objeto, indicar que no se ha
  encontrado.
  + En relaciones de composición, indicar que el objeto compuesto ya no necesita
  al objeto componente.


Por ejemplo, en el ejemplo de Space Invaders, suponed que preguntamos por el
enemigo especial:

```js
function getSpecialEnemy() {
  // buscar por el enemigo especial...
  // ... y si no lo encuentras
  return null;
}
```

En el contexto de JavaScript, los objetos no son exactamente lo mismo que en el
modelado orientado a objetos. No obstante, los objetos de JavaScript se acercan
bastante a los objetos del modelado orientado a objetos.

```js
true.toString();
3.1415.toFixed(2);
'I want to be a pirate!'.split(' ');
({}).hasOwnProperty('x');
(function (parameter) { return parameter; }).length;
```


Un mensaje se envía especificando el destinatario, seguido de un punto, seguido
del nombre del mensaje.
