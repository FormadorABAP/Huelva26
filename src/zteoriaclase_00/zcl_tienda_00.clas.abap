CLASS zcl_tienda_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS vender_producto
      IMPORTING i_precio_unidad TYPE zdecimals2
                i_cantidad      TYPE i
      EXPORTING o_iva           TYPE zdecimals2
      RETURNING VALUE(rv_total)  TYPE zdecimals2.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TIENDA_00 IMPLEMENTATION.


  METHOD vender_producto.
    rv_total = i_precio_unidad * i_cantidad.
    o_iva = rv_total * '0.21'.
  ENDMETHOD.
ENDCLASS.
