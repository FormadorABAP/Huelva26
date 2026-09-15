" ============================================
" Excepción 1: intensidad demasiado alta
" Sin get_text redefinido -> el texto sale de la
" clase de mensajes ZVELAS_00, mensaje 001
" ============================================
CLASS lcx_intensidad_alta DEFINITION
  INHERITING FROM cx_static_check.

  PUBLIC SECTION.
    INTERFACES if_t100_message.
    INTERFACES if_t100_dyn_msg.

    METHODS constructor
      IMPORTING
        textid   LIKE if_t100_message=>t100key OPTIONAL
        previous LIKE previous OPTIONAL.

ENDCLASS.

CLASS lcx_intensidad_alta IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).
    CLEAR me->textid.
    IF textid IS INITIAL.
      " Estructura al mensaje
      if_t100_message~t100key = VALUE #( msgid = 'ZVELAS_00'
                                         msgno = '010'
                                         attr1 = ''
                                         attr2 = ''
                                         attr3 = ''
                                         attr4 = '' ).
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.


" ============================================
" Excepción 2: intensidad negativa
" Mismo patrón, apuntará al mensaje 002
" ============================================
CLASS lcx_intensidad_baja DEFINITION
  INHERITING FROM cx_static_check.

  PUBLIC SECTION.
    INTERFACES if_t100_message.
    INTERFACES if_t100_dyn_msg.

    METHODS constructor
      IMPORTING
        textid   LIKE if_t100_message=>t100key OPTIONAL
        previous LIKE previous OPTIONAL.

ENDCLASS.

CLASS lcx_intensidad_baja IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = VALUE #( msgid = 'ZVELAS_00'
                                         msgno = '011'
                                         attr1 = ''
                                         attr2 = ''
                                         attr3 = ''
                                         attr4 = '' )..
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
