-- MySQL Workbench Forward Engineering

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
   id_proveedor  INT NOT NULL,
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
   nombre_producto  VARCHAR(80) NULL,
  PRIMARY KEY ( id_producto ),
  UNIQUE INDEX  id_producto_UNIQUE  ( id_producto  ASC) INVISIBLE,
  INDEX  fk_producto_proveedor1_idx  ( proveedor_id_proveedor  ASC) VISIBLE,
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
   tipo_documento_cliente  VARCHAR(80) NULL,
   nuemero_documento_cliente  INT NULL,
  PRIMARY KEY ( cliente_id ),
  UNIQUE INDEX  numero_documento_cliente_UNIQUE  ( tipo_documento_cliente  ASC,  nuemero_documento_cliente  ASC) VISIBLE,
  UNIQUE INDEX  cliente_id_UNIQUE  ( cliente_id  ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table  tienda_db . factura_venta 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  tienda_db . factura_venta  (
   id_factura_venta  INT NOT NULL,
   cliente_cliente_id  INT NOT NULL,
   producto_id_producto  INT NOT NULL,
   fecha_venta  DATE NULL,
  PRIMARY KEY ( id_factura_venta ),
  INDEX  fk_factura_venta_cliente_idx  ( cliente_cliente_id  ASC) VISIBLE,
  INDEX  fk_factura_venta_producto1_idx  ( producto_id_producto  ASC) VISIBLE,
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
