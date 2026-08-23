CLASS zcl_caja_fuerte_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      constructor IMPORTING i_codigo TYPE string,
      abrir IMPORTING i_codigo          TYPE i
            RETURNING VALUE(rv_abierta) TYPE abap_bool,
      esta_bloqueada RETURNING VALUE(rv_bloqueada) TYPE abap_bool.


  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      codigo    TYPE string,
      intentos  TYPE i,
      bloqueada TYPE abap_bool.
ENDCLASS.



CLASS ZCL_CAJA_FUERTE_00 IMPLEMENTATION.


  METHOD constructor.
    codigo = i_codigo.
    intentos = 0.
    bloqueada = abap_false.
  ENDMETHOD.


  METHOD abrir.

    IF bloqueada = abap_true. " Caja bloqueada
      rv_abierta = abap_false.

    ELSEIF bloqueada = abap_false AND codigo = i_codigo. " Caja desbloqueada con código correcto
      rv_abierta = abap_true.
      intentos = 0.

    ELSEIF bloqueada = abap_false AND codigo <> i_codigo. " Caja desbloqueada con código erroneo
      rv_abierta = abap_false.
      intentos = intentos + 1.

      IF intentos = 3. " Con el tercer intento se bloquea
        bloqueada = abap_true.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD esta_bloqueada.
    rv_bloqueada = bloqueada.
  ENDMETHOD.
ENDCLASS.
