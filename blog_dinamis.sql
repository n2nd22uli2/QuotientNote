-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.6.22-MariaDB-log - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for blog_dinamis
CREATE DATABASE IF NOT EXISTS `blog_dinamis` /*!40100 DEFAULT CHARACTER SET armscii8 COLLATE armscii8_bin */;
USE `blog_dinamis`;

-- Dumping structure for table blog_dinamis.articles
CREATE TABLE IF NOT EXISTS `articles` (
  `article_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `author_id` int(11) DEFAULT 1,
  `excerpt` text DEFAULT NULL,
  `featured_image` varchar(255) DEFAULT NULL,
  `status` enum('draft','published','archived') DEFAULT 'draft',
  `views` int(11) DEFAULT 0,
  `published_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`article_id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `author_id` (`author_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blog_dinamis.articles: 2 rows
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` (`article_id`, `title`, `slug`, `content`, `author_id`, `excerpt`, `featured_image`, `status`, `views`, `published_at`, `created_at`, `updated_at`) VALUES
	(19, 'nandaqusay', 'nandaqusay', 'shaudhasd', 7, '', 'uploads/1142393300684daf586a0a70.32514975-untitled.png', 'published', 0, '2025-06-15 00:19:35', '2025-06-14 17:19:35', '2025-06-14 17:20:24'),
	(14, 'nanda cantikk', 'sdfds', 'dsfsdf', 8, 'dfsdf', 'uploads/1734058738684d9ee61ec811.11152393-Screenshot 2025-06-04 143312.png', 'published', 0, '2025-06-14 17:58:52', '2025-06-14 10:58:52', '2025-06-14 16:10:42'),
	(17, 'nanda aulia duyung', 'nanda-aulia-duyung', 'adasdasd', 10, '', 'uploads/684da3e84a3bf.png', 'published', 0, '2025-06-14 23:31:36', '2025-06-14 16:31:36', '2025-06-14 16:31:36');
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;

-- Dumping structure for table blog_dinamis.article_author
CREATE TABLE IF NOT EXISTS `article_author` (
  `article_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `is_main_author` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`article_id`,`author_id`),
  KEY `author_id` (`author_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blog_dinamis.article_author: 3 rows
/*!40000 ALTER TABLE `article_author` DISABLE KEYS */;
INSERT INTO `article_author` (`article_id`, `author_id`, `is_main_author`) VALUES
	(10, 8, 1),
	(9, 7, 1),
	(8, 7, 1);
/*!40000 ALTER TABLE `article_author` ENABLE KEYS */;

-- Dumping structure for table blog_dinamis.article_category
CREATE TABLE IF NOT EXISTS `article_category` (
  `article_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`article_id`,`category_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blog_dinamis.article_category: 3 rows
/*!40000 ALTER TABLE `article_category` DISABLE KEYS */;
INSERT INTO `article_category` (`article_id`, `category_id`) VALUES
	(10, 3),
	(14, 3),
	(17, 3),
	(19, 1);
/*!40000 ALTER TABLE `article_category` ENABLE KEYS */;

-- Dumping structure for table blog_dinamis.article_tag
CREATE TABLE IF NOT EXISTS `article_tag` (
  `article_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`article_id`,`tag_id`),
  KEY `tag_id` (`tag_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blog_dinamis.article_tag: 3 rows
/*!40000 ALTER TABLE `article_tag` DISABLE KEYS */;
INSERT INTO `article_tag` (`article_id`, `tag_id`) VALUES
	(10, 1),
	(14, 4),
	(17, 1),
	(19, 1);
/*!40000 ALTER TABLE `article_tag` ENABLE KEYS */;

-- Dumping structure for table blog_dinamis.authors
CREATE TABLE IF NOT EXISTS `authors` (
  `author_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `bio` text DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`author_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blog_dinamis.authors: 4 rows
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` (`author_id`, `name`, `email`, `bio`, `profile_image`, `created_at`, `updated_at`) VALUES
	(7, 'user1', 'pengguna1@gmail.com', 'Bio for user1', NULL, '2025-06-14 09:28:26', '2025-06-14 09:28:26'),
	(8, 'user2', 'user2@gmail.com', 'Bio for user2', NULL, '2025-06-14 10:18:44', '2025-06-14 10:18:44'),
	(9, 'alin', 'alin@gmail.com', 'Bio for alin', NULL, '2025-06-14 10:56:05', '2025-06-14 10:56:05'),
	(10, 'nandaaulia', 'nands@gmail.com', 'Bio for nandaaulia', NULL, '2025-06-14 12:38:59', '2025-06-14 12:38:59');
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;

-- Dumping structure for table blog_dinamis.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `slug` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blog_dinamis.categories: 4 rows
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`category_id`, `name`, `description`, `slug`, `created_at`) VALUES
	(1, 'Teknologi', 'Artikel seputar teknologi terbaru', 'teknologi', '2025-04-20 12:13:03'),
	(2, 'Lifestyle', 'Tips dan trik gaya hidup modern', 'lifestyle', '2025-04-20 12:13:03'),
	(3, 'Politik', 'Berita dan analisis politik', 'politik', '2025-04-20 12:13:03'),
	(4, 'Kesehatan', 'Informasi seputar kesehatan dan kebugaran', 'kesehatan', '2025-04-20 12:13:03');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Dumping structure for table blog_dinamis.tags
CREATE TABLE IF NOT EXISTS `tags` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blog_dinamis.tags: 5 rows
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` (`tag_id`, `name`, `slug`, `created_at`) VALUES
	(1, 'Programming', 'programming', '2025-04-20 12:13:03'),
	(2, 'Web Development', 'web-development', '2025-04-20 12:13:03'),
	(3, 'Kesehatan Mental', 'kesehatan-mental', '2025-04-20 12:13:03'),
	(4, 'Politik Nasional', 'politik-nasional', '2025-04-20 12:13:03'),
	(5, 'Tips Hidup', 'tips-hidup', '2025-04-20 12:13:03');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;

-- Dumping structure for table blog_dinamis.users
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') NOT NULL DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table blog_dinamis.users: 4 rows
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `role`, `created_at`, `updated_at`) VALUES
	(7, 'user1', 'pengguna1@gmail.com', '$2y$12$ttczGfwxjvsVOX45Vf.aV.IVq90wVkrtbrynx6Uz/QCfGuwjJKyv2', 'user', '2025-06-14 09:27:42', '2025-06-14 09:27:42'),
	(8, 'user2', 'user2@gmail.com', '$2y$12$oa2Ay6IoMOarO/fo6sxAcOT/K6K4wxd4TMto896RZkfW/guf.kbjG', 'user', '2025-06-14 10:18:22', '2025-06-14 10:18:22'),
	(9, 'alin', 'alin@gmail.com', '$2y$12$W3Xg4DUjR4eEOlzAqggvkOBfzXnUjN0U84JBcgIUm/Trpr6KfXey6', 'user', '2025-06-14 10:55:48', '2025-06-14 10:55:48'),
	(10, 'nandaaulia', 'nands@gmail.com', '$2y$12$W0G/AUwliTu7yIHDdmNiaet19f2gSJpCL9i02K16jW2n4YIHHt2Ua', 'admin', '2025-06-14 11:42:49', '2025-06-14 12:38:22');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
