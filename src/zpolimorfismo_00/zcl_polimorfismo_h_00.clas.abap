CLASS zcl_polimorfismo_h_00 DEFINITION
  PUBLIC
  INHERITING FROM zcl_polimorfismo_00
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS: saludar REDEFINITION,
            escupir RETURNING VALUE(rv_gapo) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_polimorfismo_h_00 IMPLEMENTATION.
  METHOD saludar.
    rv_saludo = 'Hola, soy el hijo'.
*    nombre = 'Miguel'.
  ENDMETHOD.

  METHOD escupir.
    rv_gapo = 'Jupiiiip'.
  ENDMETHOD.

ENDCLASS.
