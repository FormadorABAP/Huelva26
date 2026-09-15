@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ayuda de Búsqueda de Dirección del Penalti'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.resultSet.sizeCategory: #XS

define view entity zi_direccion_vh_00 
    as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T(
    p_domain_name : 'ZDO_DIRECCION_00'
  )
{
    @ObjectModel.text.element: ['Descripcion']
    @UI.textArrangement: #TEXT_ONLY
    key value_low as Direccion,

    @Semantics.text: true
    text          as Descripcion
}
where language = $session.system_language
