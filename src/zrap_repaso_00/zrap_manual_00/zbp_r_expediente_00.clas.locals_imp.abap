CLASS lhc_ZR_EXPEDIENTE_00 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR Expediente RESULT result.

ENDCLASS.

CLASS lhc_ZR_EXPEDIENTE_00 IMPLEMENTATION.

  METHOD get_global_authorizations.
    result-%create = if_abap_behv=>auth-allowed.
  ENDMETHOD.

ENDCLASS.
