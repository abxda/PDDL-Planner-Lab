; -- Define un problema específico llamado 'blocks-problem'
(define (problem blocks-problem)

  ; -- Especifica a qué dominio pertenece este problema
  (:domain blocksworld)
  
  ; -- Objetos: declara los objetos específicos que existen en este problema
  (:objects
    a b c - block ; -- Tenemos tres bloques llamados a, b y c
  )
  
  ; -- Estado Inicial (Init): describe cómo está el mundo al principio
  (:init
    (ontable a)     ; -- El bloque 'a' está en la mesa
    (ontable b)     ; -- El bloque 'b' está en la mesa
    (ontable c)     ; -- El bloque 'c' está en la mesa
    (clear a)       ; -- El bloque 'a' está libre (nada encima)
    (clear b)       ; -- El bloque 'b' está libre
    (clear c)       ; -- El bloque 'c' está libre
    (handempty)     ; -- La mano del robot está vacía
  )
  
  ; -- Meta (Goal): describe el estado del mundo que queremos alcanzar
  (:goal (and
    (on a b)        ; -- Objetivo 1: el bloque 'a' debe estar sobre el bloque 'b'
    (on b c)        ; -- Objetivo 2: el bloque 'b' debe estar sobre el bloque 'c'
  ))
)