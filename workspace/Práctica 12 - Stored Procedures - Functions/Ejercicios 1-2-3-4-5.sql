# 1) Crear un procedimiento almacenado llamado plan_lista_precios_actual que devuelva los
# planes de capacitación indicando: nom_plan, modalidad, valor_actual

call plan_lista_precios_actual();

############

# 2) Crear un procedimiento almacenado llamado plan_lista_precios_a_fecha que dada una fecha devuelva
# los planes de capacitación indicando: nombre_plan, modalidad, valor_a_fecha

select curdate() into @fecha; # Podría ser cualquier fecha, en este caso pongo la actual
call plan_lista_precios_a_fecha(@fecha);

############

# 3) Modificar el procedimiento almacenado creado en 1) para que internamente invoque al
# procedimiento creado en 2).

call plan_lista_precios_actual_modificado();

############

# 4) Crear una función llamada plan_valor que reciba el nombre del plan y una fecha y devuelva
# el valor de dicho plan a esa fecha.

select 'Marketing 2' into @plan; select curdate() into @fecha;
select plan_valor(@plan, @fecha) as plan_valor;

# 5) Modifique el procedimiento almacenado creado en 2) para que internamente utilice la función creada en 4).

select curdate() into @fecha;
call plan_lista_precios_a_fecha_modificado(@fecha);
