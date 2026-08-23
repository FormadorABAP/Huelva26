CLASS zcl_test_dron_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_DRON_00 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*  Clase de test ZCL_TEST_DRON_XX que cree un dron con carga máxima 5 kg,

    DATA(lo_dron) = NEW zcl_dron_00( i_carga_max = 5 ).

    lo_dron->consultar_estado( IMPORTING o_bateria = DATA(lv_bateria)
                                         o_carga_actual = DATA(lv_carga_actual)
                                         o_modo_reserva = DATA(lv_modo) ).
    out->write( |La bateria { lv_bateria } - La carga { lv_carga_actual } - Modo reserva { lv_modo }| ).

*   y pruebe: recoger un paquete de 3 kg,
    lo_dron->recoger_paquete( 3 ).
    lo_dron->consultar_estado( IMPORTING o_bateria = lv_bateria
                                         o_carga_actual = lv_carga_actual
                                         o_modo_reserva = lv_modo ).
    out->write( |La bateria { lv_bateria } - La carga { lv_carga_actual } - Modo reserva { lv_modo }| ).

*    volar (debe entregar y bajar batería),
    lo_dron->volar_a_cliente( ).
    lo_dron->consultar_estado( IMPORTING o_bateria = lv_bateria
                                         o_carga_actual = lv_carga_actual
                                         o_modo_reserva = lv_modo ).
    out->write( |La bateria { lv_bateria } - La carga { lv_carga_actual } - Modo reserva { lv_modo }| ).

*    recoger otro paquete de 2 kg,
    lo_dron->recoger_paquete( 3 ).
    lo_dron->consultar_estado( IMPORTING o_bateria = lv_bateria
                                         o_carga_actual = lv_carga_actual
                                         o_modo_reserva = lv_modo ).
    out->write( |La bateria { lv_bateria } - La carga { lv_carga_actual } - Modo reserva { lv_modo }| ).

*   volar varias veces seguidas hasta forzar el modo reserva,
    DO 20 TIMES.
      lo_dron->volar_a_cliente( ).
      lo_dron->consultar_estado( IMPORTING o_bateria = lv_bateria
                                       o_carga_actual = lv_carga_actual
                                       o_modo_reserva = lv_modo ).
      out->write( |La bateria { lv_bateria } - La carga { lv_carga_actual } - Modo reserva { lv_modo }| ).
    ENDDO.

    lo_dron->volar_a_cliente( ).
    lo_dron->consultar_estado( IMPORTING o_bateria = lv_bateria
                                     o_carga_actual = lv_carga_actual
                                     o_modo_reserva = lv_modo ).
    out->write( |La bateria { lv_bateria } - La carga { lv_carga_actual } - Modo reserva { lv_modo }| ).
    lo_dron->volar_a_cliente( ).
    lo_dron->consultar_estado( IMPORTING o_bateria = lv_bateria
                                     o_carga_actual = lv_carga_actual
                                     o_modo_reserva = lv_modo ).
    out->write( |La bateria { lv_bateria } - La carga { lv_carga_actual } - Modo reserva { lv_modo }| ).
    lo_dron->volar_a_cliente( ).
    lo_dron->consultar_estado( IMPORTING o_bateria = lv_bateria
                                     o_carga_actual = lv_carga_actual
                                     o_modo_reserva = lv_modo ).
    out->write( |La bateria { lv_bateria } - La carga { lv_carga_actual } - Modo reserva { lv_modo }| ).
    lo_dron->volar_a_cliente( ).
    lo_dron->consultar_estado( IMPORTING o_bateria = lv_bateria
                                     o_carga_actual = lv_carga_actual
                                     o_modo_reserva = lv_modo ).
    out->write( |La bateria { lv_bateria } - La carga { lv_carga_actual } - Modo reserva { lv_modo }| ).
    lo_dron->volar_a_cliente( ).
    lo_dron->consultar_estado( IMPORTING o_bateria = lv_bateria
                                     o_carga_actual = lv_carga_actual
                                     o_modo_reserva = lv_modo ).
    out->write( |La bateria { lv_bateria } - La carga { lv_carga_actual } - Modo reserva { lv_modo }| ).

*   intentar recoger un paquete estando en reserva (debe rechazarse),
    lo_dron->recoger_paquete( 2 ).
    lo_dron->consultar_estado( IMPORTING o_bateria = lv_bateria
                                     o_carga_actual = lv_carga_actual
                                     o_modo_reserva = lv_modo ).
    out->write( |La bateria { lv_bateria } - La carga { lv_carga_actual } - Modo reserva { lv_modo }| ).

*   recargar, y volver a intentar recoger el paquete (ahora sí debe aceptarse).
    lo_dron->recargar(  ).
    lo_dron->consultar_estado( IMPORTING o_bateria = lv_bateria
                                     o_carga_actual = lv_carga_actual
                                     o_modo_reserva = lv_modo ).
    out->write( |La bateria { lv_bateria } - La carga { lv_carga_actual } - Modo reserva { lv_modo }| ).
    lo_dron->recoger_paquete( 2 ).


*    Mostrar el estado tras cada paso.
    lo_dron->consultar_estado( IMPORTING o_bateria = lv_bateria
                                     o_carga_actual = lv_carga_actual
                                     o_modo_reserva = lv_modo ).
    out->write( |La bateria { lv_bateria } - La carga { lv_carga_actual } - Modo reserva { lv_modo }| ).
  ENDMETHOD.
ENDCLASS.
