CLASS zcl_ascensor_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      constructor IMPORTING
                    i_planta_maxima TYPE i
                    i_peso_maximo   TYPE i,

      entrar_peso IMPORTING
                    i_kilos TYPE i,
      vaciar,
      subir_a_planta IMPORTING i_planta_destino TYPE i
                     RETURNING VALUE(rv_accion) TYPE abap_bool,
      consultar_estado EXPORTING o_planta_actual TYPE i
                                 o_peso_actual   TYPE i
                                 o_bloqueado     TYPE abap_bool.

  PROTECTED SECTION.


  PRIVATE SECTION.

    DATA:
      planta_actual TYPE i,
      planta_maxima TYPE i,
      peso_maximo   TYPE i,
      peso_actual   TYPE i,
      bloqueado     TYPE abap_bool.

ENDCLASS.



CLASS zcl_ascensor_00 IMPLEMENTATION.
  METHOD constructor.
    planta_actual = 0.
    planta_maxima = i_planta_maxima.
    peso_maximo = i_peso_maximo.
    peso_actual = 0.
    bloqueado = abap_false.
  ENDMETHOD.

  METHOD entrar_peso.

    " Solo si el ascenso NO está bloqueado.
    IF bloqueado = abap_false.

      " He calculado la suma en una variable auxiliar
      DATA(lv_peso_aux) = peso_actual + i_kilos.
      IF lv_peso_aux <= peso_maximo.
        peso_actual = lv_peso_aux.
      ELSE.
        bloqueado = abap_true.
      ENDIF.

    ENDIF.
  ENDMETHOD.

  METHOD vaciar.
    peso_actual = 0.
    bloqueado = abap_false.
  ENDMETHOD.

  METHOD subir_a_planta.
    IF bloqueado = abap_false.

      IF i_planta_destino >= 0 AND i_planta_destino <= planta_maxima.
        planta_actual = i_planta_destino.
        rv_accion = abap_true.
      ELSE.
        rv_accion = abap_false.
      ENDIF.

    ELSE.
      rv_accion = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD consultar_estado.
    o_planta_actual = planta_actual.
    o_peso_actual = peso_actual.
    o_bloqueado = bloqueado.
  ENDMETHOD.

ENDCLASS.
