@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumo Personajes Mario Bros'
@Metadata.allowExtensions: true

define root view entity ZC_MARIO_BROS_00
  provider contract transactional_query
  as projection on zr_mario_bros_00
{
  key IdPersonaje,
      Nombre,
      Tipo,
      Reino,
      Color,
      Poder,
      Vidas,
      Monedas,
      Nivel,
      Estado,
      FechaAlta,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt
}
