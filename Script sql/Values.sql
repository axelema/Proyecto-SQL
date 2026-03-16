
USE departamento_compras;

-- ROLES
INSERT INTO departamento_compras.rol (nombre_rol) VALUES
('Analista de Compras'),
('Comprador Senior'),
('Jefe de Compras'),
('Gerente de Abastecimiento'),
('Administrador del Sistema');


-- PERSONAL
INSERT INTO departamento_compras.personal (nombre_completo, celular, mail) VALUES
('Lucas Fernandez','+5491154321123','lfernandez@empresa.com'),
('Mariana Gomez','+5491165432234','mgomez@empresa.com'),
('Santiago Perez','+5491143327788','sperez@empresa.com'),
('Carolina Lopez','+5491167789911','clopez@empresa.com'),
('Martin Diaz','+5491155564433','mdiaz@empresa.com'),
('Florencia Rios','+5491148891122','frios@empresa.com'),
('Juan Cabrera','+5491162213344','jcabrera@empresa.com'),
('Paula Torres','+5491133345566','ptorres@empresa.com');


-- PROVEEDORES
INSERT INTO departamento_compras.proveedor (cuit, razon_social) VALUES
('30-71234567-1','Tech Solutions SA'),
('30-70888999-2','Servicios Industriales SRL'),
('30-70123456-3','Global Supply SA'),
('30-70999888-4','Infraestructura y Obras SRL'),
('30-70555444-5','Equipamientos Comerciales SA'),
('30-70666777-6','Consultoria Energética SA'),
('30-70777888-7','Sistemas Integrados SRL'),
('30-70444333-8','Logistica Empresarial SA');


-- CATEGORIAS DE PERMISOS (montos en ars)
INSERT INTO departamento_compras.categoria_permisos (categoria, monto_permitido) VALUES
('A',50000.00),
('B',200000.00),
('C',1000000.00),
('D',5000000.00),
('E',20000000.00); 


-- ROL PERSONAL
INSERT INTO departamento_compras.rol_personal (id_rol, id_personal, fecha_baja) VALUES
(1,1,NULL),
(1,2,NULL),
(2,3,NULL),
(2,4,NULL),
(3,5,NULL),
(4,6,NULL),
(1,7,NULL),
(2,8,NULL);


-- SUB AREA DE COMPRAS
INSERT INTO departamento_compras.sub_area (id_rol_personal, descripcion) VALUES
(1,'Compras IT'),
(2,'Compras Mobiliario'),
(3,'Compras Infraestructura'),
(4,'Compras Servicios Generales'),
(5,'Compras Obras Civiles'),
(6,'Compras Energia'),
(7,'Compras Software'),
(8,'Compras Logistica');


-- MATERIALES
INSERT INTO departamento_compras.material (id_sub_area, descripcion) VALUES
(1,'Notebook corporativa'),
(1,'Monitor 24 pulgadas'),
(7,'Licencia Microsoft 365'),
(7,'Licencia Power BI Pro'),
(2,'Silla ergonomica'),
(2,'Escritorio operativo'),
(3,'Cableado estructurado'),
(3,'Rack de servidores'),
(4,'Servicio limpieza oficinas'),
(4,'Servicio mantenimiento edilicio'),
(5,'Servicio obra civil menor'),
(5,'Material construccion liviana'),
(6,'Suministro energia renovable'),
(6,'Consultoria mercado electrico'),
(8,'Servicio transporte interno'),
(8,'Servicio logistica proveedores');


