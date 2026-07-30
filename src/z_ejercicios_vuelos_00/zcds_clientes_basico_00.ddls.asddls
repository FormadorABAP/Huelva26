@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Básico de Clientes'
@Metadata.ignorePropagatedAnnotations: true
define view entity zcds_clientes_basico_00
  as select from /dmo/customer as c
   inner join I_CountryText as t
   on c.country_code = t.Country
{
  c.customer_id                                as Identificador,
  concat_with_space( c.first_name, c.last_name, 1 ) as Nombre,
  c.city as Ciudad, 
  c.country_code as CodPais,
  t.CountryName as NombrePais
} where t.Language = 'S'
