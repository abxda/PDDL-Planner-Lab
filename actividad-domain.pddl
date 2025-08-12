
(define (domain logistica-actividad)
  (:requirements :strips :typing)
  
  (:types ; 
    paquete camion localizacion - object
  )
  
  (:predicates
    (en-paquete ?p ?l)      ; El paquete ?p está en la localización ?l
    (en-camion ?c ?l)       ; El camión ?c está en la localización ?l
    (paquete-en-camion ?p ?c) ; El paquete ?p está dentro del camión ?c
    (conectado ?l1 ?l2)     ; La localización ?l1 está conectada con ?l2
  )

  (:action mover
    :parameters (?c ?desde ?hacia)
    :precondition (and (en-camion ?c ?desde) (conectado ?desde ?hacia))
    :effect (and (not (en-camion ?c ?desde)) (en-camion ?c ?hacia))
  )

  (:action cargar
    :parameters (?p ?c ?l)
    :precondition (and (en-paquete ?p ?l) (en-camion ?c ?l))
    :effect (and (not (en-paquete ?p ?l)) (paquete-en-camion ?p ?c))
  )

  (:action descargar
    :parameters (?p ?c ?l)
    :precondition (and (paquete-en-camion ?p ?c) (en-camion ?c ?l))
    :effect (and (not (paquete-en-camion ?p ?c)) (en-paquete ?p ?l))
  )
)