-- OCs
INSERT INTO departamento_compras.OC 
(oc, descripcion_global, precio_total, id_proveedor, id_rol_personal, id_sub_area) VALUES
('4590001001','Compra notebooks para renovacion parque IT',1850000.00,1,1,1),
('4590001002','Compra monitores area editorial',950000.00,1,1,1),
('4590001003','Adquisicion licencias Microsoft 365',720000.00,7,7,7),
('4590001004','Servicio limpieza oficinas edificio central',540000.00,2,4,4),
('4590001005','Servicio mantenimiento edilicio trimestral',890000.00,2,4,4),
('4590001006','Compra sillas ergonomicas sector administrativo',670000.00,5,2,2),
('4590001007','Compra escritorios operativos redaccion',820000.00,5,2,2),
('4590001008','Servicio cableado estructurado piso 4',1250000.00,3,3,3),
('4590001009','Provision rack servidores datacenter',2100000.00,3,3,3),
('4590001010','Servicio mantenimiento obra civil playon',980000.00,4,5,5),
('4590001011','Compra materiales construccion ampliacion',1650000.00,4,5,5),
('4590001012','Consultoria mercado electrico anual',435000.00,6,6,6),
('4590001013','Provision energia renovable periodo anual',3200000.00,6,6,6),
('4590001014','Servicio transporte interno proveedores',540000.00,8,8,8),
('4590001015','Servicio logistica traslado equipos',780000.00,8,8,8),
('4590001016','Compra notebooks sector comercial',1450000.00,1,1,1),
('4590001017','Compra monitores sector marketing',860000.00,1,1,1),
('4590001018','Licencias Power BI corporativas',390000.00,7,7,7),
('4590001019','Servicio limpieza oficinas sucursal norte',410000.00,2,4,4),
('4590001020','Servicio mantenimiento edilicio sucursal oeste',730000.00,2,4,4),
('4590001021','Compra sillas operativas call center',590000.00,5,2,2),
('4590001022','Compra escritorios area comercial',740000.00,5,2,2),
('4590001023','Instalacion cableado estructurado sector ventas',1120000.00,3,3,3),
('4590001024','Provision rack servidores respaldo',1980000.00,3,3,3),
('4590001025','Servicio obra civil adecuacion oficinas',1250000.00,4,5,5),
('4590001026','Compra materiales ampliacion deposito',1780000.00,4,5,5),
('4590001027','Consultoria energia renovable adicional',380000.00,6,6,6),
('4590001028','Provision energia renovable trimestre',980000.00,6,6,6),
('4590001029','Servicio transporte interno materiales',460000.00,8,8,8),
('4590001030','Servicio logistica traslado mobiliario',620000.00,8,8,8);


-- Permisos
INSERT INTO departamento_compras.permisos
(id_categoria, id_rol_personal, fecha_de_baja)
VALUES
(1, 1, NULL),
(1, 2, NULL),
(2, 3, NULL),
(2, 4, NULL),
(4, 5, NULL),
(5, 6, NULL),
(1, 7, NULL),
(3, 8, NULL);


-- Aprobacion OC aprobadas
INSERT INTO departamento_compras.aprobacion_oc
(id_permisos_aprobador, oc, aprobado)
VALUES
(1, '4590001001', 1),
(3, '4590001003', 1),
(5, '4590001005', 1),
(7, '4590001007', 1),
(1, '4590001009', 1),
(3, '4590001011', 1),
(5, '4590001013', 1),
(7, '4590001015', 1),
(1, '4590001017', 1),
(3, '4590001019', 1);


-- Aprobacion OC no aprobadas
INSERT INTO departamento_compras.aprobacion_oc
(id_permisos_aprobador, oc)
VALUES
(2, '4590001002'),
(4, '4590001004'),
(6, '4590001006'),
(8, '4590001008'),
(2, '4590001010'),
(4, '4590001012'),
(6, '4590001014'),
(8, '4590001016'),
(2, '4590001018'),
(4, '4590001020');


-- OC_POS
INSERT INTO departamento_compras.OC_POS
(oc, pos, descripcion, codigo_material, precio, cantidad, fecha_de_entrega)
VALUES
('4590001001','10','Notebook corporativa Lenovo 14 pulgadas',1000,925000.00,2.00,'2026-01-20'),
('4590001002','10','Monitor LED 24 pulgadas Samsung',1001,190000.00,5.00,'2026-01-22'),
('4590001003','10','Licencia Microsoft 365 Business Standard',1002,72000.00,10.00,'2026-01-18'),
('4590001004','10','Servicio mensual de limpieza integral oficinas',1008,540000.00,1.00,'2026-01-15'),
('4590001005','10','Servicio mantenimiento edilicio enero',1009,296666.67,1.00,'2026-01-15'),
('4590001005','20','Servicio mantenimiento edilicio febrero',1009,296666.67,1.00,'2026-02-15'),
('4590001005','30','Servicio mantenimiento edilicio marzo',1009,296666.66,1.00,'2026-03-15'),
('4590001006','10','Silla ergonomica respaldo alto',1004,134000.00,5.00,'2026-01-25'),
('4590001007','10','Escritorio operativo 140x70 cm',1005,205000.00,4.00,'2026-01-28'),
('4590001008','10','Cableado estructurado piso 4 - categoria 6',1006,1250000.00,1.00,'2026-02-05'),
('4590001009','10','Rack de servidores 42U datacenter',1007,1050000.00,2.00,'2026-02-10'),
('4590001010','10','Servicio obra civil menor en playon',1010,980000.00,1.00,'2026-02-01'),

