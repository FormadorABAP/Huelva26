CLASS zcl_dcl_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_dcl_00 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TYPES tty_pedidos TYPE TABLE OF zpedido_dcl_00 WITH EMPTY KEY.
    DATA(lt_pedidos) = VALUE tty_pedidos(
        ( pedido_id = 'P001' descripcion = 'Ordenadores' zona = 'SUR' )
        ( pedido_id = 'P002' descripcion = 'Monitores'   zona = 'NOR' )
        ( pedido_id = 'P003' descripcion = 'Teclados'    zona = 'SUR' )
        ( pedido_id = 'P004' descripcion = 'Servidores'  zona = 'CEN' )
        ( pedido_id = 'P005' descripcion = 'Ratones'     zona = 'NOR' )
     ).

    INSERT zpedido_dcl_00 FROM TABLE @lt_pedidos.
    IF sy-subrc EQ 0.
      out->write( 'Pedidos insertados' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
