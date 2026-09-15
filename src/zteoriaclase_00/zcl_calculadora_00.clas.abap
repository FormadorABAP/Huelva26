CLASS zcl_calculadora_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.



    METHODS:
      sumar IMPORTING i_num1 TYPE i
                      i_num2 TYPE i,

      division IMPORTING i_num1 TYPE i
                         i_num2 TYPE i
               EXPORTING o_div  TYPE i
                         o_res  TYPE i,
      mostrar_resultado_e
        EXPORTING o_resultado TYPE i,

      mostrar_resultado_r
        RETURNING VALUE(rv_resultado) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA: resultado TYPE i.

ENDCLASS.

CLASS zcl_calculadora_00 IMPLEMENTATION.

  METHOD sumar.
    " Atributo = Suma de parametros de entrada
    resultado = i_num1 + i_num2.
  ENDMETHOD.

  METHOD division.
    o_div = i_num1 / i_num2.
    o_res = i_num1 MOD i_num2.
  ENDMETHOD.

  METHOD mostrar_resultado_e.
    " Parametro de salida = atributo
    o_resultado = resultado.
  ENDMETHOD.

  METHOD mostrar_resultado_r.
    rv_resultado = resultado.
  ENDMETHOD.

ENDCLASS.
