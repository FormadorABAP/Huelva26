CLASS zcl_deposito_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      constructor IMPORTING i_capacidad TYPE i,
      repostar_deposito IMPORTING i_litros TYPE i,
      despachar_combustible IMPORTING i_litros         TYPE i
                            RETURNING VALUE(rv_accion) TYPE abap_bool,
      consultar_nivel RETURNING VALUE(rv_nivel) TYPE i.                            .

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA:
      litros    TYPE i,
      capacidad TYPE i.

ENDCLASS.



CLASS ZCL_DEPOSITO_00 IMPLEMENTATION.


  METHOD constructor.
    capacidad = i_capacidad.
    litros = 0.
  ENDMETHOD.


  METHOD repostar_deposito.
    IF litros + i_litros <= capacidad.
      litros = litros + i_litros.
    ELSE.
      litros = capacidad.
    ENDIF.
  ENDMETHOD.


  METHOD despachar_combustible.
    IF i_litros > litros.
      rv_accion = abap_false.
    ELSE.
      litros = litros - i_litros.
      rv_accion = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD consultar_nivel.
    rv_nivel = litros.
  ENDMETHOD.
ENDCLASS.
