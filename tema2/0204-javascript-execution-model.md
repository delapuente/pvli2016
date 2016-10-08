# El modelo de ejecución de JavaScript



JavaScript se caracteriza por presentar un modelo de ejecución asíncrono donde
los resultados **no se encuentran disposibles inmediatamente** sino que lo
estarán en un futuro.



## Ámbito y _hoisting_


Como en muchos lenguajes, los nombres de las funciones **pueden reutilizarse** y
guardar valores distintos siempre y cuando se encuentren en **ámbitos
distintos**.


El ámbito o _scope_ de una variable es la porción de código donde puede ser
utilizada. **Variables con el mismo nombre en ámbitos distintos son variables
distintas**.


El **ámbito en JavaScript es el cuerpos de la función**, delimitado entre las
llaves `{` y `}` que marcan el comienzo y final del cuerpo del mismo.


```js
function introduction() {
  // Esta es la variable text.
  var text = 'I\'m Ziltoid, the Omniscient.';
  greetings();
  console.log(text);
}

function greetings(list) {
  // Y esta es OTRA variable text distinta.
  var text = 'Greetings humans!';
  console.log(text);
}

introduction();
```


En JavaScript, las funciones pueden definirse dentro de otras funciones y de
esta forma, anidar ámbitos.


El aniadmiento de funciones es útil cuando se quieren usar **pequeñas funciones
auxiliares**.


```js
function getEven(list) {
  function isEven(n) {
    return n % 2 === 0;
  }
  return list.filter(isEven);
}

getEven([1, 2, 3, 4, 5, 6]);
```


Como el ámbito es el de la función, el **mismo nombre en una función anidada se
referiere a otra cosa**:

```js
function introduction() {
  // Esta es una variable text.
  var text = 'I\'m Ziltoid, the Omniscient.';

  function greetings(list) {
    // Y esta es OTRA variable text distinta.
    var text = 'Greetings humans!';
    console.log(text);
  }

  greetings();
  console.log(text);
}

introduction();
```


En el caso anterior, decimos que la variable `text` de la función anidada
`greetings()` oculta a la variable `text` de la función `introduction()`.


Recuerda que para introducir una **nueva variable** necesitas declararla con
`var` antes de usarla (o al mismo tiempo que la asignas).


Si omites la palabra `var`, no estás creando una nueva variable sino
**reutilizando** la que ya existía.


```js
function introduction() {
  // Esta es una variable text.
  var text = 'I\'m Ziltoid, the Omniscient.';

  function greetings(list) {
    // Esta es la MISMA variable text que la de afuera.
    text = 'Greetings humans!';
    console.log(text);
  }

  greetings();
  console.log(text);
}

introduction();
```


### Hoisting


En JavaScript da igual a qué altura de la función declares una variable.
JavaScript asumirá cualquier declaración como si ocurriese al comienzo de
la función.


Es decir que esto:

```js
function f() {
  for (var i = 0; i < 10; i++) {
    for (var j = 0; j < 10; j++) {
      console.log('i: ', i, ' j: ', j);
    }
  }
}
```


Es equivalente a esto:

```js
function f() {
  var i;
  var j;
  for (i = 0; i < 10; i++) {
    for (j = 0; j < 10; j++) {
      console.log('i: ', i, ' j: ', j);
    }
  }
}
```


Fíjate que JavaScript **_alza_ la declaración de la variable, no la
inicialización**. Es por eso que este código no falla pero imprime `undefined`:

```js
function f() {
  console.log(i);
  var i = 5;
}
f();
```


En modo estricto, usar una variable que no ha sido declarada **es un error**.

```js
function f() {
  console.log(i); // comenta esto después de probar f.
  i = 5;
}
f();
```


Con las declaraciones de funciones esto no pasa, cuando una declaración de
función se alza, se alza entera, **definición incluída**.

```js
function getEven(list) {
  return list.filter(isEven);

  function isEven(n) {
    return n % 2 === 0;
  }
}

getEven([1, 2, 3, 4, 5, 6]);
```


Esto permite una bonita forma de ordenar el código en el que las funciones
auxiliares pueden situarse más abajo en las funciones que las utilicen.


Así, viendo sólo la línea:

```js
  return list.filter(isEven);
```

Ya podemos saber qué significa.


Y si aun tenemos dudas, podemos bajar e investigar qué es esa función.

```js
  function isEven(n) {
    return n % 2 === 0;
  }
```



## _Closures_


Las funciones son datos y se crean cada vez que se encuentra una instrucción
`function`. De esta forma podemos crear una función que devuelva funciones.


```js
function buildFunction() {
  return function () { return 42; };
}

var f = buildFunction();
var g = buildFunction();

typeof f === 'function';
typeof g === 'function';

f();
g(); // Las funciones hacen lo mismo...

f !== g; // ...pero NO son la misma función
```


