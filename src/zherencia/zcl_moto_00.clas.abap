CLASS zcl_moto_00 DEFINITION
  PUBLIC
  INHERITING FROM zcl_vehiculo_00
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS: caballito RETURNING VALUE(rv_accion) TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA: maletero_trasero TYPE abap_bool.

ENDCLASS.



CLASS ZCL_MOTO_00 IMPLEMENTATION.


  METHOD caballito.
    IF kilometraje > 0.
      rv_accion = abap_true.
    ELSE.
      rv_accion = abap_false.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
