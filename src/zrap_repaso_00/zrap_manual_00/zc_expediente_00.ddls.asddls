@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Expedientes jurídicos - Consumo'
@Metadata.allowExtensions: true

define root view entity ZC_EXPEDIENTE_00
  provider contract transactional_query
  as projection on ZR_EXPEDIENTE_00
{
  key IdExpediente,
      Cliente,
      Descripcion,
      TipoAsunto,
      Abogado,
      Estado,
      FechaApertura,
      FechaCierre,
      @Semantics.user.createdBy: true
      CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      CreatedAt,
      @Semantics.user.lastChangedBy: true
      LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt
}
