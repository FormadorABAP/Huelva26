@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Pedido'
define root view entity ZR_PEDIDO_25
  as select from zpedido_25
  composition [0..*] of ZR_PEDIDO_POS_25 as _Posiciones
{
  key pedido_id                 as PedidoId,

      cliente                   as Cliente,
      fecha_pedido              as FechaPedido,
      estado                    as Estado,

      created_by                as CreatedBy,
      created_at                as CreatedAt,
      last_changed_by           as LastChangedBy,
      last_changed_at           as LastChangedAt,
      local_last_changed_at     as LocalLastChangedAt,

      _Posiciones
}
