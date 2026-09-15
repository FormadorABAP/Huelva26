@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Posición Pedido Projection'
@Metadata.allowExtensions: true
define view entity ZC_PEDIDO_POS_25
  as projection on ZR_PEDIDO_POS_25
{
  key PosId,

      PedidoId,
      Producto,
      Cantidad,

      @Semantics.amount.currencyCode: 'Moneda'
      PrecioUnit,

      Moneda,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,

      _Pedido : redirected to parent ZC_PEDIDO_25
}
