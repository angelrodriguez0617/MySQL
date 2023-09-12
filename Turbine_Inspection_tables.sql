-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema turbine_inspection
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema turbine_inspection
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `turbine_inspection` DEFAULT CHARACTER SET utf8mb4 ;
USE `turbine_inspection` ;

-- -----------------------------------------------------
-- Table `turbine_inspection`.`Damage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `turbine_inspection`.`Damage` (
  `DamageID` INT NOT NULL,
  `DamageDesc` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`DamageID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `turbine_inspection`.`WindTurbine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `turbine_inspection`.`WindTurbine` (
  `WindTurbineID` INT NOT NULL,
  `Latitude` FLOAT NULL DEFAULT NULL,
  `Longitude` FLOAT NULL DEFAULT NULL,
  `HubHeight` INT NULL DEFAULT NULL,
  `TotalHeight` INT NULL DEFAULT NULL,
  PRIMARY KEY (`WindTurbineID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `turbine_inspection`.`TurbineSection`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `turbine_inspection`.`TurbineSection` (
  `TurbineSectionID` INT NOT NULL,
  `TurbineSectionDesc` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`TurbineSectionID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `turbine_inspection`.`Drone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `turbine_inspection`.`Drone` (
  `DroneID` INT NOT NULL,
  `DroneName` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`DroneID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `turbine_inspection`.`Flight`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `turbine_inspection`.`Flight` (
  `FlightID` INT NOT NULL,
  `DroneID` INT NOT NULL,
  `FlightDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`FlightID`, `DroneID`),
  INDEX `fk_MissionLog_Drone1_idx` (`DroneID` ASC) VISIBLE,
  CONSTRAINT `fk_MissionLog_Drone1`
    FOREIGN KEY (`DroneID`)
    REFERENCES `turbine_inspection`.`Drone` (`DroneID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `turbine_inspection`.`Image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `turbine_inspection`.`Image` (
  `ImageID` INT NOT NULL,
  `WindTurbineID` INT NOT NULL,
  `TurbineSectionID` INT NOT NULL,
  `FlightID` INT NOT NULL,
  `ImageName` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ImageID`, `WindTurbineID`, `TurbineSectionID`, `FlightID`),
  INDEX `fk_Image_WindTurbine1_idx` (`WindTurbineID` ASC) VISIBLE,
  INDEX `fk_Image_TurbineSection1_idx` (`TurbineSectionID` ASC) VISIBLE,
  INDEX `fk_Image_Flight1_idx` (`FlightID` ASC) VISIBLE,
  CONSTRAINT `fk_Image_WindTurbine1`
    FOREIGN KEY (`WindTurbineID`)
    REFERENCES `turbine_inspection`.`WindTurbine` (`WindTurbineID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Image_TurbineSection1`
    FOREIGN KEY (`TurbineSectionID`)
    REFERENCES `turbine_inspection`.`TurbineSection` (`TurbineSectionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Image_Flight1`
    FOREIGN KEY (`FlightID`)
    REFERENCES `turbine_inspection`.`Flight` (`FlightID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `turbine_inspection`.`MLModel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `turbine_inspection`.`MLModel` (
  `MLModelID` INT NOT NULL,
  `MLName` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`MLModelID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `turbine_inspection`.`DamageInspection`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `turbine_inspection`.`DamageInspection` (
  `DamageInspectionID` VARCHAR(45) NOT NULL,
  `MLModelID` INT NOT NULL,
  `DamageID` INT NOT NULL,
  `ImageID` INT NOT NULL,
  PRIMARY KEY (`DamageInspectionID`, `MLModelID`, `DamageID`, `ImageID`),
  INDEX `fk_WindTurbine_MissionLog_MLModel1_idx` (`MLModelID` ASC) VISIBLE,
  INDEX `fk_Analysis_Damage1_idx` (`DamageID` ASC) VISIBLE,
  INDEX `fk_DamageInspection_Image1_idx` (`ImageID` ASC) VISIBLE,
  CONSTRAINT `fk_Analysis_Damage1`
    FOREIGN KEY (`DamageID`)
    REFERENCES `turbine_inspection`.`Damage` (`DamageID`),
  CONSTRAINT `fk_DamageInspection_Image1`
    FOREIGN KEY (`ImageID`)
    REFERENCES `turbine_inspection`.`Image` (`ImageID`),
  CONSTRAINT `fk_WindTurbine_MissionLog_MLModel1`
    FOREIGN KEY (`MLModelID`)
    REFERENCES `turbine_inspection`.`MLModel` (`MLModelID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- Inserts of data

INSERT INTO windturbine VALUES (3073972,40.439602,-111.919281,50,73.50),(3073971,40.439678,-111.920059,30,45),
(3018490,40.076595,-111.584290,79,123.10),(3018491,40.075695,-111.585289,79,123.10),(3018492,40.074795,-111.586288,79,123.10),
(3018493,40.073895,-111.587288,79,123.10);

INSERT INTO turbinesection VALUES (1,'leading edge'),(2,'upper surface'),(3,'trailing edge'),(4,'lower surface');

INSERT INTO mlmodel VALUES (1,'VGGNet'),(2,'ResNet'),(3, 'Yolo'),(4, 'Haar Cascade'), (5, 'SVM'), (6, 'Residual-Wavelet');

INSERT INTO drone VALUES (1,'DJI Mini 3 Pro'),(2,'Matrice 300 RTK'),(3,'DJI Mini SE');

INSERT INTO damage VALUES (0,'no anomalies detected'),(1,'minor structural damage'),(2,'intermediate structural damage'),
(3,'major structual damage');

INSERT INTO flight VALUES (1,1,'2023-01-22 20:26'),(2,1,'2022-09-18 15:50'),(3,2,'2022-09-27 04:30'),(4,2,'2022-06-25 01:29'),
(5,3,'2022-12-29 18:28'),(6,3,'2022-11-10 15:15');

INSERT INTO image VALUES (1,3073972,1,1,'img_1'),(2,3073971,2,2,'img_2'),(3,3018490,3,3,'img_3'),(4,3018491,3,4,'img_4'),
(5,3018492,4,5,'img_5'),(6,3018493,1,6,'img_6');

INSERT INTO damageinspection VALUES (1,1,0,6),(2,2,0,1),(3,2,1,2),(4,4,0,3),(5,2,0,4),(6,5,2,5),(7,4,0,6),(8,3,3,2),(9,5,0,2),(10,1,1,3),
(11,2,0,4),(12,3,1,5),(13,4,0,6),(14,5,2,1),(15,4,3,2);
