/*
-- Creando trigger para actualizar el campo de Fecha_alta en tabla Rol_personal automaticamente cuando se insera un registro en el campo ID_PERSONAL
DELIMITER $$
CREATE TRIGGER actualizar_fecha
BEFORE INSERT ON departamento_compras.rol_personal 
FOR EACH ROW
BEGIN
	IF NEW.id_personal IS NOT NULL THEN
		SET NEW.fecha_alta = current_timestamp();
    END IF;
END$$
DELIMITER ;


-- Creando trigger para actualizar el campo de precio total en la tabla aprobacion_OC de manera automatica tomando el valor del precio en la tabla OC
-- Luego de tomado el precio, corre el segundo sub trigger que coloca la categoria correspondiente.
DELIMITER $$
CREATE TRIGGER precio_en_y_Categoria_en_Aprobacion_OC
BEFORE INSERT ON departamento_compras.aprobacion_oc
FOR EACH ROW
BEGIN
	DECLARE v_precio DECIMAL(18,2);
    DECLARE v_categoria INT;
    
    SELECT precio_total
    INTO v_precio
    FROM departamento_compras.oc
    WHERE oc = NEW.oc;
SET NEW.precio_total = v_precio;

    SELECT id_categoria
    INTO v_categoria
    FROM categoria_permisos
    WHERE monto_permitido <= NEW.precio_total
    ORDER BY monto_permitido DESC
    LIMIT 1;
SET NEW.id_categoria = v_categoria;

END$$
DELIMITER ;


-- Crendo trigger para que fecha_de_aprobacion tenga un valor cuando el campo de aprobacion es actualizado a true
DELIMITER $$
CREATE TRIGGER fecha_aprobacion_en_aprobacion_OC
BEFORE UPDATE ON departamento_compras.aprobacion_oc
FOR EACH ROW
BEGIN
	IF NEW.aprobado = 1 THEN
		SET NEW.fecha_de_aprobacion = current_timestamp();
    END IF;
END$$
DELIMITER ;


-- Crendo trigger para que fecha_de_aprobacion tenga un valor cuando el campo de aprobacion es insertado como true
DELIMITER $$
CREATE TRIGGER fecha_aprobacion_en_aprobacion_OC_insert
BEFORE INSERT ON departamento_compras.aprobacion_oc
FOR EACH ROW
BEGIN
	IF NEW.aprobado = 1 THEN
		SET NEW.fecha_de_aprobacion = current_timestamp();
    END IF;
END$$
DELIMITER ;


-- Creando trigger para insertar registros en tabla de transaccion modificacion_OC
DELIMITER $$
CREATE TRIGGER Insercion_de_campos_modificacion_OC
AFTER INSERT ON departamento_compras.OC
FOR EACH ROW
BEGIN
	INSERT INTO departamento_compras.modificacion_oc 
    ( 
    oc,
    Precio_total,
    fecha_de_modificacion,
    id_rol_personal
	)
    VALUES
    (
    NEW.oc,
    NEW.Precio_total,
    CURRENT_TIMESTAMP(),
    NEW.id_rol_personal
    );
END $$
DELIMITER ;


-- Creando trigger para actualizar registros en tabla de transaccion modificacion_OC
DELIMITER $$
CREATE TRIGGER Actualizacion_de_campos_modificacion_OC
AFTER UPDATE ON departamento_compras.oc
FOR EACH ROW
BEGIN
	INSERT INTO departamento_compras.modificacion_oc 
    ( 
    oc,
    Precio_total,
    fecha_de_modificacion,
    id_rol_personal
	)
    VALUES
    (
    NEW.oc,
    NEW.Precio_total,
    CURRENT_TIMESTAMP(),
    NEW.id_rol_personal
    );
END $$
DELIMITER ;


-- Creando trigger para insertar registros en tabla de transaccion modificacion_OC
DELIMITER $$
CREATE TRIGGER Insercion_de_campos_modificacion_oc_pos
AFTER INSERT ON departamento_compras.OC_POS
FOR EACH ROW
BEGIN
	INSERT INTO departamento_compras.modificacion_oc_pos
    ( 
    id_oc_pos,
    fecha_de_modificacion,
    precio,
    cantidad,
    fecha_de_entrega
	)
    VALUES
    (
    NEW.id_oc_pos,
    CURRENT_DATE(),
    NEW.precio,
    NEW.cantidad,
    NEW.fecha_de_entrega
    );
END $$
DELIMITER ;


-- Creando trigger para actualizar registros en tabla de transaccion modificacion_OC
DELIMITER $$
CREATE TRIGGER actualizacion_de_campos_modificacion_oc_pos
AFTER UPDATE ON departamento_compras.OC_POS
FOR EACH ROW
BEGIN
	INSERT INTO departamento_compras.modificacion_oc_pos
    ( 
    id_oc_pos,
    fecha_de_modificacion,
    precio,
    cantidad,
    fecha_de_entrega
	)
    VALUES
    (
    NEW.id_oc_pos,
    CURRENT_DATE(),
    NEW.precio,
    NEW.cantidad,
    NEW.fecha_de_entrega
    );
END $$
DELIMITER ;
*/