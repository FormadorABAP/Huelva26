CLASS zcl_candidato_externo_00 DEFINITION
  PUBLIC
  INHERITING FROM zcl_candidato_00
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA:
      num_certificaciones TYPE i.

    METHODS:
      constructor IMPORTING
                    i_id                    TYPE i
                    i_nombre_completo       TYPE string
                    i_anios_experiencia     TYPE i
                    i_dni                   TYPE string
                    i_telefono_personal     TYPE string
                    i_salario_actual        TYPE zdecimals2
                    i_salario_pretendido    TYPE zdecimals2
                    i_puntuacion_entrevista TYPE i
                    i_num_certificaciones   TYPE i,

      calcular_idoneidad REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_candidato_externo_00 IMPLEMENTATION.
  METHOD calcular_idoneidad.

    rv_idoneidad = ( anios_experiencia * '0.3' ) + ( num_certificaciones * '1.5' ).

    IF rv_idoneidad > 10.
      rv_idoneidad = 10.
    ENDIF.

  ENDMETHOD.

  METHOD constructor.

    super->constructor( i_id = i_id
                        i_nombre_completo = i_nombre_completo
                        i_anios_experiencia = i_anios_experiencia
                        i_dni = i_dni
                        i_telefono_personal = i_telefono_personal
                        i_salario_actual = i_salario_actual
                        i_salario_pretendido = i_salario_pretendido
                        i_puntuacion_entrevista = i_puntuacion_entrevista ).

    num_certificaciones = i_num_certificaciones.

  ENDMETHOD.

ENDCLASS.
