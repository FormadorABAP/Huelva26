CLASS zcl_segunda_clase_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS saludar.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_segunda_clase_00 IMPLEMENTATION.

  METHOD saludar.
    DATA lv_saludo TYPE string.
    lv_saludo = 'Hola'.
  ENDMETHOD.

ENDCLASS.
