# ✍️ Tutorial de Diagrama: Celda 13 - Tipos de Mutex en Logística

**Objetivo:** Desglosar cómo se construyen los tres diagramas de la Celda 13. Cada diagrama visualiza un tipo diferente de **relación mutex** (exclusión mutua), aplicando los conceptos teóricos del PDF de la actividad al dominio de logística que creamos.

--- 

### Construcción de los Diagramas Paso a Paso

Cada diagrama es un objeto `graphviz.Digraph` independiente. El proceso de construcción es similar para todos: inicializar, definir nodos y conectar aristas con estilos apropiados para comunicar la idea.

### 1. Diagrama: Efectos Inconsistentes

*   **Concepto:** Dos acciones son mutex si el efecto de una es la negación del efecto de la otra. No pueden ocurrir a la vez porque llevarían al mundo a un estado contradictorio. Ejemplo: un camión no puede estar en la `ciudad2` y en la `ciudad4` al mismo tiempo.

```python
# --- Código de Construcción ---
dot1 = graphviz.Digraph(comment="Efectos Inconsistentes")
dot1.attr('graph', label='Mutex: Efectos Inconsistentes', ...)

# Nodos para las dos acciones en conflicto
dot1.node('A1', 'mover(camion1, c1, c2)')
dot1.node('A2', 'mover(camion1, c1, c4)')

# Nodos para los efectos de cada acción
dot1.node('E1', 'effect: (en-camion camion1 c2)', shape='box')
dot1.node('E2', 'effect: (en-camion camion1 c4)', shape='box')

# Un nodo de texto para explicar el conflicto
dot1.node('Conflict', '❌ (en-camion camion1 c2) y (en-camion camion1 c4) son mutuamente excluyentes', shape='plaintext')

# Conectamos las acciones a sus efectos
dot1.edge('A1', 'E1')
dot1.edge('A2', 'E2')

# Conectamos los dos efectos con una línea roja sin flecha para denotar el conflicto
dot1.edge('E1', 'E2', style='dashed', color='red', dir='none', constraint='false')
```
*   **Paso a Paso:**
    1.  Se crea un grafo `dot1`.
    2.  Se definen dos nodos (`A1`, `A2`) para representar las dos acciones de `mover` que parten del mismo lugar (`c1`).
    3.  Se crean dos nodos (`E1`, `E2`) con `shape='box'` para representar los efectos resultantes: `(en-camion camion1 c2)` y `(en-camion camion1 c4)`.
    4.  Se usa una arista roja, punteada y sin dirección (`dir='none'`) para conectar `E1` y `E2`, mostrando visualmente que estos dos resultados no pueden coexistir.

### 2. Diagrama: Interferencia

*   **Concepto:** Una acción interfiere con otra si su efecto borra (niega) una de las precondiciones necesarias para la segunda acción.

```python
# --- Código de Construcción ---
dot2 = graphviz.Digraph(comment="Interferencia")
dot2.attr('graph', label='Mutex: Interferencia', ...)

# Nodos para las dos acciones
dot2.node('A1', 'descargar(paquete1, camion1, ciudad2)')
dot2.node('A2', 'mover(camion1, ciudad2, ciudad3)')

# Nodos para la precondición y el efecto en conflicto
dot2.node('P2', 'pre: (en-camion camion1 ciudad2)', shape='box')
dot2.node('E1', 'effect: (not (en-camion camion1 ciudad2))', shape='box')

# Conectamos la precondición a su acción
dot2.edge('P2', 'A2')
# Conectamos la acción a su efecto
dot2.edge('A1', 'E1')

# Conectamos el efecto de la primera con la precondición de la segunda para mostrar el conflicto
dot2.edge('E1', 'P2', style='dashed', color='red', dir='none', label='  ¡Conflicto!')
```
*   **Paso a Paso:**
    1.  Se definen las dos acciones: `A1` (descargar) y `A2` (mover).
    2.  Se crea un nodo para la precondición de `A2`: `P2` -> `(en-camion camion1 ciudad2)`.
    3.  Se crea un nodo para el efecto de `A1`: `E1` -> `(not (en-camion camion1 ciudad2))`.
    4.  La arista de conflicto (`style='dashed', color='red'`) conecta directamente el efecto `E1` con la precondición `P2`, dejando claro que la acción 1 anula un requisito de la acción 2.

### 3. Diagrama: Necesidades Competitivas

*   **Concepto:** Dos acciones compiten por un recurso si ambas necesitan la misma precondición y ambas la consumen (la borran como parte de su efecto).

```python
# --- Código de Construcción ---
dot3 = graphviz.Digraph(comment="Necesidades Competitivas")
dot3.attr('graph', label='Mutex: Necesidades Competitivas', ...)

# Nodo para la precondición compartida (el recurso)
dot3.node('P', 'pre: (en-camion camion1 ciudad1)', shape='box', style='filled', color='lightgreen')

# Nodos para las dos acciones que compiten
dot3.node('A1', 'mover(camion1, ciudad1, c2)')
dot3.node('A2', 'mover(camion1, ciudad1, c4)')

# Ambas acciones necesitan la misma precondición
dot3.edge('P', 'A1')
dot3.edge('P', 'A2')

# Conectamos las dos acciones para mostrar que compiten entre sí
dot3.edge('A1', 'A2', style='dashed', color='red', dir='none', label='Compiten por el recurso "camión en ciudad1"')
```
*   **Paso a Paso:**
    1.  Se define un único nodo para la precondición (`P`) que ambas acciones necesitan: `(en-camion camion1 ciudad1)`.
    2.  Se definen las dos acciones competidoras (`A1`, `A2`).
    3.  Se dibujan flechas normales desde la precondición `P` hacia ambas acciones, mostrando que es un requisito para las dos.
    4.  Se dibuja una arista de conflicto roja y sin dirección entre `A1` y `A2` para indicar que, aunque ambas son posibles, no pueden elegirse a la vez porque "consumen" el mismo estado inicial.
