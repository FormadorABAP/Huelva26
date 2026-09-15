CLASS zcl_velas_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_velas_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Variable que simula la intensidad que un empleado
    " intenta configurar en una vela aromática
    DATA lv_intensidad TYPE i.

    " ---------- CASO 1: intensidad demasiado alta ----------
    lv_intensidad = 15.

    TRY.
        IF lv_intensidad > 10.
          " Construimos el t100key al vuelo, apuntando
          " a la fila 001 de la clase de mensajes ZVELAS_00
          RAISE EXCEPTION TYPE lcx_intensidad_alta.
        ENDIF.

        " Si no salta la excepción, mostramos el mensaje 003
        " con el valor de la intensidad sustituyendo al &
        MESSAGE ID 'ZVELAS_00' TYPE 'I' NUMBER '012'
          WITH lv_intensidad INTO DATA(lv_msg_ok1).
        out->write( lv_msg_ok1 ).

      CATCH lcx_intensidad_alta INTO DATA(lx_alta).
        " get_text( ) va a T100, no hay texto fijo en la excepción
        out->write( lx_alta->get_text( ) ).
    ENDTRY.

    " ---------- CASO 2: intensidad negativa ----------
    lv_intensidad = -5.

    TRY.
        IF lv_intensidad < 0.
          " Lanzamos la excepción 2, distinta de la anterior,
          " con su propio texto también fijo
          RAISE EXCEPTION TYPE lcx_intensidad_baja.
        ENDIF.

        MESSAGE ID 'ZVELAS_00' TYPE 'I' NUMBER '012'
          WITH lv_intensidad INTO lv_msg_ok1.
        out->write( lv_msg_ok1 ).

      CATCH lcx_intensidad_baja INTO DATA(lx_baja).
        out->write( lx_baja->get_text( ) ).
    ENDTRY.

    " ---------- CASO 3: intensidad válida (para que vean el camino feliz) ----------
    lv_intensidad = 8.

    TRY.
        IF lv_intensidad > 10.
          RAISE EXCEPTION TYPE lcx_intensidad_alta.
        ELSEIF lv_intensidad < 0.
          RAISE EXCEPTION TYPE lcx_intensidad_baja.
        ENDIF.


        MESSAGE ID 'ZVELAS_00' TYPE 'I' NUMBER '012'
          WITH lv_intensidad INTO lv_msg_ok1.
        out->write( lv_msg_ok1 ).

      CATCH lcx_intensidad_alta INTO DATA(lx_alta2).
        out->write( lx_alta2->get_text( ) ).
      CATCH lcx_intensidad_baja INTO DATA(lx_baja2).
        out->write( lx_baja2->get_text( ) ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
