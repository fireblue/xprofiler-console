DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`(
  `id` INT UNSIGNED AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `pass` VARCHAR(200) NOT NULL,
  `identity` VARCHAR(20) NOT NULL,
  `gm_modified` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gm_create` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`name`),
  UNIQUE KEY (`identity`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `apps`;
CREATE TABLE `apps`(
  `id` INT UNSIGNED AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `owner` INT UNSIGNED NOT NULL,
  `secret` VARCHAR(50) NOT NULL,
  `gm_modified` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gm_create` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`owner`, `name`),
  INDEX (`owner`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `members`;
CREATE TABLE `members`(
  `id` INT UNSIGNED AUTO_INCREMENT,
  `app` INT UNSIGNED NOT NULL,
  `user` INT UNSIGNED NOT NULL,
  `status` INT UNSIGNED NOT NULL COMMENT '1: inviting, 2: joined',
  `gm_modified` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gm_create` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`app`, `user`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `files`;
CREATE TABLE `files`(
  `id` INT UNSIGNED AUTO_INCREMENT,
  `app` INT NOT NULL,
  `agent` VARCHAR(50) NOT NULL,
  `type` VARCHAR(50) NOT NULL,
  `file` VARCHAR(250) NOT NULL,
  `storage` VARCHAR(250) DEFAULT "",
  `user` INT UNSIGNED NOT NULL,
  `status` TINYINT UNSIGNED DEFAULT 0,
  `favor` TINYINT UNSIGNED DEFAULT 0,
  `token` VARCHAR(50) DEFAULT "",
  `gm_modified` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gm_create` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`app`, `agent`, `file`, `storage`),
  INDEX (`id`, `app`, `type`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `coredumps`;
CREATE TABLE `coredumps`(
  `id` INT UNSIGNED AUTO_INCREMENT,
  `app` INT NOT NULL,
  `agent` VARCHAR(50) NOT NULL,
  `file` VARCHAR(250) NOT NULL,
  `file_storage` VARCHAR(250) DEFAULT "",
  `file_status` TINYINT UNSIGNED DEFAULT 0,
  `node` VARCHAR(250) NOT NULL,
  `node_storage` VARCHAR(250) DEFAULT "",
  `node_status` TINYINT UNSIGNED DEFAULT 0,
  `user` INT UNSIGNED NOT NULL,
  `favor` TINYINT UNSIGNED DEFAULT 0,
  `token` VARCHAR(50) DEFAULT "",
  `gm_modified` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gm_create` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY (`app`, `agent`, `file`, `file_storage`),
  INDEX (`id`, `app`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `strategies`;
CREATE TABLE `strategies`(
 `id` INT UNSIGNED AUTO_INCREMENT,
 `app` INT NOT NULL,
 `context` VARCHAR(50) NOT NULL,
 `push` VARCHAR(50) NOT NULL,
 `expression` VARCHAR(150) NOT NULL,
 `content` VARCHAR(150) NOT NULL,
 `status` INT DEFAULT 1 COMMENT '0 disabled, 1 enabled',
 `gm_modified` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 `gm_create` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX (`id`, `app`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts`(
  `id` INT UNSIGNED AUTO_INCREMENT,
  `strategy` INT UNSIGNED NOT NULL,
  `user` INT UNSIGNED NOT NULL,
  `gm_modified` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gm_create` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX (`strategy`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
