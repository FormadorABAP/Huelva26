@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZPPT_00'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_PPT_00
  as select from zppt_00

  association [0..1] to ZI_JUGADA_VH_00 as _Jugada1Text on $projection.Jugada1 = _Jugada1Text.Jugada

  association [0..1] to ZI_JUGADA_VH_00 as _Jugada2Text on $projection.Jugada2 = _Jugada2Text.Jugada
{
  key num_partida           as NumPartida,
      nombre_1              as Nombre1,
      jugada_1              as Jugada1,
      nombre_2              as Nombre2,
      jugada_2              as Jugada2,
      ganador               as Ganador,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.user.localInstanceLastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      _Jugada1Text,
      _Jugada2Text
}
