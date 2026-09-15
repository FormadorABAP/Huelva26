@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ayuda de búsqueda Jugada'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.resultSet.sizeCategory: #XS

define view entity ZI_JUGADA_VH_00
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T(
    p_domain_name : 'ZDO_PPT_J'
  )
{
    @ObjectModel.text.element: ['Descripcion']
    @UI.textArrangement: #TEXT_ONLY
    key value_low as Jugada,

    @Semantics.text: true
    text          as Descripcion
}
where language = $session.system_language
