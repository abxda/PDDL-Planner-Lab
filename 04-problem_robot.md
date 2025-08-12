# 🎓 Tutorial PDDL 4: Problema del Robot en Almacén (`problem_robot.pddl`)

Este fichero de **problema** establece un escenario concreto para nuestro dominio `warehouse`. Definiremos un robot, varias localizaciones, un par de cajas y le daremos al robot una misión específica que cumplir.

--- 

### Desglose del Código PDDL

#### 1. Definición del Problema y Dominio

```pddl
(define (problem warehouse-prob)
  (:domain warehouse)
```
*   `(define (problem warehouse-prob))`: Nombramos nuestro problema como `warehouse-prob`.
*   `(:domain warehouse)`: Lo vinculamos al dominio `warehouse`, asegurando que podemos usar las acciones `move`, `pick` y `drop`.

#### 2. Objetos

Aquí creamos las entidades específicas de nuestro almacén.

```pddl
(:objects
    rob1 - robot
    depot storage-a storage-b - location
    box1 box2 - item
)
```
*   `rob1 - robot`: Creamos un robot llamado `rob1`.
*   `depot storage-a storage-b - location`: Creamos tres localizaciones: `depot` (el depósito principal), `storage-a` y `storage-b`.
*   `box1 box2 - item`: Creamos dos objetos para transportar, `box1` y `box2`.

#### 3. Estado Inicial

Esta es la configuración inicial de nuestro almacén.

```pddl
(:init
  (at rob1 depot)
  (handempty rob1)
  (item-at box1 storage-a)
  (item-at box2 storage-b)
  (connected depot storage-a) (connected storage-a depot)
  (connected depot storage-b) (connected storage-b depot)
)
```
*   `(at rob1 depot)`: El robot `rob1` empieza en el `depot`.
*   `(handempty rob1)`: El robot empieza con las manos vacías.
*   `(item-at box1 storage-a)`: La caja `box1` está en la localización `storage-a`.
*   `(item-at box2 storage-b)`: La caja `box2` está en la localización `storage-b`.
*   `(connected ...)`: Definimos los caminos. El `depot` está conectado con `storage-a` y `storage-b` (y viceversa, por lo que definimos las conexiones en ambos sentidos).

#### 4. Meta (Objetivo)

Esta es la misión que el robot debe cumplir.

```pddl
(:goal (and (item-at box1 depot) (item-at box2 depot)))
```
*   `(:goal (and ...))`: El objetivo final es que se cumplan todas las condiciones dentro del `and`.
*   `(item-at box1 depot)`: La caja `box1` debe terminar en el `depot`.
*   `(item-at box2 depot)`: La caja `box2` también debe terminar en el `depot`.
*   El planificador deberá encontrar una secuencia de acciones `move`, `pick` y `drop` para que el `rob1` recoja ambas cajas de sus localizaciones iniciales y las lleve al `depot`.
