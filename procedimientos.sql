use empresa_funciones;
delimiter //

create procedure AñadirProducto(
	in p_nombre varchar(100),
	in p_precio decimal(10, 2)
)
BEGIN
	-- Creamos una variable entera y le damos el valor 0 por defecto
    DECLARE v_existe INT DEFAULT 0;
    IF p_precio < 0 THEN
        SET p_precio = 0;
    END IF;
    SELECT COUNT(*) INTO v_existe 
    FROM productos 
    WHERE nombre = p_nombre;
    IF v_existe > 0 THEN
        -- Si existe, solo mostramos el mensaje (al hacer un SELECT, MySQL lo muestra por pantalla)
        SELECT 'El producto ya existe' AS Mensaje;
        
    ELSE
        -- Si no existe, hacemos el INSERT normal
        INSERT INTO productos (nombre, precio) 
        VALUES (p_nombre, p_precio);

        -- Mostramos el mensaje final. 
        -- LAST_INSERT_ID() es una función de MySQL que te devuelve el 'id' del último INSERT que acabas de hacer.
        SELECT CONCAT('La inserción se ha realizado correctamente. ID del producto: ', LAST_INSERT_ID()) AS Mensaje;
        
    END IF;

end //

delimiter ;


call AñadirProducto('cargador',25);
