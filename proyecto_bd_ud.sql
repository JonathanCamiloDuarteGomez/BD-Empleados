-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema proyecto_ud
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema proyecto_ud
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `proyecto_ud` DEFAULT CHARACTER SET utf8mb3 ;
USE `proyecto_ud` ;

-- -----------------------------------------------------
-- Table `proyecto_ud`.`cargodelempleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`cargodelempleado` (
  `idCargoDeLosEmpleados` INT NOT NULL,
  `nombreDelCargo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCargoDeLosEmpleados`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`pais` (
  `idPais` INT NOT NULL,
  `nombreNacion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPais`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`ciudad` (
  `idCiudad` INT NOT NULL,
  `nombreCiudad` VARCHAR(45) NOT NULL,
  `pais_idPais` INT NOT NULL,
  PRIMARY KEY (`idCiudad`, `pais_idPais`),
  INDEX `fk_ciudades_pais_idx` (`pais_idPais` ASC) ,
  CONSTRAINT `fk_ciudades_pais`
    FOREIGN KEY (`pais_idPais`)
    REFERENCES `proyecto_ud`.`pais` (`idPais`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`codigodeseguridad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`codigodeseguridad` (
  `idCodigoDeSeguridad` INT NOT NULL,
  `codigoDeSeguridad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCodigoDeSeguridad`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`empresa` (
  `NIT` INT NOT NULL,
  `nombreEmpresa` VARCHAR(45) NOT NULL,
  `sede_idSede` INT NOT NULL,
  `sede_pais_idPais` INT NOT NULL,
  PRIMARY KEY (`NIT`, `sede_idSede`, `sede_pais_idPais`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`estadodelcontrato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`estadodelcontrato` (
  `idEstadoDelContrato` INT NOT NULL,
  `nombreEstadoDelContrato` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEstadoDelContrato`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`estadocivil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`estadocivil` (
  `idEstadoCivil` INT NOT NULL,
  `nombreEstadoCivil` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEstadoCivil`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`estrato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`estrato` (
  `idEstrato` INT NOT NULL,
  `nivelEstrato` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEstrato`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`genero` (
  `idGenero` INT NOT NULL,
  `tipoDeGenero` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idGenero`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`tipodedocumento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`tipodedocumento` (
  `idTipoDeDocumento` INT NOT NULL,
  `nombreTipoDeDocumento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoDeDocumento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`tipodesangre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`tipodesangre` (
  `idTipoDeSangre` INT NOT NULL,
  `nombreTipoDeSangre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoDeSangre`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`persona` (
  `numeroDocumento` INT NOT NULL,
  `primerNombre` VARCHAR(45) NOT NULL,
  `segundoNombre` VARCHAR(45) NULL DEFAULT NULL,
  `primerApellido` VARCHAR(45) NOT NULL,
  `segundoApellido` VARCHAR(45) NULL DEFAULT NULL,
  `fechaDeNacimiento` DATE NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  `estadoCivil_idEstadoCivil` INT NOT NULL,
  `tipoDeSangre_idTipoDeSangre` INT NOT NULL,
  `genero_idGenero` INT NOT NULL,
  `paisDeNacimiento_idPais` INT NOT NULL,
  `tipoDeDocumento_idTipoDeDocumento` INT NOT NULL,
  `estrato_idEstrato` INT NOT NULL,
  `ultimaActualizacion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`numeroDocumento`, `estadoCivil_idEstadoCivil`, `tipoDeSangre_idTipoDeSangre`, `genero_idGenero`, `paisDeNacimiento_idPais`, `tipoDeDocumento_idTipoDeDocumento`),
  INDEX `fk_persona_estadoCivil_idx` (`estadoCivil_idEstadoCivil` ASC) ,
  INDEX `fk_persona_tipoDeSangre_idx` (`tipoDeSangre_idTipoDeSangre` ASC) ,
  INDEX `fk_persona_genero_idx` (`genero_idGenero` ASC) ,
  INDEX `fk_persona_paisDeNacimiento_idx` (`paisDeNacimiento_idPais` ASC) ,
  INDEX `fk_persona_tipoDeDocumento_idx` (`tipoDeDocumento_idTipoDeDocumento` ASC) ,
  INDEX `fk_persona_estrato` (`estrato_idEstrato` ASC) ,
  CONSTRAINT `fk_persona_estadoCivil`
    FOREIGN KEY (`estadoCivil_idEstadoCivil`)
    REFERENCES `proyecto_ud`.`estadocivil` (`idEstadoCivil`),
  CONSTRAINT `fk_persona_estrato`
    FOREIGN KEY (`estrato_idEstrato`)
    REFERENCES `proyecto_ud`.`estrato` (`idEstrato`),
  CONSTRAINT `fk_persona_genero`
    FOREIGN KEY (`genero_idGenero`)
    REFERENCES `proyecto_ud`.`genero` (`idGenero`),
  CONSTRAINT `fk_persona_paisDeNacimiento`
    FOREIGN KEY (`paisDeNacimiento_idPais`)
    REFERENCES `proyecto_ud`.`pais` (`idPais`),
  CONSTRAINT `fk_persona_tipoDeDocumento`
    FOREIGN KEY (`tipoDeDocumento_idTipoDeDocumento`)
    REFERENCES `proyecto_ud`.`tipodedocumento` (`idTipoDeDocumento`),
  CONSTRAINT `fk_persona_tipoDeSangre`
    FOREIGN KEY (`tipoDeSangre_idTipoDeSangre`)
    REFERENCES `proyecto_ud`.`tipodesangre` (`idTipoDeSangre`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`tipodecontrato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`tipodecontrato` (
  `idTipoDeContrato` INT NOT NULL,
  `nombreTipoDeContrato` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoDeContrato`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`contrato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`contrato` (
  `idContrato` INT NOT NULL,
  `salario` DOUBLE NOT NULL,
  `persona_numeroDocumento` INT NOT NULL,
  `cargoDeLEmpleado_idCargoDeLosEmpleados` INT NOT NULL,
  `estadoDelContrato_idEstadoDelContrato` INT NOT NULL,
  `tipoDeContrato_idTipoDeContrato` INT NOT NULL,
  `empresa_NIT` INT NOT NULL,
  PRIMARY KEY (`idContrato`, `persona_numeroDocumento`, `cargoDeLEmpleado_idCargoDeLosEmpleados`, `estadoDelContrato_idEstadoDelContrato`, `tipoDeContrato_idTipoDeContrato`, `empresa_NIT`),
  INDEX `fk_Contrato_persona_idx` (`persona_numeroDocumento` ASC) ,
  INDEX `fk_Contrato_cargoDeLEmpleado_idx` (`cargoDeLEmpleado_idCargoDeLosEmpleados` ASC) ,
  INDEX `fk_Contrato_estadoDelContrato_idx` (`estadoDelContrato_idEstadoDelContrato` ASC) ,
  INDEX `fk_Contrato_tipoDeContrato_idx` (`tipoDeContrato_idTipoDeContrato` ASC) ,
  INDEX `fk_Contrato_empresa_idx` (`empresa_NIT` ASC) ,
  CONSTRAINT `fk_Contrato_cargoDeLEmpleado`
    FOREIGN KEY (`cargoDeLEmpleado_idCargoDeLosEmpleados`)
    REFERENCES `proyecto_ud`.`cargodelempleado` (`idCargoDeLosEmpleados`),
  CONSTRAINT `fk_Contrato_empresa`
    FOREIGN KEY (`empresa_NIT`)
    REFERENCES `proyecto_ud`.`empresa` (`NIT`),
  CONSTRAINT `fk_Contrato_estadoDelContrato`
    FOREIGN KEY (`estadoDelContrato_idEstadoDelContrato`)
    REFERENCES `proyecto_ud`.`estadodelcontrato` (`idEstadoDelContrato`),
  CONSTRAINT `fk_Contrato_persona`
    FOREIGN KEY (`persona_numeroDocumento`)
    REFERENCES `proyecto_ud`.`persona` (`numeroDocumento`),
  CONSTRAINT `fk_Contrato_tipoDeContrato`
    FOREIGN KEY (`tipoDeContrato_idTipoDeContrato`)
    REFERENCES `proyecto_ud`.`tipodecontrato` (`idTipoDeContrato`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`estadodeltitulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`estadodeltitulo` (
  `idEstadoDelTitulo` INT NOT NULL,
  `tipoEstadoDelTitulo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEstadoDelTitulo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`sector`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`sector` (
  `idSector` INT NOT NULL,
  `nombreSector` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSector`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`experiencialaboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`experiencialaboral` (
  `idExperienciaLaboral` INT NOT NULL AUTO_INCREMENT,
  `nombreEmpresa` VARCHAR(45) NOT NULL,
  `telefonoEmpresa` VARCHAR(45) NOT NULL,
  `cargo` VARCHAR(45) NOT NULL,
  `fechaDeIngreso` DATE NOT NULL,
  `fechaDeRetiro` DATE NOT NULL,
  `semanasCotizadas` FLOAT NOT NULL,
  `sector_idSector` INT NOT NULL,
  `persona_numeroDocumento` INT NOT NULL,
  PRIMARY KEY (`idExperienciaLaboral`, `sector_idSector`, `persona_numeroDocumento`),
  INDEX `fk_experienciaLaboral_sector_idx` (`sector_idSector` ASC) ,
  INDEX `fk_experienciaLaboral_persona_idx` (`persona_numeroDocumento` ASC) ,
  CONSTRAINT `fk_experienciaLaboral_persona`
    FOREIGN KEY (`persona_numeroDocumento`)
    REFERENCES `proyecto_ud`.`persona` (`numeroDocumento`),
  CONSTRAINT `fk_experienciaLaboral_sector`
    FOREIGN KEY (`sector_idSector`)
    REFERENCES `proyecto_ud`.`sector` (`idSector`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`niveldeeducacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`niveldeeducacion` (
  `idNivelDeEducacion` INT NOT NULL,
  `tipoNivelDeEducacion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idNivelDeEducacion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`nucleoconocimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`nucleoconocimiento` (
  `idNucleoConocimiento` INT NOT NULL,
  `nombreNucleoConocimiento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idNucleoConocimiento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`rol` (
  `idRol` INT NOT NULL,
  `tipoRol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idRol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`sede`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`sede` (
  `idSede` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `pais_idPais` INT NOT NULL,
  `empresa_NIT` INT NOT NULL,
  `ciudad_idCiudad` INT NOT NULL,
  PRIMARY KEY (`idSede`, `pais_idPais`, `empresa_NIT`, `ciudad_idCiudad`),
  INDEX `fk_sede_pais_idx` (`pais_idPais` ASC) ,
  INDEX `fk_sede_empresa_idx` (`empresa_NIT` ASC) ,
  INDEX `fk_sede_ciudad_idx` (`ciudad_idCiudad` ASC) ,
  CONSTRAINT `fk_sede_ciudad`
    FOREIGN KEY (`ciudad_idCiudad`)
    REFERENCES `proyecto_ud`.`ciudad` (`idCiudad`),
  CONSTRAINT `fk_sede_empresa`
    FOREIGN KEY (`empresa_NIT`)
    REFERENCES `proyecto_ud`.`empresa` (`NIT`),
  CONSTRAINT `fk_sede_pais`
    FOREIGN KEY (`pais_idPais`)
    REFERENCES `proyecto_ud`.`pais` (`idPais`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`titulos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`titulos` (
  `idTitulos` INT NOT NULL AUTO_INCREMENT,
  `nombreInstitucion` VARCHAR(45) NOT NULL,
  `nivelDeEducacion_idNivelDeEducacion` INT NOT NULL,
  `nucleoConocimiento_idNucleoConocimiento` INT NOT NULL,
  `estadoDelEstudio_idEstadoDelEstudio` INT NOT NULL,
  `persona_numeroDocumento` INT NOT NULL,
  PRIMARY KEY (`idTitulos`, `nivelDeEducacion_idNivelDeEducacion`, `nucleoConocimiento_idNucleoConocimiento`, `estadoDelEstudio_idEstadoDelEstudio`, `persona_numeroDocumento`),
  INDEX `fk_titulos_nivelDeEducacion_idx` (`nivelDeEducacion_idNivelDeEducacion` ASC) ,
  INDEX `fk_titulos_nucleoConocimiento_idx` (`nucleoConocimiento_idNucleoConocimiento` ASC) ,
  INDEX `fk_titulos_estadoDelEstudio_idx` (`estadoDelEstudio_idEstadoDelEstudio` ASC) ,
  INDEX `fk_titulos_persona_idx` (`persona_numeroDocumento` ASC) ,
  CONSTRAINT `fk_titulos_estadoDelEstudio`
    FOREIGN KEY (`estadoDelEstudio_idEstadoDelEstudio`)
    REFERENCES `proyecto_ud`.`estadodeltitulo` (`idEstadoDelTitulo`),
  CONSTRAINT `fk_titulos_nivelDeEducacion`
    FOREIGN KEY (`nivelDeEducacion_idNivelDeEducacion`)
    REFERENCES `proyecto_ud`.`niveldeeducacion` (`idNivelDeEducacion`),
  CONSTRAINT `fk_titulos_nucleoConocimiento`
    FOREIGN KEY (`nucleoConocimiento_idNucleoConocimiento`)
    REFERENCES `proyecto_ud`.`nucleoconocimiento` (`idNucleoConocimiento`),
  CONSTRAINT `fk_titulos_persona`
    FOREIGN KEY (`persona_numeroDocumento`)
    REFERENCES `proyecto_ud`.`persona` (`numeroDocumento`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `proyecto_ud`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_ud`.`usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `contrasena` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `celular` VARCHAR(45) NOT NULL,
  `fechaDeRegistro` DATE NOT NULL,
  `rol_idRol` INT NOT NULL,
  `persona_numeroDocumento` INT NOT NULL,
  PRIMARY KEY (`idUsuario`, `rol_idRol`, `persona_numeroDocumento`),
  INDEX `fk_usuario_rol_idx` (`rol_idRol` ASC) ,
  INDEX `fk_usuario_persona_idx` (`persona_numeroDocumento` ASC) ,
  CONSTRAINT `fk_usuario_persona`
    FOREIGN KEY (`persona_numeroDocumento`)
    REFERENCES `proyecto_ud`.`persona` (`numeroDocumento`),
  CONSTRAINT `fk_usuario_rol`
    FOREIGN KEY (`rol_idRol`)
    REFERENCES `proyecto_ud`.`rol` (`idRol`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
