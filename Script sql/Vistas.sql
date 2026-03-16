/*

-- Vista aprobadores: Se utiliza para visualizar quienes son los responsables del circuito de aprobacion de las diferentes ordenes de compra
CREATE VIEW departamento_compras.aprobadores AS
SELECT
    a.id_rol_personal,
    f.nombre_completo AS `Nombre completo`,
    f.mail,
    f.celular,
    f.nombre_rol AS Puesto,
    f.descripcion AS Area,
    b.categoria,
    b.monto_permitido AS `Monto minimo`
FROM departamento_compras.permisos a
JOIN departamento_compras.categoria_permisos b
    ON a.id_categoria = b.id_categoria
JOIN (
    SELECT
        c.id_rol_personal,
        d.nombre_completo,
        d.mail,
        d.celular,
        e.nombre_rol,
        g.descripcion
    FROM departamento_compras.rol_personal c
    JOIN departamento_compras.personal d
        ON c.id_personal = d.id_personal
    JOIN departamento_compras.rol e
        ON c.id_rol = e.id_rol
    JOIN departamento_compras.sub_area g
        ON c.id_rol_personal = g.id_rol_personal
) f
    ON a.id_rol_personal = f.id_rol_personal
ORDER BY b.monto_permitido;


-- Vista cantidad de OCs x periodo: Vista que nos muestra la cantidad de ordenes de compra gestionadas aperturado por mes y por comprador.
CREATE VIEW departamento_compras.view_cant_ocs_por_periodo AS
SELECT
    d.nombre_completo,
    CAST(a.fecha_de_doc AS DATE) AS fecha_oc,
    MONTHNAME(a.fecha_de_doc) AS mes,
    COUNT(a.oc) AS cantidad_oc
FROM departamento_compras.oc a
JOIN (
    SELECT
        b.id_rol_personal,
        b.id_personal,
        c.nombre_completo
    FROM departamento_compras.rol_personal b
    JOIN departamento_compras.personal c
        ON b.id_personal = c.id_personal
) d
    ON a.id_rol_personal = d.id_rol_personal
GROUP BY
    d.nombre_completo,
    CAST(a.fecha_de_doc AS DATE),
    MONTHNAME(a.fecha_de_doc)
ORDER BY
    d.nombre_completo,
    CAST(a.fecha_de_doc AS DATE);
    
    
    -- Vista detalle de OC´s: Devuelve el detalle de las ordenes de compra vigentes. 
    CREATE VIEW departamento_compras.vw_detalle_oc AS
SELECT
    a.oc,
    a.pos,
    c.fecha_de_doc,
    d.razon_social,
    a.descripcion,
    a.codigo_material,
    a.precio,
    a.cantidad,
    a.precio * a.cantidad AS subtotal,
    a.fecha_de_entrega
FROM departamento_compras.oc_pos a
JOIN departamento_compras.oc c
    ON a.oc = c.oc
JOIN departamento_compras.proveedor d
    ON c.id_proveedor = d.id_proveedor;
