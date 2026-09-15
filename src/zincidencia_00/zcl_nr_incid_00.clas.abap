CLASS zcl_nr_incid_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_nr_incid_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA lt_interval TYPE cl_numberrange_intervals=>nr_interval.
    DATA ls_interval TYPE cl_numberrange_intervals=>nr_nriv_line.

    ls_interval-nrrangenr  = '01'.
    ls_interval-fromnumber = '0001'.
    ls_interval-tonumber   = '9999'.
    ls_interval-procind    = 'I'.

    APPEND ls_interval TO lt_interval.

    cl_numberrange_intervals=>create(
      EXPORTING
        object    = 'ZINCID_00'
        interval  = lt_interval
        subobject = ' '
      IMPORTING
        error     = DATA(lv_error)
        error_inf = DATA(ls_error)
        error_iv  = DATA(lt_error)
        warning   = DATA(lv_warning)
    ).

    IF lv_error = abap_false.

      out->write( 'Intervalo 01 creado correctamente' ).

    ELSE.

      out->write( 'Error creando el intervalo' ).
      out->write( ls_error ).

    ENDIF.

  ENDMETHOD.
ENDCLASS.
