
(define (problem problema-logistica-1)
  (:domain logistica-actividad)

  (:objects
    paquete1 - paquete
    camion1 - camion
    ciudad1 ciudad2 ciudad3 ciudad4 - localizacion
  )

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

  (:goal
    (and (en-paquete paquete1 ciudad3))
  )
)
