@AbapCatalog.sqlViewName: 'ZI_CABAPD_PASS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Aviones'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_CABAPD_PASSENGER as select from /dmo/flight
{
    plane_type_id,
    seats_max        as MaximumSeats
}
