CLASS zcl_test_deposito_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_test_deposito_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_deposito) = NEW zcl_deposito_00( 1000 ).
    out->write( | Creo un deposito de { lo_deposito->consultar_nivel(  ) } L| ).

    lo_deposito->repostar_deposito( 700 ).
    out->write( | Tras repostar 700 tengo { lo_deposito->consultar_nivel(  ) } L| ).

    lo_deposito->repostar_deposito( 500 ).
    out->write( | Tras repostar 500 tengo { lo_deposito->consultar_nivel(  ) } L| ).

    IF lo_deposito->despachar_combustible( 500 ).
      out->write( | Se han consumido 500. Ahora tengo { lo_deposito->consultar_nivel(  ) } L| ).
    ELSE.
      out->write( | NO se han consumido 500. Ahora tengo { lo_deposito->consultar_nivel(  ) } L| ).
    ENDIF.

    IF lo_deposito->despachar_combustible( 5000 ).
      out->write( | Se han consumido 5000. Ahora tengo { lo_deposito->consultar_nivel(  ) } L| ).
    ELSE.
      out->write( | NO se han consumido 5000. Ahora tengo { lo_deposito->consultar_nivel(  ) } L| ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
