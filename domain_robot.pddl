(define (domain warehouse)
  (:requirements :strips :typing)
  (:types robot location item)
  (:predicates
    (at ?r - robot ?l - location)
    (item-at ?i - item ?l - location)
    (carrying ?r - robot ?i - item)
    (handempty ?r - robot)
    (connected ?l1 - location ?l2 - location)
  )

  (:action move
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and (at ?r ?from) (connected ?from ?to))
    :effect (and (at ?r ?to) (not (at ?r ?from)))
  )
  (:action pick
    :parameters (?r - robot ?i - item ?l - location)
    :precondition (and (at ?r ?l) (item-at ?i ?l) (handempty ?r))
    :effect (and (carrying ?r ?i) (not (item-at ?i ?l)) (not (handempty ?r)))
  )
  (:action drop
    :parameters (?r - robot ?i - item ?l - location)
    :precondition (and (at ?r ?l) (carrying ?r ?i))
    :effect (and (item-at ?i ?l) (handempty ?r) (not (carrying ?r ?i)))
  )
)