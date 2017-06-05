SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `mydb` ;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`city` ;

CREATE TABLE IF NOT EXISTS `mydb`.`city` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`news`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`news` ;

CREATE TABLE IF NOT EXISTS `mydb`.`news` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `text` MEDIUMTEXT NULL,
  `added_at` DATETIME NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_news_city1_idx` (`city_id` ASC),
  CONSTRAINT `fk_news_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `mydb`.`city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`street`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`street` ;

CREATE TABLE IF NOT EXISTS `mydb`.`street` (
  `name` VARCHAR(255) NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`name`, `city_id`),
  INDEX `fk_street_city1_idx` (`city_id` ASC),
  UNIQUE INDEX `unique_street_city` (`name` ASC, `city_id` ASC),
  CONSTRAINT `fk_street_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `mydb`.`city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`phone` ;

CREATE TABLE IF NOT EXISTS `mydb`.`phone` (
  `number` VARCHAR(17) NOT NULL,
  PRIMARY KEY (`number`),
  UNIQUE INDEX `number_UNIQUE` (`number` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`address` ;

CREATE TABLE IF NOT EXISTS `mydb`.`address` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `number` VARCHAR(45) NOT NULL,
  `housing` VARCHAR(45) NOT NULL DEFAULT '',
  `building` VARCHAR(45) NOT NULL DEFAULT '',
  `entrance` VARCHAR(45) NOT NULL DEFAULT '',
  `street_name` VARCHAR(255) NOT NULL,
  `street_city_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_address_street1_idx` (`street_name` ASC, `street_city_id` ASC),
  CONSTRAINT `fk_address_street1`
    FOREIGN KEY (`street_name` , `street_city_id`)
    REFERENCES `mydb`.`street` (`name` , `city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`customer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `middle_name` VARCHAR(255) NULL DEFAULT '',
  `email` VARCHAR(255) NULL DEFAULT '',
  `phone_number` VARCHAR(17) NOT NULL,
  `address_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customer_phone1_idx` (`phone_number` ASC),
  INDEX `fk_customer_address1_idx` (`address_id` ASC),
  CONSTRAINT `fk_customer_phone1`
    FOREIGN KEY (`phone_number`)
    REFERENCES `mydb`.`phone` (`number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `mydb`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`office`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`office` ;

