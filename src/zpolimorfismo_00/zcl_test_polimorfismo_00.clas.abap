CLASS zcl_test_polimorfismo_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_POLIMORFISMO_00 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    " Visto hasta ahora
*    DATA(lo_padre) = NEW zcl_polimorfismo_00(  ).
*    out->write( lo_padre->saludar( ) ).
*
*    DATA(lo_hijo) = NEW zcl_polimorfismo_h_00(  ).
*    out->write( lo_hijo->saludar( ) ).
*
**    out->write( lo_padre->escupir( ) ).
*    out->write( lo_hijo->escupir( ) ).

*    " La novedad
*    DATA(lo_padre) = NEW zcl_polimorfismo_00(  ).
*    out->write( lo_padre->saludar( ) ).
*
*    DATA lo_hijo TYPE REF TO zcl_polimorfismo_00.
*    lo_hijo = NEW zcl_polimorfismo_h_00(  ).
*    out->write( lo_hijo->saludar( ) ).
*
*    out->write( lo_padre->escupir( ) ).
*    out->write( lo_hijo->escupir( ) ).

    " Ahora con tablas
    DATA lt_empleados TYPE TABLE OF REF TO zcl_polimorfismo_00.

    APPEND NEW zcl_polimorfismo_00( )   TO lt_empleados.
    APPEND NEW zcl_polimorfismo_h_00( ) TO lt_empleados.
    APPEND NEW zcl_polimorfismo_00( )   TO lt_empleados.
    APPEND NEW zcl_polimorfismo_h_00( ) TO lt_empleados.
    APPEND NEW zcl_polimorfismo_00( )   TO lt_empleados.
    APPEND NEW zcl_polimorfismo_h_00( ) TO lt_empleados.
    APPEND NEW zcl_polimorfismo_00( )   TO lt_empleados.
    APPEND NEW zcl_polimorfismo_h_00( ) TO lt_empleados.
    APPEND NEW zcl_polimorfismo_00( )   TO lt_empleados.
    APPEND NEW zcl_polimorfismo_h_00( ) TO lt_empleados.

    LOOP AT lt_empleados INTO DATA(lo_empleado).
      out->write( lo_empleado->saludar( ) ).
*      out->write( lo_empleado->escupir( ) ).

    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
