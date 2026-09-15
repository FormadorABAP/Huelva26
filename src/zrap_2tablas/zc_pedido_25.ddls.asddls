@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Pedido Projection'
@Metadata.allowExtensions: true
define root view entity ZC_PEDIDO_25
  provider contract transactional_query
  as projection on ZR_PEDIDO_25
{
  key PedidoId,

      Cliente,
      FechaPedido,
      Estado,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,

      _Posiciones : redirected to composition child ZC_PEDIDO_POS_25
}
