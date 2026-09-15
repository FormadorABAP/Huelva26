CLASS zcl_vuelos_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_vuelos_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

****    SELECT FROM /dmo/flight
****        FIELDS  carrier_id,
****                connection_id,
****                flight_date,
****                price,
****                currency_code
****        WHERE flight_date > '20260430'
****        INTO TABLE @DATA(lt_vuelos).
****    IF sy-subrc = 0.
****      out->write( lt_vuelos ).
****    ELSE.
****      out->write( 'No se han encontrado vuelos' ).
****    ENDIF.
***
****    7️⃣ Selecciona los vuelos cuyo número de asientos ocupados
****(SEATS_OCCUPIED) sea superior al 90% de SEATS_MAX (pista:
****puedes comparar SEATS_OCCUPIED > SEATS_MAX * '0.9'). Muestra
****CARRIER_ID, CONNECTION_ID, SEATS_MAX y SEATS_OCCUPIED.
***
***    SELECT carrier_id, connection_id, seats_max, seats_occupied
***      FROM /dmo/flight
***      WHERE seats_occupied > ( seats_max * division( 9, 10, 1 ) )
***      INTO TABLE @DATA(lt_flights).
***    IF sy-subrc EQ 0.
***      out->write( lt_flights ).
***    ENDIF.
**
***    " A partir de las claves de una reserva hay que obtener el tipo avión
***
***    " Recupero los datos de la reserva con los valores de prueba
***    SELECT SINGLE FROM /dmo/booking
***    FIELDS carrier_id, connection_id, flight_date
***    WHERE travel_id = '0017'
***        AND booking_id = '0002'
***    INTO @DATA(ls_reserva).
***    IF sy-subrc = 0.
****      out->write( ls_reserva ).
***
***      " Recupero los valores del vuelo con los datos de la reserva
***      "         obtenido anteriormente
***      SELECT SINGLE FROM /dmo/flight
***      FIELDS *
***      WHERE carrier_id = @ls_reserva-carrier_id
***          AND connection_id = @ls_reserva-connection_id
***          AND flight_date = @ls_reserva-flight_date
***      INTO @DATA(ls_vuelo).
***      IF sy-subrc = 0.
***        out->write( |El avión es { ls_vuelo-plane_type_id }| ).
***      ELSE.
***        out->write( 'Vuelo no encontrada' ).
***      ENDIF.
***
***    ELSE.
***      out->write( 'Reserva no encontrada' ).
***    ENDIF.
**
**    " Dado el nombre de una compañia dame todos sus vuelos
**    SELECT SINGLE FROM /dmo/carrier
**        FIELDS carrier_id
**        WHERE name = 'LCa Airlines Limited'
**        INTO @DATA(lv_carrier).
**
**    IF sy-subrc = 0.
**
**      " He recuperado el ID de la compañia
**      SELECT FROM /dmo/flight
**      FIELDS *
**      WHERE carrier_id = @lv_carrier
**      INTO TABLE @DATA(lt_vuelos).
**      IF sy-subrc = 0.
**        out->write( lt_vuelos ).
**      ELSE.
**        out->write( |No hay vuelos para la compañia { lv_carrier }| ).
**      ENDIF.
**
**    ELSE.
**      out->write( 'La compañia no existe' ).
**    ENDIF.
**
**    " Quiero una tabla con los campos:
**    "   Nombre de Compañia | ID Conexion | Fecha de Vuelo | Precio | Moneda
**
**    " Definir mi tabla de salida
**    TYPES: BEGIN OF ty_salida,
**             name          TYPE /dmo/carrier-name,
**             connection_id TYPE /dmo/flight-connection_id,
**             flight_date   TYPE /dmo/flight-flight_date,
**             price         TYPE /dmo/flight-price,
**             currency_code TYPE /dmo/flight-currency_code,
**           END OF ty_salida.
**
**    DATA ls_salida TYPE ty_salida.
**    DATA lt_salida TYPE TABLE OF ty_salida.
**
**    " Recuperar los datos de la BD
**    SELECT FROM /dmo/flight
**        FIELDS  carrier_id,
**                connection_id,
**                flight_date,
**                price,
**                currency_code
**        INTO TABLE @DATA(lt_flight).
**
**    SELECT FROM /dmo/carrier
**        FIELDS carrier_id, name
**        INTO TABLE @DATA(lt_carrier).
**
**    " Recorrer las tablas y a montar mi tabla de salida
**    LOOP AT lt_flight INTO DATA(ls_flight).
**
**      READ TABLE lt_carrier INTO DATA(ls_carrier)
**          WITH KEY carrier_id = ls_flight-carrier_id.
**      IF sy-subrc = 0.
**        ls_salida-name = ls_carrier-name.
**        ls_salida-connection_id = ls_flight-connection_id.
**        ls_salida-flight_date = ls_flight-flight_date.
**        ls_salida-price = ls_flight-price.
**        ls_salida-currency_code = ls_flight-currency_code.
**        APPEND ls_salida TO lt_salida.
**
**      ENDIF.
**
**    ENDLOOP.
**
**" Recorrer las tablas y a montar mi tabla de salida
**    LOOP AT lt_carrier INTO DATA(ls_carrier).
**
**      READ TABLE lt_flight INTO DATA(ls_flight)
**          WITH KEY carrier_id = ls_carrier-carrier_id.
**      IF sy-subrc = 0.
**        ls_salida-name = ls_carrier-name.
**        ls_salida-connection_id = ls_flight-connection_id.
**        ls_salida-flight_date = ls_flight-flight_date.
**        ls_salida-price = ls_flight-price.
**        ls_salida-currency_code = ls_flight-currency_code.
**        APPEND ls_salida TO lt_salida.
**
**      ENDIF.
**
**    ENDLOOP.
**
**    out->write( lt_salida ).

