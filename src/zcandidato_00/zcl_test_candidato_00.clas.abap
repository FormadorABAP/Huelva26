CLASS zcl_test_candidato_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_candidato_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF ty_candidato,
             id                    TYPE i,
             nombre_completo       TYPE string,
             anios_experiencia     TYPE i,
             dni                   TYPE string,
             telefono              TYPE string,
             salario_actual        TYPE zdecimals2,
             salario_pretendido    TYPE zdecimals2,
             puntuacion_entrevista TYPE i,
           END OF ty_candidato.

    TYPES: BEGIN OF ty_candidato_completo,
             id                    TYPE i,
             nombre_completo       TYPE string,
             anios_experiencia     TYPE i,
             dni                   TYPE string,
             telefono_personal     TYPE string,
             salario_actual        TYPE zdecimals2,
             salario_pretendido    TYPE zdecimals2,
             puntuacion_entrevista TYPE i,
             banda_salarial        TYPE string,
             idoneidad             TYPE i,
           END OF ty_candidato_completo.

    DATA lt_candidato_completo TYPE TABLE OF ty_candidato_completo.
    DATA ls_candidato_completo TYPE ty_candidato_completo.

    DATA lt_candidato_ty TYPE TABLE OF ty_candidato.

    " Crea las instancias correspondientes y guárdalas en TYPE STANDARD TABLE OF REF TO zcl_candidato.
    DATA lt_candidato TYPE TABLE OF REF TO zcl_candidato_00.

    " Construye la tabla de datos base de 4 candidatos (2 internos, 2 externos) con VALUE #( ).
    " Prohibido APPEND/INSERT.

    lt_candidato = VALUE #(

        ( NEW zcl_candidato_interno_00( i_id = 1
                i_nombre_completo       = 'LuisCa'
                i_anios_experiencia     = 8
                i_dni                   = 'A'
                i_telefono_personal     = '1'
                i_salario_actual        = 27500
                i_salario_pretendido    = 30000
                i_puntuacion_entrevista = 7 ) )

        ( NEW zcl_candidato_externo_00( i_id = 2
                i_nombre_completo       = 'Salem'
                i_anios_experiencia     = 9
                i_dni                   = 'B'
                i_telefono_personal     = '2'
                i_salario_actual        = 37500
                i_salario_pretendido    = 50000
                i_puntuacion_entrevista = 8
                i_num_certificaciones   = 6 ) )

        ( NEW zcl_candidato_interno_00( i_id = 3
                i_nombre_completo       = 'Antonio'
                i_anios_experiencia     = 3
                i_dni                   = 'C'
                i_telefono_personal     = '3'
                i_salario_actual        = 17500
                i_salario_pretendido    = 25000
                i_puntuacion_entrevista = 9 ) )

        ( NEW zcl_candidato_externo_00( i_id = 4
                i_nombre_completo       = 'Jesús'
                i_anios_experiencia     = 5
                i_dni                   = 'D'
                i_telefono_personal     = '4'
                i_salario_actual        = 31200
                i_salario_pretendido    = 37000
                i_puntuacion_entrevista = 10
                i_num_certificaciones   = 3 ) )
        ).

    " Recorrido polimórfico (sin IF/CASE por tipo) llamando a calcular_idoneidad sobre cada uno,
    " mostrando el resultado con out->write( ).

    TRY.
        lt_candidato[ 2 ]->anadir_puntos_entrevista( iv_puntos = 6 ).
        lt_candidato[ 4 ]->anadir_puntos_entrevista( iv_puntos = 3 ).
      CATCH cx_sy_itab_line_not_found.
        out->write( 'No se ha recuperado ningún candidato ').
    ENDTRY.

    LOOP AT lt_candidato INTO DATA(lo_candidato).
      out->write( | { lo_candidato->nombre_completo } - { lo_candidato->calcular_idoneidad(  ) } | ).
      out->write( lo_candidato->calcular_banda_salarial( ) ).

      APPEND VALUE #(
                        id                    = lo_candidato->id
                        nombre_completo       = lo_candidato->nombre_completo
                        anios_experiencia     = lo_candidato->anios_experiencia
                        dni                   = lo_candidato->dni
                        telefono_personal     = lo_candidato->telefono_personal
                        salario_actual        = lo_candidato->salario_actual
                        salario_pretendido    = lo_candidato->salario_pretendido
                        puntuacion_entrevista = lo_candidato->puntuacion_entrevista
                        banda_salarial        = lo_candidato->calcular_banda_salarial( )
                        idoneidad             = lo_candidato->obtener_idoneidad_final( )
                    )  TO lt_candidato_completo.
    ENDLOOP.

    lt_candidato_ty = CORRESPONDING #( lt_candidato_completo
        MAPPING
        telefono = telefono_personal

        EXCEPT
        dni
    ).

    SORT lt_candidato_completo BY idoneidad DESCENDING.
    out->write( lt_candidato_completo ).

    TRY.
        DATA(lv_ganador) = lt_candidato[ 3 ]->comparar_con( io_otro = lt_candidato[ 3 ] ).
        out->write( | Entre { lt_candidato[ 3 ]->nombre_completo } y { lt_candidato[ 3 ]->nombre_completo } gana { lv_ganador } | ).
      CATCH cx_sy_itab_line_not_found.
        out->write( 'No se ha recuperado ningún candidato ').
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
