CLASS zcx_c_abapd_no_connection DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

constants:
  begin of ZCX_C_ABAPD_NO_CONNECTION,
    msgid type symsgid value 'ZC_ABAPD',
    msgno type symsgno value '001',
    attr1 type scx_attrname value 'attr1',
    attr2 type scx_attrname value 'attr2',
    attr3 type scx_attrname value 'attr3',
    attr4 type scx_attrname value 'attr4',
  end of ZCX_C_ABAPD_NO_CONNECTION.

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCX_C_ABAPD_NO_CONNECTION IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
    previous = previous
    ).
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
*      if_t100_message~t100key = ZCX_C_ABAPD_NO_CONNECTION.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