CREATE TABLE IF NOT EXISTS `mydb`.`office` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `is_prime` TINYINT(1) NOT NULL DEFAULT 0,
  `timetable` VARCHAR(45) NOT NULL DEFAULT '',
  `phone_number` VARCHAR(17) NOT NULL,
  `address_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_office_phone1_idx` (`phone_number` ASC),
  INDEX `fk_office_address1_idx` (`address_id` ASC),
  CONSTRAINT `fk_office_phone1`
    FOREIGN KEY (`phone_number`)
    REFERENCES `mydb`.`phone` (`number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_office_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `mydb`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`room_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`room_type` ;

CREATE TABLE IF NOT EXISTS `mydb`.`room_type` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(125) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`work_price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`work_price` ;

CREATE TABLE IF NOT EXISTS `mydb`.`work_price` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `date_time` DATETIME NOT NULL,
  `corner_price` DECIMAL NOT NULL,
  `pipe_price` DECIMAL NOT NULL,
  `profile_price` DECIMAL NOT NULL,
  `hole_price` DECIMAL NOT NULL,
  `stripe_price` DECIMAL NOT NULL,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `is_discount` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`order` ;

CREATE TABLE IF NOT EXISTS `mydb`.`order` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `office_id` INT UNSIGNED NOT NULL,
  `customer_id` INT NOT NULL,
  `agreement_number` VARCHAR(125) NOT NULL DEFAULT '',
  `agreement_date` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_office1_idx` (`office_id` ASC),
  INDEX `fk_order_customer1_idx` (`customer_id` ASC),
  CONSTRAINT `fk_order_office1`
    FOREIGN KEY (`office_id`)
    REFERENCES `mydb`.`office` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`technology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`technology` ;

CREATE TABLE IF NOT EXISTS `mydb`.`technology` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`facture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`facture` ;

CREATE TABLE IF NOT EXISTS `mydb`.`facture` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `mydb`.`producer_country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`producer_country` ;

CREATE TABLE IF NOT EXISTS `mydb`.`producer_country` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`celling_producer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`celling_producer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`celling_producer` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(127) NOT NULL DEFAULT '',
  `logo` MEDIUMBLOB NULL,
  `producer_country_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_celling_producer_producer_country1_idx` (`producer_country_id` ASC),
  CONSTRAINT `fk_celling_producer_producer_country1`
    FOREIGN KEY (`producer_country_id`)
    REFERENCES `mydb`.`producer_country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`celling`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`celling` ;

CREATE TABLE IF NOT EXISTS `mydb`.`celling` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `width` FLOAT NULL,
  `technology_id` INT UNSIGNED NOT NULL,
  `facture_id` INT UNSIGNED NOT NULL,
  `celling_producer_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_celling_technology1_idx` (`technology_id` ASC),
  INDEX `fk_celling_facture1_idx` (`facture_id` ASC),
  INDEX `fk_celling_celling_producer1_idx` (`celling_producer_id` ASC),
  CONSTRAINT `fk_celling_technology1`
    FOREIGN KEY (`technology_id`)
    REFERENCES `mydb`.`technology` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_celling_facture1`
    FOREIGN KEY (`facture_id`)
    REFERENCES `mydb`.`facture` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_celling_celling_producer1`
    FOREIGN KEY (`celling_producer_id`)
    REFERENCES `mydb`.`celling_producer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`celling_price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`celling_price` ;

CREATE TABLE IF NOT EXISTS `mydb`.`celling_price` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `date_time` DATETIME NOT NULL,
  `price` DECIMAL NOT NULL,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `is_discount` TINYINT(1) NOT NULL DEFAULT 0,
  `celling_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_celling_price_celling1_idx` (`celling_id` ASC),
  CONSTRAINT `fk_celling_price_celling1`
    FOREIGN KEY (`celling_id`)
    REFERENCES `mydb`.`celling` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`room_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`room_order` ;

CREATE TABLE IF NOT EXISTS `mydb`.`room_order` (
  `order_id` INT UNSIGNED NOT NULL,
  `room_type_id` INT UNSIGNED NOT NULL,
  `corners_amount` INT NULL DEFAULT 0,
  `pipes_amount` INT NULL DEFAULT 0,
  `profiles_amount` INT NULL DEFAULT 0,
  `holes_amount` INT NULL DEFAULT 0,
  `stripes_amount` INT NULL DEFAULT 0,
  `square_meters` FLOAT NOT NULL,
  `work_price_id` INT UNSIGNED NOT NULL,
  `celling_price_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`order_id`, `room_type_id`),
  INDEX `fk_room_order_room_type1_idx` (`room_type_id` ASC),
  INDEX `fk_room_order_work_price1_idx` (`work_price_id` ASC),
  INDEX `fk_room_order_celling_price1_idx` (`celling_price_id` ASC),
  CONSTRAINT `fk_room_order_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_room_order_room_type1`
    FOREIGN KEY (`room_type_id`)
    REFERENCES `mydb`.`room_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_room_order_work_price1`
    FOREIGN KEY (`work_price_id`)
    REFERENCES `mydb`.`work_price` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_room_order_celling_price1`
    FOREIGN KEY (`celling_price_id`)
    REFERENCES `mydb`.`celling_price` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`comment` ;

CREATE TABLE IF NOT EXISTS `mydb`.`comment` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `comment` MEDIUMTEXT NOT NULL,
  `date_time` DATETIME NOT NULL,
  `room_order_order_id` INT UNSIGNED NOT NULL,
  `room_order_room_type_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_room_order1_idx` (`room_order_order_id` ASC, `room_order_room_type_id` ASC),
  CONSTRAINT `fk_comment_room_order1`
    FOREIGN KEY (`room_order_order_id` , `room_order_room_type_id`)
    REFERENCES `mydb`.`room_order` (`order_id` , `room_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`screen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`screen` ;

CREATE TABLE IF NOT EXISTS `mydb`.`screen` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `screen` MEDIUMBLOB NOT NULL,
  `room_order_room_type_id` INT UNSIGNED NOT NULL,
  `room_order_order_id` INT UNSIGNED NOT NULL,
  `room_order_order_id1` INT UNSIGNED NOT NULL,
  `room_order_room_type_id1` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_screen_room_order1_idx` (`room_order_order_id1` ASC, `room_order_room_type_id1` ASC),
  CONSTRAINT `fk_screen_room_order1`
    FOREIGN KEY (`room_order_order_id1` , `room_order_room_type_id1`)
    REFERENCES `mydb`.`room_order` (`order_id` , `room_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`lamp_producer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`lamp_producer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`lamp_producer` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(127) NOT NULL DEFAULT '',
  `logo` MEDIUMBLOB NULL,
  `producer_country_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_lamp_producer_producer_country1_idx` (`producer_country_id` ASC),
  CONSTRAINT `fk_lamp_producer_producer_country1`
    FOREIGN KEY (`producer_country_id`)
    REFERENCES `mydb`.`producer_country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`lamp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`lamp` ;

CREATE TABLE IF NOT EXISTS `mydb`.`lamp` (
  `id` INT NOT NULL,
  `frequency` VARCHAR(45) NULL,
  `power` VARCHAR(45) NULL,
  `voltage` VARCHAR(45) NULL,
  `picture` MEDIUMBLOB NULL,
  `description` MEDIUMTEXT NULL,
  `lamp_producer_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_lamp_lamp_producer1_idx` (`lamp_producer_id` ASC),
  CONSTRAINT `fk_lamp_lamp_producer1`
    FOREIGN KEY (`lamp_producer_id`)
    REFERENCES `mydb`.`lamp_producer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`lamp_price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`lamp_price` ;

CREATE TABLE IF NOT EXISTS `mydb`.`lamp_price` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `date_time` DATETIME NOT NULL,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `is_discount` TINYINT(1) NOT NULL DEFAULT 0,
  `lamp_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_lamp_price_lamp1_idx` (`lamp_id` ASC),
  CONSTRAINT `fk_lamp_price_lamp1`
    FOREIGN KEY (`lamp_id`)
    REFERENCES `mydb`.`lamp` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`room_order_has_lamp_price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`room_order_has_lamp_price` ;

CREATE TABLE IF NOT EXISTS `mydb`.`room_order_has_lamp_price` (
  `room_order_order_id` INT UNSIGNED NOT NULL,
  `room_order_room_type_id` INT UNSIGNED NOT NULL,
  `lamp_price_id` INT UNSIGNED NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`room_order_order_id`, `room_order_room_type_id`, `lamp_price_id`),
  INDEX `fk_room_order_has_lamp_price_lamp_price1_idx` (`lamp_price_id` ASC),
  INDEX `fk_room_order_has_lamp_price_room_order1_idx` (`room_order_order_id` ASC, `room_order_room_type_id` ASC),
  CONSTRAINT `fk_room_order_has_lamp_price_room_order1`
    FOREIGN KEY (`room_order_order_id` , `room_order_room_type_id`)
    REFERENCES `mydb`.`room_order` (`order_id` , `room_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_room_order_has_lamp_price_lamp_price1`
    FOREIGN KEY (`lamp_price_id`)
    REFERENCES `mydb`.`lamp_price` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`city`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`city` (`id`, `name`) VALUES (1, 'Москва');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`room_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`room_type` (`id`, `name`) VALUES (1, 'Кухня');
INSERT INTO `mydb`.`room_type` (`id`, `name`) VALUES (2, 'Ванная');
INSERT INTO `mydb`.`room_type` (`id`, `name`) VALUES (3, 'Гостиная');
INSERT INTO `mydb`.`room_type` (`id`, `name`) VALUES (4, 'Детская');
INSERT INTO `mydb`.`room_type` (`id`, `name`) VALUES (5, 'Спальня');
INSERT INTO `mydb`.`room_type` (`id`, `name`) VALUES (6, 'Прихожая');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`technology`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`technology` (`id`, `name`) VALUES (1, 'Двухуровневые');
INSERT INTO `mydb`.`technology` (`id`, `name`) VALUES (2, 'С подсветкой');
INSERT INTO `mydb`.`technology` (`id`, `name`) VALUES (3, 'Бесшовные');
INSERT INTO `mydb`.`technology` (`id`, `name`) VALUES (4, 'Звёздное небо');
INSERT INTO `mydb`.`technology` (`id`, `name`) VALUES (5, 'Криволинейные');
INSERT INTO `mydb`.`technology` (`id`, `name`) VALUES (6, 'Парящие');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`facture`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`facture` (`id`, `name`) VALUES (1, 'Матовые');
INSERT INTO `mydb`.`facture` (`id`, `name`) VALUES (2, 'Сатиновые');
INSERT INTO `mydb`.`facture` (`id`, `name`) VALUES (3, 'Глянцевые');

COMMIT;

