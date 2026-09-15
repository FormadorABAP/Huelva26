CLASS zcl_planta_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA: nombre           TYPE string,
          stock_disponible TYPE i,
          nivel_riego      TYPE i.

    METHODS:
      constructor IMPORTING i_nombre TYPE string
                            i_stock  TYPE i
                            i_nivel  TYPE i,

      vender IMPORTING i_cantidad TYPE i
             RAISING   zcx_carrefour_00,

      regar IMPORTING i_nivel TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_planta_00 IMPLEMENTATION.
  METHOD constructor.
    nombre = i_nombre.
    stock_disponible = i_stock.
    nivel_riego = i_nivel.
  ENDMETHOD.

  METHOD regar.
    nivel_riego += i_nivel.
    IF nivel_riego > 100.
      nivel_riego = 100.
    ENDIF.
  ENDMETHOD.

  METHOD vender.
    IF stock_disponible < i_cantidad.
      RAISE EXCEPTION TYPE zcx_carrefour_00
        EXPORTING
          textid = VALUE #( msgid = 'ZCARREFOUR_00'
                           msgno = '001'
                           attr1 = ''
                           attr2 = ''
                           attr3 = ''
                           attr4 = '' ).

    ENDIF.

    IF nivel_riego < 20.
      RAISE EXCEPTION TYPE zcx_carrefour_00
        EXPORTING
          textid = VALUE #( msgid = 'ZCARREFOUR_00'
                           msgno = '002'
                           attr1 = ''
                           attr2 = ''
                           attr3 = ''
                           attr4 = '' ).

    ENDIF.

    stock_disponible = stock_disponible - i_cantidad.
  ENDMETHOD.

ENDCLASS.
