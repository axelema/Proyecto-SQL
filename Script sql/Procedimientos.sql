/*

-- Procedimiento actualizacion de fecha de entrega: Se utiliza para actualizar fechas de entrega de ordenes de compra de forma que no se inserten registros ilogicos
DELIMITER $$

DROP PROCEDURE IF EXISTS departamento_compras.actualizacion_de_fecha_de_entrega $$

CREATE PROCEDURE departamento_compras.actualizacion_de_fecha_de_entrega(
    IN p_id_oc_pos VARCHAR(70),
    IN p_fecha_de_entrega DATE
)
BEGIN
    DECLARE v_fecha_de_doc DATE;

    IF p_id_oc_pos IS NULL OR TRIM(p_id_oc_pos) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Debe ingresar un id_oc_pos valido';
    END IF;

    SELECT DATE(o.fecha_de_doc)
    INTO v_fecha_de_doc
    FROM departamento_compras.oc_pos op
    JOIN departamento_compras.oc o
        ON op.oc = o.oc
    WHERE op.id_oc_pos = p_id_oc_pos;

    IF v_fecha_de_doc IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No existe la combinacion OC_POS';
    END IF;

    IF p_fecha_de_entrega < v_fecha_de_doc THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de entrega no puede ser menor a la fecha de documento';
    ELSE
        UPDATE departamento_compras.oc_pos
        SET fecha_de_entrega = p_fecha_de_entrega
        WHERE id_oc_pos = p_id_oc_pos;
    END IF;

    SELECT
        op.oc,
        op.pos,
        DATE(o.fecha_de_doc) AS fecha_de_doc,
        op.descripcion,
        pr.razon_social,
        op.fecha_de_entrega
    FROM departamento_compras.oc_pos op
    JOIN departamento_compras.oc o
        ON op.oc = o.oc
    JOIN departamento_compras.proveedor pr
        ON o.id_proveedor = pr.id_proveedor
    WHERE op.id_oc_pos = p_id_oc_pos;

END $$

DELIMITER ;


-- Procedimiento actualizacion mail personal: Actualizar mails del personal de manera logica
DELIMITER $$

DROP PROCEDURE IF EXISTS departamento_compras.actualizar_mail_personal $$

CREATE PROCEDURE departamento_compras.actualizar_mail_personal(
    IN p_id_personal INT,
    IN p_nuevo_mail VARCHAR(50)
)
BEGIN
    DECLARE v_existe_personal INT;
    DECLARE v_mail_actual VARCHAR(50);

    IF p_nuevo_mail IS NULL OR TRIM(p_nuevo_mail) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El mail no puede estar vacio';
    END IF;

    SELECT COUNT(*)
    INTO v_existe_personal
    FROM departamento_compras.personal
    WHERE id_personal = p_id_personal;

    IF v_existe_personal = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No existe el personal indicado';
    END IF;

    SELECT mail
    INTO v_mail_actual
    FROM departamento_compras.personal
    WHERE id_personal = p_id_personal;

    IF p_nuevo_mail = v_mail_actual THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El nuevo mail no puede ser igual al mail actual';
    END IF;

    UPDATE departamento_compras.personal
    SET mail = p_nuevo_mail
    WHERE id_personal = p_id_personal;

    SELECT
        id_personal,
        nombre_completo,
        celular,
        mail
    FROM departamento_compras.personal
    WHERE id_personal = p_id_personal;

END $$

DELIMITER ;