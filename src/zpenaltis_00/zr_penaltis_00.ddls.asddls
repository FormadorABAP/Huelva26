@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZPENALTIS_00'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_PENALTIS_00
  as select from zpenaltis_00
{
  key numero_lanzamiento    as NumeroLanzamiento,
      lanzador              as Lanzador,
      dir_disparo           as DirDisparo,
      portero               as Portero,
      dir_portero           as DirPortero,
      resultado             as Resultado,

      case resultado
        when 'Gol' then 3
        else 1
        end                 as Color,

      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.user.localInstanceLastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      local_last_changed_at as LocalLastChangedAt
}
