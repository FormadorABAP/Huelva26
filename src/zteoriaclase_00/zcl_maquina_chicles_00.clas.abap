CLASS zcl_maquina_chicles_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS: constructor IMPORTING i_chicles TYPE i,
      vender_chicle IMPORTING i_dinero         TYPE i
                    RETURNING VALUE(rv_dinero) TYPE i,
      consultar_stock RETURNING VALUE(rv_stock) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA: num_restantes TYPE i,
          precio        TYPE i.

ENDCLASS.



CLASS ZCL_MAQUINA_CHICLES_00 IMPLEMENTATION.


  METHOD constructor.
    num_restantes = i_chicles.
    precio = 25.
  ENDMETHOD.


  METHOD vender_chicle.
    IF num_restantes > 0.
      IF i_dinero < 25.
        rv_dinero = i_dinero. " Devuelvo TODO el dinero
      ELSE.
        rv_dinero = i_dinero - precio. " Devuelvo la vuelta
        num_restantes -= 1.
      ENDIF.

    ELSE. " No quedan chicles
      rv_dinero = i_dinero. " Devuelvo TODO el dinero
    ENDIF.
  ENDMETHOD.


  METHOD consultar_stock.
    rv_stock = num_restantes.
  ENDMETHOD.
ENDCLASS.
