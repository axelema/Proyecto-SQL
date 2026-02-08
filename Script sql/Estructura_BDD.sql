CREATE DATABASE IF NOT EXISTS departamento_compras;
USE departamento_compras;

CREATE TABLE IF NOT EXISTS departamento_compras.rol(
id_rol INT AUTO_INCREMENT NOT NULL,
nombre_rol VARCHAR(50) NOT NULL UNIQUE,
CONSTRAINT Pk_rol PRIMARY KEY (id_rol)
);

CREATE TABLE IF NOT EXISTS departamento_compras.personal(
id_personal INT AUTO_INCREMENT NOT NULL,
nombre_completo VARCHAR(50) NOT NULL,
celular VARCHAR(50) NOT NULL UNIQUE,
mail VARCHAR(50) NOT NULL UNIQUE,
CONSTRAINT pk_personal PRIMARY KEY(id_personal)
);

CREATE TABLE IF NOT EXISTS departamento_compras.proveedor(
id_proveedor INT AUTO_INCREMENT NOT NULL,
cuit VARCHAR(50) NOT NULL UNIQUE,
razon_social VARCHAR(50) NOT NULL UNIQUE,
CONSTRAINT pk_proveedor PRIMARY KEY(id_proveedor)
);

CREATE TABLE IF NOT EXISTS departamento_compras.categoria_permisos(
id_categoria INT AUTO_INCREMENT NOT NULL,
categoria VARCHAR(10) UNIQUE,
monto_permitido DECIMAL(18,2),
CONSTRAINT pk_categoria PRIMARY KEY(id_categoria)
);

CREATE TABLE IF NOT EXISTS departamento_compras.rol_personal(
id_rol_personal INT AUTO_INCREMENT NOT NULL,
id_rol INT NOT NULL,
id_personal INT NOT NULL,
fecha_alta DATE NOT NULL,
fecha_baja DATE,
CONSTRAINT pk_rol_personal PRIMARY KEY(id_rol_personal),
CONSTRAINT FK_rol FOREIGN KEY (id_rol) REFERENCES departamento_compras.rol (id_rol),
CONSTRAINT FK_personal FOREIGN KEY (id_personal) REFERENCES departamento_compras.personal (id_personal)
);

CREATE TABLE IF NOT EXISTS departamento_compras.sub_area(
id_sub_area INT AUTO_INCREMENT NOT NULL,
id_rol_personal INT NOT NULL,
descripcion VARCHAR(100) NOT NULL UNIQUE,
CONSTRAINT pk_sub_area PRIMARY KEY(id_sub_area),
CONSTRAINT fk_rol_personal FOREIGN KEY (id_rol_personal) REFERENCES departamento_compras.rol_personal (id_rol_personal)
);

CREATE TABLE IF NOT EXISTS departamento_compras.material(
codigo_material INT AUTO_INCREMENT NOT NULL,
id_sub_area INT NOT NULL,
descripcion VARCHAR(100) NOT NULL UNIQUE,
CONSTRAINT pk_material PRIMARY KEY(codigo_material),
CONSTRAINT fk_sub_area FOREIGN KEY(id_sub_area) REFERENCES departamento_compras.sub_area (id_sub_area)
)AUTO_INCREMENT = 1000;

CREATE TABLE IF NOT EXISTS departamento_compras.OC(
oc VARCHAR(15) NOT NULL,
fecha_de_doc DATE NOT NULL,
descripcion_global VARCHAR(100) NOT NULL,
precio_total DECIMAL(18,2) NOT NULL,
id_proveedor INT NOT NULL,
id_rol_personal INT NOT NULL,
id_sub_area INT NOT NULL,
CONSTRAINT pk_oc PRIMARY KEY(oc),
CONSTRAINT fk_proveedor FOREIGN KEY(id_proveedor) REFERENCES departamento_compras.proveedor (id_proveedor), 
CONSTRAINT fk_rol_personal2 FOREIGN KEY(id_rol_personal) REFERENCES departamento_compras.rol_personal (id_rol_personal),
CONSTRAINT fk_sub_area2 FOREIGN KEY(id_sub_area) REFERENCES departamento_compras.sub_area (id_sub_area)
);

