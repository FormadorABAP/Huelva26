@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZCINTA_00'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_CINTA_00
  as select from zcinta_00
{
  key id_ofrenda as IdOfrenda,
  nombre as Nombre,
  tipo_ofrenda as TipoOfrenda,
  fecha_ofrenda as FechaOfrenda,
  mensaje as Mensaje,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
}
