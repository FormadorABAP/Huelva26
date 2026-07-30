CLASS zcl_test_bombilla_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_test_bombilla_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    " Declaración + Constructor --> Forma tradicional
*    DATA lo_bombilla TYPE REF TO zcl_bombilla_00.
*    CREATE OBJECT lo_bombilla.

    " Declaración + Constructor --> Forma moderna
    DATA(lo_bombilla_1) = NEW zcl_bombilla_00( ).
    DATA(lo_bombilla_2) = NEW zcl_bombilla_00( ).

    " Llama al método encender
    lo_bombilla_2->encender( ).

    " Encender la bombilla sin el método, modificando el atributo
    lo_bombilla_1->esta_encendida = abap_true.

    " Recupera el valor del atributo y lo pinta
    out->write( |Bombilla 1 = { lo_bombilla_1->esta_encendida } | ).
    out->write( |Bombilla 2 = { lo_bombilla_2->esta_encendida } | ).

  ENDMETHOD.
ENDCLASS.
