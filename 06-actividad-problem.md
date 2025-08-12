# 🎓 Tutorial PDDL 6: Problema de la Actividad de Logística (`actividad-problem.pddl`)

Este fichero de problema configura el escenario exacto solicitado en el documento de la actividad del curso. Usando el dominio `logistica-actividad`, definimos los objetos específicos, el mapa de ciudades, la posición inicial del camión y el paquete, y el objetivo final de la misión.

--- 

### Desglose del Código PDDL

#### 1. Definición del Problema y Dominio

```pddl
(define (problem problema-logistica-1)
  (:domain logistica-actividad)
```
*   `(define (problem problema-logistica-1))`: Damos un nombre a nuestro problema.
*   `(:domain logistica-actividad)`: Vinculamos este escenario con las reglas definidas en `logistica-actividad.pddl`.

#### 2. Objetos

Aquí creamos todos los elementos que participarán en nuestro problema.

```pddl
(:objects
  paquete1 - paquete
  camion1 - camion
  ciudad1 ciudad2 ciudad3 ciudad4 - localizacion
)
```
*   `paquete1 - paquete`: Un único paquete que debe ser transportado.
*   `camion1 - camion`: Un único camión para realizar la tarea.
*   `ciudad1 ciudad2 ciudad3 ciudad4 - localizacion`: Cuatro localizaciones que representan las ciudades en el mapa del problema.

#### 3. Estado Inicial (`:init`)

Esta sección describe la configuración del mundo al inicio, tal como se muestra en la Figura 1 del PDF.

```pddl
(:init
  ; Estado inicial del problema
  (en-paquete paquete1 ciudad1)
  (en-camion camion1 ciudad2)

  ; Conexiones entre ciudades (bidireccionales)
  (conectado ciudad1 ciudad2)
  (conectado ciudad2 ciudad1)
  (conectado ciudad2 ciudad3)
  (conectado ciudad3 ciudad2)
  (conectado ciudad1 ciudad4)
  (conectado ciudad4 ciudad1)
  (conectado ciudad3 ciudad4)
  (conectado ciudad4 ciudad3)
)
```
*   `(en-paquete paquete1 ciudad1)`: El `paquete1` comienza en la `ciudad1`.
*   `(en-camion camion1 ciudad2)`: El `camion1` comienza en la `ciudad2`.
*   `(conectado ...)`: Se definen todas las rutas posibles. Es importante notar que las conexiones son bidireccionales (si se puede ir de c1 a c2, también se puede ir de c2 a c1). Crucialmente, **no existe un `(conectado ciudad1 ciudad3)`**, lo que fuerza al planificador a encontrar una ruta a través de otras ciudades.

#### 4. Meta (`:goal`)

Aquí se define la condición que debe cumplirse para que el plan se considere exitoso.

```pddl
(:goal
  (and (en-paquete paquete1 ciudad3))
)
```
*   `(:goal (and ...))`: El objetivo es simple y único.
*   `(en-paquete paquete1 ciudad3)`: El `paquete1` debe terminar en la `ciudad3`.
*   El planificador deberá encontrar una secuencia de acciones `mover`, `cargar` y `descargar` para que el `camion1` vaya de `ciudad2` a `ciudad1`, recoja el `paquete1`, lo lleve a `ciudad3` (posiblemente pasando por `ciudad2` o `ciudad4`) y lo descargue allí.
