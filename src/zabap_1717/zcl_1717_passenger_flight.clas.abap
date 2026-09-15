CLASS zcl_1717_passenger_flight DEFINITION
  PUBLIC
  INHERITING FROM zcl_1717_flight
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor IMPORTING
                                  i_carrier_id    TYPE /dmo/carrier_id
                                  i_connection_id TYPE /dmo/connection_id
                                  i_plane_type_id TYPE /dmo/plane_type_id
                        RAISING   zcx_c_abapd_no_connection.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA seats_max TYPE /dmo/plane_seats_max.

ENDCLASS.

CLASS zcl_1717_passenger_flight IMPLEMENTATION.
  METHOD constructor.

    super->constructor( i_carrier_id = i_carrier_id
                        i_connection_id = i_connection_id
                        i_plane_type_id = i_plane_type_id ).

    SELECT SINGLE MaximumSeats
        FROM ZI_CABAPD_PASSENGER
        WHERE plane_type_id = @i_plane_type_id
        INTO ( @me->seats_max ).

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_c_abapd_no_connection.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
