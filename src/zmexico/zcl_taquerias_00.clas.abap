CLASS zcl_taquerias_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_taquerias_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " === DECLARACIÓN DE VARIABLES ===
    DATA: ls_taqueria TYPE ztaquerias_00,
          lt_taqueria TYPE TABLE OF ztaquerias_00.

    " === 1. CREATE: Insertando taquerias ===
    ls_taqueria-id_taqueria = 'TAQ004'.
    ls_taqueria-nombre = 'Cochinita Pibil Express'.
    ls_taqueria-estado = 'OA'.
    ls_taqueria-especialidad = 'CO'.
    ls_taqueria-nivel_picante = 2.
    ls_taqueria-precio_taco = '18.00'.
    ls_taqueria-moneda = 'MXN'.
    INSERT ztaquerias_00 FROM @ls_taqueria.
    IF sy-subrc = 0.
      out->write( |La taquería { ls_taqueria-nombre } ha sido registrada| ).
    ELSE.
      out->write( |Registro NO válido| ).
    ENDIF.

    INSERT ztaquerias_00 FROM @( VALUE #(
        id_taqueria = 'TAQ005'
        nombre = 'Taq LCa'
        estado = 'OA'
        especialidad = 'CO'
        nivel_picante = 2
        precio_taco = '28.00'
        moneda = 'EUR'
) ).

    " === 3. READ: Leer una taqueria por su ID ===
    SELECT SINGLE FROM ztaquerias_00
        FIELDS *
        WHERE estado = 'JA'
        INTO @DATA(ls_taqueria_ja).
    IF sy-subrc = 0.
      out->write( |La taquería { ls_taqueria_ja-nombre } ha sido encontrada| ).
    ELSE.
      out->write( |NO se encuentra la taquería| ).
    ENDIF.

    " Bloque 4 — READ (ERROR): Leer una taquería que no existe
    SELECT SINGLE FROM ztaquerias_00
        FIELDS *
        WHERE estado = 'AA'
        INTO @DATA(ls_taqueria_aa).
    IF sy-subrc = 0.
      out->write( |La taquería { ls_taqueria_aa-nombre } ha sido encontrada| ).
    ELSE.
      out->write( |NO se encuentra la taquería| ).
    ENDIF.

    " Bloque 5 — READ: Listar taquerías de un estado
    SELECT FROM ztaquerias_00
        FIELDS *
        WHERE estado = 'OA'
        INTO TABLE @lt_taqueria.
    IF sy-subrc = 0.
      out->write( |Las taquerías de OA son:| ).
      out->write( lt_taqueria ).
    ELSE.
      out->write( |NO se encuentran taquerías en OA| ).
    ENDIF.

    " Bloque 9 — READ final: Recuento de taquerías restantes
    SELECT COUNT(*) FROM ztaquerias_00 INTO @DATA(lv_num_taq).
    IF sy-subrc EQ 0.
      out->write( |El num total de taq registradas son { lv_num_taq }| ).
    ELSE.
      out->write( |NO se encuentran taquerías| ).
    ENDIF.

    " Crea una estructura
    DATA lt_nueva TYPE TABLE OF ztaquerias_00.
    lt_nueva = VALUE #(
      ( id_taqueria    = 'TAQ005'
        nombre         = 'Taq LCa'
        estado         = 'OA'
        especialidad   = 'CO'
        nivel_picante  = 2
        precio_taco    = '28.00' )

      ( id_taqueria    = 'TAQ006'
        nombre         = 'Taq LCa 2'
        estado         = 'OA'
        especialidad   = 'CO'
        nivel_picante  = 2
        precio_taco    = '28.00' )
    ).


    APPEND VALUE #(
      id_taqueria    = 'TAQ005'
      nombre         = 'Taqueria Nueva'
      estado         = 'JA'
      especialidad   = 'PA'
      nivel_picante  = 3
      precio_taco    = '17.50'
) TO lt_nueva.


  ENDMETHOD.
ENDCLASS.
