-- @Author: Jose felipe escobar jfejose10@gmail.com
-- created at 2022-05-25


-- -----------------------------------------------------
-- Schema tienda_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS  tienda_db  DEFAULT CHARACTER SET utf8mb4 ;
USE  tienda_db  ;

-- -----------------------------------------------------
-- Table  tienda_db . proveedor 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  tienda_db . proveedor  (
   id_proveedor  INT NOT NULL AUTO_INCREMENT,
   nombre_proveedor  VARCHAR(80) NOT NULL,
  PRIMARY KEY ( id_proveedor ),
  UNIQUE INDEX  nombre_proveedor_UNIQUE  ( nombre_proveedor  ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table  tienda_db . producto 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  tienda_db . producto  (
   id_producto  INT NOT NULL AUTO_INCREMENT,
   proveedor_id_proveedor  INT NOT NULL,
   nombre_producto  VARCHAR(80) NOT NULL,
  PRIMARY KEY ( id_producto ),
  INDEX  fk_producto_proveedor_id  ( proveedor_id_proveedor  ASC) INVISIBLE,
  UNIQUE INDEX  nombre_producto_UNIQUE  ( nombre_producto  ASC) VISIBLE,
  CONSTRAINT  fk_producto_proveedor1 
    FOREIGN KEY ( proveedor_id_proveedor )
    REFERENCES  tienda_db . proveedor  ( id_proveedor )
    ON DELETE NO ACTION
    ON UPDATE CASCADE )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table  tienda_db . cliente 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  tienda_db . cliente 
(
     cliente_id                INT         NOT NULL AUTO_INCREMENT,
     tipo_documento_cliente    VARCHAR(80) NOT NULL,
     numero_documento_cliente  INT         NOT NULL,
    PRIMARY KEY ( cliente_id ),
    UNIQUE INDEX  numero_documento_cliente_UNIQUE  ( tipo_documento_cliente  ASC,  numero_documento_cliente  ASC) INVISIBLE
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table  tienda_db . factura_venta 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  tienda_db . factura_venta  (
   id_factura_venta  INT NOT NULL AUTO_INCREMENT,
   cliente_cliente_id  INT NOT NULL,
   fecha_venta  DATE NULL,
  PRIMARY KEY ( id_factura_venta ),
  INDEX  fk_factura_venta_cliente_id  ( cliente_cliente_id  ASC) VISIBLE,
  CONSTRAINT  fk_factura_venta_cliente1 
    FOREIGN KEY ( cliente_cliente_id )
    REFERENCES  tienda_db . cliente  ( cliente_id )
    ON DELETE NO ACTION
    ON UPDATE CASCADE )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table  tienda_db . venta_producto 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  tienda_db . venta_producto  (
   id_venta_prdoducto  INT NOT NULL AUTO_INCREMENT,
   producto_id_producto  INT NOT NULL,
   factura_venta_id_factura_venta  INT NOT NULL,
   cantidad_items  INT NOT NULL,
  PRIMARY KEY ( id_venta_prdoducto ),
  INDEX  fk_venta_producto_id_producto  ( producto_id_producto  ASC) INVISIBLE,
  INDEX  fk_venta_producto_id_factura_venta  ( factura_venta_id_factura_venta  ASC) VISIBLE,
  UNIQUE INDEX  producto_id_producto_UNIQUE  ( producto_id_producto  ASC,  factura_venta_id_factura_venta  ASC) VISIBLE,
  CONSTRAINT  fk_venta_producto_producto1 
    FOREIGN KEY ( producto_id_producto )
    REFERENCES  tienda_db . producto  ( id_producto )
    ON DELETE NO ACTION
    ON UPDATE CASCADE ,
  CONSTRAINT  fk_venta_producto_factura_venta1 
    FOREIGN KEY ( factura_venta_id_factura_venta )
    REFERENCES  tienda_db . factura_venta  ( id_factura_venta )
    ON DELETE NO ACTION
    ON UPDATE CASCADE
)
ENGINE = InnoDB;





-- -----------------------------------------------------
-- 2. INSERTAR INFORMACION
-- -----------------------------------------------------
-- cliente
insert into cliente ( tipo_documento_cliente, numero_documento_cliente) values ( 'CC', 1233560770);
insert into cliente ( tipo_documento_cliente, numero_documento_cliente) values ( 'TI', 1926951960);
insert into cliente ( tipo_documento_cliente, numero_documento_cliente) values ( 'CC', 1063182195);
insert into cliente ( tipo_documento_cliente, numero_documento_cliente) values ( 'CC', 1072127004);
insert into cliente ( tipo_documento_cliente, numero_documento_cliente) values ( 'CE', 1063176071);

-- PROVEEDOR
INSERT INTO proveedor ( nombre_proveedor) VALUE ('FINCA');
INSERT INTO proveedor ( nombre_proveedor) VALUE ('DIANA');
INSERT INTO proveedor ( nombre_proveedor) VALUE ('COLANTA');

-- producto
INSERT INTO producto ( proveedor_id_proveedor, nombre_producto) VALUE (1,'CONCENTRADO');
INSERT INTO producto ( proveedor_id_proveedor, nombre_producto) VALUE (2,'ARROZ');
INSERT INTO producto ( proveedor_id_proveedor, nombre_producto) VALUE (3,'LECHE');
INSERT INTO producto ( proveedor_id_proveedor, nombre_producto) VALUE (2,'FRIJOLES');
INSERT INTO producto ( proveedor_id_proveedor, nombre_producto) VALUE (2,'LENTEJAS');
INSERT INTO producto ( proveedor_id_proveedor, nombre_producto) VALUE (3,'QUESO');




-- FACTURA VENTA
INSERT INTO factura_venta ( cliente_cliente_id, fecha_venta) VALUE (1,'2022-05-11');
INSERT INTO factura_venta ( cliente_cliente_id, fecha_venta) VALUE (2,'2022-05-19');
INSERT INTO factura_venta ( cliente_cliente_id, fecha_venta) VALUE (3,'2022-05-13');
INSERT INTO factura_venta ( cliente_cliente_id, fecha_venta) VALUE (4,'2022-05-22');
INSERT INTO factura_venta ( cliente_cliente_id, fecha_venta) VALUE (5,'2022-05-25');

-- VENTA PRODUCTO
INSERT INTO venta_producto ( producto_id_producto, cantidad_items,  factura_venta_id_factura_venta) VALUE (1,2,1);
INSERT INTO venta_producto ( producto_id_producto, cantidad_items,  factura_venta_id_factura_venta) VALUE (2,4,1);
INSERT INTO venta_producto ( producto_id_producto, cantidad_items,  factura_venta_id_factura_venta) VALUE (3,11,1);
INSERT INTO venta_producto ( producto_id_producto, cantidad_items,  factura_venta_id_factura_venta) VALUE (4,13,1);
INSERT INTO venta_producto ( producto_id_producto, cantidad_items,  factura_venta_id_factura_venta) VALUE (5,6,2);
INSERT INTO venta_producto ( producto_id_producto, cantidad_items, factura_venta_id_factura_venta) VALUE (6,9,2);
INSERT INTO venta_producto ( producto_id_producto, cantidad_items, factura_venta_id_factura_venta) VALUE (4,15,4);


-- -----------------------------------------------------
-- 3.1 BORRADO FISICO
-- -----------------------------------------------------

DELETE FROM factura_venta WHERE id_factura_venta=4;
DELETE FROM factura_venta WHERE fecha_venta='2022-05-25';

-- -----------------------------------------------------
-- 3.2 BORRADO LOGICO
-- -----------------------------------------------------
-- Todas las consultas de vistas se deben especificar que se muestren todos los
-- registros donde el "borrado_logico" sea igual a cero

ALTER TABLE factura_venta
ADD COLUMN deletedat DATE;

UPDATE factura_venta
SET deleted_at = NOW() 
WHERE id_factura_venta=3;

UPDATE factura_venta
SET deleted_at = NOW() 
WHERE id_factura_venta=1;

SELECT id_factura_venta, fecha_venta 
FROM factura_venta
WHERE delete_at = NULL;


 id_factura_venta  INT NOT NULL AUTO_INCREMENT,
   cliente_cliente_id  INT NOT NULL,
   fecha_venta
-- ----------------------------------------------------------------------------------------------------------------
-- 4. MODIFICAR NOMBRE DEL PRODUCTO Y EL ID DEL PROVEEDOR 
-- ---------------------------------------------------------------------------------------------------------------
UPDATE  tienda_db . producto  SET  nombre_producto  = 'MAIZ PIRA',  proveedor_id_proveedor  = 3 WHERE ( id_producto  = 1);
UPDATE  tienda_db . producto  SET  nombre_producto  = 'ACEITE DIANA',  proveedor_id_proveedor  = 1 WHERE ( id_producto  =5 );
UPDATE  tienda_db . producto  SET  nombre_producto  = 'YOGURT ARTESANAL',  proveedor_id_proveedor  = 3 WHERE ( id_producto  = 6);





-- **********************************************
-- para reiniciciar todo usar este script
-- **********************************************
 DROP TABLE producto,proveedor,cliente,factura_venta,venta_producto;
