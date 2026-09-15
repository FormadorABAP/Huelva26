CLASS zcl_test_cuenta_bancaria_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_test_cuenta_bancaria_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_cuenta) = NEW zcl_cuenta_ahorro_00(
                            iv_titular = 'Fran'
                            iv_interes = '2.00' ).

    lo_cuenta->ingresar( '100.00' ).
    lo_cuenta->ingresar( '50.00' ).
    lo_cuenta->ingresar( '25.00' ).

    TRY.
        lo_cuenta->retirar( '100.00' ).
        lo_cuenta->retirar( '100.00' ).

        lo_cuenta->aplicar_interes( ).

        out->write( |Saldo: { lo_cuenta->consultar_saldo( ) }| ).
        out->write( |Operaciones internas: { lo_cuenta->consultar_operaciones( ) }| ).

      CATCH zcx_saldo_insuficiente INTO DATA(lx_error).
        out->write( lx_error->get_text( ) ).

*      CATCH zcx_saldo_insuficiente.
*        out->write( 'No hay saldo suficiente' ).

*      CATCH zcx_saldo_insuficiente.
*        MESSAGE ID 'ZEXCEPCIONES_00' TYPE 'I' NUMBER '002' INTO DATA(lv_msg1).
*        out->write( lv_msg1 ).

    ENDTRY.

  ENDMETHOD.

ENDCLASS.
