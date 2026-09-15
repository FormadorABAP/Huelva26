@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZINCIDENCIA_00'
@EndUserText.label: '###GENERATED Core Data Service Entity'

define root view entity ZR_INCIDENCIA_00
  as select from zincidencia_00

  association [0..1] to ZI_PRIORIDAD_VH_00 as _Prioridad
    on $projection.Prioridad = _Prioridad.Prioridad

{
  key id_incidencia          as IdIncidencia,

      titulo                 as Titulo,

      descripcion            as Descripcion,

      categoria              as Categoria,

      prioridad              as Prioridad,

      estado                 as Estado,

      responsable            as Responsable,

      fecha_alta             as FechaAlta,

      fecha_limite           as FechaLimite,

      fecha_cierre           as FechaCierre,

      case prioridad
          when 'A' then 1
          when 'M' then 2
          when 'B' then 3
          else 0
      end                    as PrioridadCriticality,

      @Semantics.user.createdBy: true
      created_by             as CreatedBy,

      @Semantics.user.localInstanceLastChangedBy: true
      last_changed_by        as LastChangedBy,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at        as LastChangedAt,

      @Semantics.systemDateTime.lastChangedAt: true
      local_last_changed_at  as LocalLastChangedAt,

      /* Asociación para obtener el texto de Prioridad */
      _Prioridad
}
