CLASS lhc_zr_penaltis_00 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:

      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ZrPenaltis00
        RESULT result,

      nuevo_lanzamiento FOR NUMBERING
       entities FOR CREATE ZrPenaltis00,

      calcula_resultado FOR DETERMINE ON SAVE
       keys FOR ZrPenaltis00~calcula_resultado,

      lanzar_penaltis FOR MODIFY
       keys FOR ACTION ZrPenaltis00~lanzar_penaltis RESULT result.
ENDCLASS.

CLASS lhc_zr_penaltis_00 IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD nuevo_lanzamiento.

    DATA entity TYPE STRUCTURE FOR CREATE zr_penaltis_00.

    "----------------------------------------------------------
    " 1. Si ya tiene ID, lo conservamos
    "    Importante en escenarios Draft
    "----------------------------------------------------------
    LOOP AT entities INTO entity
         WHERE NumeroLanzamiento IS NOT INITIAL.

      APPEND VALUE #(
        %cid      = entity-%cid
        %key      = entity-%key
        %is_draft = entity-%is_draft
      ) TO mapped-ZrPenaltis00.

    ENDLOOP.

    "----------------------------------------------------------
    " 2. Nos quedamos solo con las partidas sin ID
    "----------------------------------------------------------
    DATA(entities_sin_id) = entities.

    DELETE entities_sin_id
      WHERE NumeroLanzamiento IS NOT INITIAL.

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
            object            = 'ZPENAL_00'
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
          ) TO reported-ZrPenaltis00.

          APPEND VALUE #(
            %cid        = entity-%cid
            %key        = entity-%key
            %is_draft   = entity-%is_draft
            %fail-cause = if_abap_behv=>cause-conflict
          ) TO failed-ZrPenaltis00.

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
        ) TO failed-ZrPenaltis00.

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

      entity-NumeroLanzamiento =
        |{ numero_actual WIDTH = 3 ALIGN = RIGHT PAD = '0' }|.


      " MUY IMPORTANTE:
      " devolvemos CID + KEY + IS_DRAFT
      APPEND VALUE #(
        %cid      = entity-%cid
        %key      = entity-%key
        %is_draft = entity-%is_draft
      ) TO mapped-ZrPenaltis00.

    ENDLOOP.


  ENDMETHOD.

  METHOD calcula_resultado.

    " Leemos todas las partidas recibidas
    READ ENTITIES OF zr_penaltis_00 IN LOCAL MODE
      ENTITY ZrPenaltis00
        FIELDS ( DirDisparo DirPortero )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lanzamientos).

    " Modificamos todas las partidas
    MODIFY ENTITIES OF zr_penaltis_00 IN LOCAL MODE
      ENTITY ZrPenaltis00
        UPDATE FIELDS ( Resultado )
        WITH VALUE #(
          FOR lanzamiento IN lanzamientos
          (
            %tky = lanzamiento-%tky

            Resultado =
              COND #(
                WHEN lanzamiento-DirDisparo = lanzamiento-DirPortero THEN 'Parada'
                ELSE 'Gol'
              )

          )
        ).

  ENDMETHOD.

  METHOD lanzar_penaltis.

    " Leemos todas las partidas recibidas
    READ ENTITIES OF zr_penaltis_00 IN LOCAL MODE
      ENTITY ZrPenaltis00
        FIELDS ( DirDisparo DirPortero )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lanzamientos).

    " Modificamos todas las partidas
    MODIFY ENTITIES OF zr_penaltis_00 IN LOCAL MODE
      ENTITY ZrPenaltis00
        UPDATE FIELDS ( Resultado )
        WITH VALUE #(
          FOR lanzamiento IN lanzamientos
          (
            %tky = lanzamiento-%tky

            Resultado =
              COND #(
                WHEN lanzamiento-DirDisparo = lanzamiento-DirPortero THEN 'Parada'
                ELSE 'Gol'
              )

          )
        ).

    READ ENTITIES OF zr_penaltis_00 IN LOCAL MODE
      ENTITY ZrPenaltis00
        ALL FIELDS
        WITH CORRESPONDING #( keys )
      RESULT lanzamientos.

    result = VALUE #(
      FOR lanzamiento IN lanzamientos
      (
        %tky   = lanzamiento-%tky
        %param = lanzamiento
      )
    ).

  ENDMETHOD.

ENDCLASS.
