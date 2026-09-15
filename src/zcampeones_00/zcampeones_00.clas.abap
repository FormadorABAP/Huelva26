CLASS zcampeones_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcampeones_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    1️⃣ "El cliente que cambia de ciudad"
*
*   Recupera con SELECT SINGLE el registro completo del cliente '0001' de ZCLIENTE_XX.
*   Muéstralo con out->write().
*
*    Después, modifica su campo ciudad a 'SEVILLA' usando UPDATE ... SET.
*    Vuelve a hacer el SELECT SINGLE y comprueba que el cambio se ha aplicado.
*
*   Pasos: 1) SELECT SINGLE + write · 2) UPDATE con SET · 3) comprobar sy-subrc ·
*    4) SELECT SINGLE otra vez para verificar.

    DATA lv_id_cliente TYPE zcliente_00-cliente_id.
    lv_id_cliente = '0001'.

    " Recupero los datos
    SELECT SINGLE FROM zcliente_00
        FIELDS *
        WHERE cliente_id = @lv_id_cliente
        INTO @DATA(ls_cliente_1).
    IF sy-subrc = 0. " En caso de acierto
      out->write( ls_cliente_1 ).
    ELSE.            " En caso de error
      out->write( |El cliente { lv_id_cliente } no existe| ).
    ENDIF.

    " Cambiamos la ciudad a Huelva si no es la que ya tiene
    IF ls_cliente_1-ciudad <> 'Huelva'.
      UPDATE zcliente_00 SET ciudad = 'Huelva'
        WHERE cliente_id = @lv_id_cliente.
      IF sy-subrc = 0. " En caso de acierto
        out->write( |La ciudad del cliente { ls_cliente_1-nombre } se ha actualizado a Huelva| ).

        " Recuperamos tras la actualación machando los datos de la estructura
        SELECT SINGLE FROM zcliente_00
            FIELDS *
            WHERE cliente_id = @lv_id_cliente
            INTO @ls_cliente_1.
        IF sy-subrc = 0.
          out->write( ls_cliente_1 ).
        ELSE.
          out->write( |El cliente { lv_id_cliente } no existe| ).
        ENDIF.

      ELSE. " En caso de fallo al actualizar
        out->write( |La ciudad del cliente { ls_cliente_1-nombre } no se ha actualizado| ).

      ENDIF.

    ELSE.
      out->write( |La ciudad del cliente { ls_cliente_1-nombre } es { ls_cliente_1-ciudad }, no se tiene que actualizar| ).
    ENDIF.

*    2️⃣ "Pedido nuevo para un cliente existente"

*    Elige un cliente_id que ya exista en ZCLIENTE_XX (compruébalo con Data Preview).
*   Inserta una fila nueva en ZPEDIDO_XX con INSERT, usando ese cliente_id,
*   un pedido_id que no exista todavía ('0016'),
*    y datos inventados de producto e importe.

*   Después haz un JOIN ZPEDIDO_XX + ZCLIENTE_XX filtrando por ese pedido_id
*   para comprobar que aparece con el nombre del cliente correcto.

*   Pasos: 1) verificar cliente_id con Data Preview · 2) INSERT con VALUES · 3) comprobar sy-subrc
*   · 4) SELECT con JOIN para verificar.

    DATA ls_pedido_2 TYPE zpedido_00.
    ls_pedido_2-cliente_id = '0002'.
    ls_pedido_2-pedido_id = '0016'.
    ls_pedido_2-producto = 'Cargador'.
    ls_pedido_2-importe = '30.00'.
    ls_pedido_2-fecha = '20260720'.

    INSERT zpedido_00 FROM @ls_pedido_2.
    IF sy-subrc = 0.
      out->write( |Pedido añadido| ).

      SELECT FROM zpedido_00 AS p
        INNER JOIN zcliente_00 AS c
            ON c~cliente_id = p~cliente_id
            FIELDS p~pedido_id, p~producto, c~nombre
            INTO TABLE @DATA(lt_ped_cli_2).
      IF sy-subrc = 0.
        out->write( lt_ped_cli_2 ).
      ELSE.
        out->write( |Fallo en el JOIN| ).
      ENDIF.


    ELSE.
      out->write( |NO se ha añadido el pedido| ).
    ENDIF.

*   3️⃣ "El pedido que ya no existe"

*   Elige un pedido_id de ZPEDIDO_XX cualquiera (por ejemplo '0015').
*   Bórralo con DELETE. Después, intenta hacer el mismo JOIN de ZPEDIDO_XX + ZCLIENTE_XX que hicisteis antes
*   y comprueba que ese pedido ya no aparece en el resultado, aunque el cliente al que pertenecía sigue
*   existiendo en ZCLIENTE_XX.

