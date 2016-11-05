# Entidades de Phaser


<!-- Explicar la sandbox en lugar de esto -->
Los ejemplos de esta lección pueden probarse en la sandbox de Phaser.



<!-- Hay que advertir que hay un bug en la documentación de Phaser más actual
que oculta algunas propiedades. Mirar 2.5 y 2.4 también. -->



## El servidor local


Una vez hayas copiado la plantilla, lanza el siguiente comando:

```bash
$ node ./node_modules/gulp/bin/gulp run
```


Con ello lanzarás un navegador que cargará la plantilla proporcionada.


Fíjate en la URL del navegador. Indica `localhost:3000` que es el nombre de la
IP local y el número de puerto.


El comando `run` realiza los pasos necesarios para que no sea necesario recargar
cada vez que modifiquemos un archivo fuente. Los fuentes los puedes encontrar en
`src/js/`.



## Entidades `Image`


Las imágenes son las entidades visibles más simples de Phaser. Las entidades
son instancias de la clase [`Image`](
https://phaser.io/docs/2.6.2/Phaser.Image.html).


Su simplicidad las hace ligeras y eficientes en términos de memoria. Utilizamos
imágenes cuando no necesitamos físicas o animaciones.


De hecho, las imágenes **no se pueden mover** aunque se pueden rotar, escalar o
recortar. Esto las hace ideales para, por ejemplo, logos, imágenes de fondo,
elementos de interfaz...


Una imagen se crea a través del método factoría [`add.image`](
https://phaser.io/docs/2.6.2/Phaser.GameObjectFactory.html#image) del objeto
juego. Por ejemplo, como parte de la creación de un estado:

```js
create: function () {
  this.game.add.image(0, 0, 'logo');
}
```


En la plantilla, el logo se ha añadido como si fuera un sprite. Vamos a
_corregir_ esto haciendo que sea sólo una imagen:

```js
// En src/js/play_scene.js
create: function () {
  // Hemos cambiado add.sprite por add.image
  var logo = this.game.add.image(
    // Hablaremos sobre el mundo en breve.
    this.game.world.centerX, this.game.world.centerY, 'logo');
  logo.anchor.setTo(0.5, 0.5);
}
```


### Atributos relevantes de las imágenes

<!-- ¿Qué atributos sería interesante comentar? -->


### Métodos relevantes de las imágenes

<!-- ¿Y métodos? -->



## El mundo


En Phaser, la factoría de objetos se llama añadir (`add`) por una razón:
**porque añadimos las nuevas entidades al mundo**.


Para Phaser, el mundo, representado por la clase [`World`](
https://phaser.io/docs/2.6.2/Phaser.World.html), es la **abstracción del lugar
(un plano bidimensional) donde habitan las entidades**.


![El mundo, la cámara y entidades más allá de los límites de la cámara](
./imgs/world.svg)


Miramos al mundo a través de
[cámaras](https://phaser.io/docs/2.6.2/Phaser.Camera.html).


![El mundo, la cámara y entidades más allá de los límites de la cámara](
./imgs/world-and-camera.svg)


En Phaser existe sólo un mundo, que se crea automáticamente cuando creamos el
juego y al que se puede acceder a través del atributo [`world`](
https://phaser.io/docs/2.6.2/Phaser.Game.html#world) del objeto de juego.


También se crea una cámara, a la que podemos acceder a través del atributo
[`camera`](https://phaser.io/docs/2.6.2/Phaser.Game.html#camera) del objeto de
juego o del mundo.


Este mundo tiene un tamaño inicial igual al tamaño indicado al construir el
juego pero se expandirá conforme incluyamos entidades que sobrepasen los límites
del espacio de juego.



## Entidades `Sprite`


Bien sea manualmente o delegando en un sistema de físicas, en general querremos
mover nuestras imágenes por la pantalla. Para ello necesitaremos utilizar la
clase [`Sprite`](https://phaser.io/docs/2.6.2/Phaser.Sprite.html).


Además, son los sprites los que admiten animaciones basadas en _spritesheets_
como estudiaremos más adelante.


Las instancias de la clase `Sprite` se añaden al mundo utilizando el método
factoría [`add.sprite`](
https://phaser.io/docs/2.6.2/Phaser.GameObjectFactory.html#sprite), idéntico al
estudiado para añadir imágenes.


<!-- Ejemplo de campo de asteroides. -->


### Atributos relevantes de los sprites

<!-- ¿Qué atributos sería interesante comentar? -->


### Métodos relevantes de los sprites

<!-- ¿Y métodos? -->



## Transformaciones


Las imágenes, como otras entidades en Phaser, pueden alterar su posición,
rotación y factor de escala.


Se llama transformación a la **alteración de los atributos que controlan la
posición, la rotación o el factor de escala de una entidad**.


### Posicionamiento


Para alterar la posición de una entidad, recurrimos a los atributos [`x`](
https://phaser.io/docs/2.6.2/Phaser.Sprite.html#x) e [`y`](
https://phaser.io/docs/2.6.2/Phaser.Sprite.html#y).


<!-- El ejemplo moviendo los asteroides. -->


### Rotación


<!-- Contar el atributo angle y ejemplo rotandolos. -->

### Escalado


<!-- Contar el atributo y ejemplo escalando algunos de ellos -->


<!-- ¿Alguna transformación / alteración de los atributos que se propague
por la jerarquía y que me esté dejando? -->

### Sistemas de coordenadas

Es conveniente pensar que las transformaciones alteran el sistema de coordenadas
de la entidad en lugar de la entidad en sí.

El punto de ancla, el atributo `anchor` de una entidad, determina dónde se situa
el origen de coodenadas respecto del gráfico.



## La jerarquía del mundo


El mundo contiene entidades pero además, en Phaser, las entidades pueden
contener otras entidades formando así una jerarquía en forma de árbol.


La relación entre una entidad y sus entidades hijas es la de **pertenencia al
sistema de coordenadas**.


Es decir, si la entidad `Moon` se añade a la entidad `Earth`, significa que
`Moon` se encuentra en el sistema de coordenadas de `Earth`.


Lo que a su vez significa que al transformar `Earth` modificaremos `Moon`
indirectamente y que transformaremos `Moon` respecto del sistema de coordenadas
de `Earth`.


<!-- Ejemplo del sistema solar. -->
