/*-------------------------actualiza baja produccion------------------------------             */
UPDATE maquinastc maq 
JOIN operacion_trans opt ON (opt.op_chapa = maq.maqtc_chapa)  and (opt.op_emp_id=maq.emp_id)
	SET maq.maqtc_sem_jcj = maq.maqtc_sem_jcj-1
WHERE opt.op_emp_id    =1
AND   opt.op_usermodify=1
AND   opt.op_baja_prod>0;

UPDATE maquinastc maq 
SET maq.maqtc_sem_jcj=0
WHERE maq.maqtc_sem_jcj<0;

UPDATE maquinastc maq 
JOIN operacion_trans opt ON (opt.op_chapa = maq.maqtc_chapa)  and (opt.op_emp_id=maq.emp_id)
	SET maq.maqtc_sem_jcj = maq.maqtc_sem_jcj+1
WHERE opt.op_emp_id    =1
AND   opt.op_usermodify=1
AND   opt.op_baja_prod =1;
/*----------------------------------------------------------------------------------------------*/

/*-------------------------actualiza demoninacion en efectivon---------------------------------- */ 
UPDATE maquinastc maq 
JOIN operacion_trans opt ON (opt.op_chapa = maq.maqtc_chapa)  and (opt.op_emp_id=maq.emp_id)
	SET 
	maq.maqtc_denom_e = opt.maqtc_denom_e
WHERE opt.op_emp_id    =1
AND   opt.op_usermodify=1
AND   opt.maqtc_denom_e=1;

UPDATE maquinastc maq 
JOIN operacion_trans opt ON (opt.op_chapa = maq.maqtc_chapa)  and (opt.op_emp_id=maq.emp_id)
	SET 
	maq.maqtc_denom_s = opt.maqtc_denom_s
WHERE opt.op_emp_id    =1
AND   opt.op_usermodify=1
AND   opt.maqtc_denom_s=1;
/*----------------------------------------------------------------------------------------------*/

/*-------------------------actualiza metro anterior y ultimo----------------------------------- */ 
UPDATE maquinastc maq 
JOIN operacion_trans opt ON (opt.op_chapa = maq.maqtc_chapa)  and (opt.op_emp_id=maq.emp_id)
	SET 
	maq.maqtc_m1e_ant= maq.maqtc_m1e_act,
	maq.maqtc_m1s_ant= maq.maqtc_m1s_act,
	maq.maqtc_m2e_ant= maq.maqtc_m2e_act,
	maq.maqtc_m2s_ant= maq.maqtc_m2s_act,
	
	maq.maqtc_m1e_act= opt.op_ea_metroac,
	maq.maqtc_m2e_act= opt.op_eb_metroac,
	maq.maqtc_m2s_act= opt.op_sa_metroac,
	maq.maqtc_m1s_act= opt.op_sb_metroac,
	maq.maqtc_mfecha=NOW()

WHERE opt.op_emp_id    =1
AND   opt.op_usermodify=1
AND   opt.op_baja_prod=0;
/*----------------------------------------------------------------------------------------------*/
