UPDATE maquinastc tc 
INNER join maquinas_juegos ju ON TRIM(tc.maqtc_modelo) = TRIM(ju.jueg_nombre)
SET 
	tc.prov_cod=1,
	tc.jueg_cod= ju.jueg_cod
WHERE 1=1;
	