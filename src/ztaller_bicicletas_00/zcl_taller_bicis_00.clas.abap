CLASS zcl_taller_bicis_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      registrar_reparacion
        IMPORTING i_cliente    TYPE ztaller_bici_00-cliente
                  i_averia     TYPE ztaller_bici_00-averia
        RETURNING VALUE(rv_id) TYPE ztaller_bici_00-id_reparacion,

      consultar_reparacion
        IMPORTING i_reparacion TYPE ztaller_bici_00-id_reparacion
        EXPORTING o_cliente    TYPE ztaller_bici_00-cliente
                  o_averia     TYPE ztaller_bici_00-averia
                  o_estado     TYPE ztaller_bici_00-estado,

      cambiar_estado
        IMPORTING i_reparacion         TYPE ztaller_bici_00-id_reparacion
                  i_estado             TYPE     ztaller_bici_00-estado
        RETURNING VALUE(rv_reparacion) TYPE abap_bool,

      eliminar_reparacion
        IMPORTING i_reparacion         TYPE ztaller_bici_00-id_reparacion
        RETURNING VALUE(rv_reparacion) TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_taller_bicis_00 IMPLEMENTATION.
  METHOD registrar_reparacion.

    " Recupero el id máximo y le sumo 1
    SELECT MAX( id_reparacion ) FROM ztaller_bici_00
        INTO @DATA(lv_id_maximo).
    IF sy-subrc = 0.
      rv_id = lv_id_maximo + 1.
    ELSE.
      rv_id = 1.
    ENDIF.

    " Inserto el nuevo registro en la tabla
    " Montar la estructura
    DATA(ls_reparacion) = VALUE ztaller_bici_00(
        id_reparacion = rv_id
        cliente = i_cliente
        averia = i_averia
        estado = '01'
    ).

    " Añadirla a la tabla
    INSERT ztaller_bici_00 FROM @ls_reparacion.

  ENDMETHOD.

  METHOD consultar_reparacion.
    SELECT SINGLE FROM ztaller_bici_00
        FIELDS *
        WHERE id_reparacion = @i_reparacion
        INTO @DATA(ls_reparacion).
    IF sy-subrc = 0.
      o_averia = ls_reparacion-averia.
      o_cliente = ls_reparacion-cliente.
      o_estado = ls_reparacion-estado.
    ENDIF.
  ENDMETHOD.

  METHOD cambiar_estado.
    UPDATE ztaller_bici_00 SET estado = @i_estado
        WHERE id_reparacion = @i_reparacion.
    IF sy-subrc = 0.
      rv_reparacion = abap_true.
    ELSE.
      rv_reparacion = abap_false.
    ENDIF.

  ENDMETHOD.

  METHOD eliminar_reparacion.
    DELETE FROM ztaller_bici_00 WHERE id_reparacion = @i_reparacion.
    IF sy-subrc = 0.
      rv_reparacion = abap_true.
    ELSE.
      rv_reparacion = abap_false.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
