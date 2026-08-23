CLASS zcl_generar_datos_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_GENERAR_DATOS_00 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  " Limpiar datos previos (por si se ejecuta varias veces)
    DELETE FROM zcliente_00.
    DELETE FROM zpedido_00.

    " ---------- CLIENTES ----------
    DATA lt_clientes TYPE TABLE OF zcliente_00.

    lt_clientes = VALUE #(
      ( cliente_id = '0001' nombre = 'Ana Garcia'      ciudad = 'Sevilla' )
      ( cliente_id = '0002' nombre = 'Luis Perez'      ciudad = 'Huelva' )
      ( cliente_id = '0003' nombre = 'Marta Ruiz'      ciudad = 'Cadiz' )
      ( cliente_id = '0004' nombre = 'Pedro Sanchez'   ciudad = 'Sevilla' )
      ( cliente_id = '0005' nombre = 'Lucia Fernandez' ciudad = 'Granada' )
      ( cliente_id = '0006' nombre = 'Javier Torres'   ciudad = 'Huelva' )
      ( cliente_id = '0007' nombre = 'Sara Jimenez'    ciudad = 'Malaga' )
      ( cliente_id = '0008' nombre = 'Diego Morales'   ciudad = 'Sevilla' )
    ).

    INSERT zcliente_00 FROM TABLE @lt_clientes.

    " ---------- PEDIDOS ----------
    DATA lt_pedidos TYPE TABLE OF zpedido_00.

    lt_pedidos = VALUE #(
      ( pedido_id = '0001' cliente_id = '0001' producto = 'Portatil'     importe = '899.00'  fecha = '20260115' )
      ( pedido_id = '0002' cliente_id = '0001' producto = 'Raton'         importe = '25.50'   fecha = '20260118' )
      ( pedido_id = '0003' cliente_id = '0002' producto = 'Monitor'       importe = '210.00'  fecha = '20260120' )
      ( pedido_id = '0004' cliente_id = '0002' producto = 'Teclado'       importe = '45.00'   fecha = '20260122' )
      ( pedido_id = '0005' cliente_id = '0003' producto = 'Auriculares'   importe = '60.00'   fecha = '20260125' )
      ( pedido_id = '0006' cliente_id = '0004' producto = 'Tablet'        importe = '320.00'  fecha = '20260128' )
      ( pedido_id = '0007' cliente_id = '0004' producto = 'Funda tablet'  importe = '18.00'   fecha = '20260130' )
      ( pedido_id = '0008' cliente_id = '0005' producto = 'Impresora'     importe = '150.00'  fecha = '20260201' )
      ( pedido_id = '0009' cliente_id = '0006' producto = 'Silla oficina' importe = '210.00'  fecha = '20260203' )
      ( pedido_id = '0010' cliente_id = '0007' producto = 'Portatil'      importe = '750.00'  fecha = '20260205' )
      ( pedido_id = '0011' cliente_id = '0007' producto = 'Mochila'       importe = '35.00'   fecha = '20260207' )
      ( pedido_id = '0012' cliente_id = '0008' producto = 'Monitor'       importe = '195.00'  fecha = '20260210' )
      ( pedido_id = '0013' cliente_id = '0001' producto = 'Webcam'        importe = '40.00'   fecha = '20260212' )
      ( pedido_id = '0014' cliente_id = '0003' producto = 'Portatil'      importe = '910.00'  fecha = '20260215' )
      ( pedido_id = '0015' cliente_id = '0005' producto = 'Raton'         importe = '22.00'   fecha = '20260218' )
    ).

    INSERT zpedido_00 FROM TABLE @lt_pedidos.

    out->write( |Insertados { lines( lt_clientes ) } clientes y { lines( lt_pedidos ) } pedidos.| ).


  ENDMETHOD.
ENDCLASS.
