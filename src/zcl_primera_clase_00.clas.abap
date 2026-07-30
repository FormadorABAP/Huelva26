CLASS zcl_primera_clase_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_primera_clase_00 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    " Declara una estructura ls_pedido con los campos
*    " id_pedido (entero),
*    " importe (decimal)
*    " y tipo_cliente (texto), calculado a partir de un CASE.
*
*    TYPES: BEGIN OF ty_pedido,
*             id_pedido    TYPE i,
*             importe      TYPE p LENGTH 10 DECIMALS 2,
*             tipo_cliente TYPE string,
*           END OF ty_pedido.
*
*    DATA ls_pedido TYPE ty_pedido.
*
*    " Declara una tabla interna lt_pedidos de ese tipo.
*    DATA lt_pedido TYPE TABLE OF ty_pedido.
*
*    " Usando un DO 5 TIMES, para cada vuelta:
*    " asigna a id_pedido el número de vuelta
*    " (puedes usar una variable contador que incrementes tú mismo),
*
*    DO 5 TIMES.
*
*      ls_pedido-id_pedido = sy-index.
*
*      ls_pedido-importe = sy-index * '120.75'.
*
*      " Declaración inline
*      DATA(lv_resto) = sy-index MOD 2.
*
*      CASE lv_resto.
*        WHEN 0. " Caso par
*          ls_pedido-tipo_cliente = 'PREMIUM'.
*        WHEN 1. " Caso impar
*          ls_pedido-tipo_cliente = 'ESTANDAR'.
*      ENDCASE.
*
*      APPEND ls_pedido TO lt_pedido.
*    ENDDO.
*
*    out->write( lt_pedido ).
*
*    " asigna a importe el resultado de multiplicar el número
*    " de vuelta por 120.75,
*    " y usando CASE sobre el resto de dividir el número de vuelta
*    " entre 2 (par o impar),
*    " asigna a tipo_cliente el valor 'PREMIUM' si es par,
*    " o 'ESTANDAR' si es impar.
*
*    " Añade cada estructura resultante a la tabla con APPEND
*    "antes de pasar a la siguiente vuelta.
*
*    DATA lv_contador TYPE i.
*    DO 5 TIMES.
*
*      DO 2 TIMES.
*        lv_contador += 1.
*      ENDDO.
*
*    ENDDO.
*
*    out->write( '' ).
*    out->write( lv_contador ).

*    TYPES: BEGIN OF ty_producto,
*             nombre TYPE string,
*             precio TYPE p LENGTH 5 DECIMALS 2,
*           END OF ty_producto.
*
*    DATA ls_producto TYPE ty_producto.
*    DATA lt_producto TYPE TABLE OF ty_producto.
*
*    ls_producto-nombre = 'Cerveza'.
*    ls_producto-precio = '2.00'.
*    APPEND ls_producto TO lt_producto.
*
*    ls_producto-nombre = 'Ginebra'.
*    ls_producto-precio = '5.00'.
*    APPEND ls_producto TO lt_producto.
*
*    LOOP AT lt_producto INTO ls_producto.
*      out->write( ls_producto-precio ).
*    ENDLOOP.

*    TYPES:BEGIN OF ty_empleado,
*            nombre  TYPE string,
*            salario TYPE p LENGTH 5 DECIMALS 2,
*          END OF ty_empleado.
*
*    DATA: ls_empleado TYPE ty_empleado,
*          lt_empleado TYPE TABLE OF ty_empleado.
*
*    ls_empleado-nombre = 'David'.
*    ls_empleado-salario = 2500.
*    APPEND ls_empleado TO lt_empleado.
*
*    ls_empleado-nombre = 'Juan'.
*    ls_empleado-salario = 1500.
*    APPEND ls_empleado TO lt_empleado.
*
*    ls_empleado-nombre = 'Jesús'.
*    ls_empleado-salario = 4500.
*    APPEND ls_empleado TO lt_empleado.
*
*    ls_empleado-nombre = 'Pablo'.
*    ls_empleado-salario = 500.
*    APPEND ls_empleado TO lt_empleado.
*
*    LOOP AT lt_empleado INTO ls_empleado.
*      IF ls_empleado-salario > 2000.
*        out->write( ls_empleado-nombre ).
*      ENDIF.
*    ENDLOOP.

