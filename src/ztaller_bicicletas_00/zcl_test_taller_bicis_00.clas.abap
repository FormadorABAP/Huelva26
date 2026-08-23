CLASS zcl_test_taller_bicis_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_TALLER_BICIS_00 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lo_taller) = NEW zcl_taller_bicis_00( ).
*    lo_taller->registrar_reparacion( i_cliente = 'Juan'
*                                     i_averia = 'Sillín torcido' ).

    lo_taller->consultar_reparacion(
            EXPORTING i_reparacion = 2
            IMPORTING o_cliente = DATA(lv_cliente)
                      o_averia  = DATA(lv_averia)
                      o_estado  = DATA(lv_estado) ).
    IF lv_cliente IS INITIAL.
      out->write( 'No se ha encontrado la reparación' ).
    ELSE.
      out->write( |{ lv_cliente } - { lv_averia } - { lv_estado }| ).
    ENDIF.

    CLEAR: lv_cliente,
           lv_averia,
           lv_estado.

    lo_taller->consultar_reparacion(
            EXPORTING i_reparacion = 4
            IMPORTING o_cliente = lv_cliente
                      o_averia  = lv_averia
                      o_estado  = lv_estado ).
    IF lv_cliente IS INITIAL.
      out->write( 'No se ha encontrado la reparación' ).
    ELSE.
      out->write( |{ lv_cliente } - { lv_averia } - { lv_estado }| ).
    ENDIF.

*    DATA(lv_reparacion) = lo_taller->cambiar_estado( i_reparacion = 42
*                                                     i_estado = '03' ).
*    IF lv_reparacion = abap_true.
*      out->write( 'Se ha modificado el estado' ).
*    ELSE.
*      out->write( 'NO se ha modificado el estado' ).
*    ENDIF.

*    DATA(lv_reparacion) = lo_taller->eliminar_reparacion( 1 ).
*    IF lv_reparacion = abap_true.
*      out->write( 'Se ha borrado la reparación' ).
*    ELSE.
*      out->write( 'NO se ha borrado la reparación' ).
*    ENDIF.

  ENDMETHOD.
ENDCLASS.
