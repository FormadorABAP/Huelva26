CLASS zcl_test_farmacia_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_farmacia_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

********** FASE 1

********** Apartado 8

    TYPES: BEGIN OF ty_medicamento,
             id                   TYPE i,
             nombre               TYPE string,
             laboratorio          TYPE string,
             precio               TYPE zdecimals2,
             stock                TYPE i,
             tipo                 TYPE string,
             requiere_receta      TYPE abap_bool,
             principio_activo     TYPE string,
             coste_interno        TYPE zdecimals2,
             porcentaje_descuento TYPE i,
             nombre_comercial     TYPE string,
             recargo_marca        TYPE zdecimals2,
           END OF ty_medicamento.

    TYPES TTy_MEDICAMENTOS TYPE TABLE OF ty_medicamento WITH EMPTY KEY.

********** Apartado 9


    DATA(lt_medicamentos) = VALUE TTy_MEDICAMENTOS(
       ( id = 1
         nombre               = 'Paracetamol'
         laboratorio          = 'Cinfa'
         precio               = '2.50'
         stock               = 40
         tipo               = 'G'
         requiere_receta     = abap_false
         principio_activo     = 'Paracetamol'
         coste_interno        = '1.20' )
       ( id = 2
         nombre               = 'Ibuprofeno'
         laboratorio          = 'Kern Pharma'
         precio               = '3.80'
         stock               = 15
         tipo               = 'G'
         requiere_receta     = abap_false
         principio_activo     = 'Ibuprofeno'
         coste_interno        = '1.80' )
       ( id = 3
         nombre               = 'Omeprazol'
         laboratorio          = 'Cinfa'
         precio               = '5.10'
         stock               = 25
         tipo               = 'G'
         requiere_receta     = abap_false
         principio_activo     = 'Omeprazol'
         coste_interno        = '2.50' )
       ( id = 4
         nombre               = 'Amoxicilina'
         laboratorio          = 'gsk'
         precio               = '6.20'
         stock               = 8
         tipo               = 'M'
         requiere_receta     = abap_true
         principio_activo     = 'Amoxicilina + clavulánico'
         coste_interno        = '3.10' )
       ( id = 5
         nombre               = 'Acenocumarol'
         laboratorio          = 'Viatris'
         precio               = '4.90'
         stock               = 3
         tipo               = 'M'
         requiere_receta     = abap_true
         principio_activo     = 'Acenocumarol'
         coste_interno        = '2.20' )
       ( id = 6
         nombre               = 'Salbutamol'
         laboratorio          = 'gsk'
         precio               = '6.00'
         stock               = 0
         tipo               = 'M'
         requiere_receta     = abap_true
         principio_activo     = 'Salbutamol'
         coste_interno        = '3.50' )
    ).

    out->write( lt_medicamentos ).

********** FASE 2

    TYPES: BEGIN OF ty_fase2,
             nombre         TYPE string,
             stock          TYPE i,
             estado         TYPE string,
             tipo           TYPE string,
             disponibilidad TYPE abap_bool,
           END OF ty_fase2.

    TYPES Tty_fase2 TYPE TABLE OF ty_fase2 WITH EMPTY KEY.

    DATA(lt_fase2) = VALUE tty_fase2(
        FOR ls_medicamento IN lt_medicamentos
            ( nombre = ls_medicamento-nombre
              stock = ls_medicamento-stock

              " Apartado 10
              estado = COND string(
                WHEN ls_medicamento-stock >= 30 THEN 'STOCK ALTO'
                WHEN ls_medicamento-stock >= 10 THEN 'STOCK MEDIO'
                WHEN ls_medicamento-stock >= 1 THEN 'STOCK BAJO'
                ELSE 'SIN STOCK' )

              " Apartado 11
              tipo = SWITCH string(
                  ls_medicamento-tipo
                  WHEN 'G' THEN 'General'
                  WHEN 'M' THEN 'Marca'
                  WHEN 'H' THEN 'Hospitalario'
                  ELSE 'Desconocido'   )

              " Apartado 12
              disponibilidad =  xsdbool( ls_medicamento-stock > 0 AND ls_medicamento-precio > 0 )
            )
        ).

    out->write( lt_fase2 ).

