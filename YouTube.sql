-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema YouTube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema YouTube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `YouTube` DEFAULT CHARACTER SET utf8 ;
USE `YouTube` ;

-- -----------------------------------------------------
-- Table `YouTube`.`me_gusta_no_me_gusta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`me_gusta_no_me_gusta` (
  `id_gusta_no_gusta` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `opcion` ENUM('gusta', 'noGusta') NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  PRIMARY KEY (`id_gusta_no_gusta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Comentarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Comentarios` (
  `id_comentario` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_gusta_no_gusta` SMALLINT UNSIGNED NULL,
  `texto_del_comentario` VARCHAR(100) NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  PRIMARY KEY (`id_comentario`),
  INDEX `fk_comentarios_gusta_no_gusta_idx` (`id_gusta_no_gusta` ASC) ,
  CONSTRAINT `fk_comentarios_gusta_no_gusta`
    FOREIGN KEY (`id_gusta_no_gusta`)
    REFERENCES `YouTube`.`me_gusta_no_me_gusta` (`id_gusta_no_gusta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Canal` (
  `id_canal` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuario` SMALLINT UNSIGNED NOT NULL,
  `nombre_canal` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  PRIMARY KEY (`id_canal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Suscripciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Suscripciones` (
  `id_suscripcion` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_canal` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_suscripcion`),
  INDEX `id_suscripcion_canal_idx` (`id_canal` ASC) ,
  CONSTRAINT `id_suscripcion_canal`
    FOREIGN KEY (`id_canal`)
    REFERENCES `YouTube`.`Canal` (`id_canal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`PlayList`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`PlayList` (
  `id_playList` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre_playlist` VARCHAR(45) NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  `estado` ENUM('publico', 'privado') NOT NULL,
  PRIMARY KEY (`id_playList`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Usuarios` (
  `id_usuario` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_comentario` SMALLINT UNSIGNED NOT NULL,
  `id_subscripcion` SMALLINT UNSIGNED NOT NULL,
  `id_playList` SMALLINT UNSIGNED NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(10) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `sexo` ENUM('H', 'M') NOT NULL,
  `pais` VARCHAR(25) NOT NULL,
  `codigo_postal` CHAR(5) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX `fk_usuarios_comentarios_idx` (`id_comentario` ASC) ,
  INDEX `fk_usuarios_subscripcion_idx` (`id_subscripcion` ASC) ,
  INDEX `fk_usuarios_playList_idx` (`id_playList` ASC) ,
  CONSTRAINT `fk_usuarios_comentarios`
    FOREIGN KEY (`id_comentario`)
    REFERENCES `YouTube`.`Comentarios` (`id_comentario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_subscripcion`
    FOREIGN KEY (`id_subscripcion`)
    REFERENCES `YouTube`.`Suscripciones` (`id_suscripcion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_playList`
    FOREIGN KEY (`id_playList`)
    REFERENCES `YouTube`.`PlayList` (`id_playList`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Videos` (
  `id_video` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuario` SMALLINT UNSIGNED NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `tamaño` VARCHAR(45) NOT NULL,
  `nombre_archivo` VARCHAR(45) NOT NULL,
  `duracion` VARCHAR(45) NOT NULL,
  `thumbnail` BLOB NOT NULL,
  `numero_reproducciones` INT UNSIGNED NOT NULL,
  `numero_likes` INT UNSIGNED NOT NULL,
  `numero_dislikes` VARCHAR(45) NOT NULL,
  `estado` ENUM('publico', 'oculto', 'privado') NULL,
  PRIMARY KEY (`id_video`),
  INDEX `fk_videos_usuarios_idx` (`id_usuario` ASC) ,
  CONSTRAINT `fk_videos_usuarios`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `YouTube`.`Usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Etiquetas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Etiquetas` (
  `id_etiqueta` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_video` SMALLINT UNSIGNED NOT NULL,
  `nombre_etiqueta` VARCHAR(45) NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  PRIMARY KEY (`id_etiqueta`),
  INDEX `fk_etiquetas_videos_idx` (`id_video` ASC) ,
  CONSTRAINT `fk_etiquetas_videos`
    FOREIGN KEY (`id_video`)
    REFERENCES `YouTube`.`Videos` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
