SET @inc:=0;
TRUNCATE maquinas_juegos;
INSERT INTO maquinas_juegos (jueg_cod,jueg_nombre,jueg_fecha,jueg_inactivo,jueg_fecha_alta,jueg_usuario_alta,jueg_fecha_modif,jueg_usuario_modif, jueg_cant,jueg_proveedor )
SELECT 
	LPAD(@inc:=@inc+1,4,'0') 	AS jueg_cod,
	TRIM(op_modelo)				AS jueg_nombre, 
	NULL 								AS jueg_fecha,
	0 									AS jueg_inactivo,
	NOW() 							AS jueg_fecha_alta,
	"AUTO" 							AS jueg_usuario_alta,
	NOW() 							AS jueg_fecha_modif,
	"AUTO" 							AS jueg_usuario_modif,
	1 									AS jueg_cant,
	"NO DEFINIDO" 					AS jueg_proveedor 
FROM operacion
GROUP BY op_modelo
ORDER BY TRIM(op_modelo);

INSERT INTO maquinas_juegos (jueg_cod,jueg_nombre,jueg_fecha,jueg_inactivo,jueg_fecha_alta,jueg_usuario_alta,jueg_fecha_modif,jueg_usuario_modif, jueg_cant,jueg_proveedor )
SELECT 
	LPAD(0,4,'0') 	AS jueg_cod,
	"NO DEFINIDO"	AS jueg_nomre, 
	NULL 				AS jueg_fecha,
	0 					AS jueg_inactivo,
	NOW() 			AS jueg_fecha_alta,
	"AUTO" 			AS jueg_usuario_alta,
	NOW() 			AS jueg_fecha_modif,
	"AUTO" 			AS jueg_usuario_modif,
	1 					AS jueg_cant,
	"NO DEFINIDO" 	AS jueg_proveedor; 
