CLASS zcl_cafetera_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      constructor IMPORTING i_agua TYPE i,
      preparar_cafe,
      consultar_agua RETURNING VALUE(rv_agua) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA agua_restante TYPE i.

ENDCLASS.



CLASS zcl_cafetera_00 IMPLEMENTATION.

  METHOD constructor.
    agua_restante = i_agua.
  ENDMETHOD.

  METHOD preparar_cafe.
    IF agua_restante >= 250.
      agua_restante = agua_restante - 250.
    ENDIF.
  ENDMETHOD.

  METHOD consultar_agua.
    rv_agua = agua_restante.
  ENDMETHOD.

ENDCLASS.
