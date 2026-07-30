CLASS zcl_test_calculadora_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_calculadora_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Declaración
    DATA lo_calculadora TYPE REF TO zcl_calculadora_00.

    " Constructor
    CREATE OBJECT lo_calculadora.

    " Llamada a método enviando datos
    lo_calculadora->sumar( EXPORTING i_num1 = 5
                                     i_num2 = 7 ).

    lo_calculadora->division( EXPORTING i_num1 = 10
                                        i_num2 = 5
                              IMPORTING o_div = DATA(lv_div)
                                        o_res = DATA(lv_res) ).

    out->write( |La división es { lv_div } y el resto es { lv_res }| ).

    lo_calculadora->mostrar_resultado_e(
        IMPORTING o_resultado = DATA(lv_resultado_e) ).

    DATA(lv_resultado_r) =
        lo_calculadora->mostrar_resultado_r( ).

    " Pintar por pantalla
    out->write( lv_resultado_r ).


  ENDMETHOD.
ENDCLASS.
