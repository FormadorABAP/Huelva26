CLASS zcl_mascota_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS: constructor,
      comer,
      jugar,
      consultar_estado EXPORTING o_hambre  TYPE i
                                 o_energia TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA: hambre  TYPE i,
          energia TYPE i.

ENDCLASS.

CLASS zcl_mascota_00 IMPLEMENTATION.
  METHOD constructor.
    hambre = 100.
    energia = 100.
  ENDMETHOD.


  METHOD comer.
    hambre = hambre + 20.
    IF hambre > 100.
      hambre = 100.
    ENDIF.
  ENDMETHOD.

  METHOD jugar.
    IF energia >= 20.
      energia -= 15.

      hambre -= 10.
      IF hambre < 0.
        hambre = 0.
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD consultar_estado.
    o_energia = energia.
    o_hambre = hambre.
  ENDMETHOD.

ENDCLASS.
