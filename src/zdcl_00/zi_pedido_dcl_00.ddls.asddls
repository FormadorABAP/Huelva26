@AccessControl.authorizationCheck: #MANDATORY
@EndUserText.label: 'Pedidos protegidos mediante DCL'

define view entity ZI_PEDIDO_DCL_00
  as select from zpedido_dcl_00
{
    key pedido_id   as PedidoId,
        descripcion as Descripcion,
        zona        as Zona
}