*Pasos a seguir (misma estructura que el ejercicio de FLIGHT + CARRIER):*

*1. Define un tipo de salida ty_salida con estos campos:
*   - first_name (de /dmo/customer-first_name)
*   - last_name (de /dmo/customer-last_name)
*   - travel_id (de /dmo/travel-travel_id)
*   - begin_date (de /dmo/travel-begin_date)
*   - total_price (de /dmo/travel-total_price)
*   - currency_code (de /dmo/travel-currency_code)

    TYPES: BEGIN OF ty_salida,
             first_name    TYPE /dmo/customer-first_name,
             last_name     TYPE /dmo/customer-last_name,
             travel_id     TYPE /dmo/travel-travel_id,
             begin_date    TYPE /dmo/travel-begin_date,
             total_price   TYPE /dmo/travel-total_price,
             currency_code TYPE /dmo/travel-currency_code,
           END OF ty_salida.

    DATA ls_salida TYPE ty_salida.
    DATA lt_salida TYPE TABLE OF ty_salida.

*2. Recupera *todos* los viajes de /DMO/TRAVEL
*    (campos: customer_id, travel_id, begin_date, total_price, currency_code)
*    en una tabla interna lt_travel.

    SELECT FROM /dmo/travel
    FIELDS customer_id, travel_id, begin_date, total_price, currency_code
    INTO TABLE @DATA(lt_travel).

*3. Recupera *todos* los clientes de /DMO/CUSTOMER
*    (campos: customer_id, first_name, last_name) en una tabla interna lt_customer.

    SELECT FROM /dmo/CUSTOMER
    FIELDS customer_id, first_name, last_name
    INTO TABLE @DATA(lt_CUSTOMER).

*4. Recorre lt_travel con un LOOP, y por cada viaje busca
*    (READ TABLE ... WITH KEY) el cliente correspondiente en lt_customer
*    usando customer_id.

    LOOP AT lt_travel INTO DATA(ls_travel).
      READ TABLE lt_customer INTO DATA(ls_customer)
          WITH KEY customer_id = ls_travel-customer_id.

*5. Si lo encuentra (sy-subrc = 0), monta la fila de salida
*    y añádela a la tabla final con APPEND.

      IF sy-subrc = 0.
*        ls_salida-first_name = ls_customer-first_name.
*        ls_salida-last_name = ls_customer-last_name.
*        ls_salida-travel_id = ls_travel-travel_id.
*        ls_salida-begin_date = ls_travel-begin_date.
*        ls_salida-total_price = ls_travel-total_price.
*        ls_salida-currency_code = ls_travel-currency_code.

        MOVE-CORRESPONDING ls_customer TO ls_salida.
        MOVE-CORRESPONDING ls_travel TO ls_salida.
        APPEND ls_salida TO lt_salida.
      ENDIF.
    ENDLOOP.

*6. Muestra el resultado con out->write( ).
*    out->write( lt_salida ).

********************************

    " Ahora lo intentamos con JOINS

    SELECT FROM /dmo/travel AS t
            INNER JOIN /dmo/customer AS c
        ON c~customer_id = t~customer_id
        FIELDS  c~first_name,
                c~last_name,
                t~travel_id,
                t~begin_date,
                t~total_price,
                t~currency_code
        INTO TABLE @DATA(lt_salida_2).
    IF sy-subrc = 0.
      out->write( lt_salida_2 ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
