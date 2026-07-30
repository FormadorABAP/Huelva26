@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Unión de tablas'
@Metadata.ignorePropagatedAnnotations: true
define view entity zcds_clientes_productos_00 
    as select from zcliente_00 as c
        inner join zpedido_00 as p
        on c.cliente_id = p.cliente_id
{
    c.nombre,
    c.ciudad,
    p.producto,
    p.importe
}