*    Pasos: 1) SELECT SINGLE antes de borrar · 2) DELETE · 3) comprobar sy-subrc ·
*   4) JOIN para comprobar que el pedido desapareció pero el cliente sigue ahí.ç

    DATA lv_pedido_3 TYPE zpedido_00-pedido_id.
    lv_pedido_3 = '0015'.
    DELETE FROM zpedido_00
        WHERE pedido_id = @lv_pedido_3.
    IF sy-subrc = 0.
      out->write( |Se ha borrado el pedido { lv_pedido_3 } | ).
    ELSE.
      out->write( |Ha fallado el borrado| ).
    ENDIF.

    SELECT FROM zpedido_00 AS p
        INNER JOIN zcliente_00 AS c
            ON c~cliente_id = p~cliente_id
            FIELDS p~pedido_id, p~producto, c~nombre
            INTO TABLE @DATA(lt_ped_cli_3).
    IF sy-subrc = 0.
      out->write( lt_ped_cli_3 ).
    ELSE.
      out->write( |Fallo en el JOIN| ).
    ENDIF.


*   4️⃣ "Sube el importe a un cliente concreto"

*   Usando UPDATE ... WHERE, sube un 10% el importe de todos los pedidos del cliente '0001'.
*    Antes y después, haz un SELECT con SUM( importe ) filtrado por ese cliente_id
*   para comprobar visualmente que el total ha subido.

*    Pasos: 1) SELECT con SUM antes · 2) UPDATE con cálculo importe = importe * '1.1' ·
*   3) SELECT con SUM después · 4) comparar.

    lv_id_cliente = '0001'.
    SELECT FROM zpedido_00
        FIELDS SUM( importe )
        WHERE cliente_id = @lv_id_cliente
        INTO @DATA(lv_importe_4).
    IF sy-subrc = 0.
      out->write( |El importe inicial es { lv_importe_4 }€| ).
    ELSE.
      out->write( |El cliente { lv_id_cliente } no existe| ).
    ENDIF.

    " Solución PRO de Ramón
*    DATA lv_mult TYPE p DECIMALS 4.
*    lv_mult = 1 / '1.10'.
*
*    UPDATE zpedido_00
*        SET importe = division( importe, @lv_mult, 2 )
*        WHERE cliente_id = '0001'.

    " Estilo chapucero de LCa
    SELECT FROM zpedido_00
        FIELDS *
        WHERE cliente_id = @lv_id_cliente
        INTO TABLE @DATA(lt_pedido_4).
    IF sy-subrc = 0.
      LOOP AT lt_pedido_4 ASSIGNING FIELD-SYMBOL(<fs_pedido>).
        <fs_pedido>-importe = <fs_pedido>-importe * '1.1'.
      ENDLOOP.

      UPDATE zpedido_00 FROM TABLE @lt_pedido_4.
      IF sy-subrc = 0.
        out->write( |Se han actalizado los importes del cliente { lv_id_cliente } | ).
      ELSE.
        out->write( |No se han podido actualizar los importes del cliente { lv_id_cliente } | ).
      ENDIF.
    ENDIF.

    SELECT FROM zpedido_00
        FIELDS SUM( importe )
        WHERE cliente_id = @lv_id_cliente
        INTO @lv_importe_4.
    IF sy-subrc = 0.
      out->write( |El importe final es { lv_importe_4 }€| ).
    ELSE.
      out->write( |El cliente { lv_id_cliente } no existe| ).
    ENDIF.

*   5️⃣ "El cliente fantasma"

*    Intenta insertar un pedido en ZPEDIDO_XX con un cliente_id que no exista en ZCLIENTE_XX (por ejemplo '9999').
*   Comprueba con un SELECT SINGLE sobre ZCLIENTE_XX que ese código no existe,
*   y razona (sin necesidad de código extra) qué pasaría luego con un JOIN ZPEDIDO_XX + ZCLIENTE_XX con esa fila
*   — ¿en qué tipo de JOIN desaparecería y en cuál se quedaría con huecos vacíos?

