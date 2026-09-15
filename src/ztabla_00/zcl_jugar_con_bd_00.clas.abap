CLASS zcl_jugar_con_bd_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_jugar_con_bd_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

**    DATA lt_personas TYPE TABLE OF zpersonas_00.
*    DATA ls_personas TYPE zpersonas_00.
*
*    ls_personas-dni = '124'.
*    ls_personas-nombre = 'LuisCa'.
*    ls_personas-edad = '17'.
*    ls_personas-categoria = 'EMPLEADO'.
*
*    INSERT zpersonas_00 FROM @ls_personas.
*    IF sy-subrc = 0.
*      out->write( 'Dato insertado' ).
*    ELSE.
*      out->write( 'Fallo al insertar' ).
*    ENDIF.

    DATA ls_instrumento TYPE zinstrumentos_00.
    DATA lt_instrumento TYPE TABLE OF zinstrumentos_00.

    ls_instrumento-id_instrumento = 'INS002'.
    ls_instrumento-nombre         = 'Guitarra Española'.
    ls_instrumento-precio         = '150.00'.
    ls_instrumento-familia        = 'CU'.
    APPEND ls_instrumento TO lt_instrumento.

    ls_instrumento-id_instrumento = 'INS002'.
    ls_instrumento-nombre         = 'Guitarra Eléctrica'.
    ls_instrumento-precio         = '250.00'.
    ls_instrumento-familia        = 'CU'.
    APPEND ls_instrumento TO lt_instrumento.

    ls_instrumento-id_instrumento = 'INS001'.
    ls_instrumento-nombre         = 'Guitarra Clásica'.
    ls_instrumento-precio         = '350.00'.
    ls_instrumento-familia        = 'CU'.
    APPEND ls_instrumento TO lt_instrumento.

    DELETE zinstrumentos_00 FROM TABLE @lt_instrumento.

    IF sy-subrc = 0.
      out->write( 'Instrumentos insertados' ).
    ELSE.
      out->write( 'Fallo al insertar' ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
