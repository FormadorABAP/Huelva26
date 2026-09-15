CLASS lhc_zr_incidencia_00 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ZrIncidencia00
        RESULT result,

      InicializarIncidencia FOR DETERMINE ON MODIFY
       keys FOR ZrIncidencia00~InicializarIncidencia,

      CerrarIncidencia FOR MODIFY
       keys FOR ACTION ZrIncidencia00~CerrarIncidencia RESULT result,

      earlynumbering_create FOR NUMBERING
       entities FOR CREATE ZrIncidencia00.

ENDCLASS.

CLASS lhc_zr_incidencia_00 IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD InicializarIncidencia.

    " Leemos todas las incidencias recibidas
    READ ENTITIES OF zr_incidencia_00 IN LOCAL MODE
      ENTITY ZrIncidencia00
        FIELDS ( Estado FechaAlta )
        WITH CORRESPONDING #( keys )
      RESULT DATA(incidencias).

    " Modificamos todas las incidencias
    MODIFY ENTITIES OF zr_incidencia_00 IN LOCAL MODE
      ENTITY ZrIncidencia00
        UPDATE FIELDS ( Estado FechaAlta )
        WITH VALUE #(
          FOR incidencia IN incidencias
          (
            %tky = incidencia-%tky

            Estado =
              COND #(
                WHEN incidencia-Estado IS INITIAL
                THEN 'N'
                ELSE incidencia-Estado
              )

            FechaAlta =
              COND #(
                WHEN incidencia-FechaAlta IS INITIAL
                THEN cl_abap_context_info=>get_system_date( )
                ELSE incidencia-FechaAlta
              )
          )
        ).

  ENDMETHOD.

  METHOD CerrarIncidencia.

    MODIFY ENTITIES OF zr_incidencia_00 IN LOCAL MODE
     ENTITY ZrIncidencia00
       UPDATE FIELDS ( Estado FechaCierre )
       WITH VALUE #(
         FOR key IN keys
         (
           %tky        = key-%tky
           Estado      = 'C'
           FechaCierre = cl_abap_context_info=>get_system_date( )
         )
       ).

    READ ENTITIES OF zr_incidencia_00 IN LOCAL MODE
      ENTITY ZrIncidencia00
        ALL FIELDS
        WITH CORRESPONDING #( keys )
      RESULT DATA(incidencias).

    result = VALUE #(
      FOR incidencia IN incidencias
      (
        %tky   = incidencia-%tky
        %param = incidencia
      )
    ).

  ENDMETHOD.

  METHOD earlynumbering_create.

    DATA entity TYPE STRUCTURE FOR CREATE zr_incidencia_00.


    "----------------------------------------------------------
    " 1. Si ya tiene ID, lo conservamos
    "    Importante en escenarios Draft
    "----------------------------------------------------------
    LOOP AT entities INTO entity
         WHERE IdIncidencia IS NOT INITIAL.

      APPEND VALUE #(
        %cid      = entity-%cid
        %key      = entity-%key
        %is_draft = entity-%is_draft
      ) TO mapped-ZrIncidencia00.

    ENDLOOP.


    "----------------------------------------------------------
    " 2. Nos quedamos solo con las incidencias sin ID
    "----------------------------------------------------------
    DATA(entities_sin_id) = entities.

    DELETE entities_sin_id
      WHERE IdIncidencia IS NOT INITIAL.


    " Todas estaban ya numeradas
    IF entities_sin_id IS INITIAL.
      RETURN.
    ENDIF.


    "----------------------------------------------------------
    " 3. Obtenemos números del Number Range
    "----------------------------------------------------------
    TRY.

        cl_numberrange_runtime=>number_get(
          EXPORTING
            nr_range_nr       = '01'
            object            = 'ZINCID_00'
            quantity          = CONV #( lines( entities_sin_id ) )

          IMPORTING
            number            = DATA(numero_final)
            returncode        = DATA(codigo_retorno)
            returned_quantity = DATA(cantidad_devuelta)
        ).

      CATCH cx_number_ranges INTO DATA(error_number_range).

        LOOP AT entities_sin_id INTO entity.

          APPEND VALUE #(
            %cid      = entity-%cid
            %key      = entity-%key
            %is_draft = entity-%is_draft
            %msg      = error_number_range
          ) TO reported-ZrIncidencia00.

          APPEND VALUE #(
            %cid        = entity-%cid
            %key        = entity-%key
            %is_draft   = entity-%is_draft
            %fail-cause = if_abap_behv=>cause-conflict
          ) TO failed-ZrIncidencia00.

        ENDLOOP.

        RETURN.

    ENDTRY.


    "----------------------------------------------------------
    " 4. Comprobamos que tenemos números para todas
    "----------------------------------------------------------
    IF cantidad_devuelta <> lines( entities_sin_id ).

      LOOP AT entities_sin_id INTO entity.

        APPEND VALUE #(
          %cid        = entity-%cid
          %key        = entity-%key
          %is_draft   = entity-%is_draft
          %fail-cause = if_abap_behv=>cause-conflict
        ) TO failed-ZrIncidencia00.

      ENDLOOP.

      RETURN.

    ENDIF.


    "----------------------------------------------------------
    " 5. Calculamos el primer número reservado
    "----------------------------------------------------------
    DATA(numero_actual) =
      CONV i( numero_final ) - CONV i( cantidad_devuelta ).


    "----------------------------------------------------------
    " 6. Generamos INC0001, INC0002...
    "----------------------------------------------------------
    LOOP AT entities_sin_id INTO entity.

      numero_actual += 1.

      entity-IdIncidencia =
        |INC{ numero_actual WIDTH = 4 ALIGN = RIGHT PAD = '0' }|.


      " MUY IMPORTANTE:
      " devolvemos CID + KEY + IS_DRAFT
      APPEND VALUE #(
        %cid      = entity-%cid
        %key      = entity-%key
        %is_draft = entity-%is_draft
      ) TO mapped-ZrIncidencia00.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