*    TYPES: BEGIN OF ty_pedido,
*             id_pedido TYPE i,
*             importe   TYPE p LENGTH 5 DECIMALS 2,
*             estado    TYPE string,
*           END OF ty_pedido.
*
*    DATA: ls_pedido TYPE ty_pedido,
*          lt_pedido TYPE TABLE OF ty_pedido.
*
*    DATA lv_resto TYPE i.
*
*    DO 6 TIMES.
*      ls_pedido-id_pedido += 1.
*      ls_pedido-importe = ls_pedido-id_pedido * '45.30'.
*      lv_resto = ls_pedido-id_pedido MOD 3.
*
*      CASE lv_resto.
*        WHEN 0.
*          ls_pedido-estado = 'ENVIADO'.
*        WHEN 1.
*          ls_pedido-estado = 'PENDIENTE'.
*        WHEN 2.
*          ls_pedido-estado = 'CANCELADO'.
*      ENDCASE.
*
*      APPEND ls_pedido TO lt_pedido.
*    ENDDO.

*    LOOP AT lt_pedido INTO ls_pedido.
*      IF ls_pedido-estado = 'PENDIENTE'.
*        out->write( | El ID es { ls_pedido-id_pedido } y el importe { ls_pedido-importe } | ).
*      ENDIF.
*    ENDLOOP.

*    CLEAR ls_pedido.
*    READ TABLE lt_pedido INTO ls_pedido
*        WITH KEY estado = 'PENDIENTE' id_pedido = 2.
*    IF sy-subrc is INITIAL. " Ha ido bien
*      out->write( | El importe es: { ls_pedido-importe }| ).
*    ELSE.            " El READ TABLE no ha recuperado información
*      out->write( 'Pedido NO encontrado' ).
*    ENDIF.

*    TYPES: BEGIN OF ty_producto,
*             nombre TYPE string,
*             precio TYPE p LENGTH 5 DECIMALS 2,
*           END OF ty_producto.
*
*    DATA ls_producto TYPE ty_producto.
*    DATA lt_producto TYPE TABLE OF ty_producto.
*
*    ls_producto-nombre = 'Gráfica'.
*    ls_producto-precio = '300.00'.
*    APPEND ls_producto TO lt_producto.
*
*    ls_producto-nombre = 'Monitor'.
*    ls_producto-precio = '1000.00'.
*    APPEND ls_producto TO lt_producto.
*
*    ls_producto-nombre = 'Teclado'.
*    ls_producto-precio = '50.00'.
*    APPEND ls_producto TO lt_producto.
*
*    ls_producto-nombre = 'Ratón'.
*    ls_producto-precio = '70.00'.
*    APPEND ls_producto TO lt_producto.
*
*    READ TABLE lt_producto INTO ls_producto
*        INDEX 3.
*    IF sy-subrc = 0.
*      out->write( | { ls_producto-nombre } --> { ls_producto-precio }| ).
*    ELSE.
*      out->write( 'No se ha encontrado el producto' ).
*    ENDIF.

