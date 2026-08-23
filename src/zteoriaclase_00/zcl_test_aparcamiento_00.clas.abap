CLASS zcl_test_aparcamiento_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_APARCAMIENTO_00 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(lo_aparcamiento) = NEW zcl_aparcamiento_00( ).
    DATA lv_minutos TYPE i.

    DATA(lv_total) = lo_aparcamiento->calcular_tarifa(
                                EXPORTING i_horas_estacionado = 8
                                IMPORTING e_minutos_totales = lv_minutos ).

    out->write( |Se ha estaciado { lv_minutos } minutos y nos ha costado { lv_total }€| ).
  ENDMETHOD.
ENDCLASS.
