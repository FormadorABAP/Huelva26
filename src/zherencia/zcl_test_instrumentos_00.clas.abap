CLASS zcl_test_instrumentos_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_instrumentos_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
*  Crear una guitarra marca 'Yamaha' con 6 cuerdas.
    DATA(lo_guitarra) = NEW zcl_guitarra_00( i_marca = 'Yamaha'
                                             i_cuerdas = 6 ).

*    Crear un piano marca 'Roland', eléctrico.
    DATA(lo_piano) = NEW zcl_piano_00( i_marca = 'Roland'
                                       i_electrico = abap_true ).

*    Intentar afinar la cuerda número 8 de la guitarra
*            (debería fallar, no existe esa cuerda).
    DATA(lv_afinar) = lo_guitarra->afinar_cuerda( 8 ).
    IF lv_afinar = abap_true.
      out->write( 'Cuerda afinada' ).
    ELSE.
      out->write( 'Cuerda NO afinada' ).
    ENDIF.

*    Afinar la cuerda número 3 de la guitarra (debería funcionar).
    lv_afinar = lo_guitarra->afinar_cuerda( 3 ).
    IF lv_afinar = abap_true.
      out->write( 'Cuerda afinada' ).
    ELSE.
      out->write( 'Cuerda NO afinada' ).
    ENDIF.

*    Intentar pedalear en el piano recién creado
*        (debería fallar, 0 horas de uso).
    DATA(lv_pedaleo) = lo_piano->pedalear( ).
    IF lv_pedaleo = abap_true.
      out->write( 'Se ha pedaleado' ).
    ELSE.
      out->write( 'No se ha pedaleado' ).
    ENDIF.

*    Registrar 2 horas de práctica en el piano,
*        usando el método heredado del padre.
    lo_piano->registrar_practica( 2 ).

*    Volver a intentar pedalear en el piano (ahora debería funcionar).
    lv_pedaleo = lo_piano->pedalear( ).
    IF lv_pedaleo = abap_true.
      out->write( 'Se ha pedaleado' ).
    ELSE.
      out->write( 'No se ha pedaleado' ).
    ENDIF.

*    Registrar 1 hora de práctica en la guitarra,
*        usando el mismo método heredado.
    lo_guitarra->registrar_practica( 1 ).

*    Consultar y mostrar las horas de uso finales de ambos instrumentos,
*        usando el método heredado consultar_horas_uso en los dos casos.
    DATA(lv_horas) = lo_guitarra->consultar_horas_uso( ).
    out->write( |La guitarra se ha tocado { lv_horas } horas| ).

    lv_horas = lo_piano->consultar_horas_uso( ).
    out->write( |El piano se ha tocado { lv_horas } horas| ).

  ENDMETHOD.
ENDCLASS.
