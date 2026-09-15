CLASS zcl_1717_agency_model DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_agency
      IMPORTING
        i_agency        TYPE /dmo/agency_id
      RETURNING
        VALUE(r_agency) TYPE zc_abapd_agency
      RAISING
        zcx_1717_no_agency.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_1717_agency_model IMPLEMENTATION.

  METHOD get_agency.

    SELECT SINGLE *
      FROM zc_abapd_agency
      WHERE agencyId = @i_agency
      INTO @r_agency.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_1717_no_agency
        EXPORTING
          i_agency_id = i_agency.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
