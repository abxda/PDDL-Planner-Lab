# 🎓 Tutorial PDDL 5: Dominio de la Actividad de Logística (`actividad-domain.pddl`)

Este tutorial explica el dominio PDDL diseñado específicamente para la **Actividad de Logística** del curso. El objetivo es modelar un problema de transporte con un camión que se mueve entre ciudades. Este dominio es una versión simplificada de un problema logístico, ideal para entender los fundamentos del modelado.

--- 

### Desglose del Código PDDL

#### 1. Definición del Dominio y Requisitos

```pddl
(define (domain logistica-actividad)
  (:requirements :strips :typing)
```
*   `(define (domain logistica-actividad))`: Damos un nombre claro y descriptivo a nuestro dominio.
*   `(:requirements :strips :typing)`: Indicamos que usaremos acciones básicas y tipos de objetos, lo que nos permite diferenciar entre un `paquete` y un `camion`, por ejemplo.

#### 2. Tipos de Objetos

```pddl
(:types 
  paquete camion localizacion - object
)
```
*   `(:types ...)`: Definimos las categorías de objetos que existen en este mundo.
*   `paquete`: Representará la carga que debe ser transportada.
*   `camion`: El vehículo que realiza el transporte.
*   `localizacion`: Representará las ciudades o puntos en el mapa.
*   `- object`: Esta parte indica que `paquete`, `camion` y `localizacion` son sub-tipos del tipo genérico `object`, que es el tipo base en PDDL.

#### 3. Predicados

Estos son los hechos que pueden ser verdaderos o falsos para describir el estado del mundo.

```pddl
(:predicates
  (en-paquete ?p - paquete ?l - localizacion)
  (en-camion ?c - camion ?l - localizacion)
  (paquete-en-camion ?p - paquete ?c - camion)
  (conectado ?l1 - localizacion ?l2 - localizacion)
)
```
*   `(en-paquete ?p - paquete ?l - localizacion)`: El paquete `?p` está en la localización `?l`.
*   `(en-camion ?c - camion ?l - localizacion)`: El camión `?c` está en la localización `?l`.
*   `(paquete-en-camion ?p - paquete ?c - camion)`: El paquete `?p` está cargado dentro del camión `?c`.
*   `(conectado ?l1 - localizacion ?l2 - localizacion)`: Hay una ruta directa entre `?l1` y `?l2`.

#### 4. Acciones

**Acción: `mover`**
```pddl
(:action mover
  :parameters (?c - camion ?desde - localizacion ?hacia - localizacion)
  :precondition (and (en-camion ?c ?desde) (conectado ?desde ?hacia))
  :effect (and (not (en-camion ?c ?desde)) (en-camion ?c ?hacia))
)
```
*   `:parameters`: La acción necesita un camión `?c`, un origen `?desde` y un destino `?hacia`.
*   `:precondition`: El camión debe estar en la localización de origen y debe existir una conexión entre el origen y el destino.
*   `:effect`: El camión deja de estar en el origen (`not (en-camion ...)` ) y pasa a estar en el destino.

**Acción: `cargar`**
```pddl
(:action cargar
  :parameters (?p - paquete ?c - camion ?l - localizacion)
  :precondition (and (en-paquete ?p ?l) (en-camion ?c ?l))
  :effect (and (not (en-paquete ?p ?l)) (paquete-en-camion ?p ?c))
)
```
*   `:precondition`: Para cargar el paquete `?p` en el camión `?c`, ambos deben estar en la misma localización `?l`.
*   `:effect`: El paquete deja de estar en la localización y pasa a estar dentro del camión.

**Acción: `descargar`**
```pddl
(:action descargar
  :parameters (?p - paquete ?c - camion ?l - localizacion)
  :precondition (and (paquete-en-camion ?p ?c) (en-camion ?c ?l))
  :effect (and (not (paquete-en-camion ?p ?c)) (en-paquete ?p ?l))
)
```
*   `:precondition`: Para descargar, el paquete debe estar en el camión, y el camión debe estar en la localización de descarga `?l`.
*   `:effect`: El paquete deja de estar en el camión y pasa a estar en la nueva localización.