*   Pasos: 1) SELECT SINGLE cliente_id inventado → comprobar que no existe ·
*   2) INSERT pedido igualmente · 3) responder la pregunta de INNER vs LEFT OUTER JOIN.

    DATA ls_pedido_5 TYPE zpedido_00.
    ls_pedido_5-cliente_id = '9999'.
    ls_pedido_5-pedido_id = '0018'.
    ls_pedido_5-producto = 'Router'.
    ls_pedido_5-importe = '40.00'.
    ls_pedido_5-fecha = '20260720'.

    INSERT zpedido_00 FROM @ls_pedido_5.
    IF sy-subrc = 0.
      out->write( |Pedido añadido| ).

      " Comprobación con INNER JOIN
      SELECT FROM zpedido_00 AS p
        INNER JOIN zcliente_00 AS c
            ON c~cliente_id = p~cliente_id
            FIELDS p~pedido_id, p~producto, c~nombre
            INTO TABLE @DATA(lt_ped_cli_5I).
      IF sy-subrc = 0.
        out->write( |---> INNER JOIN <---| ).
        out->write( lt_ped_cli_5I ).
      ELSE.
        out->write( |Fallo en el JOIN| ).
      ENDIF.

      " Comprobación con LEFT JOIN
      SELECT FROM zpedido_00 AS p
        LEFT JOIN zcliente_00 AS c
            ON c~cliente_id = p~cliente_id
            FIELDS p~pedido_id, p~producto, c~nombre
            INTO TABLE @DATA(lt_ped_cli_5L).
      IF sy-subrc = 0.
        out->write( |---> LEFT JOIN 1 <---| ).
        out->write( lt_ped_cli_5L ).
      ELSE.
        out->write( |Fallo en el LEFT JOIN| ).
      ENDIF.

      " Comprobación con LEFT JOIN
      SELECT FROM zcliente_00 AS c
        LEFT JOIN zpedido_00 AS p
            ON c~cliente_id = p~cliente_id
            FIELDS p~pedido_id, p~producto, c~nombre
            INTO TABLE @lt_ped_cli_5L.
      IF sy-subrc = 0.
        out->write( |---> LEFT JOIN 2 <---| ).
        out->write( lt_ped_cli_5L ).
      ELSE.
        out->write( |Fallo en el LEFT JOIN| ).
      ENDIF.

    ELSE.
      out->write( |NO se ha añadido el pedido| ).
    ENDIF.

*    6️⃣ "El cliente que más ha gastado"

*    Averigua qué cliente ha gastado más dinero en total sumando el importe
*        de todos sus pedidos en ZPEDIDO_XX,
*    y muestra su nombre completo (no solo el cliente_id).

    " Recuperando los datos y recorriendo
    DATA lt_pedido_aux TYPE TABLE OF zpedido_00.
    SELECT FROM zpedido_00
        FIELDS *
        INTO TABLE @DATA(lt_pedido_6).

    LOOP AT lt_pedido_6 INTO DATA(ls_pedido_6).
      READ TABLE lt_pedido_aux ASSIGNING FIELD-SYMBOL(<fs_pedido_6>)
          WITH KEY cliente_id = ls_pedido_6.
      IF sy-subrc = 0. " El cliente existe en la auxiliar
        <fs_pedido_6>-importe = <fs_pedido_6>-importe + ls_pedido_6-importe.
      ELSE. " El cliente NO existe en la auxiliar
        APPEND ls_pedido_6 TO lt_pedido_aux.
      ENDIF.
    ENDLOOP.

    SORT lt_pedido_aux BY importe DESCENDING.
    CLEAR ls_pedido_6.
    READ TABLE lt_pedido_aux INTO ls_pedido_6 INDEX 1.
    IF sy-subrc EQ 0.
      SELECT SINGLE FROM zcliente_00
          FIELDS nombre
          WHERE cliente_id = @ls_pedido_6-cliente_id
          INTO @DATA(lv_nombre_6).
      IF sy-subrc = 0.
        out->write( lv_nombre_6 ).
      ENDIF.
    ENDIF.

    " Todo en el SELECT
    SELECT FROM zpedido_00 AS p
        INNER JOIN zcliente_00 AS c
        ON p~cliente_id = c~cliente_id
        FIELDS c~nombre, SUM( p~importe ) AS suma
        GROUP BY c~nombre
        ORDER BY suma DESCENDING
        INTO TABLE @DATA(lt_join_6).
    IF sy-subrc = 0.
      CLEAR ls_pedido_6.
      READ TABLE lt_join_6 INTO DATA(ls_join_6) INDEX 1.
      IF sy-subrc = 0.
        out->write( ls_join_6 ).
      ELSE.
        out->write( 'Fallo en el READ' ).
      ENDIF.
    ELSE.
      out->write( 'Fallo en el JOIN' ).
    ENDIF.

    " Ahora con la CDS
    SELECT FROM zcds_ejercicio_6
        FIELDS *
        ORDER BY suma DESCENDING
        INTO TABLE @DATA(lt_cds_6).
    IF sy-subrc = 0.

      READ TABLE lt_cds_6 INTO DATA(ls_cds_6) INDEX 1.
      IF sy-subrc = 0.
        out->write( ls_cds_6-nombre ).
      ELSE.
        out->write( 'Fallo en el READ' ).
      ENDIF.
    ELSE.
      out->write( 'Fallo en el JOIN' ).
    ENDIF.


  ENDMETHOD.
ENDCLASS.
