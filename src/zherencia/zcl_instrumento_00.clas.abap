CLASS zcl_instrumento_00 DEFINITION
  PUBLIC
*  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      constructor IMPORTING i_marca TYPE string,
      registrar_practica IMPORTING i_horas TYPE i,
      consultar_horas_uso RETURNING VALUE(rv_horas) type i.

  PROTECTED SECTION.

    DATA:
      marca     TYPE string,
      horas_uso TYPE i.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_instrumento_00 IMPLEMENTATION.
  METHOD constructor.
    marca = i_marca.
    horas_uso = 0.
  ENDMETHOD.

  METHOD registrar_practica.
    horas_uso += i_horas.
  ENDMETHOD.

  METHOD consultar_horas_uso.
    rv_horas = horas_uso.
  ENDMETHOD.

ENDCLASS.
