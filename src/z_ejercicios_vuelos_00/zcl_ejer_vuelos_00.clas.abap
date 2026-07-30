CLASS zcl_ejer_vuelos_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejer_vuelos_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    SELECT from zcds_vuelos_avanzado_00( p_nombre = 'Anna' )
        FIELDS *
        into table @data(lt_vuelos).
    if sy-subrc = 0.
        out->write( lt_vuelos ).
        out->write( lines( lt_vuelos ) ).

    ENDIF.

  ENDMETHOD.
ENDCLASS.
