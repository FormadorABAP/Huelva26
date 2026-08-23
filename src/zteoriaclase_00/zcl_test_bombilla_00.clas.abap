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
*    CREATE OBJECT lo_bombilla EXPORTING i_potencia = 60.

    " Declaración + Constructor --> Forma moderna
    DATA(lo_bombilla_1) = NEW zcl_bombilla_00( i_potencia = 60 ).
    DATA(lo_bombilla_2) = NEW zcl_bombilla_00( 90 ).

    " Llama al método encender
    lo_bombilla_2->encender( ).

    " Encender la bombilla sin el método, modificando el atributo
*    lo_bombilla_1->esta_encendida = abap_true.

    " Recupera el valor del atributo y lo pinta
    DATA(lv_encendido) = lo_bombilla_1->get_encendida( ).
    out->write( |Bombilla 1 = { lv_encendido }| ).

    lv_encendido = lo_bombilla_2->get_encendida( ).
    out->write( |Bombilla 2 = { lv_encendido }| ).

  ENDMETHOD.
ENDCLASS.
