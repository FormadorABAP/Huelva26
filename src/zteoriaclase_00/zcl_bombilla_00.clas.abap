CLASS zcl_bombilla_00 DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS:
      constructor IMPORTING i_potencia TYPE i,
      encender,
      get_encendida RETURNING VALUE(rv_encedida) TYPE abap_bool.

  PRIVATE SECTION.
    " Atributo
    DATA: esta_encendida TYPE abap_bool,
          potencia       TYPE i.

ENDCLASS.



CLASS ZCL_BOMBILLA_00 IMPLEMENTATION.


  METHOD encender.
    esta_encendida = abap_true.
  ENDMETHOD.


  METHOD get_encendida.
    " Parámetro = Atributo
    rv_encedida = esta_encendida.
  ENDMETHOD.


  METHOD constructor. " Un método SET
    " Atributo = parametro
    potencia = i_potencia.
  ENDMETHOD.
ENDCLASS.