*    TYPES:BEGIN OF ty_empleado,
*            id_empleado  TYPE i,
*            nombre       TYPE string,
*            departamento TYPE string,
*          END OF ty_empleado.
*
*    DATA: lt_empleados TYPE TABLE OF ty_empleado,
*          ls_empleado  TYPE ty_empleado.
*
*    ls_empleado-id_empleado = 1.
*    ls_empleado-nombre = 'Juan'.
*    ls_empleado-departamento = 'Limpieza'.
*    APPEND ls_empleado TO lt_empleados.
*
*    ls_empleado-id_empleado = 2.
*    ls_empleado-nombre = 'Paco'.
*    ls_empleado-departamento = 'Dirección'.
*    APPEND ls_empleado TO lt_empleados.
*
*    ls_empleado-id_empleado = 3.
*    ls_empleado-nombre = 'María'.
*    ls_empleado-departamento = 'RRHH'.
*    APPEND ls_empleado TO lt_empleados.
*
*    ls_empleado-id_empleado = 4.
*    ls_empleado-nombre = 'LCa'.
*    ls_empleado-departamento = 'El puto amo'.
*    APPEND ls_empleado TO lt_empleados.
*
*    ls_empleado-id_empleado = 5.
*    ls_empleado-nombre = 'María'.
*    ls_empleado-departamento = 'Administración'.
*    APPEND ls_empleado TO lt_empleados.
*
*    READ TABLE lt_empleados INTO ls_empleado
*        WITH KEY id_empleado = 7.
*    IF sy-subrc = 0.
*      out->write( |El empleado { ls_empleado-nombre } trabaja en { ls_empleado-departamento } | ).
*    ELSE.
*      out->write( 'No se ha encontrado ningún empleado con ese ID' ).
*    ENDIF.

*    TYPES: BEGIN OF ty_pedido,
*             id_pedido TYPE i,
*             importe   TYPE p LENGTH 5 DECIMALS 2,
*             estado    TYPE string,
*           END OF ty_pedido.
*
*    DATA: ls_pedido TYPE ty_pedido,
*          lt_pedido TYPE TABLE OF ty_pedido.
*
*    DO 6 TIMES.
*      ls_pedido-id_pedido = sy-index.
*      ls_pedido-importe = ls_pedido-id_pedido * '50.25'.
*
*      DATA(lv_resto) = ls_pedido-id_pedido MOD 2.
*      CASE lv_resto.
*        WHEN 0.
*          ls_pedido-estado = 'ENVIADO'.
*        WHEN 1.
*          ls_pedido-estado = 'PENDIENTE'.
*      ENDCASE.
*
*      APPEND ls_pedido TO lt_pedido.
*    ENDDO.
*
*
*    DATA(lv_id_buscado) = 4.
*    CLEAR ls_pedido.
*    READ TABLE lt_pedido INTO DATA(ls_pedido_aux)
*        WITH KEY id_pedido = lv_id_buscado
*                 estado = 'PENDIENTE'.
*
*    IF sy-subrc = 0.
*      out->write( |El importe del pedido con id { lv_id_buscado } es { ls_pedido-importe } | ).
*    ELSE.
*      out->write( |No hay pedidos pendientes con el ID { lv_id_buscado } | ).
*    ENDIF.

*    TYPES: BEGIN OF ty_persona,
*             nombre TYPE string,
*             edad   TYPE i,
*           END OF ty_persona.
*
*    DATA: ls_persona     TYPE ty_persona,
*          lt_persona     TYPE TABLE OF ty_persona.
*
*    FIELD-SYMBOLS <fs_persona> type ty_persona.
*
*
*    ls_persona-nombre = 'María'.
*    ls_persona-edad = 5.
*    APPEND ls_persona TO lt_persona.
*
*    ls_persona-nombre = 'Jenny'.
*    ls_persona-edad = 6.
*    APPEND ls_persona TO lt_persona.
*
*    ls_persona-nombre = 'LCa'.
*    ls_persona-edad = 7.
*    APPEND ls_persona TO lt_persona.
*
*    LOOP AT lt_persona ASSIGNING <fs_persona>.
*      <fs_persona>-edad = <fs_persona>-edad * 2.
*    ENDLOOP.
*
*    out->write( lt_persona ).

    "3. (Difícil) — El sistema de facturación de un taller mecánico
    "Declara con TYPES/DATA una estructura ty_reparacion con los campos id_reparacion (entero), coste (decimal) y prioridad (texto),
    "y su tabla lt_reparaciones.
    "Usando DO 8 TIMES, genera reparaciones donde id_reparacion sea el número de vuelta,
    "coste sea el número de vuelta multiplicado por 35.80, y prioridad se calcule con CASE sobre el resto de dividir el número de vuelta entre
    "3:
    " 'URGENTE' si el resto es 0,
    "'NORMAL' si es 1,
    " 'BAJA' si es 2.
    "Añade cada una con APPEND. Después, usando LOOP AT ... ASSIGNING con WHERE prioridad = 'URGENTE',
    "aplica un recargo del 15% al coste de cada reparación urgente directamente sobre la fila original.
    "Finalmente, recorre toda la tabla con un LOOP AT normal y muestra con pipes un resumen de cada reparación
    "(id, coste final, prioridad), y al terminar, muestra cuántas reparaciones en total quedaron con prioridad 'URGENTE'.

