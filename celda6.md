# ✍️ Tutorial de Diagrama: Celda 6 - Visualización de un Mutex

**Objetivo:** Entender, paso a paso, cómo se construye el diagrama de Graphviz en la Celda 6 para ilustrar el concepto de una **relación mutex** (exclusión mutua) en el contexto del Mundo de los Bloques.

El diagrama no representa un plan, sino un **conflicto lógico**: dos acciones que no pueden ocurrir al mismo tiempo.

--- 

### Construcción del Diagrama Paso a Paso

El código Python utiliza la librería `graphviz` para generar un diagrama en el lenguaje DOT. Analicemos el proceso.

#### Paso 1: Crear el Lienzo (El Grafo Principal)

```python
mutex_dot = graphviz.Digraph()
```
*   **Explicación:** Aquí creamos un objeto `Digraph` (Grafo Dirigido) vacío. Piensa en esto como nuestro lienzo en blanco, listo para que le añadamos nodos y flechas.

#### Paso 2: Añadir un Título Global

```python
mutex_dot.attr('graph', labelloc='t', label='Ilustración Conceptual de un Mutex en SAT', fontsize='16')
```
*   **Explicación:** Con `.attr()` modificamos los atributos. 
    *   `'graph'`: Indica que queremos cambiar propiedades de todo el lienzo.
    *   `label='...'`: Pone el título principal al diagrama.
    *   `labelloc='t'`: Coloca ese título en la parte superior (*top*).
    *   `fontsize='16'`: Define el tamaño de la fuente del título.

#### Paso 3: Agrupar Nodos por Instantes de Tiempo (Subgrafos)

Para organizar el diagrama, usamos "clusters" o subgrafos que representan diferentes momentos en el tiempo.

```python
with mutex_dot.subgraph(name='cluster_0') as c:
    c.attr(label='Tiempo t=0 (Estado Inicial)')
    c.node('handempty_0', '(handempty)', style='filled', color='lightgreen')
```
*   `with mutex_dot.subgraph(...) as c:`: Crea una caja (un "cluster") para agrupar nodos. Le damos un título con `c.attr(label=...)`.
*   `c.node(...)`: Dentro de este subgrafo, creamos un **nodo**.
    *   `'handempty_0'`: Es el **ID único** del nodo. No se ve en el diagrama, pero lo usamos para conectar flechas.
    *   `'(handempty)'`: Es el **texto visible** dentro del nodo.
    *   `style='filled', color='lightgreen'`: Le damos estilo al nodo para resaltar que es un hecho verdadero en el estado inicial.

Repetimos esto para el `cluster_1` que representa las acciones posibles en el siguiente instante de tiempo.

#### Paso 4: Definir las Relaciones (Aristas)

Las aristas (flechas) muestran las conexiones lógicas entre los nodos.

```python
mutex_dot.edge('handempty_0', 'pickup_a_1', label='precondición')
```
*   `.edge('ID_origen', 'ID_destino', ...)`: Dibuja una flecha desde el nodo con el primer ID hasta el nodo con el segundo ID.
*   `label='precondición'`: Escribe el texto "precondición" sobre la flecha, indicando que `(handempty)` es una precondición para la acción `(pick-up a)`.

#### Paso 5: Visualizar el Conflicto (La Arista Mutex)

Esta es la parte más importante del diagrama.

```python
mutex_dot.edge('pickup_a_1', 'pickup_b_1', label='MUTEX...', style='dashed', color='red', fontcolor='red', dir='none')
```
*   **Explicación:** Creamos una arista entre las dos acciones `(pick-up a)` y `(pick-up b)` para mostrar que son incompatibles.
*   `style='dashed', color='red'`: La dibujamos punteada y en rojo para que visualmente represente un conflicto, no un flujo normal.
*   `dir='none'`: Le quitamos la punta de la flecha. No es que una acción lleve a la otra, sino que simplemente están conectadas por un conflicto.
*   `label='MUTEX...'`: El texto explica la naturaleza del conflicto: ambas acciones necesitan el mismo recurso (la mano vacía) y no pueden ejecutarse simultáneamente.

¡Y así es como, combinando nodos, subgrafos y aristas con estilo, podemos crear un diagrama conceptual que explica una idea compleja de forma sencilla!
