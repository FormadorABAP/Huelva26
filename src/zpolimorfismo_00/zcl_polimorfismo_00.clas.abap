CLASS zcl_polimorfismo_00 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS saludar RETURNING VALUE(rv_saludo) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS poner_nombre.
    DATA nombre TYPE string.

ENDCLASS.



CLASS zcl_polimorfismo_00 IMPLEMENTATION.
  METHOD saludar.
    rv_saludo = 'Hola, soy el padre'.
    nombre = 'Juan'.
  ENDMETHOD.

  METHOD poner_nombre.
    nombre = 'David'.
  ENDMETHOD.

ENDCLASS.
