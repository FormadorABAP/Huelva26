CLASS zcl_cuenta_bancaria_00 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_titular TYPE string.

    METHODS ingresar
      IMPORTING
        iv_importe TYPE zdecimals2.

    METHODS consultar_saldo
      RETURNING VALUE(rv_saldo) TYPE zdecimals2.

    METHODS consultar_operaciones
      RETURNING VALUE(rv_operaciones) TYPE i.

  PROTECTED SECTION.
    DATA saldo   TYPE zdecimals2.
    DATA titular TYPE string.

  PRIVATE SECTION.
    DATA numero_operaciones_internas TYPE i.

    METHODS registrar_operacion_interna.

ENDCLASS.


CLASS zcl_cuenta_bancaria_00 IMPLEMENTATION.

  METHOD constructor.
    titular = iv_titular.
    saldo   = 0.
    numero_operaciones_internas = 0.
  ENDMETHOD.

  METHOD ingresar.
    saldo = saldo + iv_importe.
    registrar_operacion_interna( ).
  ENDMETHOD.

  METHOD consultar_saldo.
    rv_saldo = saldo.
  ENDMETHOD.

  METHOD consultar_operaciones.
    rv_operaciones = numero_operaciones_internas.
  ENDMETHOD.

  METHOD registrar_operacion_interna.
    numero_operaciones_internas = numero_operaciones_internas + 1.
    IF numero_operaciones_internas >= 5.
      "" aquí, por ejemplo, se lanzaría la auditoría automática
    ENDIF.
  ENDMETHOD.

ENDCLASS.
