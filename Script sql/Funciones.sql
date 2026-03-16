

-- Funcion contar posiciones: Cuenta la cantidad de posiciones de una orden de compra
DELIMITER $$

DROP FUNCTION IF EXISTS departamento_compras.fn_cant_de_posiciones $$

CREATE FUNCTION departamento_compras.fn_cant_de_posiciones(
    p_oc VARCHAR(15)
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_cantidad INT;

    SELECT COUNT(*)
    INTO v_cantidad
    FROM departamento_compras.oc_pos
    WHERE oc = p_oc;

    RETURN v_cantidad;

END $$

DELIMITER ;


-- Funcion cantidad de dias para entregar: devuelve la cantidad de dias que tiene un pedido para ser entregado
DELIMITER $$

DROP FUNCTION IF EXISTS departamento_compras.fn_dias_hasta_entrega $$

CREATE FUNCTION departamento_compras.fn_dias_hasta_entrega(
    p_oc VARCHAR(15)
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_fecha_entrega DATE;
    DECLARE v_dias INT;

    SELECT MIN(fecha_de_entrega)
    INTO v_fecha_entrega
    FROM departamento_compras.oc_pos
    WHERE oc = p_oc;

    IF v_fecha_entrega IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'OC invalida o sin fechas de entrega';
    END IF;

    SET v_dias = DATEDIFF(v_fecha_entrega, CURRENT_DATE());

    RETURN v_dias;

END $$

DELIMITER ;
