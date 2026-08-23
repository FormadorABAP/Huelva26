CLASS zcl_test_ascensor_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_ASCENSOR_00 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lo_ascensor) = NEW zcl_ascensor_00(
                                i_planta_maxima = 7
                                i_peso_maximo = 300 ).

*    DATA(lo_ascensor2) = NEW zcl_ascensor_00(
*                                i_planta_maxima = 17
*                                i_peso_maximo = 1000 ).

    lo_ascensor->entrar_peso( 200 ).
*    lo_ascensor->entrar_peso( 200 ).
    DATA(lv_accion) = lo_ascensor->subir_a_planta( 5 ).

    DATA(lv_texto) = COND string(
        WHEN lo_ascensor->subir_a_planta( 5 )
            THEN 'El ascensor se ha movido'
        ELSE 'El ascensor NO se ha movido'
        ).
    out->write( lv_texto ).

    lo_ascensor->consultar_estado( IMPORTING
                                        o_planta_actual = DATA(lv_planta_actual)
                                        o_peso_actual = DATA(lv_peso_actual)
                                        o_bloqueado = DATA(lv_bloqueado) ).


    lo_ascensor->entrar_peso( 50 ).

    lo_ascensor->vaciar( ).


  ENDMETHOD.
ENDCLASS.
