@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Mario Bros'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zr_mario_bros_00
  as select from zmario_bros_00
{
  key id_personaje    as IdPersonaje,

      nombre          as Nombre,
      tipo            as Tipo,
      reino           as Reino,
      color           as Color,
      poder           as Poder,

      vidas           as Vidas,
      monedas         as Monedas,
      nivel           as Nivel,

      estado          as Estado,
      fecha_alta      as FechaAlta,

      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
      last_changed_at as LastChangedAt
}
