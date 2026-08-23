CLASS zcl_test_vehiculo_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_VEHICULO_00 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lo_vehiculo) = NEW zcl_vehiculo_00( i_matricula = '1234' ).
    DATA(lo_coche) = NEW zcl_coche_00( i_matricula_c = '5678'
                                       i_num_puertas = 4 ).
    DATA(lo_moto) = NEW zcl_moto_00( i_matricula = '9012' ).

    lo_vehiculo->viajar( i_kilometros = 100 ).
    lo_coche->viajar( i_kilometros = 200 ).
    lo_moto->viajar( i_kilometros = 300 ).

    lo_vehiculo->get_contador( IMPORTING o_contador = DATA(lv_contador) ).
    out->write( lv_contador ).

    lo_coche->get_contador( IMPORTING o_contador = lv_contador ).
    out->write( lv_contador ).

    lo_moto->get_contador( IMPORTING o_contador = lv_contador ).
    out->write( lv_contador ).

*    lo_vehiculo->abrir_maletero( ).
    lo_coche->abrir_maletero( ).
*    lo_moto->abrir_maletero( ).

*    lo_vehiculo->caballito( ).
*    lo_coche->caballito( ).
    lo_moto->caballito( ).

*    lo_vehiculo->kilometraje.
*    lo_coche->kilometraje.

  ENDMETHOD.
ENDCLASS.
