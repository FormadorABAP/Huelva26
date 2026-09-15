CLASS zcl_coche_00 DEFINITION
  PUBLIC
  INHERITING FROM zcl_vehiculo_00
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS: constructor IMPORTING i_matricula_c TYPE string
                                   i_num_puertas TYPE i,
      abrir_maletero,
      pasar_revision REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA: num_puertas TYPE i.

ENDCLASS.



CLASS zcl_coche_00 IMPLEMENTATION.
  METHOD abrir_maletero.

  ENDMETHOD.

  METHOD constructor.

    " Padre -> metodo ( par_padre = par_hijo )
    super->constructor( i_matricula = i_matricula_c ).
    num_puertas = i_num_puertas.

  ENDMETHOD.

  METHOD pasar_revision.
    rv_revision = abap_false.
    IF num_puertas >= 4.

*      " Sin herancia
*      IF kilometraje <= 100000.
*        rv_revision = abap_true.
*      ENDIF.

      " Con herencia
      super->pasar_revision( ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
