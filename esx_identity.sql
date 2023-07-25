USE `es_extended`;

ALTER TABLE `users`
	ADD COLUMN `firstname` VARCHAR(50) NULL DEFAULT '',
	ADD COLUMN `lastname` VARCHAR(50) NULL DEFAULT '',
	ADD COLUMN `dateofbirth` VARCHAR(25) NULL DEFAULT '',
	ADD COLUMN `sex` VARCHAR(10) NULL DEFAULT '',
	ADD COLUMN `height` VARCHAR(5) NULL DEFAULT ''
;

CREATE TABLE IF NOT EXISTS `characters` (
  `identifier` varchar(101) NOT NULL ,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `dateofbirth` varchar(100) NOT NULL,
  `sex` int(11) NOT NULL,
  `height` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `characters`
	ADD COLUMN `identifier` VARCHAR(50) NULL DEFAULT '',
	ADD COLUMN `firstname` VARCHAR(50) NULL DEFAULT '',
	ADD COLUMN `lastname` VARCHAR(25) NULL DEFAULT '',
	ADD COLUMN `dateofbirth` VARCHAR(10) NULL DEFAULT '',
	ADD COLUMN `sex` VARCHAR(5) NULL DEFAULT '',
	ADD COLUMN `height` VARCHAR(5) NULL DEFAULT 
;
