(define (problem warehouse-prob)
  (:domain warehouse)
  (:objects
      rob1 - robot
      depot storage-a storage-b - location
      box1 box2 - item
  )
  (:init
    (at rob1 depot)
    (handempty rob1)
    (item-at box1 storage-a)
    (item-at box2 storage-b)
    (connected depot storage-a) (connected storage-a depot)
    (connected depot storage-b) (connected storage-b depot)
  )
  (:goal (and (item-at box1 depot) (item-at box2 depot)))
)