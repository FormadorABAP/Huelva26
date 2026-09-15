CLASS zcl_medicamento_00 DEFINITION
  PUBLIC

  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA:
      id               TYPE i,
      nombre           TYPE string,
      laboratorio      TYPE string,
      precio           TYPE zdecimals2,
      stock            TYPE i,
      requiere_receta  TYPE abap_bool,
      principio_activo TYPE string.

    METHODS:
      constructor IMPORTING
                    i_id               TYPE i
                    i_nombre           TYPE string
                    i_laboratorio      TYPE string
                    i_precio           TYPE zdecimals2
                    i_stock            TYPE i
                    i_requiere_receta  TYPE abap_bool
                    i_principio_activo TYPE string,

      calcular_precio_final RETURNING VALUE(rv_precio) TYPE zdecimals2.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_medicamento_00 IMPLEMENTATION.
  METHOD calcular_precio_final.
    rv_precio = precio.
  ENDMETHOD.

  METHOD constructor.
    id = i_id.
    nombre = i_nombre.
    laboratorio = i_laboratorio.
    precio = i_precio.
    stock = i_stock.
    requiere_receta = i_requiere_receta.
    principio_activo = i_principio_activo.
  ENDMETHOD.

ENDCLASS.
