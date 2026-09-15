CLASS zcl_med_marca_00 DEFINITION
  PUBLIC
  INHERITING FROM zcl_medicamento_00
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    data:
        nombre_comercial type string,
        recargo_marca type i.

    METHODS CALCULAR_PRECIO_FINAL REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_med_marca_00 IMPLEMENTATION.
  METHOD calcular_precio_final.

    rv_precio = super->calcular_precio_final( ) + recargo_marca.

  ENDMETHOD.

ENDCLASS.
