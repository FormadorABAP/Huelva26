CLASS zcl_avion_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA: asientos_ocu TYPE i.

    METHODS:
      constructor IMPORTING i_asientos_max TYPE i,
      embarcar_pasajero,
      get_ocupacion RETURNING VALUE(rv_ocupacion) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA: asientos_max TYPE i.

ENDCLASS.

CLASS zcl_avion_00 IMPLEMENTATION.

  METHOD constructor.
    asientos_max = i_asientos_max.
    asientos_ocu = 0.
  ENDMETHOD.

  METHOD embarcar_pasajero.
    IF asientos_max > asientos_ocu.
      asientos_ocu += 1.
    ENDIF.
  ENDMETHOD.

  METHOD get_ocupacion.
    rv_ocupacion = asientos_ocu.
  ENDMETHOD.

ENDCLASS.
