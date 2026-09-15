CLASS zcx_saldo_insuficiente DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

CONSTANTS:
      BEGIN OF mensaje_1,
        msgid TYPE symsgid VALUE 'ZEXCEPCIONES_00',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF mensaje_1.

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL .

*    " Truqui para que salga el mensaje de la clase hija
*    METHODS get_text REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_saldo_insuficiente IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
    previous = previous
    ).
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = mensaje_1.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

    " Este metodo iría fuera, está aquí para que me permita el comentario
    " Truqui para que salga el mensaje de la clase hija
*  METHOD get_text.
*    result = 'No hay saldo suficiente'.
*  ENDMETHOD.

  ENDMETHOD.



ENDCLASS.
