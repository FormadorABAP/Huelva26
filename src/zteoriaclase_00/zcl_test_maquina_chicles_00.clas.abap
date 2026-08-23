CLASS zcl_test_maquina_chicles_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_MAQUINA_CHICLES_00 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lo_maquina) = NEW zcl_maquina_chicles_00( i_chicles = 2 ).

    DATA(lv_cambio) = lo_maquina->vender_chicle( 25 ).
    out->write( |El cambio es { lv_cambio }cent| ).

    lv_cambio = lo_maquina->vender_chicle( 50 ).
    out->write( |El cambio es { lv_cambio }cent| ).

    lv_cambio = lo_maquina->vender_chicle( 10 ).
    out->write( |El cambio es { lv_cambio }cent| ).

    lv_cambio = lo_maquina->vender_chicle( 64 ).
    out->write( |El cambio es { lv_cambio }cent| ).

  ENDMETHOD.
ENDCLASS.
