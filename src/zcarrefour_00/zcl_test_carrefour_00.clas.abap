CLASS zcl_test_carrefour_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_carrefour_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_planta) = NEW zcl_planta_00(
                                i_nombre = 'Gardenia'
                                i_stock = 10
                                i_nivel = 10 ).

    TRY.
        lo_planta->vender( i_cantidad = 10 ).
        MESSAGE ID 'ZCARREFOUR_00' TYPE 'I' NUMBER 003 INTO DATA(lv_mensaje).
        out->write( lv_mensaje ).

      CATCH zcx_carrefour_00 INTO DATA(lx_error).
        out->write( lx_error->get_text(  ) ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
