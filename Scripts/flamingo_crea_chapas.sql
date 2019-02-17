SET @inc:=0;
TRUNCATE maquinas_chapa;
INSERT INTO maquinas_chapa (chapa_cod,chapa_num,chapa_inactivo)
SELECT  
	LPAD(@inc:=@inc+1,4,'0') 	AS chapa_cod,
	TRIM(op_chapa) 				AS chapa_num, 
	0 									AS chapa_inactivo
FROM operacion
GROUP BY op_chapa
ORDER BY op_chapa;