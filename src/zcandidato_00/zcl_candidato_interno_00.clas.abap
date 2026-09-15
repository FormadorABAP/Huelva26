CLASS zcl_candidato_interno_00 DEFINITION
  PUBLIC
  INHERITING FROM zcl_candidato_00
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
        puntuacion_base_interna type i VALUE 5.

    METHODS:
        calcular_idoneidad REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_candidato_interno_00 IMPLEMENTATION.
  METHOD calcular_idoneidad.

    rv_idoneidad = ( anios_experiencia * '0.6' ) + ( puntuacion_base_interna * '0.4' ).

    IF rv_idoneidad > 10.
      rv_idoneidad = 10.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
