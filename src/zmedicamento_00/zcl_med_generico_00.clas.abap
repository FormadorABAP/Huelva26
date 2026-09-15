CLASS zcl_med_generico_00 DEFINITION
  PUBLIC
  INHERITING FROM zcl_medicamento_00
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA porcentaje_descuento TYPE i.

    METHODS calcular_precio_final REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_med_generico_00 IMPLEMENTATION.
  METHOD calcular_precio_final.

    rv_precio = super->calcular_precio_final( ) * ( 1 - porcentaje_descuento / 100 ).

  ENDMETHOD.

ENDCLASS.
