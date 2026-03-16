
-- Alter sobre fecha de doc de OC, para que el campo se actualice automaticamente durante la ingesta de datos
ALTER TABLE departamento_compras.oc
MODIFY COLUMN fecha_de_doc TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;	

				
-- Alter sobre fecha alta en tabla de permisos
ALTER TABLE departamento_compras.permisos
MODIFY COLUMN fecha_de_alta TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;


-- Alter para agregar una columna de aprobacion
ALTER TABLE departamento_compras.aprobacion_oc
ADD COLUMN Aprobado BOOLEAN;


-- Alter sobre fecha_de_aprobacion en tabla de aprobacion_OC
ALTER TABLE departamento_compras.aprobacion_oc
MODIFY COLUMN fecha_de_aprobacion DATE NOT NULL;


-- Alter para que aprobacion sea por default 0
ALTER TABLE departamento_compras.aprobacion_oc
MODIFY COLUMN Aprobado BOOLEAN DEFAULT 0;


-- Alter sobre fecha_de_aprobacion en tabla de aprobacion_OC para que sea nulo (ya que puede serlo si no esta aprobada la OC)
ALTER TABLE departamento_compras.aprobacion_oc
MODIFY COLUMN fecha_de_aprobacion DATE;


-- Alter sobre la tabla modificacion_oc_pos para borrar la FK de id_rol_personal
ALTER TABLE departamento_compras.modificacion_oc_pos
DROP FOREIGN KEY fk_rol_personal4;


-- Alter sobre la tabla modificacion_oc_pos para borrar el campo de id_rol_personal
ALTER TABLE departamento_compras.modificacion_oc_pos
DROP COLUMN id_rol_personal;
*/
