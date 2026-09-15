@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZPENALTIS_00'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_PENALTIS_00
  provider contract transactional_query
  as projection on ZR_PENALTIS_00
  association [1..1] to ZR_PENALTIS_00 as _BaseEntity on $projection.NumeroLanzamiento = _BaseEntity.NumeroLanzamiento
{
  key NumeroLanzamiento,
      Lanzador,
      DirDisparo,
      Portero,
      DirPortero,
      Resultado,
      Color,

      @Semantics: {
        user.createdBy: true
      }
      CreatedBy,
      @Semantics: {
        user.localInstanceLastChangedBy: true
      }
      LastChangedBy,
      @Semantics: {
        systemDateTime.localInstanceLastChangedAt: true
      }
      LastChangedAt,
      @Semantics: {
        systemDateTime.lastChangedAt: true
      }
      LocalLastChangedAt,
      _BaseEntity
}