('4590001011','10','Material construccion liviana para ampliacion',1011,825000.00,2.00,'2026-02-03'),
('4590001012','10','Consultoria mercado electrico - etapa diagnostico',1013,217500.00,1.00,'2026-01-19'),
('4590001012','20','Consultoria mercado electrico - informe final',1013,217500.00,1.00,'2026-01-30'),
('4590001013','10','Suministro energia renovable enero',1012,800000.00,1.00,'2026-01-31'),
('4590001013','20','Suministro energia renovable febrero',1012,800000.00,1.00,'2026-02-28'),
('4590001013','30','Suministro energia renovable marzo',1012,800000.00,1.00,'2026-03-31'),
('4590001013','40','Ajuste estimado suministro energia renovable',1012,800000.00,1.00,'2026-04-30'),
('4590001014','10','Servicio transporte interno de insumos',1014,270000.00,2.00,'2026-01-24'),
('4590001015','10','Servicio logistica traslado equipos tramo 1',1015,390000.00,1.00,'2026-01-26'),
('4590001015','20','Servicio logistica traslado equipos tramo 2',1015,390000.00,1.00,'2026-01-29'),
('4590001016','10','Notebook corporativa HP Probook',1000,725000.00,2.00,'2026-02-02'),
('4590001017','10','Monitor LED 24 pulgadas LG',1001,172000.00,5.00,'2026-02-04'),
('4590001018','10','Licencia Power BI Pro anual',1003,39000.00,10.00,'2026-01-21'),
('4590001019','10','Servicio limpieza oficinas sucursal norte',1008,410000.00,1.00,'2026-01-25'),
('4590001020','10','Mantenimiento edilicio sucursal oeste - enero',1009,365000.00,1.00,'2026-01-31'),
('4590001020','20','Mantenimiento edilicio sucursal oeste - febrero',1009,365000.00,1.00,'2026-02-28'),

('4590001021','10','Silla operativa call center',1004,118000.00,5.00,'2026-02-06'),
('4590001022','10','Escritorio area comercial 140x70 cm',1005,185000.00,4.00,'2026-02-08'),
('4590001023','10','Instalacion cableado estructurado sector ventas',1006,1120000.00,1.00,'2026-02-15'),
('4590001024','10','Rack de servidores respaldo 42U',1007,990000.00,2.00,'2026-02-18'),
('4590001025','10','Servicio obra civil adecuacion oficinas planta baja',1010,625000.00,2.00,'2026-02-20'),
('4590001026','10','Material ampliacion deposito - perfileria y placas',1011,890000.00,2.00,'2026-02-22'),
('4590001027','10','Consultoria energia renovable adicional - analisis',1013,190000.00,2.00,'2026-02-12'),
('4590001028','10','Suministro energia renovable abril',1012,490000.00,1.00,'2026-04-30'),
('4590001028','20','Suministro energia renovable mayo',1012,490000.00,1.00,'2026-05-31'),
('4590001029','10','Servicio transporte interno materiales obra',1014,230000.00,2.00,'2026-02-14'),
('4590001030','10','Servicio logistica traslado mobiliario tramo unico',1015,620000.00,1.00,'2026-02-16');



-- Como inserte registros en la tabla OC antes de crear el trigger de registros automaticos en la tabla modificacion_OC, inserto esos registros ya existentes
INSERT INTO departamento_compras.modificacion_oc (oc,Precio_total,fecha_de_modificacion,id_rol_personal)
SELECT OC, precio_total, current_timestamp(), id_rol_personal
FROM oc;



-- Como inserte registros en la tabla OC_pos antes de crear el trigger de registros automaticos en la tabla modificacion_OC_POS, inserto esos registros ya existentes
INSERT INTO departamento_compras.modificacion_oc_pos (id_oc_pos,fecha_de_modificacion,precio,cantidad,fecha_de_entrega)
SELECT id_oc_pos, CURRENT_DATE(), precio, cantidad,fecha_de_entrega
FROM oc_pos;
*/
