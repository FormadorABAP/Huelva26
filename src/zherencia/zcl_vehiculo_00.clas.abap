CLASS zcl_vehiculo_00 DEFINITION
  PUBLIC
*  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      constructor IMPORTING i_matricula TYPE string,
      viajar IMPORTING i_kilometros TYPE i,
      get_contador EXPORTING o_contador TYPE i,
      pasar_revision RETURNING VALUE(rv_revision) TYPE abap_bool.

  PROTECTED SECTION.

    DATA: matricula   TYPE string,
          kilometraje TYPE i.

  PRIVATE SECTION.



ENDCLASS.

CLASS zcl_vehiculo_00 IMPLEMENTATION.
  METHOD constructor.
    matricula = i_matricula.
    kilometraje = 0.
  ENDMETHOD.

  METHOD get_contador.
    o_contador = kilometraje.
  ENDMETHOD.

  METHOD viajar.
    kilometraje += i_kilometros.
  ENDMETHOD.

  METHOD pasar_revision.
    rv_revision = abap_false.
    IF kilometraje <= 150000.
      rv_revision = abap_true.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
