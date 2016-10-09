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
function newDie(sides) {
  return function () {
    return Math.floor(Math.random() * sides) + 1;
  };
}
var d100 = newDie(100);
var d20 = newDie(20);

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

  newDie: function (sides) {
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
var d10 = diceUtils.newDie(10);
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


Lo que tenemos que hacer es que la función `die` dentro de `newDie` se refiera
al `this` del ámbito superior, no al suyo. Podemos hacer esto con un truco muy
simple:


```js
var diceUtils = {
  history: [], // Lleva el histórico de dados.

  newDie: function (sides) {
    var self = this; // self es ahora el destinatario de newDie.
    return function die() {
      var result = Math.floor(Math.random() * sides) + 1;
      // Usando self nos referimos al destinatario de newDie.
      self.history.push([new Date(), sides, result]);
      return result;
    }
  }
}
```


Esto sí funciona y es mucho más conveniente:

```js
var d10 = diceUtils.newDie(10);
var d6 = diceUtils.newDie(6);
d10();
d6();
d10();
```



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
"use strict";
var text = 'I\'m Ziltoid, the Omniscient.';

// En b.js, text es visible únicamente dentro del FICHERO.
"use strict";
var text = 'Greetings humans!';

// En una consola iniciada en el mismo directorio que a y b
require('a');
require('b');
text;
```



## Módulos
Esta sección presenta la característica _módulos_ que es específica de node.


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
"use strict";
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
"use strcit"
var dice = require('./dados');
var sanityCheck = dice.d100();
console.log(sanityCheck);
```


Para importar un módulo desde otro hay que pasar a [`require`](
https://nodejs.org/api/modules.html#modules_module_require_id)
**la ruta relativa hasta el fichero del módulo** que queremos importar
**sin extensión**. La ruta **es relativa al fichero que quiere importar**.


Si en lugar de una ruta, pasamos un nombre, accederemos a la **funcionalidad
que viene por defecto con node** o la que instalemos de terceras partes.
Usaremos esta forma en un par de ocasiones más adelante.



## Programación asíncrona y eventos


Prueba el siguiente ejemplo (copia, pega y espera 5 segundos):

```js
var fiveSeconds = 5 * 1000; // en milisegundos.
setTimeout(function () {
  // Esto ocurre pasados 5 segundos.
  console.log('T + 5 segundos: ', new Date());
}, fiveSeconds);

// Esto ocurre inmediatamente.
console.log('T: ', new Date());
```


Como puedes comprobar, el mensaje se completa pasados 5 segundos porque lo que
hace [`setTimeout`](
https://developer.mozilla.org/en-US/docs/Web/API/WindowTimers/setTimeout) es
llamar a la función tan pronto como pasen el número de milisegundos indicados.


Decimos que una función es una **_callback_** si se llama en algún momento
futuro, es decir, **asíncronamente**, para informar de algún resultado.


En el ejemplo de `setTimeout` el resultado es que ha pasado la cantidad de
tiempo especificada.


### Eventos
Esta sección presenta el módulo `readline` que es específico de node.


La programación asíncrona en JavaScript y otros lenguajes se usa para **modelar
eventos**, principalmente **esperas por entrada y salida**. En otras palabras:
hitos que ocurren pero que **no sabemos cuándo ocurren**.


La entrada y salida, a partir de ahora IO (del inglés _input / output_), no solo
supone lectura de ficheros o peticiones a la red, también incluye esperar por
una acción del usuario.


Por ejemplo:

```js
// En conversational.js
"use strict";

var readline = require('readline');

var cmd = readline.createInterface({
  input: process.stdin,  // así referenciamos la consola como entrada.
  output: process.stdout, // y así, como salida.
  prompt: '(╯°□°）╯ ' // lo que aparece para esperar la entrada del usuario.
});
```


Lanza ese programa con node y verás que no hace nada **pero tampoco termina**.
Esto es típico de los programas asíncronos. El programa queda esperando a que
pase algo. Pulsa `ctrl+c` para terminar el programa.


Ahora prueba:

```js
// Añade al final de conversational.js
console.log('Escribe algo y pulsa enter');
cmd.prompt(); // pide que el usuario escriba algo.

cmd.on('line', function (input) {
  console.log('Has dicho "' + input  + '"');
  cmd.prompt(); // pide que el usuario escriba algo.
});
```


Lo que has conseguido es **escuchar por el evento `line`** que se produce
[cada vez que en la entrada se recibe un caracter de cambio de línea](
https://nodejs.org/api/readline.html#readline_event_line).


Hablando de eventos, la función que se ejecuta asíncronamente recibe el nombre de
**_listener_** pero tampoco es raro que se la llame **_callback_**.


Se habla de **registrar un listener para un evento** o **escuchar por ese
evento** a utilizar el mecanismo que permite asociar la ejecución de una función
con dicho evento.


Con todo, aun no puedes salir del programa. Necesitas algunos cambios más:

```js
// Modifica el listener en conversational.js
cmd.on('line', function (input) {
  console.log('Has dicho "' + input  + '"');
  if (input === 'salir') {
    cmd.close();
  }
  cmd.prompt();
});

// Y añade al final...
cmd.on('close', function () {
  console.log('¡Nos vemos!');
  process.exit(0); // sale de node.
});
```


Ahora, cuando la entrada sea exactamente `salir`, cerraremos la interfaz de
línea de comandos. Esto produce un evento `close` y cuando lo recibamos,
utilizaremos el _lístener_ de ese evento para terminar el programa.


### Emisores de eventos
Esta sección presenta la clase EventEmitter que es específica de node.


Los eventos **no son un mecanismo estándar** de JavaScript. Son una forma
conveniente de modelar determinados tipos de problema pero un objeto JavaScript,
por sí solo, **no tiene API para emitir eventos**.


**En node**, para que nuestros objetos emitan eventos, tenemos varias
alternativas:


  + Implementar nuestra propia API de eventos.
  + Hacer que nuestros objetos **usen** una instancia de `EventEmitter`.
  + Hacer que nuestros objetos **sean instancias** de `EventEmitter`.


La primera supone crear nuestro propio método `on()` y los mecanismos para
emitir eventos. El segundo y el tercero usan la clase [`EventEmitter`](
https://nodejs.org/api/events.html#events_class_eventemitter) que ya implementa
esta API.


Implementaremos la opción 3 para practicar la herencia:

```js
var events = require('events');
var EventEmitter = events.EventEmitter;

function Nave() {
  EventEmitter.apply(this);
  this._ammunition = 'laser charges';
}
Nave.prototype = Object.create(EventEmitter.prototype);
Nave.prototype.constructor = Nave;

var nave = new Nave();
nave.on; // existe!
```


Ahora que nuestra nave puede emitir eventos, vamos a hacer que dispare y que
emita un evento.

```js
Nave.prototype.shoot = function () {
  console.log('PICHIUM!');
  this.emit('shoot', this._ammunition); // parte de la API de EventEmitter.
};

nave.on('shoot', function (ammunition) {
  console.log('La nave ha disparado: ', ammunition);
});

nave.shoot();
```


Los eventos son increiblemente útiles para modelar interfaces de usuario de
forma genérica.


Para ello, los **modelos deben publicar qué les ocurre**: cómo cambian, qué
hacen... Todo **a base de eventos**. Las **interfaces de usuario se
suscribirán** a estos eventos y proporcionarán la información visual adecuada.


Este modelo permite además que varias interfaces de usuario funcionen al mismo
tiempo, todas escuchando por los mismos eventos aunque también permite partir
la interfaz en otras especializadas, cada una escuchando por un determinado
conjunto de eventos.
