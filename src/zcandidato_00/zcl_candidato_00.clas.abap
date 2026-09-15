CLASS zcl_candidato_00 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA:
      id                    TYPE i,
      nombre_completo       TYPE string,
      anios_experiencia     TYPE i,
      dni                   TYPE string,
      telefono_personal     TYPE string,
      salario_actual        TYPE zdecimals2,
      salario_pretendido    TYPE zdecimals2,
      puntuacion_entrevista TYPE i.

    METHODS:
      constructor IMPORTING
                    i_id                    TYPE i
                    i_nombre_completo       TYPE string
                    i_anios_experiencia     TYPE i
                    i_dni                   TYPE string
                    i_telefono_personal     TYPE string
                    i_salario_actual        TYPE zdecimals2
                    i_salario_pretendido    TYPE zdecimals2
                    i_puntuacion_entrevista TYPE i,

      calcular_idoneidad RETURNING VALUE(rv_idoneidad) TYPE zdecimals2,

      anadir_puntos_entrevista IMPORTING iv_puntos TYPE i,

      obtener_idoneidad_final RETURNING VALUE(rv_idoneidad_final) TYPE i,

      comparar_con IMPORTING io_otro             TYPE REF TO zcl_candidato_00
                   RETURNING VALUE(rv_resultado) TYPE string,

      calcular_banda_salarial RETURNING VALUE(rv_banda) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_candidato_00 IMPLEMENTATION.
  METHOD calcular_idoneidad.
    rv_idoneidad = anios_experiencia * '0.5'.
    IF rv_idoneidad > 10.
      rv_idoneidad = 10.
    ENDIF.
  ENDMETHOD.

  METHOD anadir_puntos_entrevista.
    puntuacion_entrevista += iv_puntos.
  ENDMETHOD.

  METHOD obtener_idoneidad_final.
    " Calcular idoneidad devuelve un decimal
    DATA(lv_temp) = me->calcular_idoneidad( ).
    " Decimal + lo que sea = Decimal
    lv_temp = lv_temp + ( puntuacion_entrevista / 10 ).

    " Lo paso a entero con el CONV porque mi salida es tipo i
    " El CONV del tiron redondea, no necesito el ROUND
    rv_idoneidad_final = CONV i( lv_temp ).

    " Debe respetar polimorfismo: al llamarse desde la clase base,
    " ejecuta la versión redefinida de la subclase real del objeto.

  ENDMETHOD.

  METHOD comparar_con.

    " Calcula la idoneidad del otro candidato
    DATA(lv_ido_otro) = io_otro->obtener_idoneidad_final( ).

    " Calcula la idoneidad del mismo candidato
    " La tengo que calcular porque no tengo parametros que lo guarden
    DATA(lv_ido_mia) = me->obtener_idoneidad_final( ).

    " ¿Quien gana?
    IF lv_ido_otro > lv_ido_mia.
      rv_resultado = io_otro->nombre_completo.
    ELSEIF lv_ido_otro < lv_ido_mia.
      rv_resultado = me->nombre_completo.
    ELSE.
      rv_resultado = 'EMPATE'.
    ENDIF.

  ENDMETHOD.

  METHOD calcular_banda_salarial.
    CONSTANTS c_5000 TYPE i VALUE 5000.
    DATA(lv_inferior) = floor( salario_pretendido / c_5000 ) * c_5000.
    DATA(lv_superior) = ceil( salario_pretendido / c_5000 ) * c_5000.

    IF lv_inferior = lv_superior.
      lv_superior = lv_inferior + 5000.
    ENDIF.

    rv_banda = | { lv_inferior } - { lv_superior } |.
  ENDMETHOD.

  METHOD constructor.
    id = i_id.
    nombre_completo = i_nombre_completo.
    anios_experiencia = i_anios_experiencia.
    dni                   = i_dni.
    telefono_personal     = i_telefono_personal.
    salario_actual        = i_salario_actual.
    salario_pretendido    = i_salario_pretendido.
    puntuacion_entrevista = i_puntuacion_entrevista.
  ENDMETHOD.

ENDCLASS.
