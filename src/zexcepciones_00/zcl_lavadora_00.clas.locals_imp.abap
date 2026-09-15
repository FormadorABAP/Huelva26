*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

" ============================================
" Excepción ÚNICA para todos los errores de la lavadora.
" No sabe nada de "carga" ni "temperatura": es genérica.
" Implementa IF_T100_MESSAGE para poder resolver el texto
" desde T100 según el t100key que le pasen al lanzarla.
" ============================================
CLASS lcx_error_lavadora DEFINITION
  INHERITING FROM cx_static_check.

  PUBLIC SECTION.
    INTERFACES if_t100_message.
    INTERFACES if_t100_dyn_msg.

    METHODS constructor
      IMPORTING
        textid   LIKE if_t100_message=>t100key OPTIONAL
        previous LIKE previous OPTIONAL.

ENDCLASS.

CLASS lcx_error_lavadora IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
