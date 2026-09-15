CLASS ltc_pedidos_dcl DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    CLASS-DATA:
      environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS:
      class_setup RAISING cx_static_check,
      class_teardown.

    METHODS:

      setup RAISING cx_static_check,

      preparar_datos,

      test_sur
        FOR TESTING
        RAISING cx_static_check,

      test_nor
        FOR TESTING
        RAISING cx_static_check,

      test_sin_autorizacion
        FOR TESTING
        RAISING cx_static_check.

ENDCLASS.

CLASS ltc_pedidos_dcl IMPLEMENTATION.


  METHOD class_setup.

    environment =
      cl_cds_test_environment=>create(
        i_for_entity = 'ZI_PEDIDO_DCL_00'
      ).

  ENDMETHOD.


  METHOD class_teardown.

    environment->destroy( ).

  ENDMETHOD.


  METHOD setup.

    environment->clear_doubles( ).

  ENDMETHOD.


  METHOD preparar_datos.

    DATA lt_pedidos TYPE STANDARD TABLE OF zpedido_dcl_00
                    WITH EMPTY KEY.

    lt_pedidos = VALUE #(

      ( pedido_id   = 'P001'
        descripcion = 'Ordenadores'
        zona        = 'SUR' )

      ( pedido_id   = 'P002'
        descripcion = 'Monitores'
        zona        = 'NOR' )

      ( pedido_id   = 'P003'
        descripcion = 'Teclados'
        zona        = 'SUR' )

      ( pedido_id   = 'P004'
        descripcion = 'Servidores'
        zona        = 'CEN' )

      ( pedido_id   = 'P005'
        descripcion = 'Ratones'
        zona        = 'NOR' )

    ).

    environment->insert_test_data(
      i_data = lt_pedidos
    ).

  ENDMETHOD.
  METHOD test_nor.

    preparar_datos( ).

    DATA(auth_data) =
      cl_cds_test_data=>create_access_control_data(

        i_role_authorizations = VALUE #(

          (
            object = 'ZPEDAREA00'

            authorizations = VALUE #(

              (
                VALUE #(

                  (
                    fieldname = 'ZZONA00'
                    fieldvalues = VALUE #(
                      ( lower_value = 'NOR' )
                    )
                  )

                  (
                    fieldname = 'ACTVT'
                    fieldvalues = VALUE #(
                      ( lower_value = '03' )
                    )
                  )

                )
              )

            )

          )

        )

      ).


    environment->get_access_control_double(
      )->enable_access_control(
        i_access_control_data = auth_data
      ).


    SELECT *
      FROM zi_pedido_dcl_00
      INTO TABLE @DATA(lt_resultado).


    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_resultado )
      exp = 2
    ).


    cl_abap_unit_assert=>assert_true(
      act = xsdbool(
        line_exists(
          lt_resultado[ PedidoId = 'P002' ]
        )
      )
    ).


    cl_abap_unit_assert=>assert_true(
      act = xsdbool(
        line_exists(
          lt_resultado[ PedidoId = 'P005' ]
        )
      )
    ).

  ENDMETHOD.

  METHOD test_sin_autorizacion.

    preparar_datos( ).

    DATA(auth_data) =
      cl_cds_test_data=>create_access_control_data(
        i_role_authorizations = VALUE #( )
      ).


    environment->get_access_control_double(
      )->enable_access_control(
        i_access_control_data = auth_data
      ).


    SELECT *
      FROM zi_pedido_dcl_00
      INTO TABLE @DATA(lt_resultado).


    cl_abap_unit_assert=>assert_initial(
      act = lt_resultado
    ).

  ENDMETHOD.

  METHOD test_sur.

    preparar_datos( ).

    DATA(auth_data) =
      cl_cds_test_data=>create_access_control_data(
            i_role_authorizations = VALUE #(
              ( object = 'ZPEDAREA00'
                authorizations = VALUE #(
                      ( VALUE #(
                        ( fieldname = 'ZZONA00'
                          fieldvalues = VALUE #(
                              ( lower_value = 'SUR' )
                          )
                        )
                        ( fieldname = 'ACTVT'
                          fieldvalues = VALUE #(
                              ( lower_value = '03' )
                          )
                       )
                )
              )

            )

          )

        )

      ).


    environment->get_access_control_double(
      )->enable_access_control(
        i_access_control_data = auth_data
      ).


    SELECT *
      FROM zi_pedido_dcl_00
      INTO TABLE @DATA(lt_resultado).


    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_resultado )
      exp = 2
    ).

  ENDMETHOD.

ENDCLASS.
