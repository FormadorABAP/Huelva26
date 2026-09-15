@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ayuda de búsqueda Estado'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.resultSet.sizeCategory: #XS

define view entity ZI_ESTADO_VH_00
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T(
    p_domain_name : 'ZDO_ESTADO'
  )
{
    @ObjectModel.text.element: ['Descripcion']
    key value_low as Estado,

    @Semantics.text: true
    text          as Descripcion
}
where language = $session.system_language
