@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Avanzado de Conexiones'
@Metadata.ignorePropagatedAnnotations: true
define view entity zcds_conexiones_avanzado_00 
        with parameters p_distancia : abap.int4
        as select from /dmo/connection as co
        inner join /dmo/carrier as ca
            on co.carrier_id = ca.carrier_id
        inner join /dmo/airport as ai
            on co.airport_from_id = ai.airport_id
{
    co.airport_from_id as Aeropuerto,
    ai.city as Ciudad,
    avg( co.distance as abap.dec( 10, 0 ) ) as DistanciaMedia,
    count(*) as NumeroConexiones,
    case
       when avg( co.distance as abap.dec( 10, 0 ) ) < 1000 then 'Corta' 
       when avg( co.distance as abap.dec( 10, 0 ) ) <= 5000 then 'Media' 
       else 'Larga' 
       end as Tipo
    } where co.distance > $parameters.p_distancia
group by co.airport_from_id, ai.city
