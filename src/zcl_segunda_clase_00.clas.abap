CLASS zcl_segunda_clase_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.


    METHODS saludar.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_segunda_clase_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
*    DATA lv_saludo TYPE string.
*    lv_saludo = 'Hola'.

*    DATA(lv_decimal) = '32.5'.
*    DATA(lv_decimal2) = CONV zdecimals2('32.5').
*
*    data(lv_suma) = lv_decimal + lv_decimal2.
*
*    data(lv_trunc) = conv i( trunc( lv_decimal ) ).
*
*
*    CLEAR lv_decimal.

    data(lv_direccion) = conv zde_direcion_00( 'W' ).
    clear lv_direccion.
  ENDMETHOD.

  METHOD saludar.
    DATA lv_saludo TYPE string.
    lv_saludo = 'Hola'.
  ENDMETHOD.

ENDCLASS.
