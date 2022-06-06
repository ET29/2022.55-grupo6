SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `mydb` ;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Preguntas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Preguntas` (
  `idPreguntas` INT NOT NULL AUTO_INCREMENT,
  `cPreguntasD` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idPreguntas`, `cPreguntasD`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Respuestas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Respuestas` (
  `idRespuestas` INT NOT NULL,
  `Respuestascol` VARCHAR(45) NULL,
  `Preguntas_idPreguntas` INT NOT NULL,
  `Preguntas_cPreguntasD` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idRespuestas`, `Preguntas_idPreguntas`, `Preguntas_cPreguntasD`),
  CONSTRAINT `fk_Respuestas_Preguntas`
    FOREIGN KEY (`Preguntas_idPreguntas` , `Preguntas_cPreguntasD`)
    REFERENCES `mydb`.`Preguntas` (`idPreguntas` , `cPreguntasD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Respuestas_Preguntas_idx` ON `mydb`.`Respuestas` (`Preguntas_idPreguntas` ASC, `Preguntas_cPreguntasD` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`Estado de Auditoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estado de Auditoria` (
  `idEstado de Auditoria` INT NOT NULL,
  `Aprobado con errores` VARCHAR(45) NULL,
  `Rechazado` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstado de Auditoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Auditoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Auditoria` (
  `idAuditoria` INT NOT NULL,
  `aprobado` VARCHAR(45) NULL,
  `rechazado` VARCHAR(45) NULL,
  `Estado de Auditoria_idEstado de Auditoria` INT NOT NULL,
  PRIMARY KEY (`idAuditoria`, `Estado de Auditoria_idEstado de Auditoria`),
  CONSTRAINT `fk_Auditoria_Estado de Auditoria1`
    FOREIGN KEY (`Estado de Auditoria_idEstado de Auditoria`)
    REFERENCES `mydb`.`Estado de Auditoria` (`idEstado de Auditoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Auditoria_Estado de Auditoria1_idx` ON `mydb`.`Auditoria` (`Estado de Auditoria_idEstado de Auditoria` ASC);


-- -----------------------------------------------------
-- Table `mydb`.`Preguntas_has_Auditoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Preguntas_has_Auditoria` (
  `Preguntas_idPreguntas` INT NOT NULL,
  `Preguntas_cPreguntasD` VARCHAR(200) NOT NULL,
  `Auditoria_idAuditoria` INT NOT NULL,
  `Auditoria_Estado de Auditoria_idEstado de Auditoria` INT NOT NULL,
  PRIMARY KEY (`Preguntas_idPreguntas`, `Preguntas_cPreguntasD`, `Auditoria_idAuditoria`, `Auditoria_Estado de Auditoria_idEstado de Auditoria`),
  CONSTRAINT `fk_Preguntas_has_Auditoria_Preguntas1`
    FOREIGN KEY (`Preguntas_idPreguntas` , `Preguntas_cPreguntasD`)
    REFERENCES `mydb`.`Preguntas` (`idPreguntas` , `cPreguntasD`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Preguntas_has_Auditoria_Auditoria1`
    FOREIGN KEY (`Auditoria_idAuditoria` , `Auditoria_Estado de Auditoria_idEstado de Auditoria`)
    REFERENCES `mydb`.`Auditoria` (`idAuditoria` , `Estado de Auditoria_idEstado de Auditoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Preguntas_has_Auditoria_Auditoria1_idx` ON `mydb`.`Preguntas_has_Auditoria` (`Auditoria_idAuditoria` ASC, `Auditoria_Estado de Auditoria_idEstado de Auditoria` ASC);

CREATE INDEX `fk_Preguntas_has_Auditoria_Preguntas1_idx` ON `mydb`.`Preguntas_has_Auditoria` (`Preguntas_idPreguntas` ASC, `Preguntas_cPreguntasD` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
