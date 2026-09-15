CLASS zcl_1717_connections DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_connections IMPORTING i_departure          TYPE /dmo/airport_from_id
                            RETURNING VALUE(r_connections) TYPE zcert_connections.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_1717_connections IMPLEMENTATION.

  METHOD get_connections.

    " Vuelos directos
    SELECT FROM /dmo/connection
        FIELDS carrier_id, airport_from_id, airport_to_id, '-' AS airport_via_id
        WHERE airport_from_id = @i_departure
        INTO TABLE @r_connections.

    IF sy-subrc = 0.

*      " Vuelos con una escala
      SELECT FROM /dmo/connection AS c1
          INNER JOIN /dmo/connection AS c2
          ON
                " Que los vuelos sean siempre de la misma compañia
                c1~carrier_id = c2~carrier_id

                " La llegada de tramo 1 sea la salida del tramo 2
                AND c1~airport_to_id = c2~airport_from_id

                " La llegada del tramo 2 no sea la salida del tramo 1
                AND c1~airport_from_id <> c2~airport_to_id

              FIELDS
                 c1~carrier_id, " Compañia del tramo 1 (o tramo 2)
                 c1~airport_from_id, " Salida sea la salida del tramo 1
                 c2~airport_to_id, " Llegada sea la llegada del tramo 2
                 c1~airport_to_id AS airport_via_id " Enlace sea la salida del tramo 1 (o llegada del tramo 2)

             WHERE
                c1~airport_from_id = @i_departure " La salida del tramo 1 sea la que me viene del parámetro

         APPENDING TABLE @r_connections. " Appending para que no me borre los vuelos directos

    ENDIF.

  ENDMETHOD.

ENDCLASS.
