@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vuelo Avanzado'
@Metadata.ignorePropagatedAnnotations: true
define view entity zcds_vuelos_avanzado_00
    with parameters p_nombre : abap.char(40)
  as select from /dmo/booking  as b
    inner join   /dmo/customer as c on b.customer_id = c.customer_id
    
{
  c.first_name          as Nombre,
  count(*)             as Num_Reservas,
  @Semantics.amount.currencyCode: 'Moneda'
  sum( b.flight_price ) as ImporteTotal,
  b.currency_code       as Moneda,
  
  case
    when sum( b.flight_price ) < 1000 then 'Ocasional'  
    when sum( b.flight_price ) < 5000 then 'Frecuente'  
    else 'VIP'  
  end as Tipo_Cliente
} where c.first_name = $parameters.p_nombre
            or $parameters.p_nombre = ''
    group by
  c.first_name,
  b.currency_code
