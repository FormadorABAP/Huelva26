CLASS zcl_lavadora_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.

CLASS zcl_lavadora_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lv_carga       TYPE i,
          lv_temperatura TYPE i.

    " ---------- CASO 1: carga excedida ----------
    lv_carga       = 8.
    lv_temperatura = 80.

    TRY.
        IF lv_carga > 8.
          " Misma clase de excepción que usaremos para el caso 2,
          " pero apuntando al mensaje 001
          RAISE EXCEPTION TYPE lcx_error_lavadora
            EXPORTING
              textid = VALUE #( msgid = 'ZLAVADORA_00'
                                 msgno = '001'
                                 attr1 = '' attr2 = '' attr3 = '' attr4 = '' ).
        ENDIF.

        IF lv_temperatura > 90.
          RAISE EXCEPTION TYPE lcx_error_lavadora
            EXPORTING
              textid = VALUE #( msgid = 'ZLAVADORA_00'
                                 msgno = '002'
                                 attr1 = '' attr2 = '' attr3 = '' attr4 = '' ).
        ENDIF.

        MESSAGE ID 'ZLAVADORA_00' TYPE 'I' NUMBER '003'
          WITH lv_carga lv_temperatura INTO DATA(lv_msg_ok1).
        out->write( lv_msg_ok1 ).

      CATCH lcx_error_lavadora INTO DATA(lx_error1).
        " Un único CATCH para toda la clase: el texto es lo
        " que realmente distingue qué ha fallado
        out->write( lx_error1->get_text( ) ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
