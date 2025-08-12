; -- Define un nuevo dominio de planificación llamado 'blocksworld'
(define (domain blocksworld)
  
  ; -- Requisitos: son funcionalidades estándar del lenguaje PDDL que usaremos
  (:requirements :strips :typing)
  
  ; -- Tipos de objetos: solo existe un tipo de objeto, 'block'
  (:types 
    block
  )
  
  ; -- Predicados: son las propiedades o estados que pueden ser verdaderos o falsos
  (:predicates
    (on ?x - block ?y - block)  ; -- El bloque ?x está sobre el bloque ?y
    (ontable ?x - block)        ; -- El bloque ?x está sobre la mesa
    (clear ?x - block)          ; -- El bloque ?x no tiene nada encima (está libre)
    (handempty)                 ; -- La mano del robot está vacía
    (holding ?x - block)        ; -- La mano del robot está sosteniendo el bloque ?x
  )
  
  ; --- ACCIONES POSIBLES ---

  ; -- Acción: Recoger un bloque de la mesa
  (:action pick-up
    :parameters (?x - block) ; -- Parámetro: el bloque a recoger
    :precondition (and (clear ?x) (ontable ?x) (handempty)) ; -- Precondiciones: el bloque debe estar libre, sobre la mesa, y la mano vacía
    :effect (and (not (ontable ?x)) (not (clear ?x)) (not (handempty)) (holding ?x)) ; -- Efectos: el bloque ya no está en la mesa, ya no está libre, la mano ya no está vacía y ahora sostiene el bloque
  )
  
  ; -- Acción: Poner un bloque sobre la mesa
  (:action put-down
    :parameters (?x - block) ; -- Parámetro: el bloque a soltar
    :precondition (holding ?x) ; -- Precondición: la mano debe estar sosteniendo el bloque
    :effect (and (ontable ?x) (clear ?x) (handempty) (not (holding ?x))) ; -- Efectos: el bloque ahora está en la mesa, está libre, la mano está vacía y ya no sostiene el bloque
  )
  
  ; -- Acción: Apilar un bloque sobre otro
  (:action stack
    :parameters (?x - block ?y - block) ; -- Parámetros: el bloque ?x que se apila sobre el bloque ?y
    :precondition (and (holding ?x) (clear ?y)) ; -- Precondiciones: se debe sostener ?x y el bloque ?y debe estar libre
    :effect (and (on ?x ?y) (clear ?x) (handempty) (not (holding ?x)) (not (clear ?y))) ; -- Efectos: ?x ahora está sobre ?y, ?x está libre, la mano queda vacía, ya no se sostiene ?x y ?y ya no está libre
  )
  
  ; -- Acción: Desapilar un bloque de otro
  (:action unstack
    :parameters (?x - block ?y - block) ; -- Parámetros: el bloque ?x que se quita de encima del bloque ?y
    :precondition (and (on ?x ?y) (clear ?x) (handempty)) ; -- Precondiciones: ?x debe estar sobre ?y, ?x debe estar libre y la mano vacía
    :effect (and (holding ?x) (clear ?y) (not (on ?x ?y)) (not (clear ?x)) (not (handempty))) ; -- Efectos: ahora se sostiene ?x, ?y queda libre, ?x ya no está sobre ?y, ?x ya no está libre y la mano ya no está vacía
  )
)