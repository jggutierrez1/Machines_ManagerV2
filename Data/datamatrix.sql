-- --------------------------------------------------------
-- Host:                         190.140.2.84
-- Versión del servidor:         10.0.34-MariaDB-0ubuntu0.16.04.1 - Ubuntu 16.04
-- SO del servidor:              debian-linux-gnu
-- HeidiSQL Versión:             9.5.0.5278
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para device_db
CREATE DATABASE IF NOT EXISTS `device_db` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `device_db`;

-- Volcando estructura para tabla device_db.dispositivos
DROP TABLE IF EXISTS `dispositivos`;
CREATE TABLE IF NOT EXISTS `dispositivos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serial` varchar(50) DEFAULT NULL,
  `clave_install` varchar(30) DEFAULT '123',
  `fecha_pacceso` datetime DEFAULT NULL,
  `fecha_uacceso` datetime DEFAULT NULL,
  `dbname` varchar(30) DEFAULT 'one2009_1',
  `corre_ant` int(10) DEFAULT '0',
  `corre_act` int(10) DEFAULT '0',
  `clave_metros` varchar(30) DEFAULT 'FLAM222218',
  `clave_montos` varchar(30) DEFAULT 'FLAM333318',
  `emp_id` int(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `serial` (`serial`),
  KEY `clave_install` (`clave_install`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura de base de datos para one2009_1
CREATE DATABASE IF NOT EXISTS `one2009_1` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `one2009_1`;

-- Volcando estructura para tabla one2009_1.adelantos
DROP TABLE IF EXISTS `adelantos`;
CREATE TABLE IF NOT EXISTS `adelantos` (
  `Id_Trans` int(10) NOT NULL AUTO_INCREMENT,
  `Emp_Id` tinyint(4) DEFAULT '1',
  `Chapa` char(12) DEFAULT NULL,
  `Cod_Maq` char(12) DEFAULT NULL,
  `Fecha` datetime DEFAULT NULL,
  `Turno` tinyint(4) DEFAULT '1',
  `No_Doc` char(10) DEFAULT NULL,
  `Monto` decimal(12,2) DEFAULT '0.00',
  `Flag20` int(4) DEFAULT '0',
  `Notas` text,
  `Usuario_Crea` char(20) DEFAULT NULL,
  `Usuario_FechC` datetime DEFAULT '2009-01-01 00:00:00',
  `Usuario_Mod` char(20) DEFAULT NULL,
  `Usuario_FechM` datetime DEFAULT '2009-01-01 00:00:00',
  `Usuario_Elim` char(20) DEFAULT NULL,
  `Usuario_FechE` datetime DEFAULT '2009-01-01 00:00:00',
  PRIMARY KEY (`Id_Trans`),
  KEY `No_Maq` (`Cod_Maq`),
  KEY `Fecha` (`Fecha`),
  KEY `No_Doc` (`No_Doc`),
  KEY `Flag20` (`Flag20`),
  KEY `Chapa` (`Chapa`),
  KEY `Emp_Id` (`Emp_Id`),
  KEY `Turno` (`Turno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.base64_data
DROP TABLE IF EXISTS `base64_data`;
CREATE TABLE IF NOT EXISTS `base64_data` (
  `c` char(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `val` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.ciudad
DROP TABLE IF EXISTS `ciudad`;
CREATE TABLE IF NOT EXISTS `ciudad` (
  `CiudadID` int(11) NOT NULL,
  `CiudadNombre` char(35) NOT NULL DEFAULT '',
  `PaisCodigo` char(3) NOT NULL DEFAULT '',
  `CiudadDistrito` char(20) NOT NULL DEFAULT '',
  `CiudadPoblacion` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`CiudadID`),
  KEY `PaisCodigo` (`PaisCodigo`),
  KEY `CiudadNombre` (`CiudadNombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.clientes
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE IF NOT EXISTS `clientes` (
  `cte_id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `mun_id` int(3) unsigned NOT NULL DEFAULT '1',
  `rut_id` int(3) unsigned NOT NULL DEFAULT '1',
  `cte_nombre_loc` char(80) NOT NULL DEFAULT '',
  `cte_nombre_com` char(80) NOT NULL DEFAULT '',
  `cte_telefono1` char(25) NOT NULL DEFAULT '',
  `cte_telefono2` char(25) NOT NULL DEFAULT '',
  `cte_Fax` char(25) NOT NULL DEFAULT '',
  `cte_contacto_nom` char(35) NOT NULL DEFAULT '',
  `cte_contacto_movil` char(25) NOT NULL DEFAULT '',
  `cte_contacto_movil_bbpin` char(12) NOT NULL DEFAULT '',
  `cte_contacto_movil_email` char(120) NOT NULL DEFAULT '',
  `cte_email` char(120) NOT NULL DEFAULT '',
  `cte_webpage` varchar(130) NOT NULL DEFAULT '',
  `cte_notas` text,
  `cte_inactivo` int(1) NOT NULL DEFAULT '0',
  `cte_direccion` text,
  `cte_pag_impm` int(1) NOT NULL DEFAULT '0',
  `cte_pag_jcj` int(1) NOT NULL DEFAULT '0',
  `cte_pag_spac` int(1) NOT NULL DEFAULT '0',
  `cte_poc_ret` decimal(12,2) NOT NULL DEFAULT '0.00',
  `cte_fecha_alta` datetime NOT NULL DEFAULT '2010-01-01 00:00:00',
  `cte_fecha_modif` datetime NOT NULL DEFAULT '2010-01-01 00:00:00',
  `cte_emp_id` int(3) NOT NULL DEFAULT '0',
  `u_usuario_alta` char(20) NOT NULL DEFAULT 'ANONIMO',
  `cte_unico_emp` int(1) NOT NULL DEFAULT '0',
  `u_usuario_modif` char(20) NOT NULL DEFAULT 'ANONIMO',
  `cte_mod_metro_ant` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cte_id`),
  KEY `mun_id` (`mun_id`),
  KEY `rut_id` (`rut_id`),
  KEY `cte_nombre_loc` (`cte_nombre_loc`),
  KEY `cte_nombre_com` (`cte_nombre_com`),
  KEY `cte_inactivo` (`cte_inactivo`),
  KEY `cte_emp_id` (`cte_emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.conf_corre
DROP TABLE IF EXISTS `conf_corre`;
CREATE TABLE IF NOT EXISTS `conf_corre` (
  `autoinc` int(11) NOT NULL AUTO_INCREMENT,
  `corre_provs` int(11) NOT NULL DEFAULT '0',
  `corre_ctes` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`autoinc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.country
DROP TABLE IF EXISTS `country`;
CREATE TABLE IF NOT EXISTS `country` (
  `Code` char(3) NOT NULL DEFAULT '',
  `Name` char(52) NOT NULL DEFAULT '',
  `Continent` enum('Asia','Europe','North America','Africa','Oceania','Antarctica','South America') NOT NULL DEFAULT 'Asia',
  `Region` char(26) NOT NULL DEFAULT '',
  `SurfaceArea` float(10,2) NOT NULL DEFAULT '0.00',
  `IndepYear` smallint(6) DEFAULT NULL,
  `Population` int(11) NOT NULL DEFAULT '0',
  `LifeExpectancy` float(3,1) DEFAULT NULL,
  `GNP` float(10,2) DEFAULT NULL,
  `GNPOld` float(10,2) DEFAULT NULL,
  `LocalName` char(45) NOT NULL DEFAULT '',
  `GovernmentForm` char(45) NOT NULL DEFAULT '',
  `HeadOfState` char(60) DEFAULT NULL,
  `Capital` int(11) DEFAULT NULL,
  `Code2` char(2) NOT NULL DEFAULT '',
  PRIMARY KEY (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.denominaciones
DROP TABLE IF EXISTS `denominaciones`;
CREATE TABLE IF NOT EXISTS `denominaciones` (
  `den_id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `den_descripcion` char(30) NOT NULL DEFAULT '',
  `den_inactiva` int(4) NOT NULL DEFAULT '0',
  `den_fact_e` int(3) NOT NULL DEFAULT '0',
  `den_fact_s` int(3) NOT NULL DEFAULT '0',
  `den_valor` decimal(12,2) NOT NULL DEFAULT '0.00',
  `den_fecha_alta` datetime NOT NULL DEFAULT '2010-01-01 00:00:00',
  `den_fecha_modif` datetime NOT NULL DEFAULT '2010-01-01 00:00:00',
  `u_usuario_alta` char(20) NOT NULL DEFAULT 'ANONIMO',
  `u_usuario_modif` char(20) NOT NULL DEFAULT 'ANONIMO',
  PRIMARY KEY (`den_id`),
  KEY `den_descripcion` (`den_descripcion`),
  KEY `den_inactiva` (`den_inactiva`)
) ENGINE=InnoDB AUTO_INCREMENT=277 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.empresas
DROP TABLE IF EXISTS `empresas`;
CREATE TABLE IF NOT EXISTS `empresas` (
  `emp_id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `emp_descripcion` char(85) NOT NULL DEFAULT '',
  `emp_ruc` char(85) NOT NULL DEFAULT '',
  `emp_dv` char(10) NOT NULL DEFAULT '',
  `emp_carpeta_reportes` varchar(120) NOT NULL DEFAULT '',
  `emp_telefono1` char(12) NOT NULL DEFAULT '',
  `emp_telefono2` char(12) NOT NULL DEFAULT '',
  `emp_fax` char(12) NOT NULL DEFAULT '',
  `emp_direccion` text,
  `emp_apartado` text,
  `emp_email` char(100) NOT NULL DEFAULT '',
  `separa_mil` char(1) NOT NULL DEFAULT ',',
  `separa_dec` char(1) NOT NULL DEFAULT '.',
  `emp_imagen` blob,
  `emp_imagen_path` varchar(120) NOT NULL DEFAULT '',
  `emp_inactivo` int(1) unsigned NOT NULL DEFAULT '0',
  `emp_cargo_jcj` decimal(12,2) NOT NULL DEFAULT '0.00',
  `emp_cargo_spac` decimal(12,2) NOT NULL DEFAULT '0.00',
  `emp_fecha_alta` datetime NOT NULL DEFAULT '2010-01-01 00:00:00',
  `emp_fecha_modif` datetime NOT NULL DEFAULT '2010-01-01 00:00:00',
  `u_usuario_alta` char(20) NOT NULL DEFAULT 'ANONIMO',
  `u_usuario_modif` char(20) NOT NULL DEFAULT 'ANONIMO',
  `emp_corre_ant` int(10) DEFAULT '0',
  `emp_corre_act` int(10) DEFAULT '0',
  `emp_clave_metros` varchar(30) DEFAULT '112233',
  `emp_clave_montos` varchar(30) DEFAULT '332211',
  PRIMARY KEY (`emp_id`),
  KEY `emp_descripcion` (`emp_descripcion`),
  KEY `emp_inactivo` (`emp_inactivo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.maquinastc
DROP TABLE IF EXISTS `maquinastc`;
CREATE TABLE IF NOT EXISTS `maquinastc` (
  `maqtc_id` int(6) NOT NULL AUTO_INCREMENT,
  `maqtc_cod` char(12) NOT NULL DEFAULT '',
  `maqtc_modelo` char(60) NOT NULL DEFAULT '',
  `maqtc_chapa` char(12) NOT NULL DEFAULT '',
  `maqtc_inactivo` int(1) NOT NULL DEFAULT '0',
  `maqtc_metros` int(1) NOT NULL DEFAULT '1',
  `emp_id` int(3) NOT NULL DEFAULT '1',
  `maqtc_denom_e` int(3) NOT NULL DEFAULT '0',
  `maqtc_tipomaq` int(1) NOT NULL DEFAULT '0',
  `maqtc_denom_s` int(3) NOT NULL DEFAULT '0',
  `maqtc_m1e_act` decimal(12,2) NOT NULL DEFAULT '0.00',
  `maqtc_m1e_ant` decimal(12,2) NOT NULL DEFAULT '0.00',
  `maqtc_m1s_ant` decimal(12,2) NOT NULL DEFAULT '0.00',
  `maqtc_m2e_act` decimal(12,2) NOT NULL DEFAULT '0.00',
  `maqtc_m2e_ant` decimal(12,2) NOT NULL DEFAULT '0.00',
  `maqtc_m2s_act` decimal(12,2) NOT NULL DEFAULT '0.00',
  `maqtc_m2s_ant` decimal(12,2) NOT NULL DEFAULT '0.00',
  `maqtc_m1s_act` decimal(12,2) NOT NULL DEFAULT '0.00',
  `maqtc_mfecha` datetime DEFAULT NULL,
  `maqtc_fecha_alta` datetime NOT NULL DEFAULT '2010-01-01 00:00:00',
  `maqtc_fecha_modif` datetime NOT NULL DEFAULT '2010-01-01 00:00:00',
  `maqtc_sem_jcj` int(2) NOT NULL DEFAULT '1',
  `u_usuario_alta` char(20) NOT NULL DEFAULT 'ANONIMO',
  `u_usuario_modif` char(20) NOT NULL DEFAULT 'ANONIMO',
  PRIMARY KEY (`maqtc_id`),
  KEY `maqtc_cod` (`maqtc_cod`),
  KEY `maqtc_chapa` (`maqtc_chapa`),
  KEY `maqtc_inactivo` (`maqtc_inactivo`),
  KEY `emp_id` (`emp_id`),
  KEY `maqtc_modelo` (`maqtc_modelo`)
) ENGINE=InnoDB AUTO_INCREMENT=615 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.maquinas_lnk
DROP TABLE IF EXISTS `maquinas_lnk`;
CREATE TABLE IF NOT EXISTS `maquinas_lnk` (
  `MaqLnk_Id` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `emp_id` int(3) unsigned NOT NULL DEFAULT '1',
  `cte_id` int(4) unsigned NOT NULL DEFAULT '1',
  `maqtc_id` int(6) unsigned NOT NULL DEFAULT '1',
  `MaqLnk_fecha_alta` datetime NOT NULL DEFAULT '2010-01-01 00:00:00',
  `MaqLnk_fecha_modif` datetime NOT NULL DEFAULT '2010-01-01 00:00:00',
  PRIMARY KEY (`MaqLnk_Id`),
  KEY `cte_id` (`cte_id`),
  KEY `maqtc_id` (`maqtc_id`),
  KEY `emp_id` (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7253 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.municipios
DROP TABLE IF EXISTS `municipios`;
CREATE TABLE IF NOT EXISTS `municipios` (
  `mun_id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `mun_inactivo` int(1) unsigned NOT NULL DEFAULT '0',
  `mun_nombre` char(80) NOT NULL DEFAULT '',
  `mun_impuesto` decimal(12,2) NOT NULL DEFAULT '0.00',
  `mun_notas` longtext,
  `mun_fecha_alta` datetime NOT NULL DEFAULT '2010-01-01 00:00:00',
  `mun_fecha_modif` datetime NOT NULL DEFAULT '2010-01-01 00:00:00',
  `u_usuario_alta` char(20) NOT NULL DEFAULT 'ANONIMO',
  `u_usuario_modif` char(20) NOT NULL DEFAULT 'ANONIMO',
  PRIMARY KEY (`mun_id`),
  KEY `mun_inactivo` (`mun_inactivo`),
  KEY `mun_nombre` (`mun_nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.operacion
DROP TABLE IF EXISTS `operacion`;
CREATE TABLE IF NOT EXISTS `operacion` (
  `id_op` int(10) NOT NULL AUTO_INCREMENT,
  `MaqLnk_Id` int(4) DEFAULT '0',
  `cte_id` int(4) unsigned DEFAULT '0',
  `cte_nombre_loc` char(60) DEFAULT '',
  `cte_nombre_com` char(60) DEFAULT '',
  `cte_pag_jcj` int(1) DEFAULT '0',
  `cte_pag_spac` int(1) DEFAULT '0',
  `cte_pag_impm` int(1) DEFAULT '0',
  `maqtc_denom_e` int(3) DEFAULT '0',
  `maqtc_denom_s` int(3) DEFAULT '0',
  `den_valore` decimal(12,2) DEFAULT '0.00',
  `den_valors` decimal(12,2) DEFAULT '0.00',
  `den_fact_e` int(3) DEFAULT '0',
  `den_fact_s` int(3) DEFAULT '0',
  `maqtc_tipomaq` int(1) DEFAULT '0',
  `op_cporc_Loc` decimal(6,2) DEFAULT '0.00',
  `op_serie` int(1) DEFAULT '0',
  `op_chapa` char(12) DEFAULT '',
  `op_fecha` datetime DEFAULT '2009-01-01 00:00:00',
  `op_nodoc` char(12) DEFAULT '',
  `op_modelo` char(60) DEFAULT '',
  `op_e_pantalla` decimal(12,2) DEFAULT '0.00',
  `op_ea_metroan` decimal(12,2) DEFAULT '0.00',
  `op_ea_metroac` decimal(12,2) DEFAULT '0.00',
  `op_ea_met` decimal(12,2) DEFAULT '0.00',
  `op_sa_metroan` decimal(12,2) DEFAULT '0.00',
  `op_sa_metroac` decimal(12,2) DEFAULT '0.00',
  `op_sa_met` decimal(12,2) DEFAULT '0.00',
  `op_eb_metroan` decimal(12,2) DEFAULT '0.00',
  `op_eb_metroac` decimal(12,2) DEFAULT '0.00',
  `op_eb_met` decimal(12,2) DEFAULT '0.00',
  `op_sb_metroan` decimal(12,2) DEFAULT '0.00',
  `op_sb_metroac` decimal(12,2) DEFAULT '0.00',
  `op_sb_met` decimal(12,2) DEFAULT '0.00',
  `op_s_pantalla` decimal(12,2) DEFAULT '0.00',
  `op_cal_colect` decimal(12,2) DEFAULT '0.00',
  `op_tot_colect` decimal(12,2) DEFAULT '0.00',
  `op_tot_impmunic` decimal(12,2) DEFAULT '0.00',
  `op_tot_impjcj` decimal(12,2) DEFAULT '0.00',
  `op_tot_timbres` decimal(12,2) DEFAULT '0.00',
  `op_tot_spac` decimal(12,2) DEFAULT '0.00',
  `op_tot_tec` decimal(12,2) DEFAULT '0.00',
  `op_tot_dev` decimal(12,2) DEFAULT '0.00',
  `op_tot_otros` decimal(12,2) DEFAULT '0.00',
  `op_tot_cred` decimal(12,2) DEFAULT '0.00',
  `op_cal_cred` decimal(12,2) DEFAULT '0.00',
  `op_tot_sub` decimal(12,2) DEFAULT '0.00',
  `op_tot_itbm` decimal(12,2) DEFAULT '0.00',
  `op_tot_tot` decimal(12,2) DEFAULT '0.00',
  `op_tot_brutoloc` decimal(6,2) DEFAULT '0.00',
  `op_tot_brutoemp` decimal(6,2) DEFAULT '0.00',
  `op_tot_netoloc` decimal(12,2) DEFAULT '0.00',
  `op_tot_netoemp` decimal(12,2) DEFAULT '0.00',
  `op_observ` longtext,
  `op_num_sem` int(3) DEFAULT '0',
  `op_fecha_alta` datetime DEFAULT '2009-01-01 00:00:00',
  `op_fecha_modif` datetime DEFAULT '2009-01-01 00:00:00',
  `u_usuario_alta` char(20) DEFAULT 'ANONIMO',
  `u_usuario_modif` char(20) DEFAULT 'ANONIMO',
  `op_emp_id` int(1) DEFAULT '0',
  `op_baja_prod` int(1) DEFAULT '0',
  `op_tot_colect2` decimal(12,2) DEFAULT '0.00',
  `op_tot_cred2` decimal(12,2) DEFAULT '0.00',
  `id_device` varchar(30) DEFAULT 'MANUAL',
  `id_group` bigint(20) DEFAULT NULL,
  `op_semanas_imp` int(1) DEFAULT '1',
  `op_image_name` varchar(80) DEFAULT NULL,
  `op_usermodify` int(1) DEFAULT '0',
  PRIMARY KEY (`id_op`),
  UNIQUE KEY `master_key` (`op_emp_id`,`id_device`,`id_group`,`cte_id`,`op_chapa`,`op_fecha`,`op_nodoc`),
  KEY `MaqLnk_Id` (`MaqLnk_Id`),
  KEY `op_modelo` (`op_modelo`),
  KEY `op_fecha` (`op_fecha`),
  KEY `op_chapa` (`op_chapa`),
  KEY `op_nodoc` (`op_nodoc`),
  KEY `op_serie` (`op_serie`),
  KEY `maqtc_tipomaq` (`maqtc_tipomaq`),
  KEY `op_emp_id` (`op_emp_id`),
  KEY `maqtc_denom_e` (`maqtc_denom_e`),
  KEY `maqtc_denom_s` (`maqtc_denom_s`),
  KEY `cte_id` (`cte_id`),
  KEY `op_num_sem` (`op_num_sem`),
  KEY `op_baja_prod` (`op_baja_prod`),
  KEY `id_device` (`id_device`),
  KEY `op_usermodify` (`op_usermodify`),
  KEY `id_group` (`id_group`)
) ENGINE=InnoDB AUTO_INCREMENT=94534 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.operaciong
DROP TABLE IF EXISTS `operaciong`;
CREATE TABLE IF NOT EXISTS `operaciong` (
  `id_autoin` int(11) NOT NULL AUTO_INCREMENT,
  `cte_id` int(4) unsigned DEFAULT '0',
  `cte_nombre_loc` char(60) DEFAULT '',
  `cte_nombre_com` char(60) DEFAULT '',
  `op_cal_colect` decimal(12,2) DEFAULT '0.00',
  `op_tot_colect` decimal(12,2) DEFAULT '0.00',
  `op_tot_impmunic` decimal(12,2) DEFAULT '0.00',
  `op_tot_impjcj` decimal(12,2) DEFAULT '0.00',
  `op_tot_timbres` decimal(12,2) DEFAULT '0.00',
  `op_tot_spac` decimal(12,2) DEFAULT '0.00',
  `op_tot_tec` decimal(12,2) DEFAULT '0.00',
  `op_tot_dev` decimal(12,2) DEFAULT '0.00',
  `op_tot_otros` decimal(12,2) DEFAULT '0.00',
  `op_tot_cred` decimal(12,2) DEFAULT '0.00',
  `op_cal_cred` decimal(12,2) DEFAULT '0.00',
  `op_tot_sub` decimal(12,2) DEFAULT '0.00',
  `op_tot_itbm` decimal(12,2) DEFAULT '0.00',
  `op_tot_tot` decimal(12,2) DEFAULT '0.00',
  `op_tot_brutoloc` decimal(12,2) DEFAULT '0.00',
  `op_tot_brutoemp` decimal(12,2) DEFAULT '0.00',
  `op_tot_netoloc` decimal(12,2) DEFAULT '0.00',
  `op_tot_netoemp` decimal(12,2) DEFAULT '0.00',
  `op_observ` longtext,
  `op_emp_id` int(1) DEFAULT '0',
  `id_device` varchar(30) DEFAULT 'MANUAL',
  `id_group` bigint(20) DEFAULT NULL,
  `op_fecha_alta` datetime DEFAULT '2009-01-01 00:00:00',
  `op_fecha_modif` datetime DEFAULT '2009-01-01 00:00:00',
  `op_usermodify` int(1) DEFAULT '0',
  PRIMARY KEY (`id_autoin`),
  UNIQUE KEY `master_key` (`op_emp_id`,`cte_id`,`id_device`,`id_group`),
  KEY `cte_id` (`cte_id`),
  KEY `op_emp_id` (`op_emp_id`),
  KEY `id_device` (`id_device`),
  KEY `op_usermodify` (`op_usermodify`),
  KEY `id_group` (`id_group`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.operaciong_trans
DROP TABLE IF EXISTS `operaciong_trans`;
CREATE TABLE IF NOT EXISTS `operaciong_trans` (
  `id_autoin` int(11) NOT NULL AUTO_INCREMENT,
  `cte_id` int(4) unsigned DEFAULT '0',
  `cte_nombre_loc` char(60) DEFAULT '',
  `cte_nombre_com` char(60) DEFAULT '',
  `op_cal_colect` decimal(12,2) DEFAULT '0.00',
  `op_tot_colect` decimal(12,2) DEFAULT '0.00',
  `op_tot_impmunic` decimal(12,2) DEFAULT '0.00',
  `op_tot_impjcj` decimal(12,2) DEFAULT '0.00',
  `op_tot_timbres` decimal(12,2) DEFAULT '0.00',
  `op_tot_spac` decimal(12,2) DEFAULT '0.00',
  `op_tot_tec` decimal(12,2) DEFAULT '0.00',
  `op_tot_dev` decimal(12,2) DEFAULT '0.00',
  `op_tot_otros` decimal(12,2) DEFAULT '0.00',
  `op_tot_cred` decimal(12,2) DEFAULT '0.00',
  `op_cal_cred` decimal(12,2) DEFAULT '0.00',
  `op_tot_sub` decimal(12,2) DEFAULT '0.00',
  `op_tot_itbm` decimal(12,2) DEFAULT '0.00',
  `op_tot_tot` decimal(12,2) DEFAULT '0.00',
  `op_tot_brutoloc` decimal(12,2) DEFAULT '0.00',
  `op_tot_brutoemp` decimal(12,2) DEFAULT '0.00',
  `op_tot_netoloc` decimal(12,2) DEFAULT '0.00',
  `op_tot_netoemp` decimal(12,2) DEFAULT '0.00',
  `op_observ` longtext,
  `op_emp_id` int(1) DEFAULT '0',
  `id_device` varchar(30) DEFAULT 'MANUAL',
  `id_group` bigint(20) DEFAULT NULL,
  `op_fecha_alta` datetime DEFAULT '2009-01-01 00:00:00',
  `op_fecha_modif` datetime DEFAULT '2009-01-01 00:00:00',
  `op_usermodify` int(1) DEFAULT '0',
  PRIMARY KEY (`id_autoin`),
  UNIQUE KEY `master_key` (`op_emp_id`,`cte_id`,`id_device`,`id_group`),
  KEY `cte_id` (`cte_id`),
  KEY `op_emp_id` (`op_emp_id`),
  KEY `id_device` (`id_device`),
  KEY `op_usermodify` (`op_usermodify`),
  KEY `id_group` (`id_group`)
) ENGINE=InnoDB AUTO_INCREMENT=193 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.operacion_trans
DROP TABLE IF EXISTS `operacion_trans`;
CREATE TABLE IF NOT EXISTS `operacion_trans` (
  `id_op` int(10) NOT NULL AUTO_INCREMENT,
  `MaqLnk_Id` int(4) DEFAULT '0',
  `cte_id` int(4) unsigned DEFAULT '0',
  `cte_nombre_loc` char(60) DEFAULT '',
  `cte_nombre_com` char(60) DEFAULT '',
  `cte_pag_jcj` int(1) DEFAULT '0',
  `cte_pag_spac` int(1) DEFAULT '0',
  `cte_pag_impm` int(1) DEFAULT '0',
  `maqtc_denom_e` int(3) DEFAULT '0',
  `maqtc_denom_s` int(3) DEFAULT '0',
  `den_valore` decimal(12,2) DEFAULT '0.00',
  `den_valors` decimal(12,2) DEFAULT '0.00',
  `den_fact_e` int(3) DEFAULT '0',
  `den_fact_s` int(3) DEFAULT '0',
  `maqtc_tipomaq` int(1) DEFAULT '0',
  `op_cporc_Loc` decimal(6,2) DEFAULT '0.00',
  `op_serie` int(1) DEFAULT '0',
  `op_chapa` char(12) DEFAULT '',
  `op_fecha` datetime DEFAULT '2009-01-01 00:00:00',
  `op_nodoc` char(12) DEFAULT '',
  `op_modelo` char(60) DEFAULT '',
  `op_e_pantalla` decimal(12,2) DEFAULT '0.00',
  `op_ea_metroan` decimal(12,2) DEFAULT '0.00',
  `op_ea_metroac` decimal(12,2) DEFAULT '0.00',
  `op_ea_met` decimal(12,2) DEFAULT '0.00',
  `op_sa_metroan` decimal(12,2) DEFAULT '0.00',
  `op_sa_metroac` decimal(12,2) DEFAULT '0.00',
  `op_sa_met` decimal(12,2) DEFAULT '0.00',
  `op_eb_metroan` decimal(12,2) DEFAULT '0.00',
  `op_eb_metroac` decimal(12,2) DEFAULT '0.00',
  `op_eb_met` decimal(12,2) DEFAULT '0.00',
  `op_sb_metroan` decimal(12,2) DEFAULT '0.00',
  `op_sb_metroac` decimal(12,2) DEFAULT '0.00',
  `op_sb_met` decimal(12,2) DEFAULT '0.00',
  `op_s_pantalla` decimal(12,2) DEFAULT '0.00',
  `op_cal_colect` decimal(12,2) DEFAULT '0.00',
  `op_tot_colect` decimal(12,2) DEFAULT '0.00',
  `op_tot_impmunic` decimal(12,2) DEFAULT '0.00',
  `op_tot_impjcj` decimal(12,2) DEFAULT '0.00',
  `op_tot_timbres` decimal(12,2) DEFAULT '0.00',
  `op_tot_spac` decimal(12,2) DEFAULT '0.00',
  `op_tot_tec` decimal(12,2) DEFAULT '0.00',
  `op_tot_dev` decimal(12,2) DEFAULT '0.00',
  `op_tot_otros` decimal(12,2) DEFAULT '0.00',
  `op_tot_cred` decimal(12,2) DEFAULT '0.00',
  `op_cal_cred` decimal(12,2) DEFAULT '0.00',
  `op_tot_sub` decimal(12,2) DEFAULT '0.00',
  `op_tot_itbm` decimal(12,2) DEFAULT '0.00',
  `op_tot_tot` decimal(12,2) DEFAULT '0.00',
  `op_tot_brutoloc` decimal(12,2) DEFAULT '0.00',
  `op_tot_brutoemp` decimal(12,2) DEFAULT '0.00',
  `op_tot_netoloc` decimal(12,2) DEFAULT '0.00',
  `op_tot_netoemp` decimal(12,2) DEFAULT '0.00',
  `op_observ` longtext,
  `op_num_sem` int(3) DEFAULT '0',
  `op_fecha_alta` datetime DEFAULT '2009-01-01 00:00:00',
  `op_fecha_modif` datetime DEFAULT '2009-01-01 00:00:00',
  `u_usuario_alta` char(20) DEFAULT 'ANONIMO',
  `u_usuario_modif` char(20) DEFAULT 'ANONIMO',
  `op_emp_id` int(1) DEFAULT '0',
  `op_baja_prod` int(1) DEFAULT '0',
  `op_tot_colect2` decimal(12,2) DEFAULT '0.00',
  `op_tot_cred2` decimal(12,2) DEFAULT '0.00',
  `id_device` varchar(30) DEFAULT 'MANUAL',
  `id_group` bigint(20) DEFAULT NULL,
  `op_semanas_imp` int(1) DEFAULT '1',
  `op_image_name` varchar(80) DEFAULT NULL,
  `op_usermodify` int(1) DEFAULT '0',
  PRIMARY KEY (`id_op`),
  UNIQUE KEY `master_key` (`op_emp_id`,`id_device`,`id_group`,`cte_id`,`op_chapa`,`op_fecha`,`op_nodoc`),
  KEY `MaqLnk_Id` (`MaqLnk_Id`),
  KEY `op_modelo` (`op_modelo`),
  KEY `op_fecha` (`op_fecha`),
  KEY `op_chapa` (`op_chapa`),
  KEY `op_nodoc` (`op_nodoc`),
  KEY `op_serie` (`op_serie`),
  KEY `maqtc_tipomaq` (`maqtc_tipomaq`),
  KEY `op_emp_id` (`op_emp_id`),
  KEY `maqtc_denom_e` (`maqtc_denom_e`),
  KEY `maqtc_denom_s` (`maqtc_denom_s`),
  KEY `cte_id` (`cte_id`),
  KEY `op_num_sem` (`op_num_sem`),
  KEY `op_baja_prod` (`op_baja_prod`),
  KEY `id_device` (`id_device`),
  KEY `op_usermodify` (`op_usermodify`),
  KEY `id_group` (`id_group`)
) ENGINE=InnoDB AUTO_INCREMENT=1400 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.pais
DROP TABLE IF EXISTS `pais`;
CREATE TABLE IF NOT EXISTS `pais` (
  `PaisCodigo` char(3) NOT NULL DEFAULT '',
  `PaisNombre` char(52) NOT NULL DEFAULT '',
  `PaisContinente` varchar(50) NOT NULL DEFAULT 'Asia',
  `PaisRegion` varchar(26) NOT NULL DEFAULT '',
  `PaisArea` float NOT NULL DEFAULT '0',
  `PaisIndependencia` smallint(6) DEFAULT NULL,
  `PaisPoblacion` int(11) NOT NULL DEFAULT '0',
  `PaisExpectativaDeVida` float DEFAULT NULL,
  `PaisProductoInternoBruto` float DEFAULT NULL,
  `PaisProductoInternoBrutoAntiguo` float DEFAULT NULL,
  `PaisNombreLocal` varchar(45) NOT NULL DEFAULT '',
  `PaisGobierno` varchar(45) NOT NULL DEFAULT '',
  `PaisJefeDeEstado` varchar(60) DEFAULT NULL,
  `PaisCapital` int(11) DEFAULT NULL,
  `PaisCodigo2` char(2) NOT NULL DEFAULT '',
  PRIMARY KEY (`PaisCodigo`),
  KEY `PaisCodigo2` (`PaisCodigo2`),
  KEY `PaisNombre` (`PaisNombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.personal
DROP TABLE IF EXISTS `personal`;
CREATE TABLE IF NOT EXISTS `personal` (
  `id_autoinc` int(11) NOT NULL AUTO_INCREMENT,
  `pers_nip` char(30) DEFAULT NULL,
  `pers_inactivo` int(1) DEFAULT '0',
  `pers_nom_prim` varchar(60) DEFAULT NULL,
  `pers_nom_seg` varchar(60) DEFAULT NULL,
  `pers_apell_prim` varchar(60) DEFAULT NULL,
  `pers_apell_seg` varchar(60) DEFAULT NULL,
  `pers_dire_1` varchar(255) DEFAULT NULL,
  `pers_dire_2` varchar(255) DEFAULT NULL,
  `pers_pais` char(2) DEFAULT NULL,
  `pers_ciudad` varchar(40) DEFAULT NULL,
  `pers_sexo` char(1) DEFAULT '0',
  `pers_estado_civil` int(1) DEFAULT '0',
  `pers_fecha_nac` date DEFAULT NULL,
  `pers_movil` varchar(30) DEFAULT NULL,
  `pers_telef` varchar(30) DEFAULT NULL,
  `pers_correo` varchar(40) DEFAULT NULL,
  `pers_salario` decimal(10,2) DEFAULT '0.00',
  `pers_fecha_ingreso` date DEFAULT NULL,
  `pers_fecha_fin` date DEFAULT NULL,
  `pers_fecha_crea` datetime DEFAULT NULL,
  `pers_fecha_mod` datetime DEFAULT NULL,
  `pers_usua_crea` varchar(50) DEFAULT NULL,
  `pers_usua_mod` varchar(50) DEFAULT NULL,
  `pers_imagen` mediumblob,
  `pers_imagen_path` varchar(250) DEFAULT NULL,
  `pers_notas` blob,
  `pers_ban_cta` char(30) NOT NULL,
  `pers_ban_tipo` char(1) NOT NULL DEFAULT 'N',
  `pers_ban_nombre` char(80) NOT NULL,
  `pers_quest1` int(1) NOT NULL DEFAULT '0',
  `pers_quest2` int(1) NOT NULL DEFAULT '0',
  `pers_quest3` int(1) NOT NULL DEFAULT '0',
  `pers_quest4` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_autoinc`),
  KEY `pers_apell_prim` (`pers_apell_prim`),
  KEY `pers_apell_seg` (`pers_apell_seg`),
  KEY `pers_ban_cta` (`pers_ban_cta`),
  KEY `pers_inactivo` (`pers_inactivo`),
  KEY `pers_nip` (`pers_nip`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.premios
DROP TABLE IF EXISTS `premios`;
CREATE TABLE IF NOT EXISTS `premios` (
  `Id_Trans` int(10) NOT NULL AUTO_INCREMENT,
  `Emp_Id` int(4) DEFAULT '1',
  `Chapa` char(12) NOT NULL,
  `Cod_Maq` char(12) DEFAULT NULL,
  `No_Doc` char(20) DEFAULT NULL,
  `Turno` int(4) DEFAULT '1',
  `Fecha_Pago` datetime DEFAULT '2009-01-01 00:00:00',
  `Monto_PagadoM` decimal(12,2) DEFAULT '0.00',
  `Monto_PagadoR` decimal(12,2) DEFAULT '0.00',
  `Monto_Diferencia` decimal(12,2) DEFAULT '0.00',
  `Notas` text,
  `Flag20` int(4) DEFAULT '0',
  `Usuario_Crea` char(20) DEFAULT NULL,
  `Usuario_FechC` datetime DEFAULT '2009-01-01 00:00:00',
  `Usuario_Mod` char(20) DEFAULT NULL,
  `Usuario_FechM` datetime DEFAULT '2009-01-01 00:00:00',
  `Usuario_Elim` char(20) DEFAULT NULL,
  `Usuario_FechE` datetime DEFAULT '2009-01-01 00:00:00',
  PRIMARY KEY (`Id_Trans`),
  KEY `Chapa` (`Chapa`),
  KEY `Cod_Maq` (`Cod_Maq`),
  KEY `Emp_Id` (`Emp_Id`),
  KEY `Turno` (`Turno`),
  KEY `Fecha_Pago` (`Fecha_Pago`),
  KEY `Flag20` (`Flag20`),
  KEY `No_Doc` (`No_Doc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.proveedores
DROP TABLE IF EXISTS `proveedores`;
CREATE TABLE IF NOT EXISTS `proveedores` (
  `id_autoinc` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `prov_nombre` char(80) NOT NULL DEFAULT '',
  `prov_nombre2` char(80) NOT NULL DEFAULT '',
  `prov_ruc` char(50) NOT NULL DEFAULT '',
  `prov_telefono1` char(25) NOT NULL DEFAULT '',
  `prov_telefono2` char(25) NOT NULL DEFAULT '',
  `prov_fax` char(25) NOT NULL DEFAULT '',
  `prov_contacto_nom` char(35) NOT NULL DEFAULT '',
  `prov_contacto_movil` char(25) NOT NULL DEFAULT '',
  `prov_contacto_movil_email` char(120) NOT NULL DEFAULT '',
  `prov_email` char(120) NOT NULL DEFAULT '',
  `prov_webpage` varchar(130) NOT NULL DEFAULT '',
  `prov_notas` text,
  `prov_inactivo` tinyint(1) NOT NULL DEFAULT '0',
  `prov_direccion` text,
  `prov_fecha_alta` datetime NOT NULL DEFAULT '2010-01-01 00:00:00',
  `u_usuario_alta` char(20) NOT NULL DEFAULT 'ANONIMO',
  `prov_fecha_modif` datetime NOT NULL DEFAULT '2010-01-01 00:00:00',
  `u_usuario_modif` char(20) NOT NULL DEFAULT 'ANONIMO',
  `prov_ban_cta` char(30) NOT NULL,
  `prov_ban_tipo` char(1) NOT NULL DEFAULT 'N',
  `prov_ban_nombre` char(80) NOT NULL,
  PRIMARY KEY (`id_autoinc`),
  KEY `prov_ban_cta` (`prov_ban_cta`),
  KEY `prov_inactivo` (`prov_inactivo`),
  KEY `prov_nombre` (`prov_nombre`),
  KEY `prov_nombre2` (`prov_nombre2`),
  KEY `prov_ruc` (`prov_ruc`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.rutas
DROP TABLE IF EXISTS `rutas`;
CREATE TABLE IF NOT EXISTS `rutas` (
  `rut_id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `rut_inactivo` int(1) unsigned NOT NULL DEFAULT '0',
  `rut_nombre` char(80) NOT NULL DEFAULT '',
  `rut_notas` longtext,
  `rut_fecha_alta` datetime NOT NULL DEFAULT '2010-01-01 00:00:00',
  `rut_fecha_modif` datetime NOT NULL DEFAULT '2010-01-01 00:00:00',
  `u_usuario_alta` varchar(20) NOT NULL DEFAULT 'ANONIMO',
  `u_usuario_modif` varchar(20) NOT NULL DEFAULT 'ANONIMO',
  PRIMARY KEY (`rut_id`),
  KEY `rut_inactivo` (`rut_inactivo`),
  KEY `rut_nombre` (`rut_nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla one2009_1.usuarios
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `u_Id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `u_descripcion` varchar(120) NOT NULL DEFAULT '',
  `u_usuario` varchar(20) NOT NULL DEFAULT '',
  `u_clave` varchar(50) NOT NULL DEFAULT '',
  `u_acceso1` int(2) NOT NULL DEFAULT '0',
  `u_activo` int(1) NOT NULL DEFAULT '0',
  `u_modreportes` int(1) NOT NULL DEFAULT '0',
  `u_empresas` int(1) NOT NULL DEFAULT '0',
  `u_auditoria` int(1) NOT NULL DEFAULT '0',
  `u_conf` int(1) NOT NULL DEFAULT '0',
  `u_ruta_reportes` varchar(50) NOT NULL DEFAULT '',
  `u_usuario_alta` varchar(50) DEFAULT NULL,
  `u_fecha_alta` datetime DEFAULT NULL,
  `u_usuario_modif` varchar(50) NOT NULL,
  `u_fecha_modif` datetime DEFAULT NULL,
  `emp_id` int(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`u_Id`),
  KEY `u_usuario` (`u_usuario`),
  KEY `u_clave` (`u_clave`),
  KEY `u_activo` (`u_activo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para procedimiento one2009_1.actualiza_corre
DROP PROCEDURE IF EXISTS `actualiza_corre`;
DELIMITER //
CREATE DEFINER=`remoto`@`%` PROCEDURE `actualiza_corre`(
	IN `pid_devide` VARCHAR(50)
)
BEGIN
SET @corre=(SELECT corre_act FROM device_db.dispositivos WHERE serial=pid_devide);

UPDATE operacion SET 
	op_nodoc = CONCAT(DATE_FORMAT(op_fecha, "%Y%m%d"), LPAD(@corre:=@corre+1,4,'0'))
WHERE id_device=pid_devide
AND   op_usermodify=1 ;

UPDATE operacion SET 
	op_usermodify=0
WHERE id_device=pid_devide
AND   op_usermodify=1;

UPDATE device_db.dispositivos SET
	corre_ant=corre_act,
	corre_act=@corre
WHERE serial=pid_devide;
END//
DELIMITER ;

-- Volcando estructura para procedimiento one2009_1.actualiza_corre2
DROP PROCEDURE IF EXISTS `actualiza_corre2`;
DELIMITER //
CREATE DEFINER=`remoto`@`%` PROCEDURE `actualiza_corre2`(
	IN `pemp_id` VARCHAR(50)





)
BEGIN
SET @corre=(SELECT IFNULL(emp_corre_act,0) AS emp_corre_act FROM empresas WHERE emp_id=pemp_id);

UPDATE operacion SET 
	op_nodoc = CONCAT( LPAD(op_emp_id,2,'0'),'-',LPAD(@corre:=@corre+1,7,'0') )
WHERE op_emp_id=pemp_id
AND   op_usermodify=1 ;

UPDATE operacion SET 
	op_usermodify=0
WHERE op_emp_id=pemp_id
AND   op_usermodify=1;

UPDATE empresas SET
	emp_corre_ant=emp_corre_act,
	emp_corre_act=@corre 
WHERE emp_id=pemp_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento one2009_1.actualiza_maquinas
DROP PROCEDURE IF EXISTS `actualiza_maquinas`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualiza_maquinas`(
	IN `pCod_Emp` VARCHAR(5),
	IN `pCod_Dev` VARCHAR(50),
	IN `pCod_Cte` VARCHAR(50)




)
BEGIN
/*-------------------------actualiza baja produccion------------------------------             */
SET @corre=(SELECT IFNULL(emp_corre_act,0) AS emp_corre_act FROM empresas WHERE emp_id=pCod_Emp);

UPDATE operacion op
JOIN clientes ct ON op.cte_id = ct.cte_id SET 
	op.op_tot_brutoloc = IF(ct.cte_poc_ret=100,000000000000.00, (op.op_tot_tot * (ct.cte_poc_ret/100)) )
WHERE (op.op_emp_id 	= pCod_Emp)
AND 	(op.id_device 	= pCod_Dev)
AND 	(op.cte_id    	= pCod_Cte);

UPDATE operacion op
JOIN clientes ct ON op.cte_id = ct.cte_id SET 
 	op.op_tot_brutoemp = IF(ct.cte_poc_ret=100, op.op_tot_tot , (op.op_tot_tot - op.op_tot_brutoloc)   ),
 	op.op_tot_netoloc	 = (op.op_tot_dev + op.op_tot_otros + op.op_tot_cred + op.op_tot_brutoloc),
 	op.op_tot_netoemp	 = (op.op_tot_timbres + op.op_tot_impmunic + op.op_tot_impjcj + op.op_tot_tec + op.op_tot_brutoemp)
WHERE (op.op_emp_id 	= pCod_Emp)
AND 	(op.id_device 	= pCod_Dev)
AND 	(op.cte_id    	= pCod_Cte);

UPDATE operacion SET 
	op_nodoc = CONCAT( LPAD(op_emp_id,2,'0'),'-',LPAD(@corre:=@corre+1,7,'0') )
WHERE op_emp_id=pCod_Emp
AND   op_usermodify=1 ;

UPDATE operacion SET 
	op_usermodify=0
WHERE op_emp_id=pCod_Emp
AND   op_usermodify=1;

UPDATE empresas SET
	emp_corre_ant=emp_corre_act,
	emp_corre_act=@corre 
WHERE emp_id=pCod_Emp;
/*----------------------------------------------------------------------------------------------*/

/*-------------------------actualiza baja produccion------------------------------             */
UPDATE maquinastc maq 
JOIN operacion_trans opt ON (opt.op_chapa = maq.maqtc_chapa)  and (opt.op_emp_id=maq.emp_id)
	SET maq.maqtc_sem_jcj = maq.maqtc_sem_jcj-1
WHERE (opt.op_emp_id 	= pCod_Emp)
AND 	(opt.id_device 	= pCod_Dev)
AND 	(opt.cte_id    	= pCod_Cte)
AND   (opt.op_usermodify=1)
AND   (opt.op_baja_prod >0);

UPDATE maquinastc maq 
SET maq.maqtc_sem_jcj=0
WHERE (maq.maqtc_sem_jcj<0);

UPDATE maquinastc maq 
JOIN operacion_trans opt ON (opt.op_chapa = maq.maqtc_chapa)  and (opt.op_emp_id=maq.emp_id)
	SET maq.maqtc_sem_jcj = maq.maqtc_sem_jcj+1
WHERE (opt.op_emp_id 	= pCod_Emp)
AND 	(opt.id_device 	= pCod_Dev)
AND 	(opt.cte_id    	= pCod_Cte)
AND   (opt.op_usermodify=1)
AND   (opt.op_baja_prod =1);
/*----------------------------------------------------------------------------------------------*/

/*-------------------------actualiza demoninacion en efectivon---------------------------------- */ 
UPDATE maquinastc maq 
JOIN operacion_trans opt ON (opt.op_chapa = maq.maqtc_chapa)  and (opt.op_emp_id=maq.emp_id)
	SET 
	maq.maqtc_denom_e = opt.maqtc_denom_e
WHERE (opt.op_emp_id 	= pCod_Emp)
AND 	(opt.id_device 	= pCod_Dev)
AND 	(opt.cte_id    	= pCod_Cte)
AND   (opt.op_usermodify=1)
AND   (opt.maqtc_denom_e=1);

UPDATE maquinastc maq 
JOIN operacion_trans opt ON (opt.op_chapa = maq.maqtc_chapa)  and (opt.op_emp_id=maq.emp_id)
	SET 
	maq.maqtc_denom_s = opt.maqtc_denom_s
WHERE (opt.op_emp_id 	= pCod_Emp)
AND 	(opt.id_device 	= pCod_Dev)
AND 	(opt.cte_id    	= pCod_Cte)
AND   (opt.op_usermodify=1)
AND   (opt.maqtc_denom_s=1);
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
WHERE (opt.op_emp_id 	= pCod_Emp)
AND 	(opt.id_device 	= pCod_Dev)
AND 	(opt.cte_id    	= pCod_Cte)
AND   (opt.op_usermodify=1)
AND   (opt.op_baja_prod=0);
/*----------------------------------------------------------------------------------------------*/
UPDATE operaciong_trans 
	SET op_usermodify=0
WHERE (op_emp_id    = pCod_Emp)
AND 	(id_device 	  = pCod_Dev)
AND 	(cte_id    	  = pCod_Cte)
AND   (op_usermodify=1);

UPDATE operacion_trans 
	SET op_usermodify=0
WHERE (op_emp_id    = pCod_Emp)
AND 	(id_device 	  = pCod_Dev)
AND 	(cte_id    	  = pCod_Cte)
AND   (op_usermodify=1);

UPDATE operacion op
JOIN clientes ct ON op.cte_id = ct.cte_id SET 
	op.op_tot_brutoloc = IF(ct.cte_poc_ret=100,000000000000.00, (op.op_tot_tot * (ct.cte_poc_ret/100)) )
WHERE (op.op_emp_id 	= pCod_Emp)
AND 	(op.id_device 	= pCod_Dev)
AND 	(op.cte_id    	= pCod_Cte);

UPDATE operacion op
JOIN clientes ct ON op.cte_id = ct.cte_id SET 
 	op.op_tot_brutoemp = IF(ct.cte_poc_ret=100, op.op_tot_tot , (op.op_tot_tot - op.op_tot_brutoloc)   ),
 	op.op_tot_netoloc	 = (op.op_tot_dev + op.op_tot_otros + op.op_tot_cred + op.op_tot_brutoloc),
 	op.op_tot_netoemp	 = (op.op_tot_timbres + op.op_tot_impmunic + op.op_tot_impjcj + op.op_tot_tec + op.op_tot_brutoemp)
WHERE (op.op_emp_id 	= pCod_Emp)
AND 	(op.id_device 	= pCod_Dev)
AND 	(op.cte_id    	= pCod_Cte);

END//
DELIMITER ;

-- Volcando estructura para procedimiento one2009_1.AddColumnUnlessExists
DROP PROCEDURE IF EXISTS `AddColumnUnlessExists`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddColumnUnlessExists`(IN `dbName` tinytext, IN `tableName` tinytext, IN `fieldName` tinytext, IN `fieldDef` text)
BEGIN



	IF (@@local.group_concat_max_len < 1000000) THEN 



		SET SESSION group_concat_max_len = 1000000;



	END IF;



	IF NOT EXISTS (



		SELECT * FROM information_schema.COLUMNS



		WHERE column_name=fieldName



		AND table_name   = (SELECT CASE WHEN ((tableName IS NULL) OR (TRIM(tableName = ''))) THEN 'NONE'     ELSE tableName END  AS cValue2) 



		AND table_schema = (SELECT CASE WHEN ((dbName    IS NULL) OR (TRIM(dbName    = ''))) THEN DATABASE() ELSE dbName    END  AS cValue1)  



		)



	THEN



		SET @ddl=CONCAT('ALTER TABLE ',dbName,'.',tableName,' ADD COLUMN ',fieldName,' ',fieldDef);



		CALL pExecuteImmediate(@ddl);



	END IF;



END//
DELIMITER ;

-- Volcando estructura para procedimiento one2009_1.Change_Collate
DROP PROCEDURE IF EXISTS `Change_Collate`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Change_Collate`()
    SQL SECURITY INVOKER
BEGIN



DECLARE done INT DEFAULT 0; 



DECLARE cur_Table VARCHAR(255); 



DECLARE list_cursor CURSOR FOR 



  SELECT CONCAT("ALTER TABLE `", t.`table_schema`, "`.`", t.`table_name`, 



         "` COLLATE='utf8_spanish_ci', CONVERT TO CHARSET utf8 ;" 



         ) AS stmt 



  FROM   `information_schema`.`tables` t 



  WHERE  t.`table_type` = 'BASE TABLE' 



         AND t.`table_schema` = DATABASE() 



  ORDER  BY 1; 



DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1; 



OPEN list_cursor; 



REPEAT FETCH list_cursor INTO cur_Table; 



	IF cur_Table IS NOT NULL THEN



		CALL pExecuteImmediate(cur_Table);



	END IF; 



UNTIL done END REPEAT; 



CLOSE list_cursor; 



END//
DELIMITER ;

-- Volcando estructura para procedimiento one2009_1.drop_tables_like
DROP PROCEDURE IF EXISTS `drop_tables_like`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `drop_tables_like`(IN `DbName` varchar(255), IN `pattern` varchar(255))
BEGIN DECLARE cDb varchar(80); IF (@@local.group_concat_max_len < 1000000) THEN SET SESSION group_concat_max_len = 1000000; END IF; IF (DbName = '') THEN SET cDb := database(); ELSE SET cDb := DbName; END IF; SELECT @drop_sql := Concat('DROP TABLE IF EXISTS ', GROUP_CONCAT(table_name)) drop_statement FROM information_schema.TABLES WHERE table_schema = cdb AND table_name LIKE pattern; IF (@drop_sql IS NOT NULL) THEN CALL pExecuteImmediate(@drop_sql); END IF; END//
DELIMITER ;

-- Volcando estructura para procedimiento one2009_1.Get_AllFields_Exept
DROP PROCEDURE IF EXISTS `Get_AllFields_Exept`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Get_AllFields_Exept`(IN `pTable_Name` VARCHAR(50), IN `pFieldExclude` VARCHAR(500))
BEGIN



	DECLARE cExceptField  VARCHAR(500); 



	IF (@@local.group_concat_max_len < 1000000) THEN 



		SET SESSION group_concat_max_len = 1000000;



	END IF;



	IF ((pFieldExclude='') OR (pFieldExclude IS NULL) OR (pFieldExclude='%') ) THEN 



		SET cExceptField = '';



	ELSE



		SET cExceptField = CONCAT('AND col.column_name NOT IN("' , pFieldExclude , '")');



	END IF;



	SET @SqlLine = CONCAT('



		SELECT 



		GROUP_CONCAT(col.column_name SEPARATOR ", ") AS FieldsList 



  		FROM   information_schema.columns col 



  		WHERE  col.table_schema = DATABASE() ',cExceptField,'



  		AND col.table_name = "' , pTable_Name , '"; ');



	CALL pExecuteImmediate(@SqlLine);  	



END//
DELIMITER ;

-- Volcando estructura para procedimiento one2009_1.Get_AllFields_Exept2
DROP PROCEDURE IF EXISTS `Get_AllFields_Exept2`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `Get_AllFields_Exept2`(IN `pDatabase_Name` VARCHAR(100), IN `pTable_Name` VARCHAR(100), IN `pFieldExclude` VARCHAR(500))
BEGIN



	DECLARE cExceptField  VARCHAR(255); 



	IF (@@local.group_concat_max_len < 1000000) THEN 



		SET SESSION group_concat_max_len = 1000000;



	END IF;



	IF ((pFieldExclude='') OR (pFieldExclude IS NULL) OR (pFieldExclude='%') ) THEN 



		SET cExceptField = '';



	ELSE



		SET cExceptField = CONCAT('AND col.column_name NOT IN("' , pFieldExclude , '")');



	END IF;







	SET @SqlLine = CONCAT('



		SELECT 



		GROUP_CONCAT(col.column_name SEPARATOR ", ") AS FieldsList 



	  	FROM   information_schema.columns col 



	 	WHERE  col.table_schema = "',pDatabase_Name,'" ',cExceptField,'



	  	AND col.table_name = "' , pTable_Name , '"; ');



	CALL pExecuteImmediate(@SqlLine);  	



END//
DELIMITER ;

-- Volcando estructura para procedimiento one2009_1.pExecuteImmediate
DROP PROCEDURE IF EXISTS `pExecuteImmediate`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `pExecuteImmediate`(IN `tSQLStmt` TEXT)
BEGIN
  SET @executeImmediateSQL = tSQLStmt;
  PREPARE executeImmediateSTML FROM @executeImmediateSQL;
  EXECUTE executeImmediateSTML;
  DEALLOCATE PREPARE executeImmediateSTML;
END//
DELIMITER ;

-- Volcando estructura para procedimiento one2009_1.pLog
DROP PROCEDURE IF EXISTS `pLog`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `pLog`(IN `sTitle`  VARCHAR(255), IN `sMsg` VARCHAR(255))
BEGIN



  DECLARE strSQL VARCHAR(512);



  SET strSQL = CONCAT('SELECT ''', sMsg, ''' AS ''', sTitle, '''');



  CALL pExecuteImmediate(strSQL);



END//
DELIMITER ;

-- Volcando estructura para procedimiento one2009_1.process_list
DROP PROCEDURE IF EXISTS `process_list`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `process_list`(IN `choice` char(4), IN `usernamein` varchar(16), IN `hostnamein` varchar(60))
BEGIN DECLARE CURCONN INT; IF choice <> "show" AND choice <> "kill" THEN SELECT "wrong choice"; END IF; IF usernamein = "" THEN SET usernamein = "%"; END IF; IF hostnamein = "" THEN SET hostnamein = "%"; END IF; SET CURCONN= (SELECT connection_id() ) ; IF choice = "show" THEN SELECT * FROM information_schema.processlist WHERE ID <> CURCONN AND USER LIKE usernamein AND ( HOST LIKE CONCAT(hostnamein ,":%") OR HOST LIKE hostnamein ); ELSEIF choice = "kill" THEN IF usernamein = "root" THEN SELECT "Illegal username when killing processes"; ELSE SET @CNT = ( SELECT COUNT(*) FROM information_schema.processlist WHERE ID <> CURCONN AND USER LIKE usernamein AND ( HOST LIKE CONCAT(hostnamein ,":%") OR HOST LIKE hostnamein ) ) ; SET @VAR =1; WHILE ( @VAR <= @CNT) DO SET @TID = ( SELECT id FROM information_schema.processlist WHERE ID <> CURCONN AND USER LIKE usernamein AND ( HOST LIKE CONCAT(hostnamein ,":%") OR HOST LIKE hostnamein ) limit 1 ) ; SET @k = CONCAT("kill " , @TID); PREPARE killcom FROM @k; EXECUTE killcom; SET @k =NULL; SET @VAR=@VAR+1; END WHILE; END IF; END IF; END//
DELIMITER ;

-- Volcando estructura para procedimiento one2009_1.RPCJC01
DROP PROCEDURE IF EXISTS `RPCJC01`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `RPCJC01`(IN `Cod_Emp` CHAR(25), IN `Cod_TipM` CHAR(25), IN `Cod_Chapa` CHAR(25), IN `Cod_Cte` CHAR(25), IN `Cod_Ruta` CHAR(25), IN `Cod_Mode` CHAR(60), IN `Fecha_Ini` VARCHAR(50), IN `Fecha_Fin` VARCHAR(50), IN `Cod_Order` INT)
BEGIN
	DROP TABLE IF EXISTS `tmp`.`FIEL01`;
CREATE TABLE `tmp`.`FIEL01`
	SELECT
		CASE 
		WHEN operacion.op_serie=1 THEN concat(CAST(DATE_FORMAT(operacion.op_fecha,'%m-%d-%Y') AS CHAR(15)),'A') 
		WHEN operacion.op_serie=2 THEN concat(CAST(DATE_FORMAT(operacion.op_fecha,'%m-%d-%Y') AS CHAR(15)),'B') 
		WHEN operacion.op_serie=3 THEN concat(CAST(DATE_FORMAT(operacion.op_fecha,'%m-%d-%Y') AS CHAR(15)),'C') 
		END AS MasterO,
		IF(TRIM(operacion.cte_nombre_loc)='',clientes.cte_nombre_loc,operacion.cte_nombre_loc) AS LOCAL2,
		operacion.*,
		IF(IFNULL(operacion.op_tot_colect,0)=0,0,(operacion.op_tot_cred/operacion.op_tot_colect)*100) AS Porc_Pag,
		rutas.rut_nombre,
		clientes.cte_id
		FROM operacion
		LEFT JOIN maquinas_lnk ON operacion.MaqLnk_Id   = maquinas_lnk.MaqLnk_Id
		LEFT JOIN maquinastc   ON maquinas_lnk.maqtc_id = maquinastc.maqtc_id
		LEFT JOIN empresas     ON maquinas_lnk.emp_id   = empresas.emp_id
		LEFT JOIN clientes     ON maquinas_lnk.cte_id   = clientes.cte_id  
		LEFT JOIN municipios   ON clientes.mun_id       = municipios.mun_id 
		LEFT JOIN rutas        ON clientes.rut_id       = rutas.rut_id  
		WHERE ((maquinastc.emp_id = Cod_Emp)
		AND   (maquinastc.maqtc_tipomaq LIKE Cod_TipM)
		AND   (operacion.op_chapa       LIKE Cod_Chapa)
		AND   (clientes.cte_id          LIKE Cod_Cte  )
		AND   (clientes.rut_id          LIKE Cod_Ruta)
		AND   (TRIM(operacion.op_modelo) LIKE TRIM(Cod_Mode))
		AND   ( operacion.op_fecha>=Fecha_Ini AND operacion.op_fecha<=Fecha_Fin) ) 
		ORDER BY CASE 
			WHEN Cod_Order=1 THEN '1, 2, operacion.op_chapa' 
			WHEN Cod_Order=2 THEN '1, 2' 
			WHEN Cod_Order=3 THEN '1, operacion.op_nodoc' 
			WHEN Cod_Order=4 THEN '1, operacion.op_chapa' 
			WHEN Cod_Order=5 THEN '1, 2, operacion.op_chapa'
			WHEN Cod_Order=6 THEN 'maquinastc.maqtc_modelo, 2, operacion.op_fecha, operacion.op_chapa'
			WHEN Cod_Order=7 THEN '1, 2, operacion.op_chapa'
			WHEN Cod_Order=8 THEN '1, 2, operacion.op_chapa'
			WHEN Cod_Order=9 THEN '1, operacion.op_chapa'
			WHEN Cod_Order=10 THEN 'rutas.rut_nombre, 2, operacion.op_chapa'
			END;

END//
DELIMITER ;

-- Volcando estructura para procedimiento one2009_1.RPCJC04
DROP PROCEDURE IF EXISTS `RPCJC04`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `RPCJC04`(IN `Cod_Emp` INT, IN `Cod_TipM` INT, IN `Cod_Chapa` CHAR(50), IN `PYear` INT, IN `PMont` INT)
BEGIN
	DROP TABLE IF EXISTS `tmp`.`FIEL01`;
CREATE TABLE `tmp`.`FIEL01`
	SELECT
		CASE 
		WHEN operacion.op_serie=1 THEN concat(CAST(DATE_FORMAT(operacion.op_fecha,'%m-%d-%Y') AS CHAR(15)),'A') 
		WHEN operacion.op_serie=2 THEN concat(CAST(DATE_FORMAT(operacion.op_fecha,'%m-%d-%Y') AS CHAR(15)),'B') 
		WHEN operacion.op_serie=3 THEN concat(CAST(DATE_FORMAT(operacion.op_fecha,'%m-%d-%Y') AS CHAR(15)),'C') 
		END AS MasterO,
		IF(TRIM(operacion.cte_nombre_loc)='',clientes.cte_nombre_loc,operacion.cte_nombre_loc) AS LOCAL2,
		operacion.*,
		0 AS Porc_Pag,
		clientes.cte_id
		FROM operacion
		LEFT JOIN maquinas_lnk ON operacion.MaqLnk_Id   = maquinas_lnk.MaqLnk_Id
		LEFT JOIN maquinastc   ON maquinas_lnk.maqtc_id = maquinastc.maqtc_id
		LEFT JOIN empresas     ON maquinas_lnk.emp_id   = empresas.emp_id
		LEFT JOIN clientes     ON maquinas_lnk.cte_id   = clientes.cte_id  
		LEFT JOIN municipios   ON clientes.mun_id       = municipios.mun_id 
		LEFT JOIN rutas        ON clientes.rut_id       = rutas.rut_id  
		WHERE ((maquinastc.emp_id = Cod_Emp)
		AND   (YEAR(operacion.op_fecha) = PYear)
		AND 	(MONTH(operacion.op_fecha)= PMont)
		AND   (maquinastc.maqtc_tipomaq LIKE Cod_TipM)
		AND   (operacion.op_chapa       LIKE Cod_Chapa))
		ORDER BY 1,operacion.op_chapa;

END//
DELIMITER ;

-- Volcando estructura para procedimiento one2009_1.trunc_tables_like
DROP PROCEDURE IF EXISTS `trunc_tables_like`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `trunc_tables_like`(IN `DbName` varchar(255), IN `pattern` varchar(255))
BEGIN DECLARE cDb varchar(80); IF (@@local.group_concat_max_len < 1000000) THEN SET SESSION group_concat_max_len = 1000000; END IF; IF (DbName = '') THEN SET cDb := database(); ELSE SET cDb := DbName; END IF; SELECT @drop_sql:=concat('TRUNCATE ', group_concat(table_name)) drop_statement FROM information_schema.tables WHERE table_schema = cDb and table_name like pattern; IF (@drop_sql IS NOT NULL) THEN CALL pExecuteImmediate(@drop_sql); END IF; END//
DELIMITER ;

-- Volcando estructura para función one2009_1.BASE64_DECODE
DROP FUNCTION IF EXISTS `BASE64_DECODE`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `BASE64_DECODE`(input BLOB) RETURNS blob
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
	DECLARE ret BLOB DEFAULT '';
	DECLARE done TINYINT DEFAULT 0;

	IF input IS NULL THEN
		RETURN NULL;
	END IF;

each_block:
	WHILE NOT done DO BEGIN
		DECLARE accum_value BIGINT UNSIGNED DEFAULT 0;
		DECLARE in_count TINYINT DEFAULT 0;
		DECLARE out_count TINYINT DEFAULT 3;

each_input_char:
		WHILE in_count < 4 DO BEGIN
			DECLARE first_char CHAR(1);
	
			IF LENGTH(input) = 0 THEN
				RETURN ret;
			END IF;
	
			SET first_char = SUBSTRING(input,1,1);
			SET input = SUBSTRING(input,2);
	
			BEGIN
				DECLARE tempval TINYINT UNSIGNED;
				DECLARE error TINYINT DEFAULT 0;
				DECLARE base64_getval CURSOR FOR SELECT val FROM base64_data WHERE c = first_char;
				DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET error = 1;
	
				OPEN base64_getval;
				FETCH base64_getval INTO tempval;
				CLOSE base64_getval;

				IF error THEN
					ITERATE each_input_char;
				END IF;

				SET accum_value = (accum_value << 6) + tempval;
			END;

			SET in_count = in_count + 1;

			IF first_char = '=' THEN
				SET done = 1;
				SET out_count = out_count - 1;
			END IF;
		END; END WHILE;

		-- We've now accumulated 24 bits; deaccumulate into bytes

		-- We have to work from the left, so use the third byte position and shift left
		WHILE out_count > 0 DO BEGIN
			SET ret = CONCAT(ret,CHAR((accum_value & 0xff0000) >> 16));
			SET out_count = out_count - 1;
			SET accum_value = (accum_value << 8) & 0xffffff;
		END; END WHILE;
	
	END; END WHILE;

	RETURN ret;
END//
DELIMITER ;

-- Volcando estructura para función one2009_1.BASE64_ENCODE
DROP FUNCTION IF EXISTS `BASE64_ENCODE`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `BASE64_ENCODE`(input BLOB) RETURNS blob
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
	DECLARE ret BLOB DEFAULT '';
	DECLARE done TINYINT DEFAULT 0;

	IF input IS NULL THEN
		RETURN NULL;
	END IF;

each_block:
	WHILE NOT done DO BEGIN
		DECLARE accum_value BIGINT UNSIGNED DEFAULT 0;
		DECLARE in_count TINYINT DEFAULT 0;
		DECLARE out_count TINYINT;

each_input_char:
		WHILE in_count < 3 DO BEGIN
			DECLARE first_char CHAR(1);
	
			IF LENGTH(input) = 0 THEN
				SET done = 1;
				SET accum_value = accum_value << (8 * (3 - in_count));
				LEAVE each_input_char;
			END IF;
	
			SET first_char = SUBSTRING(input,1,1);
			SET input = SUBSTRING(input,2);
	
			SET accum_value = (accum_value << 8) + ASCII(first_char);

			SET in_count = in_count + 1;
		END; END WHILE;

		-- We've now accumulated 24 bits; deaccumulate into base64 characters

		-- We have to work from the left, so use the third byte position and shift left
		CASE
			WHEN in_count = 3 THEN SET out_count = 4;
			WHEN in_count = 2 THEN SET out_count = 3;
			WHEN in_count = 1 THEN SET out_count = 2;
			ELSE RETURN ret;
		END CASE;

		WHILE out_count > 0 DO BEGIN
			BEGIN
				DECLARE out_char CHAR(1);
				DECLARE base64_getval CURSOR FOR SELECT c FROM base64_data WHERE val = (accum_value >> 18);

				OPEN base64_getval;
				FETCH base64_getval INTO out_char;
				CLOSE base64_getval;

				SET ret = CONCAT(ret,out_char);
				SET out_count = out_count - 1;
				SET accum_value = accum_value << 6 & 0xffffff;
			END;
		END; END WHILE;

		CASE
			WHEN in_count = 2 THEN SET ret = CONCAT(ret,'=');
			WHEN in_count = 1 THEN SET ret = CONCAT(ret,'==');
			ELSE BEGIN END;
		END CASE;
	
	END; END WHILE;

	RETURN ret;
END//
DELIMITER ;

-- Volcando estructura para función one2009_1.Does_Table_Exist
DROP FUNCTION IF EXISTS `Does_Table_Exist`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `Does_Table_Exist`(`s_database_name` nvarchar(255), `s_table_name` nvarchar(255)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN



IF EXISTS (



	SELECT 



		1



		FROM 



			Information_schema.tables



		WHERE 



			table_name = s_table_name AND 



			table_schema = s_database_name) 



	THEN



	RETURN 1;



ELSE



	RETURN 0;



END IF; 



END//
DELIMITER ;

-- Volcando estructura para función one2009_1.Exists_Field
DROP FUNCTION IF EXISTS `Exists_Field`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `Exists_Field`(`pDatabase` VARCHAR(255), `pTableName` VARCHAR(255), `pColumnName` VARCHAR(255)) RETURNS int(1)
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN



IF EXISTS (SELECT * 



		FROM   information_schema.columns 



		WHERE  table_schema = (SELECT CASE WHEN ((pDatabase  IS NULL)  OR  (pDatabase  = ''))  THEN DATABASE() ELSE pDatabase   END  AS cValue1)  



			AND table_name   = (SELECT CASE WHEN ((pTableName IS NULL)  OR  (pTableName = ''))  THEN 'NONE'     ELSE pTableName  END  AS cValue2)   



      	AND column_name  = (SELECT CASE WHEN ((pColumnName IS NULL) OR  (pColumnName = '')) THEN 'NONE'     ELSE pColumnName END  AS cValue3) ) THEN 



   RETURN 1;



ELSE



	IF ((pTableName IS NULL)  OR  (pTableName = ''))  OR ((pColumnName IS NULL) OR  (pColumnName = '')) THEN 



		RETURN -1;



	ELSE



		RETURN 0;



	END IF;	



END IF;



END//
DELIMITER ;

-- Volcando estructura para función one2009_1.get_random_string
DROP FUNCTION IF EXISTS `get_random_string`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `get_random_string`(`pmStringlength` INT) RETURNS varchar(100) CHARSET utf8
    DETERMINISTIC
BEGIN



	DECLARE vString_length INTEGER;



	DECLARE vReturn_string VARCHAR(100) DEFAULT '';



	DECLARE vTemp1	 INTEGER;



	DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN RETURN -99; END;







	SET vString_length = pmStringlength;







	WHILE vString_length > 0 DO



		SET vTemp1 = FLOOR( 65 + (RAND() * 57));



		IF (vTemp1 >= 90 AND vTemp1 <= 96) THEN



			SET vTemp1 = vTemp1 + 10;



		END IF;	



		SET vReturn_string = CONCAT(vReturn_string,CHAR(vTemp1));



		SET vString_length = vString_length - 1;	



	END WHILE;



	RETURN vReturn_string;



END//
DELIMITER ;

-- Volcando estructura para función one2009_1.Table_Exist
DROP FUNCTION IF EXISTS `Table_Exist`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `Table_Exist`(`pDatabase_Name` VARCHAR(255), `pTable_Name` VARCHAR(255)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN



	set @mivar = (SELECT 1 



	FROM Information_schema.tables 



	WHERE 



	table_name = trim(pTable_Name) 



	AND table_schema = trim(pDatabase_Name));







	IF @mivar=1 THEN



	RETURN 1;



	ELSE



	RETURN 0;



	END IF; 



END//
DELIMITER ;

-- Volcando estructura para función one2009_1.Triggers_Exists
DROP FUNCTION IF EXISTS `Triggers_Exists`;
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `Triggers_Exists`(`cTriggerName` VARCHAR(50)) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN







IF EXISTS (SELECT TRIGGER_NAME FROM INFORMATION_SCHEMA.TRIGGERS WHERE TRIGGER_NAME = cTriggerName AND TRIGGER_SCHEMA = DATABASE()) THEN



	RETURN 1;



ELSE



	RETURN 0;



END IF; 	







END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
