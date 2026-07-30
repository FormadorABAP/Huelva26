CLASS zcl_test_chiringuitos_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_test_chiringuitos_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*Crear un chiringuito de bebidas.
    DATA(lo_chi_beb) = NEW zcl_chiringuito_bebidas_00( 'El chiringo de Jenni' ).

    out->write( |Hemos creado: { lo_chi_beb->nombre }| ).
*Intentar vender por 1,00€ (debería rechazarse, por debajo del mínimo).
    DATA(lv_vendido) = lo_chi_beb->vender_2( '1' ).
    IF lv_vendido.
      out->write( 'Hemos vendido una bebida' ).
    ELSE.
      out->write( 'NO hemos vendido una bebida' ).
    ENDIF.

*Vender por 3,50€ (debería aceptarse).
    CLEAR lv_vendido.
    lv_vendido = lo_chi_beb->vender_2( '3.5' ).
    IF lv_vendido.
      out->write( 'Hemos vendido una bebida' ).
    ELSE.
      out->write( 'NO hemos vendido una bebida' ).
    ENDIF.

*Consultar y mostrar su recaudación y su comisión
*    (debería salir el 10%, heredado sin cambios).

    DATA(lv_recaudacion) = lo_chi_beb->consultar_recaudacion( ).
    out->write( |La recaudación es { lv_recaudacion }| ).

    DATA(lv_comision) = lo_chi_beb->calcular_comision(  ).
    out->write( |La comisión es { lv_comision }| ).

*Crear un alquiler de hamacas.
    DATA(lo_alq_ham) = NEW zcl_alquiler_hamacas_00( 'Las sombrillas de Jenni' ).
    out->write( |Hemos creado: { lo_alq_ham->nombre }| ).

*Vender (alquilar) por 8,00€ (usando el método heredado sin redefinir, debería aceptarse sin ninguna condición especial de mínimo).
    CLEAR lv_vendido.
    lo_alq_ham->vender( '8' ).
    out->write( 'Hemos alquilado una sombrilla' ).

*Consultar y mostrar su recaudación y su comisión — aquí debería verse claramente que sale el 20%, distinto al chiringuito de bebidas, a pesar de ser el mismo método heredado del mismo padre.
    lv_recaudacion = lo_alq_ham->consultar_recaudacion( ).
    out->write( |La recaudación es { lv_recaudacion }| ).

    lv_comision = lo_alq_ham->calcular_comision(  ).
    out->write( |La comisión es { lv_comision }| ).

  ENDMETHOD.
ENDCLASS.
