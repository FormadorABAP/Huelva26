CLASS zcl_test_cafetera_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_test_cafetera_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_cafetera) = NEW zcl_cafetera_00( 600 ).
    out->write( |Agua restante cuando creo la cafetera: { lo_cafetera->consultar_agua( ) } ml| ).

    lo_cafetera->preparar_cafe(  ).
    out->write( |Agua restante tras el primer café: { lo_cafetera->consultar_agua( ) } ml| ).

    lo_cafetera->preparar_cafe(  ).
    out->write( |Agua restante tras el segundo café: { lo_cafetera->consultar_agua( ) } ml| ).

    lo_cafetera->preparar_cafe(  ).
    out->write( |Agua restante tras el tercer café: { lo_cafetera->consultar_agua( ) } ml| ).


  ENDMETHOD.
ENDCLASS.
