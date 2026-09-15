CLASS zcx_1717_no_agency DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

* Ini - LCa
    CONSTANTS:
      BEGIN OF no_agency,
        msgid TYPE symsgid VALUE 'ZC_ABAPD',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'AGENCY_ID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF no_agency.
* Fin - LCa

    DATA agency_id TYPE /dmo/agency_id .

    METHODS constructor
      IMPORTING
* Ini - LCa
        i_agency_id TYPE /dmo/agency_id
* Fin - LCa
        !textid    LIKE if_t100_message=>t100key OPTIONAL
        !previous  LIKE previous OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_1717_no_agency IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
    previous = previous
    ).

* Ini - LCa
    me->agency_id = i_agency_id.
* Fin - LCa

    CLEAR me->textid.
    IF textid IS INITIAL.

* Ini - LCa
* Código comentado:
*      if_t100_message~t100key = if_t100_message=>default_textid.
* Código nuevo:
      if_t100_message~t100key = no_agency.
* Fin - LCa

    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
