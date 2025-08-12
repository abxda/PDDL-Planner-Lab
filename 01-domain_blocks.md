# 🎓 Tutorial PDDL 1: Dominio del Mundo de los Bloques (`domain_blocks.pddl`)

Este tutorial desglosa el fichero de dominio para el clásico "Mundo de los Bloques". El objetivo de un fichero de **dominio** es definir la "física" de nuestro universo: qué tipos de objetos existen, qué propiedades pueden tener y, lo más importante, qué acciones se pueden realizar para cambiar el estado del mundo.

--- 

### Desglose del Código PDDL

#### 1. Definición del Dominio

```pddl
(define (domain blocksworld)
```
*   `(define (domain blocksworld))`: Esta es la primera línea de todo dominio. Declara un nuevo dominio y le da un nombre, en este caso, `blocksworld`.

#### 2. Requisitos

```pddl
(:requirements :strips :typing)
```
*   `(:requirements ...)`: Aquí especificamos qué características del lenguaje PDDL vamos a usar.
*   `:strips`: Es el subconjunto más básico de PDDL. Significa que nuestras acciones tendrán precondiciones y efectos simples (listas de hechos positivos y negativos).
*   `:typing`: Nos permite definir "tipos" o "categorías" de objetos, como `bloque`, `coche` o `persona`. Esto hace que el modelo sea más claro y robusto.

#### 3. Tipos de Objetos

```pddl
(:types 
  block
)
```
*   `(:types ...)`: En esta sección, definimos las categorías de objetos.
*   `block`: Para este problema, solo tenemos un tipo de objeto en nuestro mundo: el `block`.

#### 4. Predicados

Los predicados son como "frases con espacios en blanco" que describen los estados o relaciones que pueden ser verdaderos o falsos.

```pddl
(:predicates
  (on ?x - block ?y - block)  
  (ontable ?x - block)        
  (clear ?x - block)          
  (handempty)                 
  (holding ?x - block)        
)
```
*   `(on ?x - block ?y - block)`: Es verdad si el bloque `?x` está encima del bloque `?y`. Las variables `?x` y `?y` deben ser de tipo `block`.
*   `(ontable ?x - block)`: Es verdad si el bloque `?x` está sobre la mesa.
*   `(clear ?x - block)`: Es verdad si el bloque `?x` no tiene nada encima.
*   `(handempty)`: Es verdad si la mano del robot está vacía. No necesita parámetros.
*   `(holding ?x - block)`: Es verdad si la mano del robot está sosteniendo el bloque `?x`.

#### 5. Acciones

Las acciones definen cómo se puede cambiar el estado del mundo. Cada acción tiene parámetros, precondiciones (lo que debe ser verdad para ejecutarla) y efectos (lo que cambia en el mundo después de ejecutarla).

**Acción: `pick-up` (Recoger un bloque de la mesa)**
```pddl
(:action pick-up
  :parameters (?x - block)
  :precondition (and (clear ?x) (ontable ?x) (handempty))
  :effect (and (not (ontable ?x)) (not (clear ?x)) (not (handempty)) (holding ?x))
)
```
*   `:parameters (?x - block)`: La acción opera sobre un objeto, `?x`, que debe ser un bloque.
*   `:precondition (and ...)`: Para poder recoger `?x`, deben cumplirse tres condiciones: `?x` debe estar libre (`clear`), debe estar sobre la mesa (`ontable`), y la mano del robot debe estar vacía (`handempty`).
*   `:effect (and ...)`: Después de la acción, el mundo cambia: `?x` ya no está en la mesa (`not (ontable ?x)`), `?x` ya no está libre porque la mano lo ocupa (`not (clear ?x)`), la mano ya no está vacía (`not (handempty)`) y ahora está sosteniendo `?x` (`holding ?x`).

**Acción: `put-down` (Poner un bloque en la mesa)**
```pddl
(:action put-down
  :parameters (?x - block)
  :precondition (holding ?x)
  :effect (and (ontable ?x) (clear ?x) (handempty) (not (holding ?x)))
)
```
*   `:precondition`: Solo se puede ejecutar si la mano está sosteniendo el bloque `?x`.
*   `:effect`: El bloque `?x` ahora está en la mesa, está libre, la mano queda vacía y, por supuesto, ya no sostiene `?x`.

**Acción: `stack` (Apilar un bloque sobre otro)**
```pddl
(:action stack
  :parameters (?x - block ?y - block)
  :precondition (and (holding ?x) (clear ?y))
  :effect (and (on ?x ?y) (clear ?x) (handempty) (not (holding ?x)) (not (clear ?y)))
)
```
*   `:parameters`: Necesita dos bloques, `?x` (el que se apila) y `?y` (la base).
*   `:precondition`: Debemos estar sosteniendo `?x` y el bloque `?y` debe estar libre para poder apilar sobre él.
*   `:effect`: `?x` ahora está sobre `?y`, la parte superior de `?x` queda libre, la mano se vacía, ya no sostenemos `?x` y el bloque `?y` ahora está ocupado (`not (clear ?y)`).

**Acción: `unstack` (Desapilar un bloque de otro)**
```pddl
(:action unstack
  :parameters (?x - block ?y - block)
  :precondition (and (on ?x ?y) (clear ?x) (handempty))
  :effect (and (holding ?x) (clear ?y) (not (on ?x ?y)) (not (clear ?x)) (not (handempty)))
)
```
*   `:precondition`: Para desapilar `?x` de `?y`, `?x` debe estar sobre `?y`, la parte superior de `?x` debe estar libre y la mano debe estar vacía.
*   `:effect`: Ahora sostenemos `?x`, el bloque `?y` queda libre, la relación `(on ?x ?y)` deja de ser cierta, `?x` ya no está libre y la mano ya no está vacía.
