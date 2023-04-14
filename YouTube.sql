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
-- Table `YouTube`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Usuarios` (
  `id_usuario` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_comentario` INT UNSIGNED NOT NULL,
  `id_subscripcion` INT UNSIGNED NOT NULL,
  `id_playList` INT UNSIGNED NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(10) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `sexo` ENUM('H', 'M') NOT NULL,
  `pais` VARCHAR(25) NOT NULL,
  `codigo_postal` CHAR(5) NOT NULL,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Videos` (
  `id_video` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuario` INT UNSIGNED NOT NULL,
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
  `id_etiqueta` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `nombre_etiqueta` VARCHAR(45) NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  PRIMARY KEY (`id_etiqueta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Canales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Canales` (
  `id_canal` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuario` INT UNSIGNED NOT NULL,
  `nombre_canal` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  PRIMARY KEY (`id_canal`),
  INDEX `fk_canal_usuario_idx` (`id_usuario` ASC) ,
  CONSTRAINT `fk_canal_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `YouTube`.`Usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`PlayList`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`PlayList` (
  `id_playList` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuario` INT UNSIGNED NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  `estado` ENUM('publico', 'privado') NOT NULL,
  PRIMARY KEY (`id_playList`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Comentarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Comentarios` (
  `id_comentario` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_video` INT UNSIGNED NOT NULL,
  `id_usuario` INT UNSIGNED NOT NULL,
  `texto_comentario` VARCHAR(100) NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  PRIMARY KEY (`id_comentario`),
  INDEX `fk_comentarios_videos_idx` (`id_video` ASC) ,
  INDEX `fk_comentarios_usuarios_idx` (`id_usuario` ASC) ,
  CONSTRAINT `fk_comentarios_videos`
    FOREIGN KEY (`id_video`)
    REFERENCES `YouTube`.`Videos` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentarios_usuarios`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `YouTube`.`Usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Suscripciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Suscripciones` (
  `id_suscripcion` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_canal` INT UNSIGNED NOT NULL,
  `id_usuario` INT UNSIGNED NOT NULL,
  `fecha_suscripcion` DATE NULL,
  PRIMARY KEY (`id_suscripcion`),
  INDEX `fk_suscripciones_usuarios_idx` (`id_usuario` ASC) ,
  INDEX `fk_suscripciones_canales_idx` (`id_canal` ASC) ,
  CONSTRAINT `fk_suscripciones_usuarios`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `YouTube`.`Usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_suscripciones_canales`
    FOREIGN KEY (`id_canal`)
    REFERENCES `YouTube`.`Canales` (`id_canal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Likes_dislikes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Likes_dislikes` (
  `id_Likes_dislikes` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuario` INT UNSIGNED NOT NULL,
  `id_video` INT UNSIGNED NOT NULL,
  `like` ENUM("1", "0") NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  PRIMARY KEY (`id_Likes_dislikes`),
  INDEX `fk_mgNmg_video_idx` (`id_video` ASC) ,
  INDEX `fk_mgNmg_usuario_idx` (`id_usuario` ASC) ,
  CONSTRAINT `fk_mgNmg_video`
    FOREIGN KEY (`id_video`)
    REFERENCES `YouTube`.`Videos` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mgNmg_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `YouTube`.`Usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Etiquetas_Videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Etiquetas_Videos` (
  `id_etiquetas_videos` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_video` INT UNSIGNED NOT NULL,
  `id_etiqueta` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_etiquetas_videos`),
  INDEX `fk_etiVid_video_idx` (`id_video` ASC) ,
  INDEX `fk_etiVid_etiqueta_idx` (`id_etiqueta` ASC) ,
  CONSTRAINT `fk_etiVid_video`
    FOREIGN KEY (`id_video`)
    REFERENCES `YouTube`.`Videos` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_etiVid_etiqueta`
    FOREIGN KEY (`id_etiqueta`)
    REFERENCES `YouTube`.`Etiquetas` (`id_etiqueta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`PlayList_Videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`PlayList_Videos` (
  `idPlayList_Videos` INT NOT NULL AUTO_INCREMENT,
  `id_playlist` INT UNSIGNED NOT NULL,
  `id_videos` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idPlayList_Videos`),
  INDEX `fk_PlayVid_playlist_idx` (`id_playlist` ASC) ,
  INDEX `fk_PlayVid_videos_idx` (`id_videos` ASC) ,
  CONSTRAINT `fk_PlayVid_playlist`
    FOREIGN KEY (`id_playlist`)
    REFERENCES `YouTube`.`PlayList` (`id_playList`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PlayVid_videos`
    FOREIGN KEY (`id_videos`)
    REFERENCES `YouTube`.`Videos` (`id_video`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`comentarios_likes_dislikes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`comentarios_likes_dislikes` (
  `id_comentarios_likes_dislikes` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT UNSIGNED NOT NULL,
  `id_comentario` INT UNSIGNED NOT NULL,
  `like` ENUM("1", "0") NULL,
  PRIMARY KEY (`id_comentarios_likes_dislikes`),
  INDEX `fk_comLikDislik_usuario_idx` (`id_usuario` ASC) ,
  INDEX `fk_comLikDislik_comentario_idx` (`id_comentario` ASC) ,
  CONSTRAINT `fk_comLikDislik_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `YouTube`.`Usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comLikDislik_comentario`
    FOREIGN KEY (`id_comentario`)
    REFERENCES `YouTube`.`Comentarios` (`id_comentario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
