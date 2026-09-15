CLASS zcl_chiringuito_bebidas_00 DEFINITION
  PUBLIC
  INHERITING FROM zcl_chiringuito_00
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS: vender_2 IMPORTING i_dinero          TYPE zdecimals2
                      RETURNING VALUE(rv_vendido) TYPE abap_bool,

      anadir_hielo RETURNING VALUE(rv_hielo) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_chiringuito_bebidas_00 IMPLEMENTATION.
  METHOD vender_2.
    IF i_dinero >= '1.50'.
      vender( i_dinero ).
      rv_vendido = abap_true.
    ELSE.
      rv_vendido = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD anadir_hielo.
    rv_hielo = 'Bebida con hielo'.
  ENDMETHOD.

ENDCLASS.
