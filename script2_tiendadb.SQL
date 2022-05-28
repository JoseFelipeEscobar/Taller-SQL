-- @Author: Jose felipe escobar jfejose10@gmail.com
-- created at 2022-05-22

-- ----------------------------------------------
-- COSULTAR PRODUCTOS VENDIDOS A UN CLIENTE INGRESANDO 
-- EL NUMERO Y TIPO DE DOCUMENTO DE LA PERSONA
-- ----------------------------------------------
SELECT producto.id_producto,producto.nombre_producto
FROM ((venta_producto
INNER JOIN producto ON venta_producto.producto_id_producto=producto.id_producto)
INNER JOIN factura_venta ON venta_producto.factura_venta_id_factura_venta = factura_venta.id_factura_venta
INNER JOIN cliente ON venta_producto.factura_venta_id_factura_venta = cliente.cliente_id)

 WHERE factura_venta.cliente_cliente_id=1  AND cliente.tipo_documento_cliente = 'CC' ;
 

-- -----------------------------------------------------
-- Consulta por medio deL nombre del producto y mostrar
-- el id y el nombre del proveedor
-- -----------------------------------------------------
SELECT id_proveedor,nombre_proveedor
FROM (proveedor
INNER  JOIN producto ON proveedor.id_proveedor = producto.proveedor_id_proveedor
)WHERE nombre_producto='LECHE';




-- *****************************************************
-- PLUS: CONSULTA QUE PERMITE VER QUE PRODUCTO HAN
-- SIDO LOS MAS VENDIDOS EN ORDEN DE MAYOR A MENOR
-- ****************************************************
SELECT  producto.nombre_producto,cantidad_items
FROM ((venta_producto
INNER JOIN producto ON venta_producto.producto_id_producto=producto.id_producto)
)ORDER BY cantidad_items DESC LIMIT 1;

SELECT  producto.nombre_producto,cantidad_items
FROM ((venta_producto
INNER JOIN producto ON venta_producto.producto_id_producto=producto.id_producto)
)ORDER BY cantidad_items DESC LIMIT 1;



