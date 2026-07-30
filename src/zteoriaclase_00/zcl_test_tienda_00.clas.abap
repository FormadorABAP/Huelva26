CLASS zcl_test_tienda_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_tienda_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_tienda) = NEW zcl_tienda_00( ).

    DATA lv_iva TYPE zdecimals2.

    DATA(lv_total) = lo_tienda->vender_producto(
                            EXPORTING i_cantidad = 3
                                      i_precio_unidad = 10
                            IMPORTING o_iva = lv_iva ).

    out->write( | El total es { lv_total }€ y el IVA es { lv_iva } | ).

  ENDMETHOD.
ENDCLASS.
