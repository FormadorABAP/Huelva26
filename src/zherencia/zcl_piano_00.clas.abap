CLASS zcl_piano_00 DEFINITION
  PUBLIC
  INHERITING FROM zcl_instrumento_00
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS: constructor IMPORTING i_marca     TYPE string
                                   i_electrico TYPE abap_bool,
      pedalear RETURNING VALUE(rv_pedaleo) TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA electrico TYPE abap_bool.

ENDCLASS.



CLASS zcl_piano_00 IMPLEMENTATION.
  METHOD constructor.

    super->constructor( i_marca = i_marca ).
    electrico = i_electrico.

  ENDMETHOD.

  METHOD pedalear.
    rv_pedaleo = abap_false.
    IF horas_uso >= 1.
      rv_pedaleo = abap_true.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
