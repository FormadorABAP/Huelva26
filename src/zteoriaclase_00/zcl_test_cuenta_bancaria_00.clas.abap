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

    lo_cuenta->aplicar_interes( ).

    out->write( |Saldo: { lo_cuenta->consultar_saldo( ) }| ).
    out->write( |Operaciones internas: { lo_cuenta->consultar_operaciones( ) }| ).

  ENDMETHOD.

ENDCLASS.