********** FASE 3

    DATA lv_cantidad_s TYPE string.
    DATA lv_precio_s TYPE string.

    lv_cantidad_s = '12'.
    lv_precio_s = '3.50'.

    DATA lv_resultado TYPE zdecimals2.
    lv_resultado = CONV zdecimals2( lv_cantidad_s ) * CONV zdecimals2( lv_precio_s ).
*    lv_resultado = lv_cantidad_s * lv_precio_s.
    out->write( lv_resultado ).

    out->write( 'De entero a decimal ' && CONV zdecimals2( 25 ) ).
    out->write( 'De decimal a entero ' && CONV i( '25.80' ) ).
    out->write( 'ROUND ' && CONV string( round( val = '25.80' dec = 0 ) ) ).
    out->write( 'TRUNC ' && CONV string( trunc( '25.80' ) ) ).
    out->write( 'CEIL ' && CONV string( ceil( '25.80' ) ) ).
    out->write( 'FLOOR ' && CONV string( floor( '25.80' ) ) ).

    out->write( 'ROUND ' && CONV string( round( val = '-25.80' dec = 0 ) ) ).
    out->write( 'TRUNC ' && CONV string( trunc( '-25.80' ) ) ).
    out->write( 'CEIL ' && CONV string( ceil( '-25.80' ) ) ).
    out->write( 'FLOOR ' && CONV string( floor( '-25.80' ) ) ).

********** FASE 4

    out->write( 'EXACT ' && CONV string( EXACT i( '25.00' ) ) ).

    TRY.
        out->write( 'EXACT ' && CONV string( EXACT i( '25.75' ) ) ).
      CATCH cx_sy_conversion_error.
        out->write( 'NO SE PUEDE CONVERTIR 25,75 SIN PERDER INFORMACIÓN' ).
    ENDTRY.

********** FASE 5

    TRY.
        out->write( lt_medicamentos[ id = 3 ] ).
        out->write( lt_medicamentos[ id = 4 ]-nombre ).
        out->write( lt_medicamentos[ id = 2 ]-precio ).
        out->write( lt_medicamentos[ 1 ] ).
        out->write( lt_medicamentos[ 99 ] ).

      CATCH cx_sy_itab_line_not_found.
        out->write( 'MEDICAMENTO NO ENCONTRADO' ).
    ENDTRY.

********** FASE 6

    IF line_exists( lt_medicamentos[ id = 5 ] ).
      out->write( 'Existe' ).
    ELSE .
      out->write( 'NO Existe' ).
    ENDIF.

    out->write( COND string(
        WHEN line_exists( lt_medicamentos[ id = 99 ] ) THEN 'Existe'
        ELSE 'NO Existe'
        ) ).

    out->write( VALUE ty_medicamento( lt_medicamentos[ id = 99 ] OPTIONAL ) ).
    out->write( VALUE ty_medicamento( lt_medicamentos[ id = 99 ]
        DEFAULT VALUE ty_medicamento(
            nombre = 'MEDICAMENTO NO ENCONTRADO' ) ) ).

    out->write( line_index( lt_medicamentos[ id = 3 ] ) ).
    out->write( line_index( lt_medicamentos[ id = 99 ] ) ).

