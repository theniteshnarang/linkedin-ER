CREATE DATABASE  IF NOT EXISTS `linkedin` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `linkedin`;
-- MySQL dump 10.13  Distrib 8.0.38, for macos14 (arm64)
--
-- Host: localhost    Database: linkedin
-- ------------------------------------------------------
-- Server version	8.4.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `connection_requests`
--

DROP TABLE IF EXISTS `connection_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connection_requests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sender_user_id` int NOT NULL,
  `receiver_user_id` int NOT NULL,
  `connection_type` enum('follow-request','connection-request') DEFAULT NULL,
  `status` enum('sent','accepted','not-accepted','withdrawal','draft') DEFAULT 'draft',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sender_user_id` (`sender_user_id`,`receiver_user_id`,`connection_type`,`status`),
  KEY `receiver_user_id` (`receiver_user_id`),
  CONSTRAINT `connection_requests_ibfk_1` FOREIGN KEY (`sender_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `connection_requests_ibfk_2` FOREIGN KEY (`receiver_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `connection_requests`
--

LOCK TABLES `connection_requests` WRITE;
/*!40000 ALTER TABLE `connection_requests` DISABLE KEYS */;
INSERT INTO `connection_requests` VALUES (1,1,2,'connection-request','sent'),(2,1,2,'connection-request','accepted'),(7,2,3,'connection-request','sent'),(5,3,4,'follow-request','sent'),(6,3,4,'follow-request','accepted');
/*!40000 ALTER TABLE `connection_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills`
--

DROP TABLE IF EXISTS `skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `category` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`category`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills`
--

LOCK TABLES `skills` WRITE;
/*!40000 ALTER TABLE `skills` DISABLE KEYS */;
INSERT INTO `skills` VALUES (1,'Javascript',NULL,'programming language'),(2,'C++',NULL,'programming language'),(3,'Python',NULL,'programming language'),(4,'GoLang',NULL,'programming language'),(5,'Ruby on rails',NULL,'programming language');
/*!40000 ALTER TABLE `skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_connections`
--

DROP TABLE IF EXISTS `user_connections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_connections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `connection_id` int NOT NULL,
  `request_id` int NOT NULL,
  `status` enum('followed','connected','pending-follow-accept','pending-connection-accept','connected-followed') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`connection_id`,`request_id`,`status`),
  KEY `connection_id` (`connection_id`),
  KEY `request_id` (`request_id`),
  CONSTRAINT `user_connections_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_connections_ibfk_2` FOREIGN KEY (`connection_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_connections_ibfk_3` FOREIGN KEY (`request_id`) REFERENCES `connection_requests` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_connections`
--

LOCK TABLES `user_connections` WRITE;
/*!40000 ALTER TABLE `user_connections` DISABLE KEYS */;
INSERT INTO `user_connections` VALUES (1,1,2,2,'connected'),(4,2,3,7,'pending-connection-accept'),(3,3,4,6,'followed');
/*!40000 ALTER TABLE `user_connections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_contact_info`
--

DROP TABLE IF EXISTS `user_contact_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_contact_info` (
  `user_id` int NOT NULL,
  `profile_url` text,
  `email` varchar(100) DEFAULT NULL,
  `mobile` bigint DEFAULT NULL,
  `address` text,
  `dob` date DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_contact_info_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_contact_info`
--

LOCK TABLES `user_contact_info` WRITE;
/*!40000 ALTER TABLE `user_contact_info` DISABLE KEYS */;
INSERT INTO `user_contact_info` VALUES (1,'https://www.linkedin.com/in/theniteshnarang/','pnnarang9@gmail.com',9106857146,'Sardarnagar, Ahmedabad','1997-04-25'),(2,'https://www.linkedin.com/in/melindagates','melinda.gates@gmail.com',5635657455,'United States','1974-06-22'),(3,'https://www.linkedin.com/in/satyanadella/','satya.nadela@gmail.com',5635658743,'United States','1970-06-22'),(4,'https://www.linkedin.com/in/swapagarwal/','swapnilagarwal1994@yahoo.com',5635656793,'Bangalore, India','1994-05-05');
/*!40000 ALTER TABLE `user_contact_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_educations`
--

DROP TABLE IF EXISTS `user_educations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_educations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `school_name` varchar(200) DEFAULT NULL,
  `degree` varchar(200) DEFAULT NULL,
  `field_of_study` varchar(200) DEFAULT NULL,
  `grade` varchar(10) DEFAULT NULL,
  `activities_and_societies` text,
  `description` text,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`school_name`,`degree`),
  CONSTRAINT `user_educations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_educations`
--

LOCK TABLES `user_educations` WRITE;
/*!40000 ALTER TABLE `user_educations` DISABLE KEYS */;
INSERT INTO `user_educations` VALUES (1,1,'Airport School','SSE','Science',NULL,NULL,NULL,'2013-06-01','2015-06-30'),(2,1,'Parul University','Btech','Computer Science',NULL,NULL,NULL,'2015-07-01','2019-06-30'),(3,2,'Duke University','Bachelor of Science','BS, computer science',NULL,NULL,NULL,'1986-01-01','1987-01-01'),(4,2,'Duke University -  The Fuqua School Of Business','MBA','Master of Business Adminstration',NULL,NULL,NULL,'1987-01-01','1988-01-01');
/*!40000 ALTER TABLE `user_educations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_experiences`
--

DROP TABLE IF EXISTS `user_experiences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_experiences` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `title` varchar(300) DEFAULT NULL,
  `employment_type` enum('full-time','part-time','self-employed','freelance','internship','trainee') DEFAULT NULL,
  `company_name` varchar(300) DEFAULT NULL,
  `location` varchar(300) DEFAULT NULL,
  `location_type` enum('On-site','Hybrid','Remote') DEFAULT NULL,
  `is_currently_working` enum('true','false') DEFAULT NULL,
  `description` text,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_experiences_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_experiences`
--

LOCK TABLES `user_experiences` WRITE;
/*!40000 ALTER TABLE `user_experiences` DISABLE KEYS */;
INSERT INTO `user_experiences` VALUES (1,1,'Frontend Engineer','full-time','Alyve Health','Ahmedabad','Remote','false','\n- Diagnostic 2.0 & Reimbursement 2.0 - Revamped and optimized large user stories handling 10k daily transactions.\n- Main App 2.0 & Admin UI - Spearheaded the development using Next.js, serving as the technical Single Point of Contact (SPOC) for customer-facing issues.\n- Endorsement Module -  Automated the manual employee endorsement process, resulting in a 3x increase in operational productivity.\n- Order Dashboards - Enhanced the management of diagnostic and reimbursement customer-facing operations, achieving a 2x faster resolution and significantly improving user experience (UX).\n- TPA SDK Integrations - Integrated Firebase and Terra API to meet diverse business needs.\n- Vulnerabilities - Conducted codebase migrations to minimize package inter-dependency risks and upgrade to newer versions.\n- Analytical Module - Implemented advanced data visualization tools for admin and community managers using Recharts and Datagrid.','2021-11-15','2024-04-25'),(2,1,'Teaching Assistant','part-time','neog.camp','Ahmedabad','Remote','false','- Developed hobby full-stack projects to solidify the learnings.\n- Guided and managed a team of 17 peers, nurturing their professional growth and skills.','2021-02-15','2021-08-30'),(3,1,'Intern Application Engineer','part-time','Tech-Receptives Solutions Pvt','Ahmedabad','On-site','false','- Improved system performance, leading to a 2-3x time reduction in completion.\n- Developed workflows using Odoo-based software and implemented apps using React.','2020-11-15','2021-03-30'),(4,2,'Founder','full-time','Pivotal Ventures','Greater Seattle Area','On-site','true','Pivotal, which I founded in 2015, works to accelerate the pace of progress for women and families in the U.S. and around the world.','2015-01-01',NULL),(5,2,'Co-Founder & Co-Chair','full-time','Bill & Melinda Gates Foundation','Greater Seattle Area','On-site','false','As co-founder and co-chair, I set the direction and priorities of the foundation. Specifically, I concentrated on family planning, maternal and child health, and applying the principles of user-centered design to the field of global health and development.','2000-01-01','2024-01-01'),(6,2,'General Manager of Information Products','full-time','Microsoft','Greater Seattle Area','On-site','false','During my time at Microsoft, I managed teams that developed multimedia and interactive products including Expedia, Cinemania and Encarta.','1987-01-01','1996-01-01');
/*!40000 ALTER TABLE `user_experiences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_medias`
--

DROP TABLE IF EXISTS `user_medias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_medias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `user_experience_id` int DEFAULT NULL,
  `user_education_id` int DEFAULT NULL,
  `media_link` text,
  `media_title` varchar(50) DEFAULT NULL,
  `media_description` text,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `user_experience_id` (`user_experience_id`),
  KEY `user_education_id` (`user_education_id`),
  CONSTRAINT `user_medias_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_medias_ibfk_2` FOREIGN KEY (`user_experience_id`) REFERENCES `user_experiences` (`id`),
  CONSTRAINT `user_medias_ibfk_3` FOREIGN KEY (`user_education_id`) REFERENCES `user_educations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_medias`
--

LOCK TABLES `user_medias` WRITE;
/*!40000 ALTER TABLE `user_medias` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_medias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_posts`
--

DROP TABLE IF EXISTS `user_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `post_title` varchar(200) DEFAULT NULL,
  `post_description` text,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_posts`
--

LOCK TABLES `user_posts` WRITE;
/*!40000 ALTER TABLE `user_posts` DISABLE KEYS */;
INSERT INTO `user_posts` VALUES (1,2,NULL,'I loved talking with Michelle Obama, Oprah Winfrey, Gayle King, Billie Jean King, Reese Witherspoon, Ava DuVernay, and Megan Rapinoe for my new “Moments That Make Us” series. We laughed, we had fun, and we went deep. You can watch all of the episodes here:'),(2,2,NULL,'Yesterday, I got to watch my youngest Phoebe Gates graduate from Stanford University—the university that gave my dad a scholarship to study mechanical engineering back in the 1960s. I also had the honor of giving Stanford’s commencement speech, which was pretty fun. ? And while these amazing graduates already have everything they need inside of them to make their mark on the world, I offered them three pieces of advice on embracing life’s transitions. Watch the full speech:'),(3,2,NULL,'It’s hard to believe that after nearly 25 years, today is my last day of work at the Bill & Melinda Gates Foundation. As I close out this chapter, I want to extend an extra special thank you to foundation colleagues and alumni for all they’ve taught me over the years and for all the ways, big and small, they’re carrying this work forward. ❤');
/*!40000 ALTER TABLE `user_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_posts_comments`
--

DROP TABLE IF EXISTS `user_posts_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_posts_comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `post_id` int DEFAULT NULL,
  `comment_title` varchar(200) DEFAULT NULL,
  `comment_description` text,
  `parent_comment_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`post_id`,`comment_description`(100)),
  KEY `post_id` (`post_id`),
  KEY `parent_comment_id` (`parent_comment_id`),
  CONSTRAINT `user_posts_comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_posts_comments_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `user_posts` (`id`),
  CONSTRAINT `user_posts_comments_ibfk_3` FOREIGN KEY (`parent_comment_id`) REFERENCES `user_posts_comments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_posts_comments`
--

LOCK TABLES `user_posts_comments` WRITE;
/*!40000 ALTER TABLE `user_posts_comments` DISABLE KEYS */;
INSERT INTO `user_posts_comments` VALUES (1,1,1,NULL,'I’m sure those are all terrific conversations. So very many women not nearly as famous have terrific stories about the moments that make them, as well. Wouldn’t it be wonderful to start a network of local conversations to reveal a plethora of such stories that may positively impact communities? Just a thought.',NULL),(2,2,1,NULL,'Yes!',1),(4,3,1,NULL,'Talk to some women who are not famous. Many of us will probably relate to them more. These women have been interviewed so many times and have gotten a lot of press coverage by mainstream media. Time for another chapter. Help unite women with women making a difference every day with heroic efforts in their communities.',NULL),(5,4,1,NULL,'Agreed. All of these women have been interviewed by the major press. And, many of us have heard their stories before. ',4);
/*!40000 ALTER TABLE `user_posts_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_posts_comments_likes`
--

DROP TABLE IF EXISTS `user_posts_comments_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_posts_comments_likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment_id` int DEFAULT NULL,
  `liked_by_id` int DEFAULT NULL,
  `is_liked` enum('true','false') DEFAULT 'true',
  PRIMARY KEY (`id`),
  UNIQUE KEY `comment_id` (`comment_id`,`liked_by_id`),
  KEY `liked_by_id` (`liked_by_id`),
  CONSTRAINT `user_posts_comments_likes_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `user_posts_comments` (`id`),
  CONSTRAINT `user_posts_comments_likes_ibfk_2` FOREIGN KEY (`liked_by_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_posts_comments_likes`
--

LOCK TABLES `user_posts_comments_likes` WRITE;
/*!40000 ALTER TABLE `user_posts_comments_likes` DISABLE KEYS */;
INSERT INTO `user_posts_comments_likes` VALUES (1,1,1,'true'),(2,1,2,'true'),(3,1,3,'true');
/*!40000 ALTER TABLE `user_posts_comments_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_posts_likes`
--

DROP TABLE IF EXISTS `user_posts_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_posts_likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `liked_by_id` int DEFAULT NULL,
  `post_id` int DEFAULT NULL,
  `is_liked` enum('true','false') DEFAULT 'true',
  `reaction_id` int DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `liked_by_id` (`liked_by_id`,`post_id`),
  KEY `post_id` (`post_id`),
  KEY `reaction_id` (`reaction_id`),
  CONSTRAINT `user_posts_likes_ibfk_1` FOREIGN KEY (`liked_by_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_posts_likes_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `user_posts` (`id`),
  CONSTRAINT `user_posts_likes_ibfk_3` FOREIGN KEY (`reaction_id`) REFERENCES `user_reactions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_posts_likes`
--

LOCK TABLES `user_posts_likes` WRITE;
/*!40000 ALTER TABLE `user_posts_likes` DISABLE KEYS */;
INSERT INTO `user_posts_likes` VALUES (1,1,1,'true',6),(2,3,1,'true',6),(3,2,1,'true',6),(4,4,1,'true',6),(5,1,2,'true',6),(6,3,2,'true',6),(7,2,2,'true',6),(10,1,3,'true',6),(11,2,3,'true',6);
/*!40000 ALTER TABLE `user_posts_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_posts_media`
--

DROP TABLE IF EXISTS `user_posts_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_posts_media` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `post_id` int DEFAULT NULL,
  `media_link` varchar(2083) DEFAULT NULL,
  `media_title` varchar(100) DEFAULT NULL,
  `media_description` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`post_id`,`media_link`(255)),
  KEY `post_id` (`post_id`),
  CONSTRAINT `user_posts_media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_posts_media_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `user_posts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_posts_media`
--

LOCK TABLES `user_posts_media` WRITE;
/*!40000 ALTER TABLE `user_posts_media` DISABLE KEYS */;
INSERT INTO `user_posts_media` VALUES (1,2,1,'https://www.youtube.com/playlist?list=PLvRieC-OtrwvSi5EvEusy3YxsvJMLRuFD#LI','\'Moments That Makes Us\' Series',NULL),(2,2,2,'https://www.youtube.com/watch?v=A50QFI_5QQw','Melinda French Gates 2024 Stanford University Commencement Speech',NULL),(3,2,3,'https://www.linkedin.com/pulse/my-foundation-colleagues-alumni-melinda-french-gates-34dge/?trackingId=9qFA76JZQ1SI8fb8i42O3Q%3D%3D','To my foundation colleagues and alumni',NULL);
/*!40000 ALTER TABLE `user_posts_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_reactions`
--

DROP TABLE IF EXISTS `user_reactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_reactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `symbol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `sequence` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_reactions`
--

LOCK TABLES `user_reactions` WRITE;
/*!40000 ALTER TABLE `user_reactions` DISABLE KEYS */;
INSERT INTO `user_reactions` VALUES (6,'Like','?','2024-08-30 11:42:19',1),(7,'Celebrate','?','2024-08-30 11:42:19',2),(8,'Support','?','2024-08-30 11:42:19',3),(9,'Funny','?','2024-08-30 11:42:19',4),(10,'Love','❤️','2024-08-30 11:42:19',5),(11,'Insightfull','?','2024-08-30 11:42:19',6);
/*!40000 ALTER TABLE `user_reactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_settings`
--

DROP TABLE IF EXISTS `user_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_settings` (
  `user_id` int NOT NULL,
  `is_accepting_connection_request` enum('true','false') DEFAULT NULL,
  `is_accepting_follow_request` enum('true','false') DEFAULT NULL,
  `is_school_shown_in_intro` enum('true','false') DEFAULT NULL,
  `is_open_to_work` enum('recruiter','everyone','nope') DEFAULT 'nope',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_settings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_settings`
--

LOCK TABLES `user_settings` WRITE;
/*!40000 ALTER TABLE `user_settings` DISABLE KEYS */;
INSERT INTO `user_settings` VALUES (1,'true','true','true','everyone'),(2,'true','true','true','nope');
/*!40000 ALTER TABLE `user_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_skills`
--

DROP TABLE IF EXISTS `user_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_skills` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `user_experience_id` int DEFAULT NULL,
  `user_education_id` int DEFAULT NULL,
  `skill_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`skill_id`),
  KEY `user_experience_id` (`user_experience_id`),
  KEY `user_education_id` (`user_education_id`),
  KEY `skill_id` (`skill_id`),
  CONSTRAINT `user_skills_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_skills_ibfk_2` FOREIGN KEY (`user_experience_id`) REFERENCES `user_experiences` (`id`),
  CONSTRAINT `user_skills_ibfk_3` FOREIGN KEY (`user_education_id`) REFERENCES `user_educations` (`id`),
  CONSTRAINT `user_skills_ibfk_4` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_skills`
--

LOCK TABLES `user_skills` WRITE;
/*!40000 ALTER TABLE `user_skills` DISABLE KEYS */;
INSERT INTO `user_skills` VALUES (1,1,1,NULL,1),(2,1,1,NULL,2),(3,1,1,NULL,3),(4,2,4,NULL,1),(5,2,5,NULL,5),(6,2,6,NULL,4);
/*!40000 ALTER TABLE `user_skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `additional_name` text,
  `gender` enum('male','female','prefer-not-to-say','binary') DEFAULT NULL,
  `pronouns` varchar(20) DEFAULT NULL,
  `headline` text,
  `industry` varchar(100) DEFAULT NULL,
  `school` varchar(100) DEFAULT NULL,
  `location_country` varchar(100) DEFAULT NULL,
  `location_city` varchar(100) DEFAULT NULL,
  `website` text,
  `location_state` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `first_name` (`first_name`,`last_name`,`gender`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Nitesh','Narang',NULL,'male',NULL,'Software Engineer {ex: Alyve Health}','Software','Airport School','India','Ahmedabad',NULL,NULL),(2,'Melinda','Gates','French','female',NULL,'Founder of Pivotal. Co-founder of the Gates Foundation. Author of The Moment of Lift.','Information Technology',NULL,'United States','',NULL,'Greater Seatle Area'),(3,'Satya','Nadela','','male',NULL,'Chairman and CEO at Microsoft','Information Technology',NULL,'United States','Redmond',NULL,'Washington'),(4,'Swapnil','Agarwal','','male',NULL,'Founder, Roc8 Careers | Prev: SDE @Amazon and PM @Meesho','Information Technology',NULL,'India','Bengaluru',NULL,'Karnataka');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-31 13:57:46
