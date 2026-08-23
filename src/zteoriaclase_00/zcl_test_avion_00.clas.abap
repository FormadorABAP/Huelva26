CLASS zcl_test_avion_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_AVION_00 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    " Declara el objeto / la instacia
    DATA lo_avion TYPE REF TO zcl_avion_00.

    " Crea la instancia -> Llama al constructor
    CREATE OBJECT lo_avion EXPORTING i_asientos_max = 100.

    DO 17 TIMES.
      lo_avion->embarcar_pasajero( ).
    ENDDO.

    DATA(lv_ocupacion) = lo_avion->get_ocupacion( ).

    " Pinta por pantalla
    out->write( |El avión tiene { lo_avion->asientos_ocu } asientos ocupados| ).

  ENDMETHOD.
ENDCLASS.