********** FASE 7

    TYPES: BEGIN OF ty_medicamento_publico,
             id          TYPE i,
             nombre      TYPE string,
             laboratorio TYPE string,
             precio      TYPE zdecimals2,
             stock       TYPE i,
           END OF ty_medicamento_publico.

    TYPES tty_medicamentos_publicos TYPE TABLE OF ty_medicamento_publico.

    DATA(lt_medicamentos_publicos) = CORRESPONDING tty_medicamentos_publicos( lt_medicamentos ).
    out->write( lt_medicamentos_publicos ).

    TYPES: BEGIN OF tY_MEDICAMENTO_EXTERNO,
             codigo      TYPE i,
             descripcion TYPE string,
             fabricante  TYPE string,
             precio      TYPE zdecimals2,
             unidades    TYPE i,
           END OF tY_MEDICAMENTO_EXTERNO.

    TYPES ttY_MEDICAMENTOS_EXTERNOS TYPE TABLE OF tY_MEDICAMENTO_EXTERNO.
    DATA(lt_MEDICAMENTOS_EXTERNOS) = CORRESPONDING ttY_MEDICAMENTOS_EXTERNOS(
        lt_medicamentos
        MAPPING
            Codigo = id
            descripcion = nombre
            fabricante = laboratorio
            unidades = stock
        ).

    out->write( lt_MEDICAMENTOS_EXTERNOS ).


    TYPES: BEGIN OF ty_medicamento_auditoria,
             id            TYPE i,
             nombre        TYPE string,
             precio        TYPE zdecimals2,
             coste_interno TYPE zdecimals2,
           END OF ty_medicamento_auditoria.

    TYPES tty_medicamentos_auditoria TYPE TABLE OF ty_medicamento_auditoria.

    DATA(lt_medicamentos_auditoria) = CORRESPONDING tty_medicamentos_auditoria(
            lt_medicamentos
            EXCEPT
            coste_interno ).
    out->write( lt_medicamentos_auditoria ).


********** FASE 8

    DATA(ls_medicamento_8) = lt_medicamentos[ id = 2 ].

    DATA(ls_medicamento_8b) = VALUE ty_medicamento(
        BASE
            ls_medicamento_8
            stock = 35 ).

    out->write( ls_medicamento_8 ).
    out->write( ls_medicamento_8b ).


********** FASE 9

    TYPES: BEGIN OF ty_resumen_medicamento,
             id     TYPE i,
             nombre TYPE string,
             precio TYPE zdecimals2,
             stock  TYPE i,
           END OF ty_resumen_medicamento.

    TYPES tty_RESUMEN_MEDICAMENTOS TYPE TABLE OF ty_RESUMEN_MEDICAMENTO WITH EMPTY KEY.

    DATA(lt_resumen) = VALUE tty_RESUMEN_MEDICAMENTOS(
     FOR ls_medicamento IN lt_medicamentos (
        id = ls_medicamento-id
        nombre = ls_medicamento-nombre
        precio = ls_medicamento-precio
        stock = ls_medicamento-stock ) ).

    out->write( lt_resumen ).

    CLEAR lt_medicamentos_publicos[].
    lt_medicamentos_publicos = VALUE #(
         FOR ls_medicamento IN lt_medicamentos (
            CORRESPONDING #( ls_medicamento )
             ) ) .

    out->write( lt_medicamentos_publicos ).

********** FASE 9

    TYPES: BEGIN OF ty_valor_stock,
             id            TYPE i,
             nombre        TYPE string,
             subtotal      TYPE zdecimals2,
             iva           TYPE zdecimals2,
             total_con_iva TYPE zdecimals2,
           END OF ty_valor_stock.

    TYPES tty_valor_stock TYPE TABLE OF ty_valor_stock WITH EMPTY KEY.

    DATA(lt_valor_stock) = VALUE tty_valor_stock(
     FOR ls_medicamento IN lt_medicamentos

            LET
                lv_subtotal = conv zdecimals2( ls_medicamento-precio * ls_medicamento-stock )
                lv_iva = conv zdecimals2( lv_subtotal * '0.04' )
                lv_total = conv zdecimals2( lv_subtotal + lv_iva )
            IN (
                id = ls_medicamento-id
                nombre = ls_medicamento-nombre
                subtotal = lv_subtotal
                iva = lv_iva
                total_con_iva = lv_total )
            ).

    out->write( lt_valor_stock ).
  ENDMETHOD.

ENDCLASS.
