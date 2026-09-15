CLASS lhc_zr_ppt_00 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:

      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ZrPpt00
        RESULT result,

      nueva_partida FOR NUMBERING
       entities FOR CREATE ZrPpt00,

      Calcular_Ganador FOR DETERMINE ON MODIFY
       keys FOR ZrPpt00~Calcular_Ganador.

*      Calcular_Ganador2 FOR MODIFY
*       keys FOR ACTION ZrPpt00~Calcular_Ganador2 RESULT result.

ENDCLASS.

CLASS lhc_zr_ppt_00 IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.



  METHOD nueva_partida.

    DATA entity TYPE STRUCTURE FOR CREATE zr_ppt_00.

    "----------------------------------------------------------
    " 1. Si ya tiene ID, lo conservamos
    "    Importante en escenarios Draft
    "----------------------------------------------------------
    LOOP AT entities INTO entity
         WHERE NumPartida IS NOT INITIAL.

      APPEND VALUE #(
        %cid      = entity-%cid
        %key      = entity-%key
        %is_draft = entity-%is_draft
      ) TO mapped-ZrPpt00.

    ENDLOOP.

    "----------------------------------------------------------
    " 2. Nos quedamos solo con las partidas sin ID
    "----------------------------------------------------------
    DATA(entities_sin_id) = entities.

    DELETE entities_sin_id
      WHERE NumPartida IS NOT INITIAL.

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
            object            = 'ZPPT_00'
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
          ) TO reported-ZrPpt00.

          APPEND VALUE #(
            %cid        = entity-%cid
            %key        = entity-%key
            %is_draft   = entity-%is_draft
            %fail-cause = if_abap_behv=>cause-conflict
          ) TO failed-ZrPpt00.

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
        ) TO failed-ZrPpt00.

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

      entity-NumPartida =
        |{ numero_actual WIDTH = 3 ALIGN = RIGHT PAD = '0' }|.


      " MUY IMPORTANTE:
      " devolvemos CID + KEY + IS_DRAFT
      APPEND VALUE #(
        %cid      = entity-%cid
        %key      = entity-%key
        %is_draft = entity-%is_draft
      ) TO mapped-ZrPpt00.

    ENDLOOP.

  ENDMETHOD.

  METHOD Calcular_Ganador.

    " Leemos todas las partidas recibidas
    READ ENTITIES OF zr_ppt_00 IN LOCAL MODE
      ENTITY ZrPpt00
        FIELDS ( Jugada1 Jugada2 Nombre1 Nombre2 )
        WITH CORRESPONDING #( keys )
      RESULT DATA(partidas).

    " Modificamos todas las partidas
    MODIFY ENTITIES OF zr_ppt_00 IN LOCAL MODE
      ENTITY ZrPpt00
        UPDATE FIELDS ( Ganador )
        WITH VALUE #(
          FOR partida IN partidas
          (
            %tky = partida-%tky

            Ganador =
              COND #(
                WHEN partida-Jugada1 = partida-Jugada2 THEN 'Empate'
                WHEN ( partida-Jugada1 = 1 AND partida-Jugada2 = 2 )
                  OR ( partida-Jugada1 = 2 AND partida-Jugada2 = 3 )
                  OR ( partida-Jugada1 = 3 AND partida-Jugada2 = 1 ) THEN partida-Nombre2
                ELSE partida-nombre1
              )

          )
        ).

  ENDMETHOD.

*  METHOD Calcular_Ganador2.
*
*    READ ENTITIES OF zr_ppt_00 IN LOCAL MODE
*          ENTITY ZrPpt00
*            ALL FIELDS
*            WITH CORRESPONDING #( keys )
*          RESULT DATA(partidas).
*
*    LOOP AT partidas INTO DATA(partida).
*
*      MODIFY ENTITIES OF zr_ppt_00 IN LOCAL MODE
*        ENTITY ZrPpt00
*   UPDATE FIELDS ( Ganador )
*   WITH VALUE #(
*     FOR key IN keys
*     (
*       %tky        = key-%tky
*       Ganador =
*          COND #(
*            WHEN partida-Jugada1 = partida-Jugada2 THEN 'Empate'
*            WHEN ( partida-Jugada1 = 1 AND partida-Jugada2 = 2 )
*              OR ( partida-Jugada1 = 2 AND partida-Jugada2 = 3 )
*              OR ( partida-Jugada1 = 3 AND partida-Jugada2 = 1 ) THEN partida-Nombre2
*            ELSE partida-nombre1
*   ) ) ).
*
*    ENDLOOP.
*
*
**
**
**    READ ENTITIES OF zr_ppt_00 IN LOCAL MODE
**          ENTITY ZrPpt00
**            ALL FIELDS
**            WITH CORRESPONDING #( keys )
**          RESULT DATA(partidas).
**
**    result = VALUE #(
**      FOR partida IN partidas
**      (
**        %tky   = partida-%tky
**        %param = partida
**      )
**    ).
**
**    " Modificamos todas las partidas
**    MODIFY ENTITIES OF zr_ppt_00 IN LOCAL MODE
**      ENTITY ZrPpt00
**        UPDATE FIELDS ( Ganador )
**        WITH VALUE #(
**          FOR partida IN partidas
**          (
**            %tky = partida-%tky
**
**            Ganador =
**              COND #(
**                WHEN partida-Jugada1 = partida-Jugada2 THEN 'Empate'
**                WHEN ( partida-Jugada1 = 1 AND partida-Jugada2 = 2 )
**                  OR ( partida-Jugada1 = 2 AND partida-Jugada2 = 3 )
**                  OR ( partida-Jugada1 = 3 AND partida-Jugada2 = 1 ) THEN partida-Nombre2
**                ELSE partida-nombre1
**              )
**
**          )
**        ).
*
*
*
*  ENDMETHOD.

ENDCLASS.
