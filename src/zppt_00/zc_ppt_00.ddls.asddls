@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZPPT_00'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_PPT_00
  provider contract transactional_query
  as projection on ZR_PPT_00
  association [1..1] to ZR_PPT_00 as _BaseEntity on $projection.NumPartida = _BaseEntity.NumPartida
{
  key NumPartida,

      Nombre1,
      @ObjectModel.text.element: ['Jugada1Descripcion']
      Jugada1,
      @Semantics.text: true
      _Jugada1Text.Descripcion as Jugada1Descripcion,

      Nombre2,
      @ObjectModel.text.element: ['Jugada2Descripcion']
      Jugada2,
      @Semantics.text: true
      _Jugada2Text.Descripcion as Jugada2Descripcion,

      Ganador,
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
      _Jugada1Text,
      _Jugada2Text,
      _BaseEntity
}
