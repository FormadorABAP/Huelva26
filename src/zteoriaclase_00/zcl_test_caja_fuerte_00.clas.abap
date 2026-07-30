CLASS zcl_test_caja_fuerte_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_caja_fuerte_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_caja) = NEW zcl_caja_fuerte_00( i_codigo = '9876' ).
    DATA lv_bloqueada TYPE abap_bool.
    DATA lv_abierta TYPE abap_bool.

    out->write( 'Creamos la caja' ).
    lv_bloqueada = lo_caja->esta_bloqueada( ).
    IF lv_bloqueada = abap_true.
      out->write( 'La caja está bloqueada' ).
    ELSE.
      out->write( 'La caja NO está bloqueada' ).
    ENDIF.

    out->write( 'Primer intento' ).
    lv_abierta = lo_caja->abrir( i_codigo = '1' ).
    IF lv_abierta = abap_true.
      out->write( 'La caja está abierta' ).
    ELSE.
      out->write( 'La caja está cerrada' ).
    ENDIF.

    lv_bloqueada = lo_caja->esta_bloqueada( ).
    IF lv_bloqueada = abap_true.
      out->write( 'La caja está bloqueada' ).
    ELSE.
      out->write( 'La caja NO está bloqueada' ).
    ENDIF.

    out->write( 'Segundo intento' ).
    lv_abierta = lo_caja->abrir( i_codigo = '2' ).
    IF lv_abierta = abap_true.
      out->write( 'La caja está abierta' ).
    ELSE.
      out->write( 'La caja está cerrada' ).
    ENDIF.

    lv_bloqueada = lo_caja->esta_bloqueada( ).
    IF lv_bloqueada = abap_true.
      out->write( 'La caja está bloqueada' ).
    ELSE.
      out->write( 'La caja NO está bloqueada' ).
    ENDIF.

    out->write( 'Tercer intento' ).
    lv_abierta = lo_caja->abrir( i_codigo = '9876' ).
    IF lv_abierta = abap_true.
      out->write( 'La caja está abierta' ).
    ELSE.
      out->write( 'La caja está cerrada' ).
    ENDIF.

    IF lo_caja->esta_bloqueada( ) = abap_true.
      out->write( 'La caja está bloqueada' ).
    ELSE.
      out->write( 'La caja NO está bloqueada' ).
    ENDIF.

    out->write( 'Cuarto intento' ).
    lv_abierta = lo_caja->abrir( i_codigo = '1' ).
    IF lv_abierta = abap_true.
      out->write( 'La caja está abierta' ).
    ELSE.
      out->write( 'La caja está cerrada' ).
    ENDIF.

    IF lo_caja->esta_bloqueada( ) = abap_true.
      out->write( 'La caja está bloqueada' ).
    ELSE.
      out->write( 'La caja NO está bloqueada' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
