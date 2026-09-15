CLASS zcl_aparcamiento_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS calcular_tarifa
      IMPORTING i_horas_estacionado TYPE i
      EXPORTING e_minutos_totales   TYPE i
      RETURNING VALUE(rv_precio)    TYPE zdecimals2.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_aparcamiento_00 IMPLEMENTATION.
  METHOD calcular_tarifa.
    rv_precio = i_horas_estacionado * '1.50'.
    e_minutos_totales = i_horas_estacionado * 60.
  ENDMETHOD.

ENDCLASS.
