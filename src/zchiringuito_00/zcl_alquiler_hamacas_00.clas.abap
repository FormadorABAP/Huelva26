CLASS zcl_alquiler_hamacas_00 DEFINITION
  PUBLIC
  INHERITING FROM zcl_chiringuito_00
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS: calcular_comision REDEFINITION,
             reservar_sombrilla IMPORTING i_sombrilla type i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_alquiler_hamacas_00 IMPLEMENTATION.
  METHOD calcular_comision.
*    rv_comision = recaudacion * '0.2'.

     rv_comision = super->calcular_comision(  ) * 2.

  ENDMETHOD.

  METHOD reservar_sombrilla.

  ENDMETHOD.

ENDCLASS.
