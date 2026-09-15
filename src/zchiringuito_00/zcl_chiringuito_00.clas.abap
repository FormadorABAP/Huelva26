CLASS zcl_chiringuito_00 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA: nombre      TYPE string,
          recaudacion TYPE zdecimals2.

    METHODS: constructor IMPORTING i_nombre TYPE string,
      vender IMPORTING i_dinero TYPE zdecimals2,
      calcular_comision RETURNING VALUE(rv_comision) TYPE zdecimals2,
      consultar_recaudacion RETURNING VALUE(rv_recaudacion) TYPE zdecimals2.

  PROTECTED SECTION.


  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_chiringuito_00 IMPLEMENTATION.
  METHOD vender.
    recaudacion = recaudacion + i_dinero.
  ENDMETHOD.

  METHOD calcular_comision.
    rv_comision = recaudacion * '0.1'.
  ENDMETHOD.

  METHOD consultar_recaudacion.
    rv_recaudacion = recaudacion.
  ENDMETHOD.

  METHOD constructor.
    nombre = i_nombre.
    recaudacion = 0.
  ENDMETHOD.

ENDCLASS.
