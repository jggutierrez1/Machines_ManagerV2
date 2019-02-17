ALTER TABLE `maquinastc`
	ADD COLUMN `prov_cod`INT(11) NULL DEFAULT NULL AFTER `maqtc_cod`,
	ADD INDEX `prov_cod` (`prov_cod`),
	ADD COLUMN `jueg_cod` INT(11) NULL DEFAULT NULL AFTER `maqtc_cod`,
	ADD INDEX `jueg_cod` (`jueg_cod`),
	ADD COLUMN `maqtc_serie` CHAR(30) NOT NULL DEFAULT '' AFTER `maqtc_modelo`,
	ADD INDEX `maqtc_serie` (`maqtc_serie`);
	
ALTER TABLE `clientes`
	 AUTO_INCREMENT=1,
	ADD COLUMN `cte_autoinc` INT(11) NOT NULL AUTO_INCREMENT FIRST,
	CHANGE COLUMN `cte_id` `cte_id` INT(11) NULL DEFAULT NULL AFTER `cte_autoinc`,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`cte_autoinc`),
	ADD UNIQUE INDEX `cte_id` (`cte_id`);

ALTER TABLE `empresas`
	AUTO_INCREMENT=1,
	ADD COLUMN `emp_autoinc` INT(11) NOT NULL AUTO_INCREMENT FIRST,
	CHANGE COLUMN `emp_id` `emp_id` INT(3) NULL DEFAULT NULL AFTER `emp_autoinc`,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`emp_autoinc`),
	ADD UNIQUE INDEX `emp_id` (`emp_id`);

ALTER TABLE `maquinastc`
	AUTO_INCREMENT=1,
	ADD COLUMN `maqtc_autoinc` INT(11) NOT NULL AUTO_INCREMENT FIRST,
	CHANGE COLUMN `maqtc_id` `maqtc_id` INT(11) NULL DEFAULT NULL AFTER `maqtc_autoinc`,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`maqtc_autoinc`),
	ADD UNIQUE INDEX `maqtc_id` (`maqtc_id`);

ALTER TABLE `maquinas_lnk`
	CHANGE COLUMN `MaqLnk_Id` `MaqLnk_Id` INT(11) NOT NULL AUTO_INCREMENT FIRST,
	CHANGE COLUMN `cte_id` `cte_id` INT(11) NOT NULL DEFAULT '0' AFTER `emp_id`,
	CHANGE COLUMN `maqtc_id` `maqtc_id` INT(11) NOT NULL DEFAULT '0' AFTER `cte_id`,
	ADD COLUMN `MaqLnk_usuario_alta` CHAR(12) NULL DEFAULT "" NULL AFTER `MaqLnk_fecha_alta`,
	ADD COLUMN `MaqLnk_usuario_modif` CHAR(12) NULL DEFAULT "" NULL AFTER `MaqLnk_fecha_modif`;
	
ALTER TABLE `maquinastc_metros`
	ADD COLUMN `maqtc_id` INT(11) NOT NULL DEFAULT '0' AFTER `emp_id`,
	INDEX `maqtc_id` (`maqtc_id`),
	ADD COLUMN `maqtc_nodoc` VARCHAR(30) NULL DEFAULT NULL AFTER `maqtc_mfecha`,
	ADD INDEX `maqtc_nodoc` (`maqtc_nodoc`);

UPDATE maquinastc_metros me 
INNER join maquinastc ma ON TRIM(ma.maqtc_chapa) = TRIM(me.maqtc_chapa)
SET 
	me.maqtc_id=ma.maqtc_id
WHERE 1=1;

ALTER TABLE `operacion`
	ADD COLUMN `prov_cod` INT(11) NULL DEFAULT NULL AFTER `cte_pag_impm`,
	ADD COLUMN `maqtc_id` INT(11) NOT NULL DEFAULT '0' AFTER `MaqLnk_Id`,
	ADD INDEX `maqtc_id` (`maqtc_id`),
	ADD COLUMN `jueg_cod` INT(11) NULL DEFAULT NULL AFTER `maqtc_id`,
	ADD INDEX `jueg_cod` (`jueg_cod`);

