@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Expedientes jurídicos - Raíz'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_EXPEDIENTE_00
  as select from zexpediente_00
{
  key id_expediente         as IdExpediente,

      cliente               as Cliente,
      descripcion           as Descripcion,
      tipo_asunto           as TipoAsunto,
      abogado               as Abogado,
      estado                as Estado,
      fecha_apertura        as FechaApertura,
      fecha_cierre          as FechaCierre,

      created_by            as CreatedBy,
      created_at            as CreatedAt,
      last_changed_by       as LastChangedBy,
      last_changed_at       as LastChangedAt
}
