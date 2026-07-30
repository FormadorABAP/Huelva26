@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vuelo Medio'
@Metadata.ignorePropagatedAnnotations: true
define view entity zcds_vuelos_medio_00

    as select from /dmo/flight as f
    inner join /dmo/carrier as c
    on f.carrier_id = c.carrier_id
{
    c.name as nombre,
    count( * ) as num_vuelos,
    
    @Semantics.amount.currencyCode: 'moneda'
    avg( f.price as abap.curr(16,2) ) as media,
    
    @Semantics.amount.currencyCode: 'moneda'
    min( f.price ) as minimo,
    
    @Semantics.amount.currencyCode: 'moneda'
    max( f.price ) as maximo,
    
    f.currency_code as moneda
} group by c.name, f.currency_code