ALTER TABLE `operacion_trans`
	ADD COLUMN `prov_cod` INT(11) NULL DEFAULT NULL AFTER `cte_pag_impm`,
	ADD COLUMN `maqtc_id` INT(11) NOT NULL DEFAULT '0' AFTER `MaqLnk_Id`,
	ADD INDEX `maqtc_id` (`maqtc_id`),
	ADD COLUMN `jueg_cod` INT(11) NULL DEFAULT NULL AFTER `maqtc_id`,
	ADD INDEX `jueg_cod` (`jueg_cod`);


UPDATE maquinastc tc 
INNER join maquinas_juegos ju ON TRIM(tc.maqtc_modelo) = TRIM(ju.jueg_nombre)
SET 
	tc.prov_cod=1,
	tc.jueg_cod= ju.jueg_cod
WHERE 1=1;
UPDATE maquinastc SET jueg_cod=0,maqtc_modelo='JUEGO NO DEFINIDO' WHERE jueg_cod IS NULL;
UPDATE maquinastc SET prov_cod=1 WHERE prov_cod IS NULL;

	
UPDATE operacion
INNER JOIN maquinastc ON operacion.op_chapa=maquinastc.maqtc_chapa
SET 
	operacion.maqtc_id= maquinastc.maqtc_id,
	operacion.prov_cod= maquinastc.prov_cod,
	operacion.jueg_cod= maquinastc.jueg_cod
WHERE 1=1;

UPDATE operacion_trans
INNER JOIN maquinastc ON operacion_trans.op_chapa=maquinastc.maqtc_chapa
SET 
	operacion_trans.maqtc_id= maquinastc.maqtc_id,
	operacion_trans.prov_cod= maquinastc.prov_cod,
	operacion_trans.jueg_cod= maquinastc.jueg_cod
WHERE 1=1;