Por sí sólo, este no es un mecanismo muy potente pero sabiendo que una
función anidada puede acceder a las variables de los ámbitos superiores,
podemos hacer algo así:


```js
function newDice(sides) {
  return function () {
    return Math.floor(Math.random() * sides) + 1;
  };
}
var d100 = newDice(100);
var d20 = newDice(20);

d100();
d20();
```


En JavaScript, **las funciones retienen el acceso a las variables en ámbitos
superiores**.


Una **función que se refiere a alguna de las variables en ámbitos superiores
se denomina _closure_**.


Esto **no afecta al valor de `this`** que seguirá siendo **el destinatario
del mensaje**.


### Métodos, closures y `this`


Considera el siguiente ejemplo:

```js
var diceUtils = {
  history: [], // Lleva el histórico de dados.

  newDice: function (sides) {
    return function die() {
      var result = Math.floor(Math.random() * sides) + 1;
      this.history.push([new Date(), sides, result]);
      return result;
    }
  }
}
```


Nuestra intención es poder crear dados y llevar un registro de todas las tiradas
que se hagan con estos dados.


Pero esto no funciona:

```js
var d10 = diceUtils.newDice(10);
d10(); // error!
```


Y es así porque **`this` siempre es el destinatario del mensaje** y `d10` se
está llamando como si fuera una función y no un método.


Recordad que podíamos hacer que cualquier función tomara un valor forzoso como
`this` con `.apply()` por lo que esto sí funciona pero es un engorro:

```js
d10.apply(diceUtils);
d10.apply(diceUtils);
diceUtils.history;
```


Lo que tenemos que hacer es que la función `die` dentro de `newDice` se refiera
al `this` del ámbito superior, no al suyo. Podemos hacer esto con un truco muy
simple:


```js
var diceUtils = {
  history: [], // Lleva el histórico de dados.

  newDice: function (sides) {
    var self = this; // self es ahora el destinatario de newDice.
    return function die() {
      var result = Math.floor(Math.random() * sides) + 1;
      // Usando self nos referimos al destinatario de newDice.
      self.history.push([new Date(), sides, result]);
      return result;
    }
  }
}
```


Esto sí funciona y es mucho más conveniente:

```js
var d10 = diceUtils.newDice(10);
var d6 = diceUtils.newDice(6);
d10();
d6();
d10();
```



## Programación asíncrona y eventos




## Diferencias entre ámbitos en node y el navegador


Hemos dicho que el ámbito en JavaScript es equivalente a la función pero sabemos
que podemos abrir una consola o un fichero y empezar a declarar variables sin
necesidad de escribir una función.


Esto es así porque estamos usando el **ámbito global**. El ámbito global está
**disponible en el navegador y en node**.


```js
// Esta es una variable text en el ámbito GLOBAL
var text = 'I\'m Ziltoid, the Omniscient.';

// Esta es una función en el ámbito GLOBAL
function greetings(list) {
  // Esta es OTRA variable text en el ámbito de la función.
  var text = 'Greetings humans!';
  console.log(text);
}

greetings();
console.log(text);
```


Sin embargo, existe una peculiaridad en node. El ámbito global es realmente
**local al fichero**. Esto quiere decir que:

```js
// En a.js, text es visible únicamente dentro del FICHERO.
var text = 'I\'m Ziltoid, the Omniscient.';

// En b.js, text es visible únicamente dentro del FICHERO.
var text = 'Greetings humans!';

// En una consola iniciada en el mismo directorio que a y b
require('a');
require('b');
text;
```



## Módulos


Una de las principales desventajas de JavaScript (hasta la próxima versión) es
que no hay forma de organizar el código en módulos.


Los módulos sirven para aglomerar funcionalidad relacionada: tipos, funciones,
constantes, configuración...


Node sí tienen módulo y, afortunadamente, existen herramientas que simulan
módulos como los de node en el navegador.


En node, **los ficheros JavaScript acabados en `.js` son módulos**.


Node permite exponer o **exportar funcionalidad de un módulo**:

```js
// En dice.js
function die100Sides() {
  return Math.floor(Math.random() * 100) + 1;
}

// Asigna la función die100Sides a la propiedad d100 del objeto module.exports
module.exports.d100 = die100Sides;
```

Poniéndola dentro del objeto `module.exports`


Realmente, lo que se exporta es **siempre `module.exports`**, que en principio
es un objeto vacío:

```js
typeof module.exports;
module.exports;
```

Lo que pongas dentro, queda también exportado.


Y ahora **importarlo desde otro módulo**:

```js
// En cthulhuRpg.js
var dice = require('./dados');
var sanityCheck = dice.d100();
console.log(sanityCheck);
```
