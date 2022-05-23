-- MySQL Workbench Forward Engineering
-- @Author: Jose felipe escobar jfejose10@gmail.com
-- created at 2022-05-22

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tienda_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tienda_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS  tienda_db  DEFAULT CHARACTER SET utf8 ;
USE  tienda_db  ;

-- -----------------------------------------------------
-- Table  tienda_db . proveedor 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  tienda_db . proveedor  (
   id_proveedor  INT NOT NULL AUTO_INCREMENT,
   nombre_proveedor  VARCHAR(80) NOT NULL,
  PRIMARY KEY ( id_proveedor ),
  UNIQUE INDEX  id_proveedor_UNIQUE  ( id_proveedor  ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table  tienda_db . producto 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  tienda_db . producto  (
   id_producto  INT NOT NULL AUTO_INCREMENT,
   proveedor_id_proveedor  INT NOT NULL,
   nombre_producto  VARCHAR(80) NOT NULL,
  PRIMARY KEY ( id_producto ),
  UNIQUE INDEX  id_producto_UNIQUE  ( id_producto  ASC) INVISIBLE,
  INDEX  fk_producto_proveedor  ( proveedor_id_proveedor  ASC) VISIBLE,
  CONSTRAINT  fk_producto_proveedor1 
    FOREIGN KEY ( proveedor_id_proveedor )
    REFERENCES  tienda_db . proveedor  ( id_proveedor )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table  tienda_db . cliente 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  tienda_db . cliente  (
   cliente_id  INT NOT NULL AUTO_INCREMENT,
   tipo_documento_cliente  VARCHAR(80) NOT NULL,
   numero_documento_cliente  INT NOT NULL,
  PRIMARY KEY ( cliente_id ),
  UNIQUE INDEX  numero_documento_cliente_UNIQUE  ( tipo_documento_cliente  ASC,  numero_documento_cliente  ASC) VISIBLE,
  UNIQUE INDEX  cliente_id_UNIQUE  ( cliente_id  ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table  tienda_db . factura_venta 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  tienda_db . factura_venta  (
   id_factura_venta  INT NOT NULL AUTO_INCREMENT,
   cliente_cliente_id  INT NOT NULL,
   producto_id_producto  INT NOT NULL,
   fecha_venta  DATE NULL,
   cantidad_items  INT UNSIGNED NOT NULL,
  PRIMARY KEY ( id_factura_venta ),
  INDEX  fk_factura_venta_cliente_id  ( cliente_cliente_id  ASC) VISIBLE,
  INDEX  fk_factura_venta_producto_id  ( producto_id_producto  ASC) VISIBLE,
  UNIQUE INDEX  id_factura_venta_UNIQUE  ( id_factura_venta  ASC) VISIBLE,
  CONSTRAINT  fk_factura_venta_cliente 
    FOREIGN KEY ( cliente_cliente_id )
    REFERENCES  tienda_db . cliente  ( cliente_id )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT  fk_factura_venta_producto1 
    FOREIGN KEY ( producto_id_producto )
    REFERENCES  tienda_db . producto  ( id_producto )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- -----------------------------------------------------
-- 2. INSERTAR INFORMACION
-- -----------------------------------------------------
-- cliente
insert into cliente ( tipo_documento_cliente, numero_documento_cliente) values ( 'CC', 1233560770);
insert into cliente ( tipo_documento_cliente, numero_documento_cliente) values ( 'TI', 1926951960);
insert into cliente ( tipo_documento_cliente, numero_documento_cliente) values ( 'CC', 1072127006);



-- producto
INSERT INTO producto ( proveedor_id_proveedor, nombre_producto) VALUE (1,'CONCENTRADO');
INSERT INTO producto ( proveedor_id_proveedor, nombre_producto) VALUE (2,'ARROZ');
INSERT INTO producto ( proveedor_id_proveedor, nombre_producto) VALUE (3,'LECHE');
INSERT INTO producto ( proveedor_id_proveedor, nombre_producto) VALUE (2,'FRIJOLES');
INSERT INTO producto ( proveedor_id_proveedor, nombre_producto) VALUE (2,'LENTEJAS');
INSERT INTO producto ( proveedor_id_proveedor, nombre_producto) VALUE (3,'QUESO');

-- PROVEEDOR
INSERT INTO proveedor ( nombre_proveedor) VALUE ('FINCA');
INSERT INTO proveedor ( nombre_proveedor) VALUE ('DIANA');
INSERT INTO proveedor ( nombre_proveedor) VALUE ('COLANTA');

-- FACTURA VENTA
INSERT INTO factura_venta ( cliente_cliente_id, producto_id_producto, fecha_venta, cantidad_items) VALUE (1,2,'2022-05-11',1);
INSERT INTO factura_venta ( cliente_cliente_id, producto_id_producto, fecha_venta, cantidad_items) VALUE (2,1,'2022-05-19',2);
INSERT INTO factura_venta ( cliente_cliente_id, producto_id_producto, fecha_venta, cantidad_items) VALUE (3,3,'2022-05-13',4);
INSERT INTO factura_venta ( cliente_cliente_id, producto_id_producto, fecha_venta, cantidad_items) VALUE (2,3,'2022-05-22',10);


-- -----------------------------------------------------
-- 3.1 BORRADO FISICO
-- -----------------------------------------------------

DELETE FROM factura_venta WHERE id_factura_venta=4;
DELETE FROM factura_venta WHERE fecha_venta='2022-05-22';


-- -----------------------------------------------------
-- 3.2 BORRADO LOGICO
-- -----------------------------------------------------
-- Todas las consultas de vistas se deben especificar que se muestren todos los
-- registros donde el "borrado_logico" sea igual a cero

ALTER TABLE factura_venta 
ADD COLUMN borrado_logico BIT NOT NULL DEFAULT 0;

UPDATE factura_venta 
SET borrado_logico = 1 WHERE id_factura_venta=4;

UPDATE factura_venta 
SET borrado_logico = 1 WHERE id_factura_venta=2;

-- consulta sin borrado logico
SELECT id_factura_venta FROM factura_venta ;

-- consulta con borrado logico implementado
SELECT nombre_producto FROM producto WHERE factura_venta.borrado_logico=0;

-- ----------------------------------------------------------------------------------------------------------------
-- 4. MODIFICAR NOMBRE Y EL ID DEL PROVEEDOR DEL PRODUCTO
-- ---------------------------------------------------------------------------------------------------------------
UPDATE  tienda_db . producto  SET  nombre_producto  = 'MAIZ PIRA',  proveedor_id_proveedor  = 3 WHERE ( id_producto  = 1) and ( proveedor_id_proveedor  = 2);                         
UPDATE  tienda_db . producto  SET  nombre_producto  = 'ACEITE DIANA',  proveedor_id_proveedor  = 1 WHERE ( id_producto  =5 ) and ( proveedor_id_proveedor  = 3);
UPDATE  tienda_db . producto  SET  nombreProducto  = 'YOGURT ARTESANAL',  proveedor_id_proveedor  = 3 WHERE ( id_producto  = 6) and ( proveedor_id_proveedor  = 1);



-- vistas rapaidas de los nombres de los productos 
CREATE VIEW views_productos AS
SELECT nombre_producto,id_producto FROM producto;
-- drop all tables
DROP VIEW vista_rapida;
DROP TABLE factura_venta, producto;--cliente,proveedor