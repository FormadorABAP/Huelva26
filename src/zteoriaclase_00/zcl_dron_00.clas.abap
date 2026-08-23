CLASS zcl_dron_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      constructor IMPORTING i_carga_max TYPE i,

      recoger_paquete IMPORTING i_peso             TYPE i
                      RETURNING VALUE(rv_aceptado) TYPE abap_bool,

      volar_a_cliente RETURNING VALUE(rv_volar) TYPE abap_bool,

      recargar,

      consultar_estado EXPORTING o_bateria      TYPE i
                                 o_carga_actual TYPE i
                                 o_modo_reserva TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA:
      bateria      TYPE i,
      carga_maxima TYPE i,
      carga_actual TYPE i,
      modo_reserva TYPE abap_bool.

ENDCLASS.



CLASS ZCL_DRON_00 IMPLEMENTATION.


  METHOD constructor.
    carga_maxima = i_carga_max.
    bateria = 100.
    carga_actual = 0.
    modo_reserva = abap_false.
  ENDMETHOD.


  METHOD recoger_paquete.

    DATA(lv_carga_aux) = carga_actual + i_peso.

    IF lv_carga_aux <= carga_maxima AND bateria >= 20.
      carga_actual = lv_carga_aux.
      rv_aceptado = abap_true.
    ELSE.
      rv_aceptado = abap_false.
    ENDIF.

  ENDMETHOD.


  METHOD volar_a_cliente.

    IF modo_reserva = abap_false.

      " ¿Lleva peso?
      IF carga_actual > 0.
        DATA(lv_consumo) = bateria - 15.
      ELSE.
        lv_consumo = bateria - 5.
      ENDIF.

      IF lv_consumo < 0.
        rv_volar = abap_false.

      ELSE.
        rv_volar = abap_true.
        carga_actual = 0.
        bateria = lv_consumo.

        IF lv_consumo <= 10.
          modo_reserva = abap_true.
        ENDIF.

      ENDIF.

    ELSE.
      rv_volar = abap_false.
    ENDIF.

  ENDMETHOD.


  METHOD recargar.
    bateria = 100.
    modo_reserva = abap_false.
  ENDMETHOD.


  METHOD consultar_estado.
    o_bateria = bateria.
    o_carga_actual = carga_actual.
    o_modo_reserva = modo_reserva.
  ENDMETHOD.
ENDCLASS.
