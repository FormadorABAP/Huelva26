@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}

@ObjectModel: {
  sapObjectNodeType.name: 'ZINCIDENCIA_00'
}

@AccessControl.authorizationCheck: #MANDATORY

define root view entity ZC_INCIDENCIA_00
  provider contract transactional_query
  as projection on ZR_INCIDENCIA_00

  association [1..1] to ZR_INCIDENCIA_00 as _BaseEntity
    on $projection.IdIncidencia = _BaseEntity.IdIncidencia

{
  key IdIncidencia,

      Titulo,
      Descripcion,
      Categoria,

      @ObjectModel.text.element: ['PrioridadTexto']
      Prioridad,

      _Prioridad.Descripcion as PrioridadTexto,

      PrioridadCriticality,

      Estado,
      Responsable,
      FechaAlta,
      FechaLimite,
      FechaCierre,

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

      _BaseEntity,
      _Prioridad
}