DROP TABLE IF EXISTS `global`;
CREATE TABLE IF NOT EXISTS `global` (
  `autoinc` int(11) NOT NULL AUTO_INCREMENT,
  `corre_emp` int(11) NOT NULL DEFAULT 0,
  `corre_cli` int(11) NOT NULL DEFAULT 0,
  `corre_maq` int(11) NOT NULL DEFAULT 0,
  `corre_prov_maq` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`autoinc`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=UTF8;

INSERT INTO `global` (corre_emp,corre_cli,corre_maq,corre_prov_maq) VALUES (0,0,0,0);	
UPDATE `global` SET corre_emp=(SELECT MAX(emp_id)+1 FROM empresas ) WHERE 1=1;
UPDATE `global` SET corre_cli=(SELECT MAX(cte_id)+1 FROM clientes ) WHERE 1=1;
UPDATE `global` SET corre_maq=(SELECT MAX(maqtc_id)+1 FROM maquinastc ) WHERE 1=1;

-- Volcando estructura para tabla one2009_1.maquinas_prov
DROP TABLE IF EXISTS `maquinas_prov`;
CREATE TABLE IF NOT EXISTS `maquinas_prov` (
  `autoinc` int(11) NOT NULL AUTO_INCREMENT,
  `prov_cod` int(11) DEFAULT 0,
  `prov_nombre` varchar(50) DEFAULT '',
  `prov_porc` decimal(12,2) DEFAULT 0.00,
  `prov_fecha_alta` datetime DEFAULT NULL,
  `prov_usuario_alta` char(12) DEFAULT NULL,
  `prov_fecha_modif` datetime DEFAULT NULL,
  `prov_usuario_modif` char(12) DEFAULT NULL,
  `prov_retenc` int(1) DEFAULT 0,
  `prov_inactivo` int(1) DEFAULT 0,
  PRIMARY KEY (`autoinc`),
  UNIQUE KEY `prov_cod` (`prov_cod`),
  KEY `prov_nombre` (`prov_nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla one2009_1.maquinas_prov: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `maquinas_prov` DISABLE KEYS */;
INSERT INTO `maquinas_prov` (`autoinc`, `prov_cod`, `prov_nombre`, `prov_porc`, `prov_fecha_alta`, `prov_usuario_alta`, `prov_fecha_modif`, `prov_usuario_modif`, `prov_retenc`, `prov_inactivo`) VALUES
	(1, 1, 'GENERICO/CLON', 0.00, '2019-02-03 13:22:36', 'SYSTEM', '2019-02-03 13:22:38', 'SYSTEM', 0, 0),
	(2, 6, 'BALLY WULFF', 0.00, NULL, NULL, NULL, NULL, 0, 0),
	(3, 2, 'NOVOMATIC', 0.00, NULL, NULL, NULL, NULL, 0, 0),
	(4, 3, 'NSM-LÖWEN', 0.00, NULL, NULL, NULL, NULL, 0, 0),
	(5, 4, 'MERKUR', 0.00, NULL, NULL, NULL, NULL, 0, 0),
	(6, 5, 'WMS WILLIAMS INTERACTIVE', 0.00, NULL, NULL, NULL, NULL, 0, 0);

ALTER TABLE `maquinas_lnk`
	CHANGE COLUMN `emp_id` `emp_id` INT(3) NOT NULL DEFAULT '1' AFTER `MaqLnk_Id`,
	CHANGE COLUMN `MaqLnk_fecha_alta` `MaqLnk_fecha_alta` DATETIME NULL DEFAULT '2010-01-01 00:00:00' AFTER `maqtc_id`,
	CHANGE COLUMN `MaqLnk_fecha_modif` `MaqLnk_fecha_modif` DATETIME NULL DEFAULT '2010-01-01 00:00:00' AFTER `MaqLnk_usuario_alta`,
	CHANGE COLUMN `MaqLnk_usuario_alta` `MaqLnk_usuario_alta` CHAR(12) NULL DEFAULT '' AFTER `MaqLnk_fecha_alta`,
	CHANGE COLUMN `MaqLnk_usuario_modif` `MaqLnk_usuario_modif` CHAR(12) NULL DEFAULT '' AFTER `MaqLnk_fecha_modif`;

ALTER TABLE `maquinas_prov`
	CHANGE COLUMN `prov_cod` `prov_cod` INT(11) NOT NULL DEFAULT '0' AFTER `autoinc`,
	CHANGE COLUMN `prov_nombre` `prov_nombre` VARCHAR(50) NOT NULL DEFAULT '' AFTER `prov_cod`,
	CHANGE COLUMN `prov_porc` `prov_porc` DECIMAL(12,2) NOT NULL DEFAULT '0' AFTER `prov_nombre`,
	CHANGE COLUMN `prov_retenc` `prov_retenc` INT(1) NOT NULL DEFAULT '0' AFTER `prov_porc`,
	CHANGE COLUMN `prov_inactivo` `prov_inactivo` INT(1) NOT NULL DEFAULT '0' AFTER `prov_retenc`;

ALTER TABLE `maquinas_juegos`
	CHANGE COLUMN `jueg_cod` `jueg_cod` INT(11) NOT NULL DEFAULT '0' AFTER `jueg_autoinc`,
	CHANGE COLUMN `jueg_nombre` `jueg_nombre` VARCHAR(50) NOT NULL DEFAULT ' ' AFTER `jueg_cod`,
	CHANGE COLUMN `jueg_fecha` `jueg_fecha` DATE NULL DEFAULT NULL AFTER `jueg_nombre`,
	CHANGE COLUMN `jueg_inactivo` `jueg_inactivo` INT(1) NOT NULL DEFAULT '0' AFTER `jueg_fecha`,
	CHANGE COLUMN `jueg_cant` `jueg_cant` INT(3) NOT NULL DEFAULT '1' AFTER `jueg_inactivo`,
	CHANGE COLUMN `jueg_proveedor` `jueg_proveedor` VARCHAR(50) NULL DEFAULT NULL AFTER `jueg_cant`,
	CHANGE COLUMN `jueg_fecha_alta` `jueg_fecha_alta` DATETIME NULL DEFAULT NULL AFTER `jueg_proveedor`;

ALTER TABLE `operaciong`
	ADD COLUMN `op_aplica_interf` INT(1) NULL DEFAULT '0' AFTER `op_usuario_modif`,
	ADD INDEX `op_aplica_interf` (`op_aplica_interf`);

ALTER TABLE `operacion`
	ADD COLUMN `op_aplica_interf` INT(1) NULL DEFAULT '0' AFTER `op_usermodify`,
	ADD COLUMN `op_aplica_num` VARCHAR(30) NULL DEFAULT NULL AFTER `op_aplica_interf`,
	ADD INDEX `op_aplica_interf` (`op_aplica_interf`),
	ADD INDEX `op_aplica_num` (`op_aplica_num`);

ALTER TABLE `clientes`
	ADD COLUMN `cte_id_interf` VARCHAR(20) NULL DEFAULT NULL AFTER `cte_mod_metro_ant`,
	ADD INDEX `cte_id_interf` (`cte_id_interf`);

ALTER TABLE `maquinas_prov`
	ADD COLUMN `prov_notas` TEXT NOT NULL DEFAULT '' AFTER `prov_inactivo`,
	ADD COLUMN `prov_telefono1` CHAR(25) NOT NULL DEFAULT '' AFTER `prov_notas`,
	ADD COLUMN `prov_telefono2` CHAR(25) NOT NULL DEFAULT '' AFTER `prov_telefono1`,
	ADD COLUMN `prov_Fax` CHAR(25) NOT NULL DEFAULT '' AFTER `prov_telefono2`,
	ADD COLUMN `prov_contacto_nom` CHAR(35) NOT NULL DEFAULT '' AFTER `prov_Fax`,
	ADD COLUMN `prov_contacto_movil` CHAR(25) NOT NULL DEFAULT '' AFTER `prov_contacto_nom`,
	ADD COLUMN `prov_contacto_email` CHAR(120) NOT NULL DEFAULT '' AFTER `prov_contacto_movil`,
	ADD COLUMN `prov_email` CHAR(120) NOT NULL DEFAULT '' AFTER `prov_contacto_movil_email`,
	ADD COLUMN `prov_webpage` VARCHAR(130) NOT NULL DEFAULT '' AFTER `prov_email`;
	
ALTER TABLE `empresas`
	ADD COLUMN `emp_clave_facturas` VARCHAR(30) NULL DEFAULT '82878884' AFTER `emp_clave_montos`;
	
ALTER TABLE `operaciong`
	ADD COLUMN `op_tot_porc_cons` DECIMAL(12,2) NULL DEFAULT '0' AFTER `op_tot_spac`;

ALTER TABLE `operaciong_trans`
	ADD COLUMN `op_tot_porc_cons` DECIMAL(12,2) NULL DEFAULT '0' AFTER `op_tot_spac`;

ALTER TABLE `operacion`
	ADD COLUMN `op_tot_porc_cons` DECIMAL(12,2) NULL DEFAULT '0' AFTER `op_tot_spac`,
	ADD COLUMN `op_maq_proc_cons` DECIMAL(6,2) NULL DEFAULT '0' AFTER `op_cporc_Loc`;

ALTER TABLE `operacion_trans`
	ADD COLUMN `op_tot_porc_cons` DECIMAL(12,2) NULL DEFAULT '0' AFTER `op_tot_spac`,
	ADD COLUMN `op_maq_proc_cons` DECIMAL(6,2) NULL DEFAULT '0' AFTER `op_cporc_Loc`;

