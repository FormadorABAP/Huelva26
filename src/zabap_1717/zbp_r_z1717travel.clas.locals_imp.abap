CLASS lhc_zr_z1717travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ZrZ1717travel
        RESULT result,

      setInitialStatus FOR DETERMINE ON SAVE
       keys FOR ZrZ1717travel~setInitialStatus.
ENDCLASS.

CLASS lhc_zr_z1717travel IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD setInitialStatus.

    MODIFY ENTITIES OF zr_z1717travel IN LOCAL MODE
        ENTITY zrz1717travel
        UPDATE FIELDS ( status )
        WITH VALUE #(
            FOR key IN keys (
                %tky = key-%tky
                Status = 'N'
            )
        ).

  ENDMETHOD.

ENDCLASS.