*    TYPES: BEGIN OF ty_reparacion,
*             id_reparacion TYPE i,
*             coste         TYPE p LENGTH 10 DECIMALS 2,
*             prioridad     TYPE string,
*           END OF ty_reparacion.
*
*    DATA: lt_reparacion TYPE TABLE OF ty_reparacion,
*          ls_reparacion TYPE ty_reparacion.
*
*    DATA: lv_contador_urgentes TYPE i.
*
*    DO 8 TIMES.
*
*      ls_reparacion-id_reparacion = sy-index.
*      ls_reparacion-coste = sy-index * '35.80'.
*
*      DATA(lv_resto) = ls_reparacion-id_reparacion MOD 3.
*      CASE lv_resto.
*        WHEN 0.
*          ls_reparacion-prioridad = 'URGENTE'.
*        WHEN 1.
*          ls_reparacion-prioridad = 'NORMAL'.
*        WHEN 2.
*          ls_reparacion-prioridad = 'BAJA'.
*      ENDCASE.
*      APPEND ls_reparacion TO lt_reparacion.
*    ENDDO.
*
*    LOOP AT lt_reparacion ASSIGNING FIELD-SYMBOL(<fs_reparacion>)
*        WHERE prioridad = 'URGENTE'.
*      <fs_reparacion>-coste = <fs_reparacion>-coste +
*                                    ( <fs_reparacion>-coste * '0.15' ).
*    ENDLOOP.
*
*    LOOP AT lt_reparacion INTO ls_reparacion.
*      out->write( |El ID { ls_reparacion-id_reparacion } tiene un coste final de { ls_reparacion-coste } y la prioridad es: { ls_reparacion-prioridad }| ).
*      IF ls_reparacion-prioridad = 'URGENTE'.
*        lv_contador_urgentes = lv_contador_urgentes + 1.
*      ENDIF.
*    ENDLOOP.
*    out->write( |Las reparaciones en estado 'URGENTE' son un total de: { lv_contador_urgentes }| ).

