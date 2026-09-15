@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Posición de pedido'
define view entity ZR_PEDIDO_POS_25
  as select from zpedido_pos_25
  association to parent ZR_PEDIDO_25 as _Pedido
    on $projection.PedidoId = _Pedido.PedidoId
{
  key pos_id                    as PosId,

      pedido_id                 as PedidoId,
      producto                  as Producto,
      cantidad                  as Cantidad,

      @Semantics.amount.currencyCode: 'Moneda'
      precio_unit               as PrecioUnit,

      moneda                    as Moneda,

      created_by                as CreatedBy,
      created_at                as CreatedAt,
      last_changed_by           as LastChangedBy,
      last_changed_at           as LastChangedAt,
      local_last_changed_at     as LocalLastChangedAt,

      _Pedido
}
