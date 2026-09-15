CLASS zexcepcion_controlada_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zexcepcion_controlada_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lv_dividendo TYPE i VALUE 10,
          lv_divisor   TYPE i VALUE 2,
          lv_resultado TYPE i.

    TRY.
        lv_resultado = lv_dividendo / lv_divisor.
        out->write( lv_resultado ).
      CATCH cx_sy_zerodivide INTO DATA(lx_error).
        out->write( lx_error->get_text( ) ).
    ENDTRY.



  ENDMETHOD.
ENDCLASS.
