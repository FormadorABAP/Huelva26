@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Medio de Agencias'
@Metadata.ignorePropagatedAnnotations: true
define view entity zcds_agencias_medio_00
  with parameters
    p_pais : land1
  as select from /dmo/agency  as a
    inner join   /dmo/travel  as t on t.agency_id = a.agency_id
    inner join   /dmo/booking as b on t.travel_id = b.travel_id
{
  a.name                                     as Nombre,
  count(*)                                   as NumReservas,
  @Semantics.amount.currencyCode: 'Moneda'
  sum( b.flight_price )                      as Suma,
  @Semantics.amount.currencyCode: 'Moneda'
  avg(b.flight_price as abap.curr( 16, 2 ) ) as Media,
  b.currency_code                            as Moneda
}
where
  a.country_code = $parameters.p_pais
group by
  a.name,
  b.currency_code