*4. (Muy muy muy difícil) — El centro de control de una carrera de relevos
*Declara con TYPES/DATA una estructura ty_corredor con los campos
*    dorsal (entero),
*    tiempo_vuelta (decimal),
*    equipo (texto)
*    y estado (texto),
*
*    y su tabla lt_corredores.
*
*    Usando DO 10 TIMES, genera corredores donde
*        dorsal sea el número de vuelta,
*            tiempo_vuelta sea el resultado de 50 menos el número de vuelta
*                multiplicado por 1.25 (para que varíen los tiempos),
*            equipo se calcule con CASE sobre el resto de dividir el dorsal entre 2
*                ('ROJO' si es par, 'AZUL' si es impar),
*             y estado se deje inicialmente vacío.
*
*    Añade cada corredor con APPEND.
*
*    Después, usando LOOP AT ... ASSIGNING sin filtro, recorre toda la tabla y,
*    con un IF anidado combinando condiciones lógicas, actualiza estado directamente
*    sobre la fila original:
*        si tiempo_vuelta es menor que 40 Y el equipo es 'ROJO', asigna 'CLASIFICADO';
*        si tiempo_vuelta es menor que 40 Y el equipo es 'AZUL', asigna 'CLASIFICADO' también,
*            pero antes de asignarlo comprueba con un READ TABLE (por dorsal, usando declaración inline)
*            si ya existe un corredor del equipo 'ROJO' con un tiempo_vuelta mejor (menor);
*                si es así, asigna en su lugar 'DESCALIFICADO POR EQUIPO'.
*
*        Para cualquier otro caso, asigna 'ELIMINADO'.
*
*        Al terminar, recorre la tabla de nuevo con
*            LOOP AT ... WHERE estado = 'CLASIFICADO' y muestra con
*            pipes el resumen de los clasificados,
*            junto con un contador final de cuántos corredores de cada
*            equipo ('ROJO' y 'AZUL') lograron clasificarse.

    TYPES: BEGIN OF ty_corredor,
             dorsal        TYPE i,
             tiempo_vuelta TYPE p LENGTH 5 DECIMALS 2,
             equipo        TYPE string,
             estado        TYPE string,
           END OF ty_corredor.

    DATA ls_corredor TYPE ty_corredor.
    DATA lt_corredor TYPE TABLE OF ty_corredor.

    DO 10 TIMES.
      ls_corredor-dorsal = sy-index.
      ls_corredor-tiempo_vuelta = 45 - ( sy-index * '1.25' ).

      IF sy-index > 8.
        ls_corredor-tiempo_vuelta += 5.
      ENDIF.

      DATA(lv_resto) = sy-index MOD 2.
      CASE lv_resto.
        WHEN 0.
          ls_corredor-equipo = 'ROJO'.
        WHEN 1.
          ls_corredor-equipo = 'AZUL'.
      ENDCASE.

      APPEND ls_corredor TO lt_corredor.

    ENDDO.

*    Después, usando LOOP AT ... ASSIGNING sin filtro, recorre toda la tabla y,
*    con un IF anidado combinando condiciones lógicas, actualiza estado directamente
*    sobre la fila original:
*        si tiempo_vuelta es menor que 40 Y el equipo es 'ROJO', asigna 'CLASIFICADO';
*        si tiempo_vuelta es menor que 40 Y el equipo es 'AZUL', asigna 'CLASIFICADO' también,
*            pero antes de asignarlo comprueba con un READ TABLE (por dorsal, usando declaración inline)
*            si ya existe un corredor del equipo 'ROJO' con un tiempo_vuelta mejor (menor);
*                si es así, asigna en su lugar 'DESCALIFICADO POR EQUIPO'.
*
*        Para cualquier otro caso, asigna 'ELIMINADO'.

    SORT lt_corredor BY tiempo_vuelta ASCENDING.

    LOOP AT lt_corredor ASSIGNING FIELD-SYMBOL(<fs_corredor>).
      IF <fs_corredor>-tiempo_vuelta < 40.
        READ TABLE lt_corredor ASSIGNING FIELD-SYMBOL(<fs_clasificado>)
          WITH KEY equipo = <fs_corredor>-equipo
                   estado = 'CLASIFICADO'.
        IF sy-subrc = 0.
          IF <fs_clasificado>-tiempo_vuelta < <fs_corredor>-tiempo_vuelta.
            <fs_corredor>-estado = 'DESCALIFICADO POR EQUIPO'.
          ELSE.
            <fs_corredor>-estado = 'CLASIFICADO'.
*            <fs_clasificado>-estado = 'DESCALIFICADO POR EQUIPO'.
          ENDIF.

        ELSE.
          <fs_corredor>-estado = 'CLASIFICADO'.
        ENDIF.

      ELSE.
        <fs_corredor>-estado = 'ELIMINADO'.
      ENDIF.
    ENDLOOP.

    LOOP AT lt_corredor INTO ls_corredor
        WHERE estado = 'CLASIFICADO'.
      out->write( ls_corredor ).
    ENDLOOP.

    out->write( lt_corredor ).

  ENDMETHOD.
ENDCLASS.
