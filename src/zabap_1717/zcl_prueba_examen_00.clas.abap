CLASS zcl_prueba_examen_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_prueba_examen_00 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*    TRY.
*        DATA(lo_flight) = NEW zcl_1717_flight(
*                    i_carrier_id = 'A'
*                    i_connection_id = 0
*                    i_plane_type_id = 'X' ).
*        out->write( lo_flight ).
*      CATCH zcx_c_abapd_no_connection INTO DATA(lo_error).
*        out->write( lo_error->get_text( ) ).
*    ENDTRY.

*    TRY.
*        DATA(lo_passeger) = NEW zcl_1717_passenger_flight(
*                    i_carrier_id = 'A'
*                    i_connection_id = 0
*                    i_plane_type_id = 'X' ).
*        out->write( lo_passeger ).
*      CATCH zcx_c_abapd_no_connection INTO DATA(lo_error).
*        out->write( lo_error->get_text( ) ).
*    ENDTRY.

*    DATA(lo_connection) = NEW zcl_1717_connections( ).
*
*    out->write( lo_connection->get_connections( i_departure = 'HAV' ) ).

*    DATA(lo_agencia) = NEW zcl_1717_agency_model( ).
*
*    TRY.
*        out->write( lo_agencia->get_agency( i_agency = 1 ) ).
*      CATCH zcx_1717_no_agency INTO DATA(lo_error).
*        out->write( lo_error->get_text( ) ).
*    ENDTRY.

    DATA lt_customer TYPE z1717_t_cust.

    DATA lt_cust2 TYPE TABLE OF z1717_customer.

    lt_customer = VALUE #(
    (
        customer_id = 2
        first_name = 'LCa'
        last_name  = 'Perez'
        street       = 'Calle'
        postal_code  = 4
        city         = 'Huelva'
        country_code = 'S'
     )
         (
        customer_id = 1
        first_name = 'LCa'
        last_name  = 'Perez'
        street       = 'Calle'
        postal_code  = 4
        city         = 'Huelva'
        country_code = 'S'
     )

     ).

    out->write( lt_customer ).
  ENDMETHOD.

ENDCLASS.
