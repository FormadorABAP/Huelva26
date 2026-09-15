CLASS zcl_test_mascota_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_mascota_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    data(lo_mascota) = new zcl_mascota_00(  ).
    do 8 times.
        lo_mascota->jugar(  ).
        lo_mascota->consultar_estado( IMPORTING o_energia = data(lv_energia)
                                                o_hambre = data(lv_hambre) ).
        out->write( |Nivel hambre: { lv_hambre } - Nivel energia: { lv_energia }| ).
    ENDDO.

    out->write( 'Le doy de comer' ).
    lo_mascota->comer(  ).
    lo_mascota->consultar_estado( IMPORTING o_energia = lv_energia
                                                o_hambre = lv_hambre ).
        out->write( |Nivel hambre: { lv_hambre } - Nivel energia: { lv_energia }| ).

  ENDMETHOD.
ENDCLASS.
