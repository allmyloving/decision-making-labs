-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.19-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for decision_theory_labs
CREATE DATABASE IF NOT EXISTS `decision_theory_labs` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `decision_theory_labs`;

-- Dumping structure for table decision_theory_labs.alternative
CREATE TABLE IF NOT EXISTS `alternative` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Dumping data for table decision_theory_labs.alternative: ~4 rows (approximately)
/*!40000 ALTER TABLE `alternative` DISABLE KEYS */;
INSERT INTO `alternative` (`id`, `description`) VALUES
	(2, 'pr. Haharina, 35'),
	(3, 'vul Ahsarova, 12'),
	(4, 'vul. Heroiv Pratsi, 13'),
	(5, 'pr, Moskovskyi, 123');
/*!40000 ALTER TABLE `alternative` ENABLE KEYS */;

-- Dumping structure for table decision_theory_labs.auth_group
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table decision_theory_labs.auth_group: ~0 rows (approximately)
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;

-- Dumping structure for table decision_theory_labs.auth_group_permissions
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table decision_theory_labs.auth_group_permissions: ~0 rows (approximately)
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;

-- Dumping structure for table decision_theory_labs.auth_permission
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- Dumping data for table decision_theory_labs.auth_permission: ~18 rows (approximately)
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(1, 'Can add log entry', 1, 'add_logentry'),
	(2, 'Can change log entry', 1, 'change_logentry'),
	(3, 'Can delete log entry', 1, 'delete_logentry'),
	(4, 'Can add permission', 2, 'add_permission'),
	(5, 'Can change permission', 2, 'change_permission'),
	(6, 'Can delete permission', 2, 'delete_permission'),
	(7, 'Can add group', 3, 'add_group'),
	(8, 'Can change group', 3, 'change_group'),
	(9, 'Can delete group', 3, 'delete_group'),
	(10, 'Can add user', 4, 'add_user'),
	(11, 'Can change user', 4, 'change_user'),
	(12, 'Can delete user', 4, 'delete_user'),
	(13, 'Can add content type', 5, 'add_contenttype'),
	(14, 'Can change content type', 5, 'change_contenttype'),
	(15, 'Can delete content type', 5, 'delete_contenttype'),
	(16, 'Can add session', 6, 'add_session'),
	(17, 'Can change session', 6, 'change_session'),
	(18, 'Can delete session', 6, 'delete_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;

-- Dumping structure for table decision_theory_labs.auth_user
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table decision_theory_labs.auth_user: ~0 rows (approximately)
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(1, 'pbkdf2_sha256$100000$9HOspcxTssxJ$ZPKvtqxXy6wlmkoP79I7d1zt4U/d9VuSGhseo5YzBWQ=', '2018-05-13 15:58:55.559059', 1, 'admin', '', '', 'admin@mail.com', 1, 1, '2018-05-13 15:58:28.524430');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;

-- Dumping structure for table decision_theory_labs.auth_user_groups
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table decision_theory_labs.auth_user_groups: ~0 rows (approximately)
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;

-- Dumping structure for table decision_theory_labs.auth_user_user_permissions
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table decision_theory_labs.auth_user_user_permissions: ~0 rows (approximately)
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;

-- Dumping structure for table decision_theory_labs.criterion
CREATE TABLE IF NOT EXISTS `criterion` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `range` int(10) unsigned NOT NULL,
  `weight` int(10) unsigned NOT NULL,
  `type` enum('quantitative','qualitative') NOT NULL,
  `optimalityType` enum('max','min') NOT NULL,
  `unitOfMeasurement` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Dumping data for table decision_theory_labs.criterion: ~4 rows (approximately)
/*!40000 ALTER TABLE `criterion` DISABLE KEYS */;
INSERT INTO `criterion` (`id`, `name`, `range`, `weight`, `type`, `optimalityType`, `unitOfMeasurement`) VALUES
	(1, 'Price per month', 0, 3, 'quantitative', 'min', 'Hryvnia'),
	(2, 'Time to get to university', 2, 2, 'quantitative', 'min', 'minutes'),
	(3, 'Has bath', 1, 1, 'qualitative', 'max', 'y/n'),
	(4, 'Devices', 7, 3, 'quantitative', 'max', 'pcs'),
	(5, 'Renovation date', 2, 3, 'quantitative', 'max', 'year');
/*!40000 ALTER TABLE `criterion` ENABLE KEYS */;

-- Dumping structure for table decision_theory_labs.django_admin_log
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- Dumping data for table decision_theory_labs.django_admin_log: ~14 rows (approximately)
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
	(1, '2018-05-14 12:34:46.666868', '1', 'Price per month', 1, '[{"added": {}}]', 7, 1),
	(2, '2018-05-14 12:43:39.380765', '1', 'Lpr object (1)', 1, '[{"added": {}}]', 8, 1),
	(3, '2018-05-14 12:45:08.969984', '1', 'Goodcriteria name: Price per month', 1, '[{"added": {}}]', 9, 1),
	(4, '2018-05-14 13:07:07.301996', '2', 'pr. Haharina, 35', 1, '[{"added": {}}]', 11, 1),
	(5, '2018-05-14 13:07:14.226189', '1', 'this is alternative', 3, '', 11, 1),
	(6, '2018-05-14 13:08:39.373105', '2', 'Time to get to university, type: quantitative, optimality: min, unit of measurement: minutes', 1, '[{"added": {}}]', 7, 1),
	(7, '2018-05-14 13:09:26.924854', '3', 'Has bath, type: qualitative, optimality: max, unit of measurement: y/n', 1, '[{"added": {}}]', 7, 1),
	(8, '2018-05-14 13:09:54.306327', '4', 'Devices, type: quantitative, optimality: max, unit of measurement: pcs', 1, '[{"added": {}}]', 7, 1),
	(9, '2018-05-14 13:10:20.488588', '5', 'Renovation date, type: quantitative, optimality: max, unit of measurement: year', 1, '[{"added": {}}]', 7, 1),
	(10, '2018-05-14 13:10:40.873665', '3', 'vul Ahsarova, 12', 1, '[{"added": {}}]', 11, 1),
	(11, '2018-05-14 13:10:57.349436', '4', 'vul. Heroiv Pratsi, 13', 1, '[{"added": {}}]', 11, 1),
	(12, '2018-05-14 13:11:10.481595', '5', 'pr, Moskovskyi, 123', 1, '[{"added": {}}]', 11, 1),
	(13, '2018-05-14 13:17:56.716601', '2', 'Excellent, criteria name: Price per month', 1, '[{"added": {}}]', 9, 1),
	(14, '2018-05-14 13:19:34.033709', '2', 'Alternative: vul Ahsarova, 12, criteria: Price per month, mark: Good', 1, '[{"added": {}}]', 10, 1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;

-- Dumping structure for table decision_theory_labs.django_content_type
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- Dumping data for table decision_theory_labs.django_content_type: ~11 rows (approximately)
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(1, 'admin', 'logentry'),
	(3, 'auth', 'group'),
	(2, 'auth', 'permission'),
	(4, 'auth', 'user'),
	(5, 'contenttypes', 'contenttype'),
	(11, 'lab1', 'alternative'),
	(7, 'lab1', 'criterion'),
	(8, 'lab1', 'lpr'),
	(9, 'lab1', 'mark'),
	(10, 'lab1', 'vector'),
	(6, 'sessions', 'session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;

-- Dumping structure for table decision_theory_labs.django_migrations
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- Dumping data for table decision_theory_labs.django_migrations: ~14 rows (approximately)
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'contenttypes', '0001_initial', '2018-05-13 15:47:36.923783'),
	(2, 'auth', '0001_initial', '2018-05-13 15:47:38.263378'),
	(3, 'admin', '0001_initial', '2018-05-13 15:47:38.552380'),
	(4, 'admin', '0002_logentry_remove_auto_add', '2018-05-13 15:47:38.567891'),
	(5, 'contenttypes', '0002_remove_content_type_name', '2018-05-13 15:47:38.729604'),
	(6, 'auth', '0002_alter_permission_name_max_length', '2018-05-13 15:47:38.875209'),
	(7, 'auth', '0003_alter_user_email_max_length', '2018-05-13 15:47:38.982200'),
	(8, 'auth', '0004_alter_user_username_opts', '2018-05-13 15:47:38.997211'),
	(9, 'auth', '0005_alter_user_last_login_null', '2018-05-13 15:47:39.080104'),
	(10, 'auth', '0006_require_contenttypes_0002', '2018-05-13 15:47:39.087110'),
	(11, 'auth', '0007_alter_validators_add_error_messages', '2018-05-13 15:47:39.101118'),
	(12, 'auth', '0008_alter_user_username_max_length', '2018-05-13 15:47:39.205050'),
	(13, 'auth', '0009_alter_user_last_name_max_length', '2018-05-13 15:47:39.309935'),
	(14, 'sessions', '0001_initial', '2018-05-13 15:47:39.387577');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;

-- Dumping structure for table decision_theory_labs.django_session
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table decision_theory_labs.django_session: ~1 rows (approximately)
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('4psampsi0uqpdwx1veyqu9v2nkrb09st', 'YTMwMThlMTZlYWMzMTNiMzY3MTc4NWQ5NjM5YWY0NzU4MmQwYWYxMjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNTRlYmE5MGE3Mzc5NDVjZDMxMjIyOWYwOWY5ZjYxNzk5NDdkNTlmIn0=', '2018-05-27 15:58:55.566055');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;

-- Dumping structure for table decision_theory_labs.lpr
CREATE TABLE IF NOT EXISTS `lpr` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `range` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table decision_theory_labs.lpr: ~0 rows (approximately)
/*!40000 ALTER TABLE `lpr` DISABLE KEYS */;
INSERT INTO `lpr` (`id`, `name`, `range`) VALUES
	(1, 'Ivan', 2);
/*!40000 ALTER TABLE `lpr` ENABLE KEYS */;

-- Dumping structure for table decision_theory_labs.mark
CREATE TABLE IF NOT EXISTS `mark` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `crit_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL DEFAULT '0',
  `range` double NOT NULL DEFAULT '0',
  `num_equiv` decimal(10,2) NOT NULL DEFAULT '0.00',
  `norm_mark` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `criterion` (`crit_id`),
  CONSTRAINT `criterion` FOREIGN KEY (`crit_id`) REFERENCES `criterion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table decision_theory_labs.mark: ~2 rows (approximately)
/*!40000 ALTER TABLE `mark` DISABLE KEYS */;
INSERT INTO `mark` (`id`, `crit_id`, `name`, `range`, `num_equiv`, `norm_mark`) VALUES
	(1, 1, 'Good', 2, 4.00, 0.90),
	(2, 1, 'Excellent', 1, 3500.00, 1.00);
/*!40000 ALTER TABLE `mark` ENABLE KEYS */;

-- Dumping structure for table decision_theory_labs.result
CREATE TABLE IF NOT EXISTS `result` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `lpr_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `alt_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `range` int(10) unsigned NOT NULL DEFAULT '0',
  `alt_weight` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `lpr` (`lpr_id`),
  KEY `result_to_alternative` (`alt_id`),
  CONSTRAINT `lpr` FOREIGN KEY (`lpr_id`) REFERENCES `lpr` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `result_to_alternative` FOREIGN KEY (`alt_id`) REFERENCES `alternative` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table decision_theory_labs.result: ~0 rows (approximately)
/*!40000 ALTER TABLE `result` DISABLE KEYS */;
/*!40000 ALTER TABLE `result` ENABLE KEYS */;

-- Dumping structure for table decision_theory_labs.vector
CREATE TABLE IF NOT EXISTS `vector` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `alt_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `mark_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `alternative` (`alt_id`),
  KEY `mark` (`mark_id`),
  CONSTRAINT `alternative` FOREIGN KEY (`alt_id`) REFERENCES `alternative` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mark` FOREIGN KEY (`mark_id`) REFERENCES `mark` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table decision_theory_labs.vector: ~1 rows (approximately)
/*!40000 ALTER TABLE `vector` DISABLE KEYS */;
INSERT INTO `vector` (`id`, `alt_id`, `mark_id`) VALUES
	(2, 3, 1);
/*!40000 ALTER TABLE `vector` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
