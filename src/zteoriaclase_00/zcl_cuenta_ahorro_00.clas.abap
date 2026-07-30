CLASS zcl_cuenta_ahorro_00 DEFINITION
  PUBLIC
  INHERITING FROM zcl_cuenta_bancaria_00
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_titular TYPE string
        iv_interes TYPE zdecimals2.

    METHODS: aplicar_interes.

  PRIVATE SECTION.
    DATA interes TYPE zdecimals2.

ENDCLASS.


CLASS zcl_cuenta_ahorro_00 IMPLEMENTATION.

  METHOD constructor.
    super->constructor( iv_titular = iv_titular ).
    interes = iv_interes.
  ENDMETHOD.

  METHOD aplicar_interes.
    "" la hija SÍ puede tocar 'saldo' porque es PROTECTED, heredado del padre
    saldo = saldo + ( saldo * interes / 100 ).
  ENDMETHOD.

ENDCLASS.
