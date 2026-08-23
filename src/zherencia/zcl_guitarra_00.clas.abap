CLASS zcl_guitarra_00 DEFINITION
  PUBLIC
  INHERITING FROM zcl_instrumento_00
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS: constructor IMPORTING i_marca   TYPE string
                                   i_cuerdas TYPE i,
      afinar_cuerda IMPORTING i_cuerda          TYPE i
                    RETURNING VALUE(rv_afinado) TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA: num_cuerdas TYPE i.

ENDCLASS.



CLASS ZCL_GUITARRA_00 IMPLEMENTATION.


  METHOD constructor.

    super->constructor( i_marca = i_marca ).
    num_cuerdas = i_cuerdas.

  ENDMETHOD.


  METHOD afinar_cuerda.
    rv_afinado = abap_false.
    IF i_cuerda > 0 AND i_cuerda <= num_cuerdas.
      rv_afinado = abap_true.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
