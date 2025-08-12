# 🎓 Tutorial PDDL 2: Problema del Mundo de los Bloques (`problem_blocks.pddl`)

Si el fichero de **dominio** define las "reglas del juego", el fichero de **problema** define una "partida" específica. Aquí establecemos el escenario inicial y el objetivo final que queremos alcanzar. Cada fichero de problema está ligado a un dominio específico.

--- 

### Desglose del Código PDDL

#### 1. Definición del Problema y Dominio

```pddl
(define (problem blocks-problem)
  (:domain blocksworld)
```
*   `(define (problem blocks-problem))`: Declara un nuevo problema y le da el nombre `blocks-problem`.
*   `(:domain blocksworld)`: Esta línea es crucial. Vincula este problema con el dominio `blocksworld` que definimos en el otro archivo. El planificador sabrá qué acciones y predicados puede usar al leer esta línea.

#### 2. Objetos

```pddl
(:objects
  a b c - block
)
```
*   `(:objects ...)`: Aquí declaramos las "instancias" o los objetos concretos que existen en esta partida.
*   `a b c - block`: Estamos creando tres objetos llamados `a`, `b` y `c`, y le decimos al planificador que los tres son de tipo `block` (un tipo que definimos en el dominio).

#### 3. Estado Inicial

```pddl
(:init
  (ontable a)
  (ontable b)
  (ontable c)
  (clear a)
  (clear b)
  (clear c)
  (handempty)
)
```
*   `(:init ...)`: Esta sección es una "fotografía" del mundo al comenzar la partida. Cada línea es un predicado que es **verdadero** en el estado inicial.
*   `(ontable a)`: El bloque `a` está sobre la mesa.
*   `(clear a)`: El bloque `a` no tiene nada encima.
*   `(handempty)`: La mano del robot está vacía.
*   En conjunto, estas líneas describen un estado inicial donde los tres bloques (`a`, `b`, `c`) están separados sobre la mesa.

#### 4. Meta (Objetivo)

```pddl
(:goal (and
  (on a b)
  (on b c)
))
```
*   `(:goal ...)`: Aquí describimos el estado del mundo que queremos alcanzar. El plan será una secuencia de acciones que haga que todas estas condiciones sean verdaderas.
*   `(and ...)`: Es un operador lógico que significa que **todas** las condiciones dentro de él deben ser verdaderas para que se considere que hemos alcanzado la meta.
*   `(on a b)`: El primer objetivo es que el bloque `a` esté sobre el bloque `b`.
*   `(on b c)`: El segundo objetivo es que el bloque `b` esté sobre el bloque `c`.
*   El planificador deberá encontrar una secuencia de acciones (como `pick-up`, `stack`, etc.) para transformar el estado `:init` en un estado donde se cumplan estas condiciones de `:goal`, formando una torre `c-b-a`.