CREATE TABLE IF NOT EXISTS departamento_compras.OC_POS(
oc VARCHAR(15) NOT NULL,
pos VARCHAR(50) NOT NULL,
id_oc_pos VARCHAR(70) GENERATED ALWAYS AS (concat(oc,pos)) STORED,
descripcion VARCHAR(100) NOT NULL,
codigo_material INT NOT NULL,
precio DECIMAL(18,2) NOT NULL,
cantidad DECIMAL(18,2) NOT NULL,
fecha_de_entrega DATE NOT NULL,
CONSTRAINT pk_oc_pos PRIMARY KEY(id_oc_pos),
CONSTRAINT fk_OC FOREIGN KEY (oc) REFERENCES departamento_compras.oc (oc),
CONSTRAINT fk_codigo_material FOREIGN KEY (codigo_material) REFERENCES departamento_compras.material (codigo_material)
);

CREATE TABLE IF NOT EXISTS departamento_compras.modificacion_OC(
id_modificacion_oc INT AUTO_INCREMENT NOT NULL,
oc VARCHAR(15) NOT NULL,
Precio_total DECIMAL(18,2) NOT NULL,
fecha_de_modificacion DATE NOT NULL,
id_rol_personal INT NOT NULL,
CONSTRAINT pk_modificacion_oc PRIMARY KEY(id_modificacion_oc),
CONSTRAINT fk_OC2 FOREIGN KEY (oc) REFERENCES departamento_compras.oc (oc),
CONSTRAINT fk_rol_personal3 FOREIGN KEY(id_rol_personal) REFERENCES departamento_compras.rol_personal (id_rol_personal)
);

CREATE TABLE IF NOT EXISTS departamento_compras.modificacion_oc_pos(
id_modificacion_oc_pos INT AUTO_INCREMENT NOT NULL,
id_rol_personal INT NOT NULL,
id_oc_pos VARCHAR(70) NOT NULL,
fecha_de_modificacion DATE NOT NULL,
precio DECIMAL(18,2) NOT NULL,
cantidad DECIMAL(18,2) NOT NULL,
fecha_de_entrega DATE NOT NULL,
CONSTRAINT pk_modificacion_oc_pos PRIMARY KEY(id_modificacion_oc_pos),
CONSTRAINT fk_rol_personal4 FOREIGN KEY(id_rol_personal) REFERENCES departamento_compras.rol_personal (id_rol_personal),
CONSTRAINT fk_oc_pos FOREIGN KEY(id_oc_pos) REFERENCES departamento_compras.oc_pos (id_oc_pos)
);

CREATE TABLE IF NOT EXISTS departamento_compras.permisos(
id_permisos_aprobador INT AUTO_INCREMENT NOT NULL,
id_categoria INT NOT NULL,
id_rol_personal INT NOT NULL,
fecha_de_alta DATE NOT NULL,
fecha_de_baja DATE,
CONSTRAINT pk_permisos PRIMARY KEY(id_permisos_aprobador),
CONSTRAINT fk_rol_personal5 FOREIGN KEY(id_rol_personal) REFERENCES departamento_compras.rol_personal (id_rol_personal),
CONSTRAINT fk_categoria FOREIGN KEY(id_categoria) REFERENCES departamento_compras.categoria_permisos (id_categoria)
);

CREATE TABLE IF NOT EXISTS departamento_compras.aprobacion_oc(
id_aprobacion INT AUTO_INCREMENT NOT NULL,
id_permisos_aprobador INT NOT NULL,
oc VARCHAR(15) NOT NULL,
fecha_de_aprobacion DATE NOT NULL,
precio_total DECIMAL(18,2),
id_categoria INT NOT NULL,
CONSTRAINT pk_aprobacion PRIMARY KEY(id_aprobacion),
CONSTRAINT fk_permisos_aprobador FOREIGN KEY(id_permisos_aprobador) REFERENCES departamento_compras.permisos (id_permisos_aprobador),
CONSTRAINT fk_OC3 FOREIGN KEY (oc) REFERENCES departamento_compras.oc (oc),
CONSTRAINT fk_categoria2 FOREIGN KEY(id_categoria) REFERENCES departamento_compras.categoria_permisos (id_categoria)
);