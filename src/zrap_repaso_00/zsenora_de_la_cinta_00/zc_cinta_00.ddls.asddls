@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZCINTA_00'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_CINTA_00
  provider contract transactional_query
  as projection on ZR_CINTA_00
  association [1..1] to ZR_CINTA_00 as _BaseEntity on $projection.IdOfrenda = _BaseEntity.IdOfrenda
{
  key IdOfrenda,
  Nombre,
  TipoOfrenda,
//  FechaOfrenda,
  Mensaje,
  @Semantics: {
    user.createdBy: true
  }
  CreatedBy,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  CreatedAt,
  @Semantics: {
    user.lastChangedBy: true
  }
  LastChangedBy,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,
  _BaseEntity
}
