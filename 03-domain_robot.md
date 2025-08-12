# 🎓 Tutorial PDDL 3: Dominio del Robot en Almacén (`domain_robot.pddl`)

En este tutorial, avanzamos a un problema ligeramente más complejo: un robot que opera en un almacén. El **dominio** definirá las capacidades de este robot: cómo se mueve, cómo recoge y deja objetos, y las reglas del entorno del almacén.

--- 

### Desglose del Código PDDL

#### 1. Definición del Dominio y Requisitos

```pddl
(define (domain warehouse)
  (:requirements :strips :typing)
```
*   `(define (domain warehouse))`: Declaramos un nuevo dominio llamado `warehouse`.
*   `(:requirements :strips :typing)`: Al igual que antes, usamos las funcionalidades básicas de PDDL y la definición de tipos.

#### 2. Tipos de Objetos

```pddl
(:types robot location item)
```
*   `(:types ...)`: Aquí definimos tres categorías distintas de objetos para hacer nuestro modelo más claro.
*   `robot`: Representará a nuestros agentes móviles.
*   `location`: Representará los distintos lugares en el almacén (ej. 'depósito', 'almacén-a').
*   `item`: Representará los paquetes o cajas que deben ser movidos.

#### 3. Predicados

Estos predicados describen el estado del robot y los objetos en el almacén.

```pddl
(:predicates
  (at ?r - robot ?l - location)
  (item-at ?i - item ?l - location)
  (carrying ?r - robot ?i - item)
  (handempty ?r - robot)
  (connected ?l1 - location ?l2 - location)
)
```
*   `(at ?r - robot ?l - location)`: El robot `?r` se encuentra en la localización `?l`.
*   `(item-at ?i - item ?l - location)`: El objeto `?i` se encuentra en la localización `?l`.
*   `(carrying ?r - robot ?i - item)`: El robot `?r` está cargando el objeto `?i`.
*   `(handempty ?r - robot)`: El robot `?r` no está cargando nada.
*   `(connected ?l1 - location ?l2 - location)`: Existe un camino directo entre la localización `?l1` y la `?l2`.

#### 4. Acciones

**Acción: `move` (Mover el robot)**
```pddl
(:action move
  :parameters (?r - robot ?from - location ?to - location)
  :precondition (and (at ?r ?from) (connected ?from ?to))
  :effect (and (at ?r ?to) (not (at ?r ?from)))
)
```
*   `:parameters`: La acción necesita saber qué robot `?r` se mueve, desde dónde `?from` y hacia dónde `?to`.
*   `:precondition`: Para moverse, el robot `?r` debe estar en la localización de origen `?from`, y debe existir una conexión entre `?from` y `?to`.
*   `:effect`: El robot ya no está en `?from` (`not (at ?r ?from)`) y ahora está en `?to` (`at ?r ?to`).

**Acción: `pick` (Recoger un objeto)**
```pddl
(:action pick
  :parameters (?r - robot ?i - item ?l - location)
  :precondition (and (at ?r ?l) (item-at ?i ?l) (handempty ?r))
  :effect (and (carrying ?r ?i) (not (item-at ?i ?l)) (not (handempty ?r)))
)
```
*   `:precondition`: Para recoger el objeto `?i`, el robot `?r` debe estar en la misma localización `?l` que el objeto, y el robot no debe estar cargando nada (`handempty`).
*   `:effect`: El robot ahora está cargando el objeto `?i`, el objeto `?i` ya no está en la localización `?l`, y el robot ya no tiene las manos vacías.

**Acción: `drop` (Dejar un objeto)**
```pddl
(:action drop
  :parameters (?r - robot ?i - item ?l - location)
  :precondition (and (at ?r ?l) (carrying ?r ?i))
  :effect (and (item-at ?i ?l) (handempty ?r) (not (carrying ?r ?i)))
)
```
*   `:precondition`: Para dejar el objeto `?i`, el robot `?r` debe estar en la localización `?l` deseada y debe estar cargando dicho objeto `?i`.
*   `:effect`: El objeto `?i` ahora está en la localización `?l`, el robot vuelve a tener las manos vacías, y ya no está cargando el objeto.
