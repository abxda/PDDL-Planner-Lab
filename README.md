# PDDL-Planner-Lab
Laboratorio de Planificación Automática en PDDL

Este proyecto es un laboratorio práctico diseñado para explorar y demostrar los fundamentos de la Planificación Automática (Automated Planning) utilizando el
Lenguaje de Definición de Dominios de Planificación (PDDL). El objetivo es servir como material de estudio y experimentación para entender cómo se modelan
problemas y cómo los agentes inteligentes pueden generar secuencias de acciones para resolverlos.

## Contenido Principal

Se utiliza el planificador de última generación **Fast Downward** para resolver diversos problemas de planificación. El repositorio contiene las definiciones
de dominio y problema para varios escenarios clásicos, incluyendo:

*   **Mundo de los Bloques:** El problema canónico para entender el apilamiento y las relaciones entre objetos.
*   **Robot en Almacén:** Un problema de logística simple donde un robot debe recoger y entregar paquetes en distintas localizaciones.
*   **Logística de Transporte:** Un problema más complejo que modela el transporte de un paquete entre ciudades, requiriendo una ruta de varios pasos.

## Entorno de Trabajo

Todo el flujo de trabajo se gestiona a través de **cuadernos de Jupyter (`.ipynb`)** que permiten ejecutar los planificadores, analizar los resultados y
visualizar los planes generados de forma interactiva.

Para garantizar la total reproducibilidad y evitar problemas de dependencias, el entorno de ejecución completo se gestiona con **Vagrant**. El `Vagrantfile`
incluido aprovisiona una máquina virtual Ubuntu con todas las herramientas, librerías de Python y el planificador Fast Downward ya compilado y listo para usar.

## Conceptos Demostrados

*   **Modelado en PDDL:** Creación de dominios y problemas desde cero.
*   **Planificación Independiente del Dominio:** Uso del mismo código para resolver problemas estructuralmente diferentes.
*   **Análisis de Heurísticas:** Comparación empírica de la eficiencia de diferentes heurísticas (h_add, h_ff, h_lmcut).
*   **Planificación Basada en SAT:** Exploración de la planificación como un problema de satisfactibilidad lógica.
*   **Visualización de Planes y Conceptos:** Generación de diagramas para entender los planes y las relaciones lógicas (mutex).
