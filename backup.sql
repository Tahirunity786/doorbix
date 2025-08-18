-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: localhost    Database: doorbixv0
-- ------------------------------------------------------
-- Server version	8.0.42-0ubuntu0.22.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_customuser'),(22,'Can change user',6,'change_customuser'),(23,'Can delete user',6,'delete_customuser'),(24,'Can view user',6,'view_customuser'),(25,'Can add pc tags',7,'add_pctags'),(26,'Can change pc tags',7,'change_pctags'),(27,'Can delete pc tags',7,'delete_pctags'),(28,'Can view pc tags',7,'view_pctags'),(29,'Can add product category',8,'add_productcategory'),(30,'Can change product category',8,'change_productcategory'),(31,'Can delete product category',8,'delete_productcategory'),(32,'Can view product category',8,'view_productcategory'),(33,'Can add product image schema',9,'add_productimageschema'),(34,'Can change product image schema',9,'change_productimageschema'),(35,'Can delete product image schema',9,'delete_productimageschema'),(36,'Can view product image schema',9,'view_productimageschema'),(37,'Can add product shipping',10,'add_productshipping'),(38,'Can change product shipping',10,'change_productshipping'),(39,'Can delete product shipping',10,'delete_productshipping'),(40,'Can view product shipping',10,'view_productshipping'),(41,'Can add product collection',11,'add_productcollection'),(42,'Can change product collection',11,'change_productcollection'),(43,'Can delete product collection',11,'delete_productcollection'),(44,'Can view product collection',11,'view_productcollection'),(45,'Can add product variant',12,'add_productvariant'),(46,'Can change product variant',12,'change_productvariant'),(47,'Can delete product variant',12,'delete_productvariant'),(48,'Can view product variant',12,'view_productvariant'),(49,'Can add product',13,'add_product'),(50,'Can change product',13,'change_product'),(51,'Can delete product',13,'delete_product'),(52,'Can view product',13,'view_product'),(53,'Can add inventory',14,'add_inventory'),(54,'Can change inventory',14,'change_inventory'),(55,'Can delete inventory',14,'delete_inventory'),(56,'Can view inventory',14,'view_inventory'),(57,'Can add inventory history',15,'add_inventoryhistory'),(58,'Can change inventory history',15,'change_inventoryhistory'),(59,'Can delete inventory history',15,'delete_inventoryhistory'),(60,'Can view inventory history',15,'view_inventoryhistory'),(61,'Can add Product Meta',16,'add_productmeta'),(62,'Can change Product Meta',16,'change_productmeta'),(63,'Can delete Product Meta',16,'delete_productmeta'),(64,'Can view Product Meta',16,'view_productmeta'),(65,'Can add product review',17,'add_productreview'),(66,'Can change product review',17,'change_productreview'),(67,'Can delete product review',17,'delete_productreview'),(68,'Can view product review',17,'view_productreview'),(69,'Can add tags',18,'add_tags'),(70,'Can change tags',18,'change_tags'),(71,'Can delete tags',18,'delete_tags'),(72,'Can view tags',18,'view_tags'),(73,'Can add category',19,'add_category'),(74,'Can change category',19,'change_category'),(75,'Can delete category',19,'delete_category'),(76,'Can view category',19,'view_category'),(77,'Can add blog post',20,'add_blogpost'),(78,'Can change blog post',20,'change_blogpost'),(79,'Can delete blog post',20,'delete_blogpost'),(80,'Can view blog post',20,'view_blogpost'),(81,'Can add comments',21,'add_comments'),(82,'Can change comments',21,'change_comments'),(83,'Can delete comments',21,'delete_comments'),(84,'Can view comments',21,'view_comments'),(85,'Can add discount',22,'add_discount'),(86,'Can change discount',22,'change_discount'),(87,'Can delete discount',22,'delete_discount'),(88,'Can view discount',22,'view_discount'),(89,'Can add discount usage',23,'add_discountusage'),(90,'Can change discount usage',23,'change_discountusage'),(91,'Can delete discount usage',23,'delete_discountusage'),(92,'Can view discount usage',23,'view_discountusage');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_a_customuser`
--

DROP TABLE IF EXISTS `core_a_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_a_customuser` (
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_a_customuser`
--

LOCK TABLES `core_a_customuser` WRITE;
/*!40000 ALTER TABLE `core_a_customuser` DISABLE KEYS */;
INSERT INTO `core_a_customuser` VALUES ('pbkdf2_sha256$1000000$4SHCqMR7MmIhDzuEaVu9b2$KMvB0Bs6xM6WAKs2xnsNej51KX+C3Jv7va5NNXXeXzs=','2025-08-09 15:05:10.491237',1,'rutab','','','admin@rutab.com',1,1,'2025-08-02 18:38:29.888485','4d47bbb4c6c04cbbb22b5b3517b7d3cb'),('pbkdf2_sha256$1000000$CqhgOmIC3kvsSs6s2B5rik$ANqJaHsLqpTEEz1ee3NBgEBzwUZ2c+379pK4qNfr89o=','2025-08-05 17:34:32.892991',1,'tahir','','','admin@tahir.com',1,1,'2025-08-02 18:36:46.609588','6b432032276146bc8e08143e4a1c9707'),('pbkdf2_sha256$1000000$IXZ3HV2dc4FAMF7MeHvEVR$X6Cl2rIbAhb3TNME33k2SlZuUjvhvCB/tICPCqXTKCs=','2025-08-08 17:30:22.038734',1,'arslan','','','admin@arslan.com',1,1,'2025-08-06 15:02:33.933281','76a515ae483a4b41988c0738c71b7298'),('pbkdf2_sha256$1000000$NSJ4LiNDJWbjFf0eT0hzm8$a3MzFPLpq9ji93aLvGpqcIC87P6rWyEmUyR6KGp2Ei0=','2025-08-06 05:47:09.680507',1,'hassan','','','admin@hassan.com',1,1,'2025-08-02 18:37:27.358143','aee2db4b0e9844eb9c21248145715231');
/*!40000 ALTER TABLE `core_a_customuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_a_customuser_groups`
--

DROP TABLE IF EXISTS `core_a_customuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_a_customuser_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` char(32) NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_a_customuser_groups_customuser_id_group_id_faffda81_uniq` (`customuser_id`,`group_id`),
  KEY `core_a_customuser_groups_group_id_dc862ac3_fk_auth_group_id` (`group_id`),
  CONSTRAINT `core_a_customuser_gr_customuser_id_62ea8ab2_fk_core_a_cu` FOREIGN KEY (`customuser_id`) REFERENCES `core_a_customuser` (`id`),
  CONSTRAINT `core_a_customuser_groups_group_id_dc862ac3_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_a_customuser_groups`
--

LOCK TABLES `core_a_customuser_groups` WRITE;
/*!40000 ALTER TABLE `core_a_customuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_a_customuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_a_customuser_user_permissions`
--

DROP TABLE IF EXISTS `core_a_customuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_a_customuser_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` char(32) NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_a_customuser_user_p_customuser_id_permission_6e3b6315_uniq` (`customuser_id`,`permission_id`),
  KEY `core_a_customuser_us_permission_id_5c1f269a_fk_auth_perm` (`permission_id`),
  CONSTRAINT `core_a_customuser_us_customuser_id_fbbbfc2a_fk_core_a_cu` FOREIGN KEY (`customuser_id`) REFERENCES `core_a_customuser` (`id`),
  CONSTRAINT `core_a_customuser_us_permission_id_5c1f269a_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_a_customuser_user_permissions`
--

LOCK TABLES `core_a_customuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `core_a_customuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_a_customuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_b_blogpost`
--

DROP TABLE IF EXISTS `core_b_blogpost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_b_blogpost` (
  `id` char(32) NOT NULL,
  `blogImage` varchar(100) NOT NULL,
  `blogTitle` varchar(200) NOT NULL,
  `slug` varchar(220) NOT NULL,
  `blogDescription` longtext NOT NULL,
  `blogExcerpt` longtext NOT NULL,
  `metaTitle` varchar(255) NOT NULL,
  `metaDescription` varchar(300) NOT NULL,
  `is_featured` tinyint(1) NOT NULL,
  `is_published` tinyint(1) NOT NULL,
  `views_count` int unsigned NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `blogCategory_id` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `core_b_blogpost_blogCategory_id_901637b5_fk_core_b_category_id` (`blogCategory_id`),
  KEY `core_b_blogpost_blogTitle_798ccf1e` (`blogTitle`),
  CONSTRAINT `core_b_blogpost_blogCategory_id_901637b5_fk_core_b_category_id` FOREIGN KEY (`blogCategory_id`) REFERENCES `core_b_category` (`id`),
  CONSTRAINT `core_b_blogpost_chk_1` CHECK ((`views_count` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_b_blogpost`
--

LOCK TABLES `core_b_blogpost` WRITE;
/*!40000 ALTER TABLE `core_b_blogpost` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_b_blogpost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_b_blogpost_blogTags`
--

DROP TABLE IF EXISTS `core_b_blogpost_blogTags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_b_blogpost_blogTags` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `blogpost_id` char(32) NOT NULL,
  `tags_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_b_blogpost_blogTags_blogpost_id_tags_id_b7a0568d_uniq` (`blogpost_id`,`tags_id`),
  KEY `core_b_blogpost_blogTags_tags_id_79695a7e_fk_core_b_tags_id` (`tags_id`),
  CONSTRAINT `core_b_blogpost_blog_blogpost_id_949d3967_fk_core_b_bl` FOREIGN KEY (`blogpost_id`) REFERENCES `core_b_blogpost` (`id`),
  CONSTRAINT `core_b_blogpost_blogTags_tags_id_79695a7e_fk_core_b_tags_id` FOREIGN KEY (`tags_id`) REFERENCES `core_b_tags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_b_blogpost_blogTags`
--

LOCK TABLES `core_b_blogpost_blogTags` WRITE;
/*!40000 ALTER TABLE `core_b_blogpost_blogTags` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_b_blogpost_blogTags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_b_category`
--

DROP TABLE IF EXISTS `core_b_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_b_category` (
  `id` char(32) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(120) NOT NULL,
  `description` longtext,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_b_category`
--

LOCK TABLES `core_b_category` WRITE;
/*!40000 ALTER TABLE `core_b_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_b_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_b_comments`
--

DROP TABLE IF EXISTS `core_b_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_b_comments` (
  `id` char(32) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `comment` longtext NOT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `comment_on_comment_id` char(32) DEFAULT NULL,
  `post_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_b_comments_comment_on_comment_i_efe0ace0_fk_core_b_co` (`comment_on_comment_id`),
  KEY `core_b_comments_post_id_29e9132f_fk_core_b_blogpost_id` (`post_id`),
  KEY `core_b_comments_name_aad39c1e` (`name`),
  KEY `core_b_comments_email_3fb18827` (`email`),
  CONSTRAINT `core_b_comments_comment_on_comment_i_efe0ace0_fk_core_b_co` FOREIGN KEY (`comment_on_comment_id`) REFERENCES `core_b_comments` (`id`),
  CONSTRAINT `core_b_comments_post_id_29e9132f_fk_core_b_blogpost_id` FOREIGN KEY (`post_id`) REFERENCES `core_b_blogpost` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_b_comments`
--

LOCK TABLES `core_b_comments` WRITE;
/*!40000 ALTER TABLE `core_b_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_b_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_b_tags`
--

DROP TABLE IF EXISTS `core_b_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_b_tags` (
  `id` char(32) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(120) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_b_tags`
--

LOCK TABLES `core_b_tags` WRITE;
/*!40000 ALTER TABLE `core_b_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_b_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_discount`
--

DROP TABLE IF EXISTS `core_p_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_discount` (
  `id` char(32) NOT NULL,
  `name` varchar(180) NOT NULL,
  `code` varchar(64) DEFAULT NULL,
  `description` longtext,
  `discount_type` varchar(10) NOT NULL,
  `value` decimal(12,2) NOT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `combinable` tinyint(1) NOT NULL,
  `minimum_order_value` decimal(12,2) DEFAULT NULL,
  `usage_limit` int unsigned DEFAULT NULL,
  `usage_limit_per_user` int unsigned DEFAULT NULL,
  `priority` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `core_p_disc_code_0b41df_idx` (`code`),
  KEY `core_p_disc_active_3b1f2b_idx` (`active`,`start_date`,`end_date`),
  CONSTRAINT `core_p_discount_chk_1` CHECK ((`usage_limit` >= 0)),
  CONSTRAINT `core_p_discount_chk_2` CHECK ((`usage_limit_per_user` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_discount`
--

LOCK TABLES `core_p_discount` WRITE;
/*!40000 ALTER TABLE `core_p_discount` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_p_discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_discount_categories`
--

DROP TABLE IF EXISTS `core_p_discount_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_discount_categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `discount_id` char(32) NOT NULL,
  `productcategory_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_p_discount_categori_discount_id_productcateg_d0be0024_uniq` (`discount_id`,`productcategory_id`),
  KEY `core_p_discount_cate_productcategory_id_516efe60_fk_core_p_pr` (`productcategory_id`),
  CONSTRAINT `core_p_discount_cate_discount_id_621598cf_fk_core_p_di` FOREIGN KEY (`discount_id`) REFERENCES `core_p_discount` (`id`),
  CONSTRAINT `core_p_discount_cate_productcategory_id_516efe60_fk_core_p_pr` FOREIGN KEY (`productcategory_id`) REFERENCES `core_p_productcategory` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_discount_categories`
--

LOCK TABLES `core_p_discount_categories` WRITE;
/*!40000 ALTER TABLE `core_p_discount_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_p_discount_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_discount_collections`
--

DROP TABLE IF EXISTS `core_p_discount_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_discount_collections` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `discount_id` char(32) NOT NULL,
  `productcollection_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_p_discount_collecti_discount_id_productcolle_0c693620_uniq` (`discount_id`,`productcollection_id`),
  KEY `core_p_discount_coll_productcollection_id_683f6956_fk_core_p_pr` (`productcollection_id`),
  CONSTRAINT `core_p_discount_coll_discount_id_2b2cb667_fk_core_p_di` FOREIGN KEY (`discount_id`) REFERENCES `core_p_discount` (`id`),
  CONSTRAINT `core_p_discount_coll_productcollection_id_683f6956_fk_core_p_pr` FOREIGN KEY (`productcollection_id`) REFERENCES `core_p_productcollection` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_discount_collections`
--

LOCK TABLES `core_p_discount_collections` WRITE;
/*!40000 ALTER TABLE `core_p_discount_collections` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_p_discount_collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_discount_products`
--

DROP TABLE IF EXISTS `core_p_discount_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_discount_products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `discount_id` char(32) NOT NULL,
  `product_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_p_discount_products_discount_id_product_id_faaae2ef_uniq` (`discount_id`,`product_id`),
  KEY `core_p_discount_prod_product_id_786cc762_fk_core_p_pr` (`product_id`),
  CONSTRAINT `core_p_discount_prod_discount_id_3ab463d9_fk_core_p_di` FOREIGN KEY (`discount_id`) REFERENCES `core_p_discount` (`id`),
  CONSTRAINT `core_p_discount_prod_product_id_786cc762_fk_core_p_pr` FOREIGN KEY (`product_id`) REFERENCES `core_p_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_discount_products`
--

LOCK TABLES `core_p_discount_products` WRITE;
/*!40000 ALTER TABLE `core_p_discount_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_p_discount_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_discount_variants`
--

DROP TABLE IF EXISTS `core_p_discount_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_discount_variants` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `discount_id` char(32) NOT NULL,
  `productvariant_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_p_discount_variants_discount_id_productvaria_12459846_uniq` (`discount_id`,`productvariant_id`),
  KEY `core_p_discount_vari_productvariant_id_481ecb3a_fk_core_p_pr` (`productvariant_id`),
  CONSTRAINT `core_p_discount_vari_discount_id_f6c3932c_fk_core_p_di` FOREIGN KEY (`discount_id`) REFERENCES `core_p_discount` (`id`),
  CONSTRAINT `core_p_discount_vari_productvariant_id_481ecb3a_fk_core_p_pr` FOREIGN KEY (`productvariant_id`) REFERENCES `core_p_productvariant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_discount_variants`
--

LOCK TABLES `core_p_discount_variants` WRITE;
/*!40000 ALTER TABLE `core_p_discount_variants` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_p_discount_variants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_discountusage`
--

DROP TABLE IF EXISTS `core_p_discountusage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_discountusage` (
  `id` char(32) NOT NULL,
  `order_reference` varchar(255) DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `discount_id` char(32) NOT NULL,
  `used_by_id` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `core_p_disc_discoun_253583_idx` (`discount_id`),
  KEY `core_p_disc_used_by_f4b82d_idx` (`used_by_id`),
  CONSTRAINT `core_p_discountusage_discount_id_e7e21b16_fk_core_p_discount_id` FOREIGN KEY (`discount_id`) REFERENCES `core_p_discount` (`id`),
  CONSTRAINT `core_p_discountusage_used_by_id_5d6e4b84_fk_core_a_customuser_id` FOREIGN KEY (`used_by_id`) REFERENCES `core_a_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_discountusage`
--

LOCK TABLES `core_p_discountusage` WRITE;
/*!40000 ALTER TABLE `core_p_discountusage` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_p_discountusage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_inventory`
--

DROP TABLE IF EXISTS `core_p_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_inventory` (
  `id` char(32) NOT NULL,
  `quantity` int unsigned NOT NULL,
  `low_stock_threshold` int unsigned NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `product_id` char(32) DEFAULT NULL,
  `variant_id` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`),
  UNIQUE KEY `variant_id` (`variant_id`),
  CONSTRAINT `core_p_inventory_product_id_5d378b22_fk_core_p_product_id` FOREIGN KEY (`product_id`) REFERENCES `core_p_product` (`id`),
  CONSTRAINT `core_p_inventory_variant_id_eca07bee_fk_core_p_productvariant_id` FOREIGN KEY (`variant_id`) REFERENCES `core_p_productvariant` (`id`),
  CONSTRAINT `core_p_inventory_chk_1` CHECK ((`quantity` >= 0)),
  CONSTRAINT `core_p_inventory_chk_2` CHECK ((`low_stock_threshold` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_inventory`
--

LOCK TABLES `core_p_inventory` WRITE;
/*!40000 ALTER TABLE `core_p_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_p_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_inventoryhistory`
--

DROP TABLE IF EXISTS `core_p_inventoryhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_inventoryhistory` (
  `id` char(32) NOT NULL,
  `change_type` varchar(3) NOT NULL,
  `quantity` int unsigned NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `remarks` longtext,
  `inventory_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_p_inventoryhist_inventory_id_f134f99b_fk_core_p_in` (`inventory_id`),
  CONSTRAINT `core_p_inventoryhist_inventory_id_f134f99b_fk_core_p_in` FOREIGN KEY (`inventory_id`) REFERENCES `core_p_inventory` (`id`),
  CONSTRAINT `core_p_inventoryhistory_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_inventoryhistory`
--

LOCK TABLES `core_p_inventoryhistory` WRITE;
/*!40000 ALTER TABLE `core_p_inventoryhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_p_inventoryhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_pctags`
--

DROP TABLE IF EXISTS `core_p_pctags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_pctags` (
  `id` char(32) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_pctags`
--

LOCK TABLES `core_p_pctags` WRITE;
/*!40000 ALTER TABLE `core_p_pctags` DISABLE KEYS */;
INSERT INTO `core_p_pctags` VALUES ('17cb34bf939f46c0a5e35c0bf462c5e8','2.4G wireless keyboard'),('e77b0ec11c4c434faa95398ca447a06f','all-in-one grooming'),('51acab3609f84812a42147b1fcac5b86','arm strength exerciser'),('e9ef8190af2544739264514deaba0f23','AutoEssentials'),('b3b1298b974e48d093cff631fb6ce047','babies toys'),('abf643a4a7ab42a095555dc018cfaf8e','beard trimmer'),('a72ca6aa859c4f42a48336eb2d49861b','beauty'),('961f178ea333414fbd565a6406779786','Beauty Gadget'),('58b352410ca6488fb3b3f29871f53072','bluetooth headset'),('7c92871f5a8a40e6828c721d2d7931db','body hair trimmer'),('5f719c4a9e424041a719901d671003b5','car accessories'),('2f9a201b66884f9b9f52d799f204413e','car gadgets'),('5278e1f2fe5a4e4890f54fdd6220bfa3','car interior accessories'),('24b61d7aee924affa5172904fa67e904','cartoon lamp'),('656f1a7ab58f4a5b8a4e3732a882b9a8','Classic Fashion'),('eed09ef5852f4cafb67f7bd729fd224f','coffee mug'),('47a3a4008ddc43a8a553aca5f9ff887f','compact wireless keyboard'),('53a2612d325f473e854a61e4c9829514','cookware and utensils'),('278cd94681824e3ba8fb55ecb4f770e9','daily moisturizing oil'),('86159f9dc37947e88b2f6510ce95419d','daily sunblock'),('5a72d0afb5c54e628f7a7c4f50096021','Daily Wear Jewelry'),('682e7262b659421b8dfa7fff13e982eb','Dainty Accessories'),('f79dc8b3cda547beaa99cf0ca5b0f222','dark color lipstick'),('3c6dc04c0b7e4cd085d8f3d89dbd2af0','dashboard accessories'),('7c9989a3959b4b86aaebbe8f63d6334f','deep tissue massager'),('352d1c81d81540a09c4c606738d350e8','electric mug'),('7ec76f50f2e6451296d03a11f34aadf5','Elegant Accessories'),('21db9b51809f4ed7932f9c6ccfeff86b','Everyday Elegance'),('13d5d24d926849438e84261409b582b6','fascial massage gun'),('5f5267d8f75c4a4484fdded5f937a479','Fashion Necklace'),('1d9c82d38e9b4a7289ed533e4e0e4df1','fitness'),('e1e0df3e086d4843b803f022a90f31d2','forearm trainer'),('a2b2bcb1e2574c438ca1b769e94cbc27','games'),('103c05d0599f4e2d8a3c7ec4d6220963','gym'),('34f96d3e77cf44d6b431be847b763cf3','hand grip strengthener'),('cc583a0419da4cb4a513f8be6cf72ddd','handheld massager'),('078c72df77ec46498b8386fea65fdff0','hands-free phone holder'),('80bfbf77cad7439ea3c1c73cf5dabf44','Health'),('66ae5ee7b23f48b5af16565e276c0d9c','home and kitchen essentials'),('6dda263dbd3840ed8d5af70d49f4398b','home gym tool'),('dd8bb4a2b2bc46f29e754614d7a56dd5','hydrating body oil'),('a624e596cfa84701a5502a386467239e','kids'),('587677ecf73047b3a61bc40deb5e3b8c','kitchen accessories online'),('a4b1e9ec0ec64ee89fbf3014a9bd07f0','kitchen appliances'),('f82640dd703d43abb2ad58cb896ab343','lamp'),('282ed42568534f468cfd0a600c712864','lip makeup essentials'),('ec4ae441a302414eadbdcf07bc8336cd','lipstick'),('7cb5ee38e6c448129f28df2a9702954c','long-lasting lipstick'),('3605b405bc8d437da7d12ff74b01e42e','makeup products'),('503002f2d23a4e7ca9d690b6baabad6e','matte lip color set'),('45a7925a3c064cefa6a6017bc90c4bb2','men’s grooming set'),('f5b899952792428887a8ffeccecd0bbe','men’s personal care'),('8c8d8691889c4f30b69d3096829cae3d','mini keyboard for PC and laptop'),('e2b16e20d83d470ab41c98f74ef23c89','Minimalist Jewelry'),('e8daabe4ada24c97a2506baead4b81db','mobile accessories'),('189c49850af34f8eaedbc314c72e233b','modern home accessories'),('0e317bf61b2549d985a0f2de82844948','moisturizing sunscreen'),('96059d872a20448a948c2a38fdfc52f6','muscle massage gun'),('dee75266aee74b3485e7486c9a6fec67','Necklace'),('6ca2848cebe744fa906af922184308b6','night lamp'),('640effbe8cb5432cb2b13cfb952de58d','noise cancelling headphones'),('e198ffe8e0274e4db9d64cbe19278877','over-ear headphones'),('bba6a5652d214a1b824abb8ec1a4d40d','phone cradle for car'),('d02d4d377a484a95880c4ce248ac283b','products'),('d17cc2f34e594eddb3db5fd82adb73ba','professional hand gripper'),('76f817276a064af3a49e66cb7d886ed9','retro wireless keyboard'),('22dd32c51aef47b0bd35d1babfd4d66a','Samsung Fold2 phone case'),('4d1838345b6d416a9f2153655ac91dad','Samsung Z Fold2 case'),('5394556b808d4182ba3eea28c8a665d7','skin brightening oil'),('e5ea60f3ba8346d680b70cdb7964a8a4','skin tightening device'),('8317c564994149789fdfc50c0dc300be','Skincare Massager'),('2842d3f45b214a619c35ac886769ad5c','smartwatches and fitness brands'),('f1f5187a625c4cf98918956e5b71d259','SPF lotion'),('0366adc60eb14b6681030a7f1b2885c7','sports'),('5ee95e6e70604a9baa37f8fb5021ccb7','sportswear'),('1bb7e8d4eec34dec8994d4b6d90526ec','spring grip'),('ce94ab7510124ff2b95e21370f063fa4','stylish headphones'),('406472b234194d83b3a2015761a5215c','sunscreen lotion'),('d56129f4bce34a148e7c558928fef02a','Tech'),('e9e3e68aa16a4e748d4e009272732ac3','tech accessories'),('6c9d1ef22309453a91c28c997ed8f482','tech gadgets online'),('2bb8c7e82dc345baab371d90fa465060','toys'),('1a09411ea52249cab8dd4e5c6cd5c235','two-in-one phone case'),('b93e5c1f95be498da46abd60223b7647','universal car accessories'),('41939b0141c4413591733e74c8acac0b','USB Facial Gun'),('fa802801c62046919edd172578425927','UV protection cream'),('d8b1d523326846c38d28750a1472dfee','VGR grooming kit'),('3770cdbfe8c242efadcf52a7548ef603','vitamin c body oil'),('8f24b6507c8e4e9db1522a3f7fa377ca','vitamin c skincare'),('3b4ebae5bc2e46f48b6eaa4718ed53a8','wearable technology'),('4aefdda0e7624522b448b414762c7565','wireless headphones'),('4cafcf77732d459599cb80bf915284cc','Z Fold2 flip case');
/*!40000 ALTER TABLE `core_p_pctags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_product`
--

DROP TABLE IF EXISTS `core_p_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_product` (
  `id` char(32) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `productPrice` decimal(10,2) NOT NULL,
  `productCostPrice` decimal(10,2) DEFAULT NULL,
  `productComparePrice` decimal(10,2) DEFAULT NULL,
  `productStock` int unsigned NOT NULL,
  `productSKU` varchar(100) NOT NULL,
  `productBarcode` varchar(100) DEFAULT NULL,
  `productIsActive` varchar(30) NOT NULL,
  `productCreatedAt` datetime(6) NOT NULL,
  `productUpdatedAt` datetime(6) NOT NULL,
  `productSlug` varchar(255) DEFAULT NULL,
  `productIsFeatured` tinyint(1) NOT NULL,
  `productIsOnSale` tinyint(1) NOT NULL,
  `productType` varchar(100) NOT NULL,
  `productVendor` varchar(255) NOT NULL,
  `productSaleCountinue` tinyint(1) NOT NULL,
  `productIsTrackQuantity` tinyint(1) NOT NULL,
  `productShipping_id` char(32) DEFAULT NULL,
  `productVariant_id` char(32) DEFAULT NULL,
  `productSeo_id` char(32) DEFAULT NULL,
  `productIsBestSelling` tinyint(1) NOT NULL,
  `productIsForSubscription` tinyint(1) NOT NULL,
  `productDescription` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `productSKU` (`productSKU`),
  UNIQUE KEY `productSlug` (`productSlug`),
  UNIQUE KEY `productBarcode` (`productBarcode`),
  UNIQUE KEY `productShipping_id` (`productShipping_id`),
  UNIQUE KEY `productSeo_id` (`productSeo_id`),
  KEY `core_p_product_productVariant_id_8aa9860c_fk_core_p_pr` (`productVariant_id`),
  KEY `core_p_product_productName_6d5dad41` (`productName`),
  CONSTRAINT `core_p_product_productSeo_id_a8f04f09_fk` FOREIGN KEY (`productSeo_id`) REFERENCES `core_p_productmeta` (`id`),
  CONSTRAINT `core_p_product_productShipping_id_7a9e0d31_fk_core_p_pr` FOREIGN KEY (`productShipping_id`) REFERENCES `core_p_productshipping` (`id`),
  CONSTRAINT `core_p_product_productVariant_id_8aa9860c_fk_core_p_pr` FOREIGN KEY (`productVariant_id`) REFERENCES `core_p_productvariant` (`id`),
  CONSTRAINT `core_p_product_chk_1` CHECK ((`productStock` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_product`
--

LOCK TABLES `core_p_product` WRITE;
/*!40000 ALTER TABLE `core_p_product` DISABLE KEYS */;
INSERT INTO `core_p_product` VALUES ('16164e716e7b4ac88be431e761db7021','Mini 2.4G Punk Wireless Keyboard',85.00,79.00,99.96,10,'ZMPB142639502BY',NULL,'published','2025-08-05 06:27:00.358457','2025-08-09 14:20:11.713078','mini-24g-punk-wireless-keyboard',1,0,'wireless keyboard','Zambeel',1,0,'1d2d29a8bfc74c87a5833c8d1ea30eb9','0506e7b0c9964309a767a980f182cafe','ee2680f83b1842cd907045d5f4b467fb',1,0,'<h2><strong>Product Information:</strong></h2>\r\n\r\n<p><strong>Mini Wireless 2.4G Punk Wireless Keyboard</strong><br />\r\n<strong>Product color:</strong> white pink blue<br />\r\n<strong>Item model number:</strong> Y60<br />\r\n<strong>Adapter battery:</strong> 2 AA batteries (battery needs to be prepared by yourself)<br />\r\n<strong>Product size:</strong> 30*15.5*3.5cm<br />\r\n<strong>Number of keys</strong>: 75 keys<br />\r\n<strong>System Compatibility:</strong> Windows XP / Win7 / Win8 / Win10</p>\r\n\r\n<p><br />\r\n<strong>Packing List:&nbsp;</strong></p>\r\n\r\n<p>1x Keyboard</p>'),('1cb8f5a7889642cebdd05ec7e08023b8','Rabbit LED Night Light Silicone Animal Cartoon Dimmable Lamp USB Rechargeable For Children Kids Baby Gift Bedside Bedroom',62.00,55.00,90.00,6,'ZMJT130203301AZ',NULL,'published','2025-08-06 06:01:38.057950','2025-08-09 14:18:44.005210','rabbit-led-night-light-silicone-animal-cartoon-dimmable-lamp-usb-rechargeable-for-children-kids-baby-gift-bedside-bedroom',1,1,'LED Night Light','Zambeel',1,0,NULL,NULL,'77c24bfe80904f9794ea8fbc9fb7f919',1,0,'<h2><strong>Overview:</strong></h2>\r\n\r\n<p><strong>1. Made of safety:</strong> BPA-free soft silicone material, no sharp edges, surface soft Press, handheld size and eco-friendly, really is a good gift, perfect for babies, kids, teenagers, adults, friends or colleagues.<br />\r\n<strong>2. Easy Press/ pat control:-</strong> kids night light, designed for children to learn and play - Press or pat the bunny to change colours.<br />\r\n<strong>3. Adorable appearance:</strong> The shape is designed to be adorable rabbit. Keep you in a good mood with the soft lighting;<br />\r\n<strong>4. Adjustable Lamp</strong>: Adjust brightness freely. Through the soft silicone surface, the light looks soft and warm. Create a comfortable and relaxing atmosphere.<br />\r\n<br />\r\n<strong>Specification</strong><br />\r\n<strong>Additional features:</strong> warm light white light dual tone light<br />\r\n<strong>Voltage:</strong> &le;36V (V)<br />\r\n<strong>Shade material:</strong> silicone<br />\r\n<strong>Average service life:</strong> 1000 (h)<br />\r\n<strong>Light color:</strong> warm light white light double color<br />\r\n<strong>Light source power</strong>: 0.2-1.5W (W)<br />\r\n<strong>Power supply mode:</strong> battery<br />\r\n<strong>Battery capacity:</strong> 1200mAh<br />\r\n<strong>Light color temperature:</strong> 2700-6500K<br />\r\n<strong>Charging time:</strong> about 4.5H<br />\r\n<strong>Use time:</strong> about 200H low light / about 8H high light<br />\r\n<strong>Size Information:</strong>147&times;90&times;98MM<br />\r\n<br />\r\n<strong>Package Content :</strong><br />\r\n1*lamp+1*USB cable+1*instruction</p>'),('336e7bd17725412f9668d3951ee08226','Vitamin C Body Oil (100ml)',40.00,34.00,49.95,5,'VCBO-N-GF-ZAM',NULL,'published','2025-08-07 10:52:45.110006','2025-08-09 14:11:04.182071','vitamin-c-body-oil-100ml',1,0,'Body Oil','Zambeel',1,0,NULL,NULL,'5442d26edfa746b2912a23c392e02662',1,0,'<h2>Features:</h2>\r\n\r\n<ul>\r\n	<li>🍊&nbsp;<strong>Vitamin C Body Oil (100ml)</strong>&nbsp;&ndash; Nourish your skin with the rejuvenating power of Vitamin C!</li>\r\n	<li>✨&nbsp;<strong>Brightens &amp; Hydrates</strong>&nbsp;&ndash; Helps brighten your skin tone while providing deep hydration for a radiant and glowing complexion.</li>\r\n	<li>🌿&nbsp;<strong>Rich in Antioxidants</strong>&nbsp;&ndash; Packed with Vitamin C to protect your skin from environmental damage and reduce signs of aging.</li>\r\n	<li>🛁&nbsp;<strong>Lightweight &amp; Non-Greasy</strong>&nbsp;&ndash; Absorbs quickly into the skin, leaving it soft, smooth, and refreshed without any sticky residue.</li>\r\n	<li>🌟&nbsp;<strong>Perfect for Daily Use</strong>&nbsp;&ndash; Suitable for all skin types, ideal for use after a shower or before bed to lock in moisture.</li>\r\n	<li>🧴&nbsp;<strong>Compact 100ml Bottle</strong>&nbsp;&ndash; Easy to carry, perfect for travel or to keep at home as part of your skincare routine.</li>\r\n</ul>'),('3449643f062e4deda01e6e7f0485ed42','Three-in-one Mobile Phone Wireless Charger Small Night Lamp',103.00,97.00,149.97,10,'ZMSJ179514901AZ','ZMSJ179514901AZ','published','2025-08-04 17:58:08.625613','2025-08-04 18:02:28.986882','three-in-one-mobile-phone-wireless-charger-small-night-lamp',1,1,'Wireless Charger','Zambeel',1,1,NULL,'0506e7b0c9964309a767a980f182cafe','6bde52214d134d998c6c1d032558b2b0',1,1,''),('452cb12151d74173b15d4a5268512977','Rayhong - Car scratch Removel Wax',38.00,32.00,NULL,10,'RCSX-120-ML-GF-ZAM',NULL,'published','2025-08-09 15:25:13.181944','2025-08-09 15:25:13.182013','rayhong-car-scratch-removel-wax',0,0,'Car Care','MyZambeel',0,0,NULL,NULL,NULL,0,0,'<h4>Features:</h4>\r\n\r\n<p><strong>Rayhong Car Scratch Removal Wax (120ml) 🚗✨</strong></p>\r\n\r\n<ul>\r\n	<li>🔧&nbsp;<strong>Effortlessly Removes Scratches</strong>&nbsp;&ndash; Helps eliminate light scratches, swirls, and oxidation.</li>\r\n	<li>💎&nbsp;<strong>Restores Shine &amp; Gloss</strong>&nbsp;&ndash; Brings back the original luster of your car&rsquo;s paint.</li>\r\n	<li>🛡️&nbsp;<strong>Protects Against Future Damage</strong>&nbsp;&ndash; Adds a protective layer to prevent fading and oxidation.</li>\r\n	<li>✅&nbsp;<strong>Safe for All Paint Colors</strong>&nbsp;&ndash; Works on any car color without leaving stains or residue.</li>\r\n	<li>🚫&nbsp;<strong>No Harsh Chemicals</strong>&nbsp;&ndash; Gentle formula that won&rsquo;t harm your vehicle&rsquo;s surface.</li>\r\n	<li>🔄&nbsp;<strong>Easy-to-Use</strong>&nbsp;&ndash; Just apply, buff, and wipe for a flawless finish.</li>\r\n</ul>'),('47a080e8e5df4c398646eaef99402857','Leather Repair Cream',35.00,30.00,NULL,10,'ZMQCGJQC00067-60ml',NULL,'published','2025-08-09 15:21:52.391228','2025-08-09 15:21:52.391288','leather-repair-cream',0,0,'Car Care','MyZambeel',0,0,NULL,NULL,NULL,0,0,'<p>Product Name: Leather Anion Repair Cream<br />\r\nContent: 60ML<br />\r\nPerformance introduction: Filling in places such as trachoma, good adhesion, no hardening of the wound, and no flying off.</p>'),('6b8370854e6a4f02831372e6005615df','Matte Lipstick Set',28.00,25.00,30.00,26,'MTT-MGE-GF-ZAM',NULL,'published','2025-08-07 17:19:30.965457','2025-08-09 14:02:24.197038','matte-lipstick-set',1,1,'lipstick','Zambeel',1,0,NULL,NULL,'b58f9daede0349cb8df99f420d82e796',1,0,'<h2>Features:</h2>\r\n\r\n<ul>\r\n	<li><strong>Vibrant Color:</strong>&nbsp;stunning shades, perfect for every occasion!</li>\r\n	<li>🧡&nbsp;<strong>Long-Lasting Wear</strong>: Enjoy a bold matte finish that stays on all day without fading.</li>\r\n	<li>🌿&nbsp;<strong>Moisturizing Formula</strong>: Infused with nourishing ingredients to keep your lips soft and smooth.</li>\r\n	<li>🌟&nbsp;<strong>Cruelty-Free &amp; Vegan</strong>: Beauty you can feel good about!</li>\r\n	<li>🎨&nbsp;<strong>Perfect Gift</strong>: Stylish and compact packaging makes it a great gift for any makeup lover.</li>\r\n	<li>💼&nbsp;<strong>Travel-Friendly</strong>: Slip it in your bag for quick touch-ups on the go.</li>\r\n</ul>'),('7de361fcdbd34ad7bd6e45f3a37af865','925 Sterling Silver Simple Temperament Clavicle Necklace',50.00,45.00,55.00,30,'ZMLX213800801AZ',NULL,'published','2025-08-09 13:36:33.278992','2025-08-09 13:36:33.279048','925-sterling-silver-simple-temperament-clavicle-necklace',1,1,'Jewellery','Zambeel',1,0,NULL,NULL,'afa71f2c2ea84ae1a1413cab40320965',1,0,'<p><strong>Product information:</strong><br />\r\n<strong>Treatment Process</strong>: Diamond<br />\r\n<strong>Colo</strong>r: YD003/platinum color about 2.1G,<br />\r\n<strong>Chain style</strong>: water wave chain<br />\r\n<strong>Material</strong>: Silver<br />\r\n<strong>Purity</strong>: 925 silver<br />\r\n<strong>Shape</strong>: Leaves</p>\r\n\r\n<p><strong>Packing list:</strong><br />\r\nNecklace * 1pc&nbsp;</p>'),('7f69f2e173b84f36b9146f8e63ce30a2','UV Protection Refreshing Protective Cream Sunscreen Lotion',43.00,37.00,54.94,20,'ZMYD202752801AZ',NULL,'published','2025-08-06 10:16:09.704931','2025-08-09 14:12:13.450467','uv-protection-refreshing-protective-cream-sunscreen-lotion',1,0,'Sunscreen lotion & cream','Zambeel',1,1,NULL,NULL,'cbb8d16d5e824f49b7c159501a898efd',1,0,'<p><strong>Product information:</strong><br />\r\nApplicable people: general<br />\r\nSpecification: 75ml sunscreen<br />\r\nApplicable skin type: Universal<br />\r\nNet content: 75ml<br />\r\nSize: 14.1x3.7cm<br />\r\nCategory: Sunscreen/makeup primer</p>\r\n\r\n<p><br />\r\n<strong>Packing list:</strong><br />\r\nSunscreen * 1</p>'),('83832402960e48d5b9dc6171d34928fa','Electric Coffee Mug USB Rechargeable Automatic Magnetic Cup IP67 Waterproof Food-Safe Stainless Steel For Juice Tea Milksha Kitchen Gadgets',60.00,52.00,75.00,10,'ZMYD187072701AZ',NULL,'published','2025-08-06 06:12:31.121170','2025-08-09 14:15:25.984456','electric-coffee-mug-usb-rechargeable-automatic-magnetic-cup-ip67-waterproof-food-safe-stainless-steel-for-juice-tea-milksha-kitchen-gadgets',1,0,'Electric Coffee Mug','Zambeel',1,0,NULL,NULL,'1988f1101f0d4bf3b1f200855c5af7c2',1,0,'<h2><strong>Overview:</strong></h2>\r\n\r\n<p><strong>【Multiple Uses】:</strong>Perfectly crafted mug for morning coffee while traveling. Designed to work well on the go. A sturdy lid minimizes spills even when the stirring function is on. Keep the bottom lid tightly closed for best results. Great for coffee, tea, hot chocolate, milk, protein shakes, lemonade and many other stirable light mixed drinks.<br />\r\n<strong>【Rechargeable Mode】:</strong>Simply connect the mug to any USB port with the included USB cable, 200mA battery capacity, TYPE-C fast charging, can be used for about 60 minutes on a single charge, easy to use.<br />\r\n<strong>【Temperature Display】:</strong> Touch LCD shows the temperature. You can monitor the water temperature in real-time with intelligent temperature measurement. Non-slip base and physical stirring can also help drinks cool down quickly.<br />\r\n<strong>【380ML/13OZ capacity, Easy to&nbsp;</strong><span style=\"box-sizing:border-box; margin:0px; padding:0px\"><strong>Clean 】:</strong>&nbsp;The magnetic stirrer on the bottom of the mug can be quickly removed and reinserted for easy cleaning. However, please do not use the dishwasher or submerge it completely</span>&nbsp;to clean. The cup is made of food-grade PP plastic material with a 304 stainless steel interior. Note: The handle is not waterproof and cannot be fully immersed.<br />\r\n<strong>【Creative Gift】:</strong>Cute Mug, Cute Gift. The perfect gift for family, friends, and coworkers who love coffee, hot chocolate, or other drinks that need to be stirred. Novel, fun, and practical, an ideal gift.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Product information:</strong><br />\r\nColor: JB-01 auto stirring Cup (LCD)<br />\r\nSize (height, caliber):13.8 * 8cm<br />\r\nGrade: Grade 7 waterproof<br />\r\nApplicable places: home use, outdoor use, Leisure Bar<br />\r\nCapacity: White</p>\r\n\r\n<p><br />\r\n<strong>Packing list:</strong><br />\r\nMixing cup X1</p>'),('843c9455ee714dcf819544140c3731a9','Hoco - Center Console Car Holder (HW8)',85.00,78.00,101.93,10,'HW8-N-MAW-ZAM',NULL,'published','2025-08-07 11:16:14.253366','2025-08-09 14:08:54.732898','hoco-center-console-car-holder-hw8',1,1,'Car interior accessories','Zambeel',1,1,NULL,NULL,'6fa2d78b11f24d45841051e904802b56',1,0,'<h2>Features:</h2>\r\n\r\n<p><strong>Hoco - Center Console Car Holder (HW8) 🚗📱</strong></p>\r\n\r\n<p>🔹&nbsp;<strong>Premium Build &amp; Stylish Design ✨</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Material:</strong>&nbsp;PC + tempered glass &ndash; durable &amp; elegant 💎</li>\r\n	<li><strong>Surface Finish:</strong>&nbsp;Sunburn + oil injection for a sleek, modern look 🚀</li>\r\n</ul>\r\n\r\n<p>🔹&nbsp;<strong>Fast &amp; Efficient Wireless Charging ⚡</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Output Power:</strong>&nbsp;<strong>5W / 7.5W / 10W / 15W</strong>&nbsp;🔥</li>\r\n	<li><strong>15W charging</strong>&nbsp;supports select&nbsp;<strong>LG phones</strong>&nbsp;📱</li>\r\n	<li>Provides&nbsp;<strong>stable &amp; safe charging</strong>&nbsp;while driving ✅</li>\r\n</ul>\r\n\r\n<p>🔹&nbsp;<strong>Wide Compatibility 📲</strong></p>\r\n\r\n<ul>\r\n	<li>Supports&nbsp;<strong>4.5 - 7.0-inch smartphones</strong></li>\r\n	<li><strong>Firm &amp; adjustable grip</strong>&nbsp;for secure mounting 🔒</li>\r\n</ul>\r\n\r\n<p>🔹&nbsp;<strong>Perfect for Car Use 🚘</strong></p>\r\n\r\n<ul>\r\n	<li><strong>Designed for center console mounting</strong>&nbsp;🏎️</li>\r\n	<li>Keeps your phone stable, accessible &amp; charged on the go ⚡</li>\r\n</ul>\r\n\r\n<p>Upgrade your driving experience with this sleek &amp; functional car holder! 🚀</p>'),('af84edac8e604e1b8219e60480fc7c24','Samsung Z FOLD2 Flip Split Two-in-one Multi-Function Phone Case',70.00,62.00,95.00,15,'ZMSJBHFG00072-Black-Z FOLD2',NULL,'published','2025-08-05 06:01:43.494902','2025-08-09 15:30:36.647343','samsung-z-fold2-flip-split-two-in-one-multi-function-phone-case',1,0,'Mobile cover','Zambeel',1,0,NULL,NULL,'a6cc5318194f4a61bc78b251d6593dc1',1,0,'<h2>Product information&nbsp;：</h2>\r\n\r\n<p><strong>Product material:</strong> first layer cowhide<br />\r\n<strong>Product style:</strong> business<br />\r\n<strong>Product Type</strong>: Protective Case/Soft Shell<br />\r\n<strong>Product color:</strong> carbon black, plain black, plain green<br />\r\n<br />\r\n<strong>About packaging</strong>: products are shipped in OPP bags<br />\r\n<strong>About Products:</strong><br />\r\n2-in-1 multifunctional protective cover, the back shell can be taken out and used as a stand-alone, or can be combined as a clamshell shell, this one also has the function of a stand, which can be used as a stand</p>'),('c28e83babce74dc48135465fd35850bf','Spring Grip Men\'s Professional Exercise Arm Strength Home Fitness Equipment',45.00,40.00,52.00,20,'ZMYD192635902BY',NULL,'published','2025-08-07 12:02:23.353314','2025-08-09 14:06:02.229247','spring-grip-mens-professional-exercise-arm-strength-home-fitness-equipment',1,1,'Hand Gripper','Zambeel',1,1,NULL,NULL,'e2828e09880046f5b0bf5ec916b9d2fc',1,1,'<h2><strong>Product information:</strong></h2>\r\n\r\n<p><strong>Applicable scenario:</strong> Fitness Equipment<br />\r\n<strong>Color:</strong> Orange [single pack] VIP version count, black and gray [single pack] VIP version count, light blue [single pack] VIP version count,<br />\r\n<strong>Material:</strong> spring steels<br />\r\n<strong>Applicable object</strong>: male/female<br />\r\n<strong>Product Size:</strong> approximately 11cm X 16cm high</p>\r\n\r\n<p><br />\r\n<strong>Packing list:</strong><br />\r\nGrip strength device * 1</p>'),('f3a5782630a74336925cec1109e26bb7','Vibe Sphere Headphones',86.00,80.00,100.00,6,'VSHD-N-MAW-ZAM',NULL,'published','2025-08-07 11:00:34.525131','2025-08-09 13:48:32.611014','vibe-sphere-headphones',1,1,'Headphones','Zambeel',1,0,NULL,NULL,'f3420009b5da439caf9d9dffa19ee864',1,0,'<h2>Feature:</h2>\r\n\r\n<ul>\r\n	<li>🔗&nbsp;<strong>Advanced Bluetooth V5.3 Technology</strong>&nbsp;&ndash; Features the latest chip for fast, stable, and seamless audio connections, ensuring uninterrupted performance. 🎶✨</li>\r\n	<li>🔋&nbsp;<strong>Impressive 200mAh Battery Capacity</strong>&nbsp;&ndash; Built to deliver long-lasting performance, keeping you powered throughout the day. 🕒⚡</li>\r\n	<li>🎵&nbsp;<strong>Extended Playtime</strong>&nbsp;&ndash; Enjoy up to 20 hours of non-stop music, calls, or podcasts, perfect for long journeys or workdays. 📱🎧</li>\r\n	<li>⚡&nbsp;<strong>Wireless Charging Capability</strong>&nbsp;&ndash; Convenient cable-free charging option for added ease and portability. Simply charge and go! 🌟🔋</li>\r\n	<li>🔌&nbsp;<strong>Type-C Charging Port</strong>&nbsp;&ndash; Recharge quickly and effortlessly with the reliable Type-C connection, so you&rsquo;re always ready for action. ✨🔌</li>\r\n</ul>'),('f6070702f97c4714850f4338d72d43b6','USB Facial Gun',125.00,116.00,180.00,15,'USBF-N-GF-ZAM',NULL,'published','2025-08-09 13:06:51.579532','2025-08-09 13:06:51.579594','usb-facial-gun',1,0,'Massager','Zambeel',1,1,NULL,NULL,'6eac28b936714370b46f0b40971735bd',1,0,'<h2>Features:</h2>\r\n\r\n<ul>\r\n	<li><strong>Massage Heads:</strong>&nbsp;6 interchangeable heads for versatile use 💆&zwj;♀️✨</li>\r\n	<li><strong>Power Specs:</strong>&nbsp;DC interface 12V, 0.5A ⚡</li>\r\n	<li><strong>Speed Range:</strong>&nbsp;Adjustable revolution speed from 1800 to 3200 RPM for personalized massage intensity 🔄</li>\r\n	<li><strong>Battery Capacity:</strong>&nbsp;Long-lasting 2500mAh battery for extended use 🔋</li>\r\n	<li><strong>Switching Mode:</strong>&nbsp;Dual switch for easy operation (power + gear) 🔘</li>\r\n	<li><strong>Gear Adjustment:</strong>&nbsp;30 levels of adjustment to find your perfect massage setting ⚙️</li>\r\n	<li><strong>Charging Interface:</strong>&nbsp;DC charging interface for convenient connectivity 🔌</li>\r\n	<li><strong>Charging Voltage:</strong>&nbsp;Compatible with 110-240V, perfect for worldwide use 🌍</li>\r\n</ul>'),('f7ae91f95fcc4801a2f6da2dd9895f58','Car Cup Holder With Wireless Charging',89.00,82.00,NULL,10,'ZMQC158419302BY',NULL,'published','2025-08-09 15:19:03.891861','2025-08-09 15:19:03.891930','car-cup-holder-with-wireless-charging',0,0,'Car Cup Holder and Charger','MyZambeel',0,0,NULL,NULL,NULL,0,0,'<p><strong>Product information:</strong></p>\r\n\r\n<p>Order No.: car cup holder<br />\r\nModel: ordinary model - single box, wireless charging - single box<br />\r\nScope of application: instrument panel<br />\r\nInput voltage: DC 5V/2A; 9V/1.67A; 12V/17.5A<br />\r\nOutput voltage: 5W; 7.5W; 10W; 15W<br />\r\nTransmission distance: &le; 6MM<br />\r\nCharging efficiency: &ge; 73%<br />\r\nMaterial: ABS, polyurethane<br />\r\n<br />\r\n<strong>Suggestion:</strong><br />\r\n1. Mintiml cup holder expander adapter charging station.<br />\r\n2. Car USB interface, supporting high-speed charging.<br />\r\n3. To facilitate high-speed charging of smart phones, please use a phone case with a thickness of less than 2mm.</p>\r\n\r\n<p><br />\r\n<strong>Packing list:</strong></p>\r\n\r\n<p>Normal edition:<br />\r\n1x fixed body+1x frame cup+1x seamless cup+1x table<br />\r\nWireless charging version:<br />\r\n1x fixed body+1x frame cup+1x seamless cup+1x table+1x wireless charging board+1x type-c charging line</p>'),('fd0e97c50c1942629a5b9fc3eafa31e4','Portable Electric Air Pump',94.47,86.00,NULL,10,'PEP-BLK-CA-ZAM',NULL,'published','2025-08-09 15:13:59.795726','2025-08-09 15:13:59.795794','portable-electric-air-pump',1,1,'Car Air Pump','MyZambeel',0,0,NULL,NULL,NULL,0,0,'<p>Introducing the Portable Electric Air Pump! 🌬️<br />\r\n<br />\r\nInflate your items quickly and effortlessly with this lightweight and portable pump. It&#39;s perfect for inflating beach balls, air mattresses, and more! 🏖️🛏️<br />\r\n<br />\r\nWith its powerful, yet silent motor, you can inflate your items without any hassle. 🤫🚀<br />\r\n<br />\r\nThis Portable Electric Air Pump is the perfect tool for any cyclist, motorcyclist, or outdoor enthusiast looking for quick and easy tire inflation. 🚴&zwj;♂️🏍️🏞️<br />\r\n<br />\r\nIts compact design is perfect for carrying on the go, while its robust motor makes quick work of any tire inflation job. Enjoy convenient and efficient tire inflation wherever you go with this Portable Electric Air Pump! 🚗🏕️🔌💨</p>');
/*!40000 ALTER TABLE `core_p_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_product_productCategory`
--

DROP TABLE IF EXISTS `core_p_product_productCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_product_productCategory` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` char(32) NOT NULL,
  `productcategory_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_p_product_productCa_product_id_productcatego_ad0b6e1c_uniq` (`product_id`,`productcategory_id`),
  KEY `core_p_product_productCategory_productcategory_id_ef4a948d_fk` (`productcategory_id`),
  CONSTRAINT `core_p_product_produ_product_id_db322457_fk_core_p_pr` FOREIGN KEY (`product_id`) REFERENCES `core_p_product` (`id`),
  CONSTRAINT `core_p_product_productCategory_productcategory_id_ef4a948d_fk` FOREIGN KEY (`productcategory_id`) REFERENCES `core_p_productcategory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_product_productCategory`
--

LOCK TABLES `core_p_product_productCategory` WRITE;
/*!40000 ALTER TABLE `core_p_product_productCategory` DISABLE KEYS */;
INSERT INTO `core_p_product_productCategory` VALUES (6,'16164e716e7b4ac88be431e761db7021','ff2cc748d1014b88936b8a0426427239'),(7,'1cb8f5a7889642cebdd05ec7e08023b8','8b669d20132c4e42bdc93d1e2dfbd55e'),(11,'336e7bd17725412f9668d3951ee08226','d721c6f335674eb5b48aef518d717523'),(4,'3449643f062e4deda01e6e7f0485ed42','1dae06f9d7f540f68fad43b083316545'),(22,'452cb12151d74173b15d4a5268512977','bbb39dd3ec864a8b9e4a9afe3667c83f'),(21,'47a080e8e5df4c398646eaef99402857','bbb39dd3ec864a8b9e4a9afe3667c83f'),(16,'6b8370854e6a4f02831372e6005615df','e0fe040895604abbb154c523b91ff32a'),(18,'7de361fcdbd34ad7bd6e45f3a37af865','e075064389294a6c9249a388b380b0c3'),(10,'7f69f2e173b84f36b9146f8e63ce30a2','e0fe040895604abbb154c523b91ff32a'),(8,'83832402960e48d5b9dc6171d34928fa','2777c9dedb0e438db31b55f6ec8d1ac4'),(13,'843c9455ee714dcf819544140c3731a9','ff57996ed8034d54a7f56c9767f1e7a7'),(5,'af84edac8e604e1b8219e60480fc7c24','c9072e13f5cb40efa7e36af0472e3d0a'),(14,'c28e83babce74dc48135465fd35850bf','ca1f121babc44633aa60b5ce473ce8ef'),(12,'f3a5782630a74336925cec1109e26bb7','83dbbe6a55764d72bd7a5b84707b7ca3'),(17,'f6070702f97c4714850f4338d72d43b6','74ef6cbfd65145f89315e17f9c0f417a'),(20,'f7ae91f95fcc4801a2f6da2dd9895f58','ff57996ed8034d54a7f56c9767f1e7a7'),(19,'fd0e97c50c1942629a5b9fc3eafa31e4','ff57996ed8034d54a7f56c9767f1e7a7');
/*!40000 ALTER TABLE `core_p_product_productCategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_product_productCollection`
--

DROP TABLE IF EXISTS `core_p_product_productCollection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_product_productCollection` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` char(32) NOT NULL,
  `productcollection_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_p_product_productCo_product_id_productcollec_a485f193_uniq` (`product_id`,`productcollection_id`),
  KEY `core_p_product_produ_productcollection_id_2adfa015_fk_core_p_pr` (`productcollection_id`),
  CONSTRAINT `core_p_product_produ_product_id_bdd69ef4_fk_core_p_pr` FOREIGN KEY (`product_id`) REFERENCES `core_p_product` (`id`),
  CONSTRAINT `core_p_product_produ_productcollection_id_2adfa015_fk_core_p_pr` FOREIGN KEY (`productcollection_id`) REFERENCES `core_p_productcollection` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_product_productCollection`
--

LOCK TABLES `core_p_product_productCollection` WRITE;
/*!40000 ALTER TABLE `core_p_product_productCollection` DISABLE KEYS */;
INSERT INTO `core_p_product_productCollection` VALUES (6,'16164e716e7b4ac88be431e761db7021','ccd6028bfd7943ae833ec04c05114577'),(7,'1cb8f5a7889642cebdd05ec7e08023b8','a0d3ab8a71884e14b907dbd354109b18'),(11,'336e7bd17725412f9668d3951ee08226','989829fd7855468aad68bd7d99348746'),(4,'3449643f062e4deda01e6e7f0485ed42','ccd6028bfd7943ae833ec04c05114577'),(22,'452cb12151d74173b15d4a5268512977','72aac0bb2e0740a4b293ca93536a2c75'),(21,'47a080e8e5df4c398646eaef99402857','72aac0bb2e0740a4b293ca93536a2c75'),(16,'6b8370854e6a4f02831372e6005615df','989829fd7855468aad68bd7d99348746'),(18,'7de361fcdbd34ad7bd6e45f3a37af865','a632e37a523f4c15b2b09dd8930f2a38'),(10,'7f69f2e173b84f36b9146f8e63ce30a2','989829fd7855468aad68bd7d99348746'),(8,'83832402960e48d5b9dc6171d34928fa','b3ab91b1aac34b8f9cd74175c0038254'),(13,'843c9455ee714dcf819544140c3731a9','72aac0bb2e0740a4b293ca93536a2c75'),(5,'af84edac8e604e1b8219e60480fc7c24','ccd6028bfd7943ae833ec04c05114577'),(14,'c28e83babce74dc48135465fd35850bf','dfa0b385d88c48449c95e85da83157ce'),(12,'f3a5782630a74336925cec1109e26bb7','ccd6028bfd7943ae833ec04c05114577'),(17,'f6070702f97c4714850f4338d72d43b6','989829fd7855468aad68bd7d99348746'),(20,'f7ae91f95fcc4801a2f6da2dd9895f58','72aac0bb2e0740a4b293ca93536a2c75'),(19,'fd0e97c50c1942629a5b9fc3eafa31e4','72aac0bb2e0740a4b293ca93536a2c75');
/*!40000 ALTER TABLE `core_p_product_productCollection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_product_productImages`
--

DROP TABLE IF EXISTS `core_p_product_productImages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_product_productImages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` char(32) NOT NULL,
  `productimageschema_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_p_product_productIm_product_id_productimages_97561bf9_uniq` (`product_id`,`productimageschema_id`),
  KEY `core_p_product_produ_productimageschema_i_86ce47dc_fk_core_p_pr` (`productimageschema_id`),
  CONSTRAINT `core_p_product_produ_product_id_8fee7605_fk_core_p_pr` FOREIGN KEY (`product_id`) REFERENCES `core_p_product` (`id`),
  CONSTRAINT `core_p_product_produ_productimageschema_i_86ce47dc_fk_core_p_pr` FOREIGN KEY (`productimageschema_id`) REFERENCES `core_p_productimageschema` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_product_productImages`
--

LOCK TABLES `core_p_product_productImages` WRITE;
/*!40000 ALTER TABLE `core_p_product_productImages` DISABLE KEYS */;
INSERT INTO `core_p_product_productImages` VALUES (15,'16164e716e7b4ac88be431e761db7021','e0393d50259e475eb0fbc68ddec21078'),(14,'16164e716e7b4ac88be431e761db7021','ee2e67198da8487d8361f919740a650d'),(16,'1cb8f5a7889642cebdd05ec7e08023b8','2c96414a54fd4ce5a42fd8e3b79d9842'),(17,'1cb8f5a7889642cebdd05ec7e08023b8','764a17b3187a40d9a8d0c08346dea7f9'),(18,'1cb8f5a7889642cebdd05ec7e08023b8','d9626fa9ad7e4c3187192b155cb20a1b'),(29,'336e7bd17725412f9668d3951ee08226','77a4ededb6ac4eb1864c2d0c40a3e033'),(30,'336e7bd17725412f9668d3951ee08226','79322e0a1e9a451c82606d1535bc51fc'),(28,'336e7bd17725412f9668d3951ee08226','c493f994a07a43e3b7399964c03194fa'),(11,'3449643f062e4deda01e6e7f0485ed42','18ed4fd583c64bf189bdd76187384e84'),(10,'3449643f062e4deda01e6e7f0485ed42','e232416faaec4c9985f2dbf07a770e62'),(9,'3449643f062e4deda01e6e7f0485ed42','e6af29bc08ee43a2a65cc833f6997acb'),(70,'452cb12151d74173b15d4a5268512977','4bb57c3bbea043dba363d226aa8d2472'),(73,'452cb12151d74173b15d4a5268512977','7d33ed7f850444e3a236fed41b6d909b'),(72,'452cb12151d74173b15d4a5268512977','c1deadf0c4884d67b92506cafe01b6af'),(71,'452cb12151d74173b15d4a5268512977','fc1ba72caf474e7cb5f3eee8d380d213'),(69,'47a080e8e5df4c398646eaef99402857','4c0dd049779542adb562970ea412b137'),(48,'6b8370854e6a4f02831372e6005615df','63b53392693f44dbaab31d2f0b5fc9ad'),(52,'7de361fcdbd34ad7bd6e45f3a37af865','d215bb2bb3d54df0ad944602891aff8f'),(54,'7de361fcdbd34ad7bd6e45f3a37af865','e8bee89a485f46f6929c3f43f1709878'),(53,'7de361fcdbd34ad7bd6e45f3a37af865','f964534d7bf54ffdb763210046471fe4'),(27,'7f69f2e173b84f36b9146f8e63ce30a2','43a367d0d12a45079a02114d3a473f82'),(26,'7f69f2e173b84f36b9146f8e63ce30a2','54f89d8c78384a71b85fe5b5235ec4d0'),(25,'7f69f2e173b84f36b9146f8e63ce30a2','8d5048ba9a7546dfb6ec59320b55efc9'),(21,'83832402960e48d5b9dc6171d34928fa','05bea4d5ab0748ed9cf1bf46067c235d'),(19,'83832402960e48d5b9dc6171d34928fa','88b8df3e644944d6875aaad5d8469d42'),(22,'83832402960e48d5b9dc6171d34928fa','a197fedc35374561b0587d96d5964f6f'),(20,'83832402960e48d5b9dc6171d34928fa','ae7c9cb08e624424aa3bde14515ccf71'),(58,'843c9455ee714dcf819544140c3731a9','562164aa92ef4b01b16f97695eb08fcf'),(59,'843c9455ee714dcf819544140c3731a9','67974bbbbef64618b76e046931f7c8dc'),(60,'843c9455ee714dcf819544140c3731a9','68b0e4c9def945718987f531c148bb40'),(13,'af84edac8e604e1b8219e60480fc7c24','119da33d48d349a28465abbd2464c06d'),(12,'af84edac8e604e1b8219e60480fc7c24','33fab3b4540c42d790a3ce49f6348729'),(37,'c28e83babce74dc48135465fd35850bf','0610b25b1818408dbc3f2f9403ae7f53'),(40,'c28e83babce74dc48135465fd35850bf','5887c4e36a4f47d58b236dd74194cbf4'),(38,'c28e83babce74dc48135465fd35850bf','bc44f1f65087436e840a1cffb01f51b0'),(39,'c28e83babce74dc48135465fd35850bf','c33b89a7486742309173246339ca151f'),(57,'f3a5782630a74336925cec1109e26bb7','39f11b8c62d5432a8d60feff926bcae5'),(56,'f3a5782630a74336925cec1109e26bb7','569fa2cecf7c44da9dd852c98dcdc8ca'),(55,'f3a5782630a74336925cec1109e26bb7','e52068a040c04013945bfc40ce3676f2'),(50,'f6070702f97c4714850f4338d72d43b6','0dde23d414de44e3be380a6e78e75221'),(51,'f6070702f97c4714850f4338d72d43b6','e6cc8646c91f43478ab1af8d016e257d'),(49,'f6070702f97c4714850f4338d72d43b6','e971a64ba04147bd8df1c5f8c82891fa'),(67,'f7ae91f95fcc4801a2f6da2dd9895f58','4c4a5cfcaf284647ac8f136f6bc9c544'),(68,'f7ae91f95fcc4801a2f6da2dd9895f58','784ec99585914deda54f2f79c7d0dc3b'),(66,'f7ae91f95fcc4801a2f6da2dd9895f58','817eb606e9d24c809be11edfe1612dd1'),(65,'f7ae91f95fcc4801a2f6da2dd9895f58','876445a348614440a88d634a1d72e3d1'),(61,'fd0e97c50c1942629a5b9fc3eafa31e4','1423741aeb6a43cda71bda6e3c281002'),(62,'fd0e97c50c1942629a5b9fc3eafa31e4','4408fa6a89eb4320a227dc33edf19df7'),(64,'fd0e97c50c1942629a5b9fc3eafa31e4','710e5fb81db04a55aa60c88b60d70f36'),(63,'fd0e97c50c1942629a5b9fc3eafa31e4','c64cb65e2d304dd6bdfe563da3441dae');
/*!40000 ALTER TABLE `core_p_product_productImages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_product_productTags`
--

DROP TABLE IF EXISTS `core_p_product_productTags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_product_productTags` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` char(32) NOT NULL,
  `pctags_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_p_product_productTags_product_id_pctags_id_c6ab2b4d_uniq` (`product_id`,`pctags_id`),
  KEY `core_p_product_productTags_pctags_id_0fd78551_fk` (`pctags_id`),
  CONSTRAINT `core_p_product_produ_product_id_04d25d78_fk_core_p_pr` FOREIGN KEY (`product_id`) REFERENCES `core_p_product` (`id`),
  CONSTRAINT `core_p_product_productTags_pctags_id_0fd78551_fk` FOREIGN KEY (`pctags_id`) REFERENCES `core_p_pctags` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_product_productTags`
--

LOCK TABLES `core_p_product_productTags` WRITE;
/*!40000 ALTER TABLE `core_p_product_productTags` DISABLE KEYS */;
INSERT INTO `core_p_product_productTags` VALUES (9,'16164e716e7b4ac88be431e761db7021','17cb34bf939f46c0a5e35c0bf462c5e8'),(12,'16164e716e7b4ac88be431e761db7021','47a3a4008ddc43a8a553aca5f9ff887f'),(10,'16164e716e7b4ac88be431e761db7021','76f817276a064af3a49e66cb7d886ed9'),(11,'16164e716e7b4ac88be431e761db7021','8c8d8691889c4f30b69d3096829cae3d'),(14,'1cb8f5a7889642cebdd05ec7e08023b8','24b61d7aee924affa5172904fa67e904'),(13,'1cb8f5a7889642cebdd05ec7e08023b8','6ca2848cebe744fa906af922184308b6'),(15,'1cb8f5a7889642cebdd05ec7e08023b8','a624e596cfa84701a5502a386467239e'),(16,'1cb8f5a7889642cebdd05ec7e08023b8','b3b1298b974e48d093cff631fb6ce047'),(17,'1cb8f5a7889642cebdd05ec7e08023b8','f82640dd703d43abb2ad58cb896ab343'),(35,'336e7bd17725412f9668d3951ee08226','278cd94681824e3ba8fb55ecb4f770e9'),(34,'336e7bd17725412f9668d3951ee08226','3770cdbfe8c242efadcf52a7548ef603'),(32,'336e7bd17725412f9668d3951ee08226','5394556b808d4182ba3eea28c8a665d7'),(36,'336e7bd17725412f9668d3951ee08226','8f24b6507c8e4e9db1522a3f7fa377ca'),(33,'336e7bd17725412f9668d3951ee08226','dd8bb4a2b2bc46f29e754614d7a56dd5'),(4,'3449643f062e4deda01e6e7f0485ed42','e9e3e68aa16a4e748d4e009272732ac3'),(58,'6b8370854e6a4f02831372e6005615df','3605b405bc8d437da7d12ff74b01e42e'),(60,'6b8370854e6a4f02831372e6005615df','ec4ae441a302414eadbdcf07bc8336cd'),(59,'6b8370854e6a4f02831372e6005615df','f79dc8b3cda547beaa99cf0ca5b0f222'),(67,'7de361fcdbd34ad7bd6e45f3a37af865','21db9b51809f4ed7932f9c6ccfeff86b'),(69,'7de361fcdbd34ad7bd6e45f3a37af865','656f1a7ab58f4a5b8a4e3732a882b9a8'),(68,'7de361fcdbd34ad7bd6e45f3a37af865','dee75266aee74b3485e7486c9a6fec67'),(31,'7f69f2e173b84f36b9146f8e63ce30a2','0e317bf61b2549d985a0f2de82844948'),(29,'7f69f2e173b84f36b9146f8e63ce30a2','406472b234194d83b3a2015761a5215c'),(28,'7f69f2e173b84f36b9146f8e63ce30a2','86159f9dc37947e88b2f6510ce95419d'),(27,'7f69f2e173b84f36b9146f8e63ce30a2','f1f5187a625c4cf98918956e5b71d259'),(30,'7f69f2e173b84f36b9146f8e63ce30a2','fa802801c62046919edd172578425927'),(20,'83832402960e48d5b9dc6171d34928fa','189c49850af34f8eaedbc314c72e233b'),(21,'83832402960e48d5b9dc6171d34928fa','352d1c81d81540a09c4c606738d350e8'),(18,'83832402960e48d5b9dc6171d34928fa','66ae5ee7b23f48b5af16565e276c0d9c'),(22,'83832402960e48d5b9dc6171d34928fa','a4b1e9ec0ec64ee89fbf3014a9bd07f0'),(19,'83832402960e48d5b9dc6171d34928fa','eed09ef5852f4cafb67f7bd729fd224f'),(43,'843c9455ee714dcf819544140c3731a9','2f9a201b66884f9b9f52d799f204413e'),(46,'843c9455ee714dcf819544140c3731a9','5278e1f2fe5a4e4890f54fdd6220bfa3'),(45,'843c9455ee714dcf819544140c3731a9','5f719c4a9e424041a719901d671003b5'),(42,'843c9455ee714dcf819544140c3731a9','b93e5c1f95be498da46abd60223b7647'),(44,'843c9455ee714dcf819544140c3731a9','e9ef8190af2544739264514deaba0f23'),(6,'af84edac8e604e1b8219e60480fc7c24','1a09411ea52249cab8dd4e5c6cd5c235'),(5,'af84edac8e604e1b8219e60480fc7c24','22dd32c51aef47b0bd35d1babfd4d66a'),(7,'af84edac8e604e1b8219e60480fc7c24','4cafcf77732d459599cb80bf915284cc'),(8,'af84edac8e604e1b8219e60480fc7c24','4d1838345b6d416a9f2153655ac91dad'),(51,'c28e83babce74dc48135465fd35850bf','1bb7e8d4eec34dec8994d4b6d90526ec'),(50,'c28e83babce74dc48135465fd35850bf','34f96d3e77cf44d6b431be847b763cf3'),(48,'c28e83babce74dc48135465fd35850bf','51acab3609f84812a42147b1fcac5b86'),(49,'c28e83babce74dc48135465fd35850bf','6dda263dbd3840ed8d5af70d49f4398b'),(52,'c28e83babce74dc48135465fd35850bf','d17cc2f34e594eddb3db5fd82adb73ba'),(47,'c28e83babce74dc48135465fd35850bf','e1e0df3e086d4843b803f022a90f31d2'),(40,'f3a5782630a74336925cec1109e26bb7','4aefdda0e7624522b448b414762c7565'),(37,'f3a5782630a74336925cec1109e26bb7','58b352410ca6488fb3b3f29871f53072'),(38,'f3a5782630a74336925cec1109e26bb7','640effbe8cb5432cb2b13cfb952de58d'),(39,'f3a5782630a74336925cec1109e26bb7','ce94ab7510124ff2b95e21370f063fa4'),(41,'f3a5782630a74336925cec1109e26bb7','e198ffe8e0274e4db9d64cbe19278877'),(66,'f6070702f97c4714850f4338d72d43b6','13d5d24d926849438e84261409b582b6'),(63,'f6070702f97c4714850f4338d72d43b6','41939b0141c4413591733e74c8acac0b'),(61,'f6070702f97c4714850f4338d72d43b6','7c9989a3959b4b86aaebbe8f63d6334f'),(62,'f6070702f97c4714850f4338d72d43b6','8317c564994149789fdfc50c0dc300be'),(65,'f6070702f97c4714850f4338d72d43b6','96059d872a20448a948c2a38fdfc52f6'),(64,'f6070702f97c4714850f4338d72d43b6','961f178ea333414fbd565a6406779786'),(74,'f7ae91f95fcc4801a2f6da2dd9895f58','2f9a201b66884f9b9f52d799f204413e'),(73,'f7ae91f95fcc4801a2f6da2dd9895f58','5f719c4a9e424041a719901d671003b5'),(72,'fd0e97c50c1942629a5b9fc3eafa31e4','2f9a201b66884f9b9f52d799f204413e'),(71,'fd0e97c50c1942629a5b9fc3eafa31e4','3c6dc04c0b7e4cd085d8f3d89dbd2af0'),(70,'fd0e97c50c1942629a5b9fc3eafa31e4','5f719c4a9e424041a719901d671003b5');
/*!40000 ALTER TABLE `core_p_product_productTags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_productcategory`
--

DROP TABLE IF EXISTS `core_p_productcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_productcategory` (
  `id` char(32) NOT NULL,
  `categoryName` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categoryName` (`categoryName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_productcategory`
--

LOCK TABLES `core_p_productcategory` WRITE;
/*!40000 ALTER TABLE `core_p_productcategory` DISABLE KEYS */;
INSERT INTO `core_p_productcategory` VALUES ('1dae06f9d7f540f68fad43b083316545','Wireless Chargers','2025-08-04 17:33:33.287049'),('2777c9dedb0e438db31b55f6ec8d1ac4','Electric Coffee Mug','2025-08-06 06:07:28.216291'),('74ef6cbfd65145f89315e17f9c0f417a','Massager','2025-08-06 09:53:12.973336'),('83dbbe6a55764d72bd7a5b84707b7ca3','Headphones','2025-08-07 10:55:12.716713'),('8b669d20132c4e42bdc93d1e2dfbd55e','Rabbit LED Night Light','2025-08-06 05:54:36.541648'),('bbb39dd3ec864a8b9e4a9afe3667c83f','Care Care products','2025-08-09 15:20:35.473132'),('c1b4e70c531f40b4873a8ecd91ad8a30','Cloth','2025-08-02 18:43:12.514623'),('c9072e13f5cb40efa7e36af0472e3d0a','Mobile covers','2025-08-05 05:54:15.873308'),('ca1f121babc44633aa60b5ce473ce8ef','Spring Hand Gripper','2025-08-07 11:57:00.746230'),('d721c6f335674eb5b48aef518d717523','Body oil','2025-08-07 10:47:13.096245'),('d8e62671235e46c1873b870789849173','Tech','2025-08-04 16:47:23.801582'),('e075064389294a6c9249a388b380b0c3','Jewellery','2025-08-09 13:24:07.469157'),('e0fe040895604abbb154c523b91ff32a','Beauty','2025-08-06 10:10:53.389004'),('f619797644f446798d59e34ef33f6f5c','Skin & personal care','2025-08-07 12:06:06.409978'),('ff2cc748d1014b88936b8a0426427239','wireless keyboard','2025-08-05 06:16:32.579174'),('ff57996ed8034d54a7f56c9767f1e7a7','car interior accessories','2025-08-07 11:08:57.618630');
/*!40000 ALTER TABLE `core_p_productcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_productcollection`
--

DROP TABLE IF EXISTS `core_p_productcollection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_productcollection` (
  `id` char(32) NOT NULL,
  `collectionName` varchar(255) NOT NULL,
  `collectionImage` varchar(100) NOT NULL,
  `collectionDescription` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `collectionSlug` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collectionName` (`collectionName`),
  UNIQUE KEY `collectionSlug` (`collectionSlug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_productcollection`
--

LOCK TABLES `core_p_productcollection` WRITE;
/*!40000 ALTER TABLE `core_p_productcollection` DISABLE KEYS */;
INSERT INTO `core_p_productcollection` VALUES ('72aac0bb2e0740a4b293ca93536a2c75','Car Accessories','collection_images/brock-wegner-pWGUMQSWBwI-unsplash_1.jpg','Premium car accessories for comfort, safety, style, and convenience—durable, easy to install, and perfect for any driver.','2025-08-07 11:08:09.156597','car-assessories'),('989829fd7855468aad68bd7d99348746','Health & Beauty','collection_images/natural-cosmetics-desk_1.jpg','Premium health and beauty essentials for radiant skin and total wellness.','2025-08-05 05:22:41.848042','health-beauty'),('a0d3ab8a71884e14b907dbd354109b18','Toys, Games & Babies','collection_images/yuri-li-p0hDztR46cw-unsplash_1.jpg','Safe, fun, and educational toys and baby essentials for play, learning, and care.','2025-08-05 05:39:36.593845','toys-games-babies'),('a632e37a523f4c15b2b09dd8930f2a38','Fashion','collection_images/martin-de-arriba-uf_IDewI6iQ-unsplash.jpg','Stylish, versatile, and timeless fashion pieces designed to elevate your look for any occasion.','2025-08-09 13:23:00.814756','fashion'),('b3ab91b1aac34b8f9cd74175c0038254','Home & Kitchen','collection_images/ryan-spaulding-zt1o4M_HEYU-unsplash_1.jpg','Stylish, functional home and kitchen essentials for modern, comfortable living.','2025-08-05 05:45:49.740007','home-kitchen'),('ccd6028bfd7943ae833ec04c05114577','Mobiles, Laptops & Wearables','collection_images/altumcode-RrFvYtCwO8E-unsplash_1.jpg','Latest mobiles, laptops, and wearables to keep you connected in style.','2025-08-04 16:47:08.574577','mobiles-laptops-wearables'),('dfa0b385d88c48449c95e85da83157ce','Fitness, Sports & Outdoors','collection_images/decorative-fitness-concept-with-slate_1.jpg','Top-quality fitness, sports, and outdoor gear to keep you active and adventure-ready.','2025-08-05 05:33:28.252876','fitness-sports-outdoors');
/*!40000 ALTER TABLE `core_p_productcollection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_productcollection_collectionTags`
--

DROP TABLE IF EXISTS `core_p_productcollection_collectionTags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_productcollection_collectionTags` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `productcollection_id` char(32) NOT NULL,
  `pctags_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_p_productcollection_productcollection_id_pct_b14904b0_uniq` (`productcollection_id`,`pctags_id`),
  KEY `core_p_productcollection_collectionTags_pctags_id_32fae762_fk` (`pctags_id`),
  CONSTRAINT `core_p_productcollec_productcollection_id_16cc3ef4_fk_core_p_pr` FOREIGN KEY (`productcollection_id`) REFERENCES `core_p_productcollection` (`id`),
  CONSTRAINT `core_p_productcollection_collectionTags_pctags_id_32fae762_fk` FOREIGN KEY (`pctags_id`) REFERENCES `core_p_pctags` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_productcollection_collectionTags`
--

LOCK TABLES `core_p_productcollection_collectionTags` WRITE;
/*!40000 ALTER TABLE `core_p_productcollection_collectionTags` DISABLE KEYS */;
INSERT INTO `core_p_productcollection_collectionTags` VALUES (26,'72aac0bb2e0740a4b293ca93536a2c75','2f9a201b66884f9b9f52d799f204413e'),(25,'72aac0bb2e0740a4b293ca93536a2c75','3c6dc04c0b7e4cd085d8f3d89dbd2af0'),(28,'72aac0bb2e0740a4b293ca93536a2c75','5278e1f2fe5a4e4890f54fdd6220bfa3'),(27,'72aac0bb2e0740a4b293ca93536a2c75','5f719c4a9e424041a719901d671003b5'),(24,'72aac0bb2e0740a4b293ca93536a2c75','b93e5c1f95be498da46abd60223b7647'),(7,'989829fd7855468aad68bd7d99348746','1d9c82d38e9b4a7289ed533e4e0e4df1'),(4,'989829fd7855468aad68bd7d99348746','80bfbf77cad7439ea3c1c73cf5dabf44'),(5,'989829fd7855468aad68bd7d99348746','a72ca6aa859c4f42a48336eb2d49861b'),(6,'989829fd7855468aad68bd7d99348746','d02d4d377a484a95880c4ce248ac283b'),(13,'a0d3ab8a71884e14b907dbd354109b18','2bb8c7e82dc345baab371d90fa465060'),(16,'a0d3ab8a71884e14b907dbd354109b18','a2b2bcb1e2574c438ca1b769e94cbc27'),(15,'a0d3ab8a71884e14b907dbd354109b18','a624e596cfa84701a5502a386467239e'),(14,'a0d3ab8a71884e14b907dbd354109b18','b3b1298b974e48d093cff631fb6ce047'),(31,'a632e37a523f4c15b2b09dd8930f2a38','5a72d0afb5c54e628f7a7c4f50096021'),(32,'a632e37a523f4c15b2b09dd8930f2a38','5f5267d8f75c4a4484fdded5f937a479'),(29,'a632e37a523f4c15b2b09dd8930f2a38','682e7262b659421b8dfa7fff13e982eb'),(30,'a632e37a523f4c15b2b09dd8930f2a38','7ec76f50f2e6451296d03a11f34aadf5'),(33,'a632e37a523f4c15b2b09dd8930f2a38','e2b16e20d83d470ab41c98f74ef23c89'),(19,'b3ab91b1aac34b8f9cd74175c0038254','189c49850af34f8eaedbc314c72e233b'),(18,'b3ab91b1aac34b8f9cd74175c0038254','53a2612d325f473e854a61e4c9829514'),(20,'b3ab91b1aac34b8f9cd74175c0038254','587677ecf73047b3a61bc40deb5e3b8c'),(17,'b3ab91b1aac34b8f9cd74175c0038254','66ae5ee7b23f48b5af16565e276c0d9c'),(22,'ccd6028bfd7943ae833ec04c05114577','2842d3f45b214a619c35ac886769ad5c'),(23,'ccd6028bfd7943ae833ec04c05114577','3b4ebae5bc2e46f48b6eaa4718ed53a8'),(21,'ccd6028bfd7943ae833ec04c05114577','6c9d1ef22309453a91c28c997ed8f482'),(3,'ccd6028bfd7943ae833ec04c05114577','d56129f4bce34a148e7c558928fef02a'),(2,'ccd6028bfd7943ae833ec04c05114577','e8daabe4ada24c97a2506baead4b81db'),(12,'dfa0b385d88c48449c95e85da83157ce','0366adc60eb14b6681030a7f1b2885c7'),(10,'dfa0b385d88c48449c95e85da83157ce','103c05d0599f4e2d8a3c7ec4d6220963'),(11,'dfa0b385d88c48449c95e85da83157ce','1d9c82d38e9b4a7289ed533e4e0e4df1'),(9,'dfa0b385d88c48449c95e85da83157ce','5ee95e6e70604a9baa37f8fb5021ccb7');
/*!40000 ALTER TABLE `core_p_productcollection_collectionTags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_productimageschema`
--

DROP TABLE IF EXISTS `core_p_productimageschema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_productimageschema` (
  `id` char(32) NOT NULL,
  `image` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_productimageschema`
--

LOCK TABLES `core_p_productimageschema` WRITE;
/*!40000 ALTER TABLE `core_p_productimageschema` DISABLE KEYS */;
INSERT INTO `core_p_productimageschema` VALUES ('05bea4d5ab0748ed9cf1bf46067c235d','product_images/2403180639080323300.jpg','2025-08-06 06:06:09.282818'),('0610b25b1818408dbc3f2f9403ae7f53','product_images/1737752277529268224.jpg','2025-08-07 11:55:41.927521'),('0dde23d414de44e3be380a6e78e75221','product_images/Screenshot_2024-11-02_102247.png','2025-08-09 12:58:06.182821'),('119da33d48d349a28465abbd2464c06d','product_images/62ae65d1-3a4e-40ce-89d4-47845d6c9ad8.jpg','2025-08-05 05:53:13.374699'),('1423741aeb6a43cda71bda6e3c281002','product_images/portable-electric-air-pump-35347.jpg','2025-08-09 15:11:46.130297'),('18ed4fd583c64bf189bdd76187384e84','product_images/5241c398-870e-473a-b27e-a85105ddab06.jpg','2025-08-04 16:43:55.786420'),('2c96414a54fd4ce5a42fd8e3b79d9842','product_images/2403230329520329000.jpg','2025-08-06 05:53:32.644622'),('33fab3b4540c42d790a3ce49f6348729','product_images/samsung-z-fold2-flip-split-two-in-one-multi-function-phone-case-160353.jpg','2025-08-05 05:51:41.297528'),('39f11b8c62d5432a8d60feff926bcae5','product_images/shopping_1_082Tj7u.webp','2025-08-09 13:46:14.493233'),('3f0e6c3927f645b0ad8a5a1d25aa99d1','product_images/shopping_2.webp','2025-08-07 10:54:31.552625'),('43a367d0d12a45079a02114d3a473f82','product_images/2405050230570326700.jpg','2025-08-06 10:09:52.725225'),('4408fa6a89eb4320a227dc33edf19df7','product_images/portable-electric-air-pump-40154.jpg','2025-08-09 15:12:00.926407'),('48df31e1df2c4871adec4ce65eda9262','product_images/hoco-ca120-prospering-car-center-console-holder-clamp_p8nw0aT.jpg','2025-08-07 11:11:03.119885'),('4bb57c3bbea043dba363d226aa8d2472','product_images/rayhong-car-scratch-removel-wax.jpg','2025-08-09 15:24:44.903203'),('4c0dd049779542adb562970ea412b137','product_images/leather-repair-cream-659300.jpg','2025-08-09 15:20:09.988399'),('4c4a5cfcaf284647ac8f136f6bc9c544','product_images/car-cup-holder-with-wireless-cha.jpg','2025-08-09 15:15:37.871446'),('5238227a3eac42dd95fe4a48227a2d1a','product_images/jmookokokok.webp','2025-08-07 12:04:37.882668'),('54f89d8c78384a71b85fe5b5235ec4d0','product_images/2405050230560329800.jpg','2025-08-06 10:10:09.212844'),('55950bd177984853a4ba336718976ce6','product_images/818g0r0RvtL._SX679_.jpg','2025-08-07 17:07:41.898851'),('562164aa92ef4b01b16f97695eb08fcf','product_images/hoco-ca120-prospering-car-center-console-holder-horizontally_DPSQ1oa.jpg','2025-08-09 14:07:14.903305'),('569fa2cecf7c44da9dd852c98dcdc8ca','product_images/shopping_8_qcbjw9k.png','2025-08-09 13:46:40.552405'),('5887c4e36a4f47d58b236dd74194cbf4','product_images/1737752277285998592.jpg','2025-08-07 11:55:31.676058'),('5caf9fa0b522452fb0f5399f265d09ad','product_images/818g0r0RvtL_xOrU02l._SX679_.jpg','2025-08-07 17:22:10.890854'),('5e7125ec97ca472db56a488e4bc2e45e','product_images/97147-5-600x600.webp','2025-08-07 12:04:27.612282'),('63b53392693f44dbaab31d2f0b5fc9ad','product_images/71U3mmLPPyL_7ZJZZMU._SX679_.jpg','2025-08-07 17:26:07.566276'),('67974bbbbef64618b76e046931f7c8dc','product_images/hoco-ca120-prospering-car-center-console-holder-windshield_BzmFOA5.jpg','2025-08-09 14:06:36.678053'),('68b0e4c9def945718987f531c148bb40','product_images/hoco-ca120-prospering-car-center-console-holder-clamp_9k82ysl.jpg','2025-08-09 14:06:58.405293'),('710e5fb81db04a55aa60c88b60d70f36','product_images/portable-electric-air-pump-73517.jpg','2025-08-09 15:11:53.296154'),('764a17b3187a40d9a8d0c08346dea7f9','product_images/2403230329520328300.jpg','2025-08-06 05:53:44.634871'),('77a4ededb6ac4eb1864c2d0c40a3e033','product_images/Screenshot_2025-01-09_115258.png','2025-08-07 10:46:39.735697'),('784ec99585914deda54f2f79c7d0dc3b','product_images/car-cup-holder-with-wireless-cha_3.jpg','2025-08-09 15:16:06.369905'),('79322e0a1e9a451c82606d1535bc51fc','product_images/Screenshot_2025-01-09_115417.png','2025-08-07 10:46:12.809183'),('7af1a325dafa4e1e9060389e447870aa','product_images/hoco-ca120-prospering-car-center-console-holder-windshield.jpg','2025-08-07 11:11:15.519319'),('7d0d7bcc0c7f48abb7fcd1a78dde8adb','product_images/9-8efh0rfh.PNG','2025-08-06 09:52:10.436779'),('7d33ed7f850444e3a236fed41b6d909b','product_images/rayhong-car-scratch-removel-wax_1.jpg','2025-08-09 15:24:53.919718'),('817eb606e9d24c809be11edfe1612dd1','product_images/car-cup-holder-with-wireless-cha_2.jpg','2025-08-09 15:15:57.929317'),('876445a348614440a88d634a1d72e3d1','product_images/car-cup-holder-with-wireless-cha_1.jpg','2025-08-09 15:15:47.310871'),('88b8df3e644944d6875aaad5d8469d42','product_images/2403180639080321400.jpg','2025-08-06 06:06:56.384994'),('8a21139dc76843188d4fe6a0bc0dc3dc','product_images/FasialGunKH-740-ezgif.com-video-to-gif-converter.gif','2025-08-06 09:51:52.072145'),('8d5048ba9a7546dfb6ec59320b55efc9','product_images/2405050230570321800.jpg','2025-08-06 10:10:27.448412'),('8e73739daa454f32ba52322f12e69b93','product_images/hoco-ca120-prospering-car-center-console-holder-clamp.jpg','2025-08-07 11:02:48.292697'),('a197fedc35374561b0587d96d5964f6f','product_images/2403180639080322200.jpg','2025-08-06 06:06:38.377744'),('a6058943642043be95b1dfa390a2f05e','product_images/hoco-ca120-prospering-car-center-console-holder-horizontally_OnOTuhk.jpg','2025-08-07 11:10:49.891012'),('ae7c9cb08e624424aa3bde14515ccf71','product_images/2403180639080323100.jpg','2025-08-06 06:06:23.892602'),('b5c078c8427645a7b32d386e44758307','product_images/hoco-ca120-prospering-car-center-console-holder.jpg','2025-08-07 11:03:00.904530'),('b8e7373426df48b0a65de4617695dea2','product_images/hoco-ca120-prospering-car-center-console-holder-horizontally.jpg','2025-08-07 11:02:35.227849'),('bc44f1f65087436e840a1cffb01f51b0','product_images/1737752277076283392.jpg','2025-08-07 11:55:22.286477'),('c1deadf0c4884d67b92506cafe01b6af','product_images/rayhong-car-scratch-removel-wax_2.jpg','2025-08-09 15:25:01.833267'),('c33b89a7486742309173246339ca151f','product_images/1737752276640075776.jpg','2025-08-07 11:55:11.444883'),('c493f994a07a43e3b7399964c03194fa','product_images/Screenshot_2025-01-09_115405.png','2025-08-07 10:46:27.065598'),('c64cb65e2d304dd6bdfe563da3441dae','product_images/portable-electric-air-pump-42082.jpg','2025-08-09 15:11:38.110681'),('c9fe7fa43aa741df9245610c0e9295c2','product_images/71U3mmLPPyL._SX679_.jpg','2025-08-07 17:07:24.247255'),('d18244aa989947a58125d6c5dd6eba44','product_images/shopping_1.webp','2025-08-07 10:54:42.352135'),('d19c80d1d0c54022b3048a9c92fad717','product_images/71U3mmLPPyL_nmIoFVb._SX679_.jpg','2025-08-07 17:22:51.289691'),('d215bb2bb3d54df0ad944602891aff8f','product_images/ecc9ce54-2d37-43e2-a3d8-b9ced7b044b2.jpg','2025-08-09 13:13:43.037009'),('d9626fa9ad7e4c3187192b155cb20a1b','product_images/2403230329520328600.jpg','2025-08-06 05:53:20.013531'),('daccbc60858e442aa45fb6319e045ef3','product_images/97147-6-600x600.webp','2025-08-07 12:04:18.310818'),('e0393d50259e475eb0fbc68ddec21078','product_images/a00a2452-3117-43cc-ad8c-13e8ac02d8f8.jpg','2025-08-05 06:20:05.758489'),('e07534e6dc1e463a8caf0a7cee772cdf','product_images/shopping_8.png','2025-08-07 10:54:10.038427'),('e232416faaec4c9985f2dbf07a770e62','product_images/e2cc93af-449f-4fa2-a4f5-eb4826b65734.jpg','2025-08-04 16:44:13.052201'),('e52068a040c04013945bfc40ce3676f2','product_images/shopping_2_kr7LYVX.webp','2025-08-09 13:45:55.624001'),('e6af29bc08ee43a2a65cc833f6997acb','product_images/c6aaf455-725d-4d79-b4c8-cfe8ee7a37fd.jpg','2025-08-04 16:43:43.972392'),('e6cc8646c91f43478ab1af8d016e257d','product_images/Screenshot_2024-11-02_102308.png','2025-08-09 12:57:53.034514'),('e8bee89a485f46f6929c3f43f1709878','product_images/41cc2a49-fa8c-4131-a03f-0fe5d629301d.jpg','2025-08-09 13:14:06.895495'),('e971a64ba04147bd8df1c5f8c82891fa','product_images/Screenshot_2024-11-02_102327.png','2025-08-09 12:57:38.562119'),('ee2e67198da8487d8361f919740a650d','product_images/3d491ff6-a4fe-4af0-bfc9-f14f9d5beec7.jpg','2025-08-05 06:19:55.666189'),('f964534d7bf54ffdb763210046471fe4','product_images/4f1fa2e3-9648-4055-9d1b-8c1a12c5ff87.jpg','2025-08-09 13:13:55.450000'),('fc1ba72caf474e7cb5f3eee8d380d213','product_images/rayhong-car-scratch-removel-wax_3.jpg','2025-08-09 15:25:11.186349');
/*!40000 ALTER TABLE `core_p_productimageschema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_productmeta`
--

DROP TABLE IF EXISTS `core_p_productmeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_productmeta` (
  `id` char(32) NOT NULL,
  `metaTitle` varchar(255) NOT NULL,
  `metaDescription` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_productmeta`
--

LOCK TABLES `core_p_productmeta` WRITE;
/*!40000 ALTER TABLE `core_p_productmeta` DISABLE KEYS */;
INSERT INTO `core_p_productmeta` VALUES ('1988f1101f0d4bf3b1f200855c5af7c2','Electric USB Magnetic Coffee Mug – Self-Stirring & Waterproof','USB rechargeable self-stirring coffee mug with magnetic mixing. IP67 waterproof, food-safe stainless steel – perfect for coffee, tea, milk, and more.'),('5442d26edfa746b2912a23c392e02662','Vitamin C Body Oil – Brightening & Hydrating (100ml)','Nourishing Vitamin C body oil for radiant, hydrated skin. Lightweight formula helps brighten, even tone, and improve skin texture. Ideal for daily use.'),('6bde52214d134d998c6c1d032558b2b0','wireless charger','White wireless charger with USB interface, 18W total output, up to 30W max. Fast, safe charging for compatible devices. Sleek design for everyday use.'),('6eac28b936714370b46f0b40971735bd','USB Facial Gun – Portable Facial Massage & Skin Revitalization Tool','Experience deep facial relaxation and improved circulation with our USB Facial Gun. Compact, portable, and easy to use—perfect for home or travel skincare routines.'),('6fa2d78b11f24d45841051e904802b56','Hoco HW8 Car Holder – Center Console Phone Mount','Secure your phone while driving with the Hoco HW8 Center Console Car Holder. Adjustable, stable, and easy to install – perfect for hands-free navigation.'),('77c24bfe80904f9794ea8fbc9fb7f919','Rabbit LED Night Light – USB Rechargeable Kids Lamp','Adorable rabbit LED night light with soft silicone design. Dimmable, USB rechargeable, perfect gift for babies, kids, and children\'s bedroom decor.'),('a6cc5318194f4a61bc78b251d6593dc1','Samsung Z Fold2 Flip Split Case – Two-in-One Multi-Function Cover | Durable & Stylish','Protect your Samsung Z Fold 2 with this stylish flip split two-in-one case. Multi-functional design offers durability, convenience, and a perfect fit.'),('ace6119cd4654573a79a791e6fc48f0b','VGR Men’s Grooming Kit – Professional All-in-One Trimmer','Complete grooming kit for men by VGR. Includes precision trimmer, shaver, and grooming tools. Ideal for beard, hair, and body care – cordless & rechargeable.'),('afa71f2c2ea84ae1a1413cab40320965','925 Sterling Silver Simple Temperament Clavicle Necklace – Elegant Minimalist Jewelry','Add timeless elegance to your look with our 925 Sterling Silver Simple Temperament Clavicle Necklace. Minimalist design, premium silver, and perfect for daily wear or special occasions.'),('b58f9daede0349cb8df99f420d82e796','Matte Lipstick Set – Long-Lasting, Highly Pigmented & Velvet Finish','Discover our Matte Lipstick Set with rich, highly pigmented shades for all-day wear. Smooth velvet finish, non-drying formula—perfect for every look, from casual to glam.'),('cbb8d16d5e824f49b7c159501a898efd','Refreshing UV Protection Cream – SPF Sunscreen Lotion','Lightweight, refreshing sunscreen lotion with powerful UV protection. Non-greasy formula ideal for daily use on all skin types. Moisturizes & protects.'),('de5616ef4e0c416f8d7a9da065695bad','Fascial Massage Gun – Deep Tissue Muscle Relief Tool','Powerful fascial massage gun for deep tissue relief. Quiet, portable, and adjustable speeds – ideal for athletes, fitness recovery, and pain relief therapy.'),('e2828e09880046f5b0bf5ec916b9d2fc','Spring Grip Arm Exerciser – Men’s Home Fitness Tool','Build arm strength and muscle with this professional spring grip exerciser. Ideal for men’s home workouts, forearm training, and upper body conditioning.'),('ee2680f83b1842cd907045d5f4b467fb','Mini 2.4G Punk Wireless Keyboard – Retro Style, Compact & Portable','Enjoy smooth, cable-free typing with this mini 2.4G wireless keyboard. Features a retro punk design, stable connection, and compact build for portability.'),('f3420009b5da439caf9d9dffa19ee864','Vibe Sphere Headphones – Immersive Sound & Comfort','Experience premium sound with Vibe Sphere Headphones. Sleek, comfortable design with deep bass, noise isolation, and long-lasting battery life.');
/*!40000 ALTER TABLE `core_p_productmeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_productmeta_metaKeywords`
--

DROP TABLE IF EXISTS `core_p_productmeta_metaKeywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_productmeta_metaKeywords` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `productmeta_id` char(32) NOT NULL,
  `pctags_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `core_p_productmeta_metaK_productmeta_id_pctags_id_f02e55e7_uniq` (`productmeta_id`,`pctags_id`),
  KEY `core_p_productmeta_m_pctags_id_57b489b8_fk_core_p_pc` (`pctags_id`),
  CONSTRAINT `core_p_productmeta_m_pctags_id_57b489b8_fk_core_p_pc` FOREIGN KEY (`pctags_id`) REFERENCES `core_p_pctags` (`id`),
  CONSTRAINT `core_p_productmeta_m_productmeta_id_c622ffdc_fk_core_p_pr` FOREIGN KEY (`productmeta_id`) REFERENCES `core_p_productmeta` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_productmeta_metaKeywords`
--

LOCK TABLES `core_p_productmeta_metaKeywords` WRITE;
/*!40000 ALTER TABLE `core_p_productmeta_metaKeywords` DISABLE KEYS */;
INSERT INTO `core_p_productmeta_metaKeywords` VALUES (5,'6eac28b936714370b46f0b40971735bd','13d5d24d926849438e84261409b582b6'),(1,'6eac28b936714370b46f0b40971735bd','7c9989a3959b4b86aaebbe8f63d6334f'),(2,'6eac28b936714370b46f0b40971735bd','96059d872a20448a948c2a38fdfc52f6'),(4,'6eac28b936714370b46f0b40971735bd','cc583a0419da4cb4a513f8be6cf72ddd'),(3,'6eac28b936714370b46f0b40971735bd','e5ea60f3ba8346d680b70cdb7964a8a4'),(10,'afa71f2c2ea84ae1a1413cab40320965','21db9b51809f4ed7932f9c6ccfeff86b'),(9,'afa71f2c2ea84ae1a1413cab40320965','5a72d0afb5c54e628f7a7c4f50096021'),(11,'afa71f2c2ea84ae1a1413cab40320965','5f5267d8f75c4a4484fdded5f937a479'),(13,'afa71f2c2ea84ae1a1413cab40320965','656f1a7ab58f4a5b8a4e3732a882b9a8'),(6,'afa71f2c2ea84ae1a1413cab40320965','682e7262b659421b8dfa7fff13e982eb'),(8,'afa71f2c2ea84ae1a1413cab40320965','7ec76f50f2e6451296d03a11f34aadf5'),(7,'afa71f2c2ea84ae1a1413cab40320965','dee75266aee74b3485e7486c9a6fec67'),(12,'afa71f2c2ea84ae1a1413cab40320965','e2b16e20d83d470ab41c98f74ef23c89'),(15,'b58f9daede0349cb8df99f420d82e796','282ed42568534f468cfd0a600c712864'),(16,'b58f9daede0349cb8df99f420d82e796','503002f2d23a4e7ca9d690b6baabad6e'),(14,'b58f9daede0349cb8df99f420d82e796','7cb5ee38e6c448129f28df2a9702954c'),(18,'b58f9daede0349cb8df99f420d82e796','ec4ae441a302414eadbdcf07bc8336cd'),(17,'b58f9daede0349cb8df99f420d82e796','f79dc8b3cda547beaa99cf0ca5b0f222');
/*!40000 ALTER TABLE `core_p_productmeta_metaKeywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_productreview`
--

DROP TABLE IF EXISTS `core_p_productreview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_productreview` (
  `id` char(32) NOT NULL,
  `rating_image` varchar(100) DEFAULT NULL,
  `rating` decimal(3,2) DEFAULT NULL,
  `rating_comment` longtext NOT NULL,
  `review_to_id` char(32) NOT NULL,
  `reviewd_by_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_p_productreview_review_to_id_d3ae4664_fk_core_p_product_id` (`review_to_id`),
  KEY `core_p_productreview_reviewd_by_id_35adb9ad_fk_core_a_cu` (`reviewd_by_id`),
  KEY `core_p_productreview_rating_d5729417` (`rating`),
  CONSTRAINT `core_p_productreview_review_to_id_d3ae4664_fk_core_p_product_id` FOREIGN KEY (`review_to_id`) REFERENCES `core_p_product` (`id`),
  CONSTRAINT `core_p_productreview_reviewd_by_id_35adb9ad_fk_core_a_cu` FOREIGN KEY (`reviewd_by_id`) REFERENCES `core_a_customuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_productreview`
--

LOCK TABLES `core_p_productreview` WRITE;
/*!40000 ALTER TABLE `core_p_productreview` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_p_productreview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_productshipping`
--

DROP TABLE IF EXISTS `core_p_productshipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_productshipping` (
  `id` char(32) NOT NULL,
  `shippingWeight` decimal(10,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `shippingUnit` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_productshipping`
--

LOCK TABLES `core_p_productshipping` WRITE;
/*!40000 ALTER TABLE `core_p_productshipping` DISABLE KEYS */;
INSERT INTO `core_p_productshipping` VALUES ('1d2d29a8bfc74c87a5833c8d1ea30eb9',5.00,'2025-08-05 05:56:03.422204','g'),('6b9ef67a9f484132854a8dc0804976ab',200.00,'2025-08-04 17:50:49.926756','g'),('71468ce32470433181b73e3a8030ecd0',350.00,'2025-08-05 06:20:28.746694','g');
/*!40000 ALTER TABLE `core_p_productshipping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_p_productvariant`
--

DROP TABLE IF EXISTS `core_p_productvariant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_p_productvariant` (
  `id` char(32) NOT NULL,
  `variantImage` varchar(100) NOT NULL,
  `variantName` varchar(255) NOT NULL,
  `variantPrice` decimal(10,2) NOT NULL,
  `variantSKU` varchar(100) NOT NULL,
  `variantStock` int unsigned NOT NULL,
  `variantBarcode` varchar(100) DEFAULT NULL,
  `variantIsActive` tinyint(1) NOT NULL,
  `variantCreatedAt` datetime(6) NOT NULL,
  `variantUpdatedAt` datetime(6) NOT NULL,
  `parentVariant_id` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `variantSKU` (`variantSKU`),
  UNIQUE KEY `variantBarcode` (`variantBarcode`),
  KEY `core_p_productvarian_parentVariant_id_c74bf5a6_fk_core_p_pr` (`parentVariant_id`),
  CONSTRAINT `core_p_productvarian_parentVariant_id_c74bf5a6_fk_core_p_pr` FOREIGN KEY (`parentVariant_id`) REFERENCES `core_p_productvariant` (`id`),
  CONSTRAINT `core_p_productvariant_chk_1` CHECK ((`variantStock` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_p_productvariant`
--

LOCK TABLES `core_p_productvariant` WRITE;
/*!40000 ALTER TABLE `core_p_productvariant` DISABLE KEYS */;
INSERT INTO `core_p_productvariant` VALUES ('0506e7b0c9964309a767a980f182cafe','variant_images/eed2d737-ba39-4c77-8086-916a880f372d.jpg','white',103.00,'',10,NULL,1,'2025-08-04 17:50:23.314016','2025-08-04 17:50:23.314073',NULL);
/*!40000 ALTER TABLE `core_p_productvariant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_core_a_customuser_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_core_a_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `core_a_customuser` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=289 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-08-02 18:41:38.565032','a27843f6-a116-48a5-bab9-29593cf1aa89','Image for a27843f6-a116-48a5-bab9-29593cf1aa89',1,'[{\"added\": {}}]',9,'6b432032276146bc8e08143e4a1c9707'),(2,'2025-08-02 18:42:36.822876','028ce62d-cff0-4aae-89e4-b7b0bdb47311','Cloth',1,'[{\"added\": {}}]',7,'6b432032276146bc8e08143e4a1c9707'),(3,'2025-08-02 18:42:54.376203','193e08fa-de5c-456b-8857-b3ed5502a433','Fashion',1,'[{\"added\": {}}]',11,'6b432032276146bc8e08143e4a1c9707'),(4,'2025-08-02 18:43:12.999242','c1b4e70c-531f-40b4-873a-8ecd91ad8a30','Cloth',1,'[{\"added\": {}}]',8,'6b432032276146bc8e08143e4a1c9707'),(5,'2025-08-02 18:43:37.392178','5dd608ea-a8c4-4978-9944-cb46db849466','T-SHIRT',1,'[{\"added\": {}}]',7,'6b432032276146bc8e08143e4a1c9707'),(6,'2025-08-02 18:44:37.656220','b4cc492c-c718-4a36-8512-e104d49550ee','Cartoon Baby Pillow',1,'[{\"added\": {}}]',13,'6b432032276146bc8e08143e4a1c9707'),(7,'2025-08-02 18:45:13.872239','b4cc492c-c718-4a36-8512-e104d49550ee','Cartoon Baby Pillow',2,'[{\"changed\": {\"fields\": [\"ProductSlug\"]}}]',13,'6b432032276146bc8e08143e4a1c9707'),(8,'2025-08-02 19:04:06.800120','e547161e-98ec-471b-8edb-4265a6541d63','Image for e547161e-98ec-471b-8edb-4265a6541d63',1,'[{\"added\": {}}]',9,'6b432032276146bc8e08143e4a1c9707'),(9,'2025-08-02 19:04:21.063433','b4cc492c-c718-4a36-8512-e104d49550ee','Cartoon Baby Pillow',2,'[{\"changed\": {\"fields\": [\"ProductImages\"]}}]',13,'6b432032276146bc8e08143e4a1c9707'),(10,'2025-08-03 11:04:07.046893','b4cc492c-c718-4a36-8512-e104d49550ee','Cartoon Baby Pillow',2,'[]',13,'6b432032276146bc8e08143e4a1c9707'),(11,'2025-08-03 11:05:22.469428','3bd75990-c070-461a-854c-a9a7716ea893','Image for 3bd75990-c070-461a-854c-a9a7716ea893',1,'[{\"added\": {}}]',9,'6b432032276146bc8e08143e4a1c9707'),(12,'2025-08-03 11:06:52.133178','f7a4ca14-f486-466e-aeea-b6bc607d92ae','Cartoon Baby Pillow Premium',1,'[{\"added\": {}}]',13,'6b432032276146bc8e08143e4a1c9707'),(13,'2025-08-03 17:52:31.323457','f7a4ca14-f486-466e-aeea-b6bc607d92ae','Cartoon Baby Pillow Premium',2,'[{\"changed\": {\"fields\": [\"ProductImages\"]}}]',13,'6b432032276146bc8e08143e4a1c9707'),(14,'2025-08-03 18:36:21.430088','f7a4ca14-f486-466e-aeea-b6bc607d92ae','Cartoon Baby Pillow Premium',2,'[{\"changed\": {\"fields\": [\"ProductIsBestSelling\"]}}]',13,'6b432032276146bc8e08143e4a1c9707'),(15,'2025-08-03 19:56:29.742305','55f7b3e8-20ed-4700-b488-1ad60e614910','Image for 55f7b3e8-20ed-4700-b488-1ad60e614910',1,'[{\"added\": {}}]',9,'6b432032276146bc8e08143e4a1c9707'),(16,'2025-08-03 19:57:30.043884','0eed600a-0f90-4557-96b3-ea563f14fd76','Red T shirt',1,'[{\"added\": {}}]',13,'6b432032276146bc8e08143e4a1c9707'),(17,'2025-08-03 19:58:07.640654','0eed600a-0f90-4557-96b3-ea563f14fd76','Red T shirt',2,'[{\"changed\": {\"fields\": [\"ProductIsBestSelling\"]}}]',13,'6b432032276146bc8e08143e4a1c9707'),(18,'2025-08-03 20:14:02.886391','f3e4c12a-0a8c-40f6-b0df-45b74a502cc5','Image for f3e4c12a-0a8c-40f6-b0df-45b74a502cc5',1,'[{\"added\": {}}]',9,'6b432032276146bc8e08143e4a1c9707'),(19,'2025-08-03 20:14:14.802312','0eed600a-0f90-4557-96b3-ea563f14fd76','Red T shirt',2,'[{\"changed\": {\"fields\": [\"ProductImages\"]}}]',13,'6b432032276146bc8e08143e4a1c9707'),(20,'2025-08-03 20:38:54.063277','0eed600a-0f90-4557-96b3-ea563f14fd76','Red T shirt',2,'[]',13,'6b432032276146bc8e08143e4a1c9707'),(21,'2025-08-03 20:40:16.255780','b2fc95c0-4c26-41b2-ac0e-aee47084d5e6','Image for b2fc95c0-4c26-41b2-ac0e-aee47084d5e6',1,'[{\"added\": {}}]',9,'6b432032276146bc8e08143e4a1c9707'),(22,'2025-08-03 20:40:27.144832','0eed600a-0f90-4557-96b3-ea563f14fd76','Red T shirt',2,'[{\"changed\": {\"fields\": [\"ProductImages\"]}}]',13,'6b432032276146bc8e08143e4a1c9707'),(23,'2025-08-03 20:44:19.503160','f7a4ca14-f486-466e-aeea-b6bc607d92ae','Cartoon Baby Pillow Premium',3,'',13,'6b432032276146bc8e08143e4a1c9707'),(24,'2025-08-03 21:38:09.918589','b4cc492c-c718-4a36-8512-e104d49550ee','Cartoon Baby Pillow',2,'[{\"changed\": {\"fields\": [\"ProductIsBestSelling\"]}}]',13,'6b432032276146bc8e08143e4a1c9707'),(25,'2025-08-04 05:26:32.916361','0eed600a-0f90-4557-96b3-ea563f14fd76','Red T shirt',2,'[{\"changed\": {\"fields\": [\"ProductDescription\"]}}]',13,'6b432032276146bc8e08143e4a1c9707'),(26,'2025-08-04 16:14:03.456640','193e08fa-de5c-456b-8857-b3ed5502a433','Fashion',2,'[{\"changed\": {\"fields\": [\"CollectionDescription\"]}}]',11,'6b432032276146bc8e08143e4a1c9707'),(27,'2025-08-04 16:43:43.997532','e6af29bc-08ee-43a2-a65c-c833f6997acb','Image for e6af29bc-08ee-43a2-a65c-c833f6997acb',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(28,'2025-08-04 16:43:55.801101','18ed4fd5-83c6-4bf1-89bd-d76187384e84','Image for 18ed4fd5-83c6-4bf1-89bd-d76187384e84',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(29,'2025-08-04 16:44:13.066415','e232416f-aaec-4c99-85f2-dbf07a770e62','Image for e232416f-aaec-4c99-85f2-dbf07a770e62',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(30,'2025-08-04 16:45:38.322174','d56129f4-bce3-4a14-8e7c-558928fef02a','Tech',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(31,'2025-08-04 16:45:55.573494','e8daabe4-ada2-4c97-a250-6baead4b81db','mobile accessories',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(32,'2025-08-04 16:47:08.607388','ccd6028b-fd79-43ae-833e-c04c05114577','Mobile Accessories',1,'[{\"added\": {}}]',11,'aee2db4b0e9844eb9c21248145715231'),(33,'2025-08-04 16:47:23.806411','d8e62671-235e-46c1-873b-870789849173','Tech',1,'[{\"added\": {}}]',8,'aee2db4b0e9844eb9c21248145715231'),(34,'2025-08-04 16:47:40.035310','e9e3e68a-a16a-4e74-8d4e-009272732ac3','tech accessories',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(35,'2025-08-04 17:05:40.444505','ccd6028b-fd79-43ae-833e-c04c05114577','Mobile Accessories',2,'[{\"changed\": {\"fields\": [\"CollectionDescription\"]}}]',11,'6b432032276146bc8e08143e4a1c9707'),(36,'2025-08-04 17:33:33.318323','1dae06f9-d7f5-40f6-8fad-43b083316545','Wireless Chargers',1,'[{\"added\": {}}]',8,'aee2db4b0e9844eb9c21248145715231'),(37,'2025-08-04 17:50:23.334731','0506e7b0-c996-4309-a767-a980f182cafe','white',1,'[{\"added\": {}}]',12,'aee2db4b0e9844eb9c21248145715231'),(38,'2025-08-04 17:50:49.942220','6b9ef67a-9f48-4132-854a-8dc0804976ab','g - g',1,'[{\"added\": {}}]',10,'aee2db4b0e9844eb9c21248145715231'),(39,'2025-08-04 17:57:53.465952','6bde5221-4d13-4d99-8c6c-1d032558b2b0','wireless charger',1,'[{\"added\": {}}]',16,'aee2db4b0e9844eb9c21248145715231'),(40,'2025-08-04 17:58:08.721220','3449643f-062e-4ded-a01e-6e7f0485ed42','Three-in-one Mobile Phone Wireless Charger Small Night Lamp',1,'[{\"added\": {}}]',13,'aee2db4b0e9844eb9c21248145715231'),(41,'2025-08-04 18:02:29.043240','3449643f-062e-4ded-a01e-6e7f0485ed42','Three-in-one Mobile Phone Wireless Charger Small Night Lamp',2,'[{\"changed\": {\"fields\": [\"ProductShipping\"]}}]',13,'6b432032276146bc8e08143e4a1c9707'),(42,'2025-08-04 18:06:50.893776','0eed600a-0f90-4557-96b3-ea563f14fd76','Red T shirt',3,'',13,'6b432032276146bc8e08143e4a1c9707'),(43,'2025-08-04 18:06:50.893849','b4cc492c-c718-4a36-8512-e104d49550ee','Cartoon Baby Pillow',3,'',13,'6b432032276146bc8e08143e4a1c9707'),(44,'2025-08-04 18:11:41.475377','193e08fa-de5c-456b-8857-b3ed5502a433','Fashion',3,'',11,'6b432032276146bc8e08143e4a1c9707'),(45,'2025-08-04 18:12:03.562983','f3e4c12a-0a8c-40f6-b0df-45b74a502cc5','Image for f3e4c12a-0a8c-40f6-b0df-45b74a502cc5',3,'',9,'6b432032276146bc8e08143e4a1c9707'),(46,'2025-08-04 18:12:28.764360','e547161e-98ec-471b-8edb-4265a6541d63','Image for e547161e-98ec-471b-8edb-4265a6541d63',3,'',9,'6b432032276146bc8e08143e4a1c9707'),(47,'2025-08-04 18:13:23.947379','b2fc95c0-4c26-41b2-ac0e-aee47084d5e6','Image for b2fc95c0-4c26-41b2-ac0e-aee47084d5e6',3,'',9,'6b432032276146bc8e08143e4a1c9707'),(48,'2025-08-04 18:13:23.947461','a27843f6-a116-48a5-bab9-29593cf1aa89','Image for a27843f6-a116-48a5-bab9-29593cf1aa89',3,'',9,'6b432032276146bc8e08143e4a1c9707'),(49,'2025-08-04 18:13:23.947497','55f7b3e8-20ed-4700-b488-1ad60e614910','Image for 55f7b3e8-20ed-4700-b488-1ad60e614910',3,'',9,'6b432032276146bc8e08143e4a1c9707'),(50,'2025-08-04 18:13:23.947527','3bd75990-c070-461a-854c-a9a7716ea893','Image for 3bd75990-c070-461a-854c-a9a7716ea893',3,'',9,'6b432032276146bc8e08143e4a1c9707'),(51,'2025-08-04 18:14:54.197517','5dd608ea-a8c4-4978-9944-cb46db849466','T-SHIRT',3,'',7,'6b432032276146bc8e08143e4a1c9707'),(52,'2025-08-04 18:14:54.197611','028ce62d-cff0-4aae-89e4-b7b0bdb47311','Cloth',3,'',7,'6b432032276146bc8e08143e4a1c9707'),(53,'2025-08-05 05:16:53.358784','80bfbf77-cad7-439e-a3c1-c73cf5dabf44','Health',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(54,'2025-08-05 05:17:04.690292','a72ca6aa-859c-4f42-a483-36eb2d49861b','beauty',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(55,'2025-08-05 05:17:16.416811','1d9c82d3-8e9b-4a72-89ed-533e4e0e4df1','fitness',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(56,'2025-08-05 05:17:29.363993','d02d4d37-7a48-4a95-880c-4ce248ac283b','products',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(57,'2025-08-05 05:22:41.894575','989829fd-7855-468a-ad68-bd7d99348746','Health & Beauty',1,'[{\"added\": {}}]',11,'aee2db4b0e9844eb9c21248145715231'),(58,'2025-08-05 05:25:08.364716','ccd6028b-fd79-43ae-833e-c04c05114577','Mobile Accessories',2,'[{\"changed\": {\"fields\": [\"CollectionImage\", \"CollectionTags\", \"CollectionDescription\"]}}]',11,'aee2db4b0e9844eb9c21248145715231'),(59,'2025-08-05 05:27:24.294562','ccd6028b-fd79-43ae-833e-c04c05114577','Mobile Accessories',2,'[{\"changed\": {\"fields\": [\"CollectionImage\"]}}]',11,'aee2db4b0e9844eb9c21248145715231'),(60,'2025-08-05 05:31:56.553212','5ee95e6e-7060-4a9b-aa37-f8fb5021ccb7','sportswear',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(61,'2025-08-05 05:32:12.185766','103c05d0-599f-4e2d-8a3c-7ec4d6220963','gym',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(62,'2025-08-05 05:32:26.531112','0366adc6-0eb1-4b66-8103-0a7f1b2885c7','sports',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(63,'2025-08-05 05:33:28.273612','dfa0b385-d88c-4844-9c95-e85da83157ce','Fitness, Sports & Outdoors',1,'[{\"added\": {}}]',11,'aee2db4b0e9844eb9c21248145715231'),(64,'2025-08-05 05:38:19.960250','a624e596-cfa8-4701-a550-2a386467239e','kids',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(65,'2025-08-05 05:38:28.322521','2bb8c7e8-2dc3-45ba-ab37-1d90fa465060','toys',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(66,'2025-08-05 05:38:35.613876','a2b2bcb1-e257-4c43-8ca1-b769e94cbc27','games',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(67,'2025-08-05 05:38:48.630990','b3b1298b-974e-48d0-93cf-f631fb6ce047','babies toys',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(68,'2025-08-05 05:39:36.608654','a0d3ab8a-7188-4e14-b907-dbd354109b18','Toys, Games & Babies',1,'[{\"added\": {}}]',11,'aee2db4b0e9844eb9c21248145715231'),(69,'2025-08-05 05:44:07.838650','66ae5ee7-b23f-48b5-af16-565e276c0d9c','home and kitchen essentials',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(70,'2025-08-05 05:44:38.021669','53a2612d-325f-473e-854a-61e4c9829514','cookware and utensils',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(71,'2025-08-05 05:44:58.705910','189c4985-0af3-4f8e-aedb-c314c72e233b','modern home accessories',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(72,'2025-08-05 05:45:33.567892','587677ec-f730-47b3-a61b-c40deb5e3b8c','kitchen accessories online',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(73,'2025-08-05 05:45:49.765948','b3ab91b1-aac3-4b8f-9cd7-4175c0038254','Home & Kitchen',1,'[{\"added\": {}}]',11,'aee2db4b0e9844eb9c21248145715231'),(74,'2025-08-05 05:51:41.303614','33fab3b4-540c-42d7-90a3-ce49f6348729','Image for 33fab3b4-540c-42d7-90a3-ce49f6348729',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(75,'2025-08-05 05:53:13.384884','119da33d-48d3-49a2-8465-abbd2464c06d','Image for 119da33d-48d3-49a2-8465-abbd2464c06d',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(76,'2025-08-05 05:54:15.876950','c9072e13-f5cb-40ef-a7e3-6af0472e3d0a','Mobile covers',1,'[{\"added\": {}}]',8,'aee2db4b0e9844eb9c21248145715231'),(77,'2025-08-05 05:55:03.081934','4d183834-5b6d-416a-9f21-53655ac91dad','Samsung Z Fold2 case',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(78,'2025-08-05 05:55:15.104926','4cafcf77-732d-4595-99cb-80bf915284cc','Z Fold2 flip case',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(79,'2025-08-05 05:55:28.069634','1a09411e-a522-49ca-b8dd-4e5c6cd5c235','two-in-one phone case',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(80,'2025-08-05 05:55:46.940993','22dd32c5-1aef-47b0-bd35-d1babfd4d66a','Samsung Fold2 phone case',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(81,'2025-08-05 05:56:03.432075','1d2d29a8-bfc7-4c87-a583-3c8d1ea30eb9','g - g',1,'[{\"added\": {}}]',10,'aee2db4b0e9844eb9c21248145715231'),(82,'2025-08-05 06:00:49.568995','a6cc5318-194f-4a61-bc78-b251d6593dc1','Samsung Z Fold2 Flip Split Case – Two-in-One Multi-Function Cover | Durable & Stylish',1,'[{\"added\": {}}]',16,'aee2db4b0e9844eb9c21248145715231'),(83,'2025-08-05 06:01:43.595156','af84edac-8e60-4e1b-8219-e60480fc7c24','Samsung Z FOLD2 Flip Split Two-in-one Multi-Function Phone Case',1,'[{\"added\": {}}]',13,'aee2db4b0e9844eb9c21248145715231'),(84,'2025-08-05 06:11:22.715233','6c9d1ef2-2309-453a-91c2-8c997ed8f482','tech gadgets online',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(85,'2025-08-05 06:11:40.148569','3b4ebae5-bc2e-46f4-8b6e-aa4718ed53a8','wearable technology',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(86,'2025-08-05 06:12:37.048308','2842d3f4-5b21-4a61-9c35-ac886769ad5c','smartwatches and fitness brands',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(87,'2025-08-05 06:12:44.938615','ccd6028b-fd79-43ae-833e-c04c05114577','Mobiles, Laptops & Wearables',2,'[{\"changed\": {\"fields\": [\"CollectionName\", \"CollectionSlug\", \"CollectionImage\", \"CollectionTags\", \"CollectionDescription\"]}}]',11,'aee2db4b0e9844eb9c21248145715231'),(88,'2025-08-05 06:16:32.585011','ff2cc748-d101-4b88-936b-8a0426427239','wireless keyboard',1,'[{\"added\": {}}]',8,'aee2db4b0e9844eb9c21248145715231'),(89,'2025-08-05 06:17:55.113370','17cb34bf-939f-46c0-a5e3-5c0bf462c5e8','2.4G wireless keyboard',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(90,'2025-08-05 06:18:14.275992','47a3a400-8ddc-43a8-a553-aca5f9ff887f','compact wireless keyboard',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(91,'2025-08-05 06:18:28.208085','8c8d8691-889c-4f30-b69d-3096829cae3d','mini keyboard for PC and laptop',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(92,'2025-08-05 06:18:44.203579','76f81727-6a06-4af3-a49e-66cb7d886ed9','retro wireless keyboard',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(93,'2025-08-05 06:19:55.695087','ee2e6719-8da8-487d-8361-f919740a650d','Image for ee2e6719-8da8-487d-8361-f919740a650d',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(94,'2025-08-05 06:20:05.766772','e0393d50-259e-475e-b0fb-c68ddec21078','Image for e0393d50-259e-475e-b0fb-c68ddec21078',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(95,'2025-08-05 06:20:28.761366','71468ce3-2470-4331-81b7-3e3a8030ecd0','g - g',1,'[{\"added\": {}}]',10,'aee2db4b0e9844eb9c21248145715231'),(96,'2025-08-05 06:26:49.106065','ee2680f8-3b18-42cd-9070-45d5f4b467fb','Mini 2.4G Punk Wireless Keyboard – Retro Style, Compact & Portable',1,'[{\"added\": {}}]',16,'aee2db4b0e9844eb9c21248145715231'),(97,'2025-08-05 06:27:00.451706','16164e71-6e7b-4ac8-8be4-31e761db7021','Mini 2.4G Punk Wireless Keyboard',1,'[{\"added\": {}}]',13,'aee2db4b0e9844eb9c21248145715231'),(98,'2025-08-05 06:53:09.664746','af84edac-8e60-4e1b-8219-e60480fc7c24','Samsung Z FOLD2 Flip Split Two-in-one Multi-Function Phone Case',2,'[{\"changed\": {\"fields\": [\"ProductShipping\"]}}]',13,'6b432032276146bc8e08143e4a1c9707'),(99,'2025-08-05 06:54:03.889009','16164e71-6e7b-4ac8-8be4-31e761db7021','Mini 2.4G Punk Wireless Keyboard',2,'[{\"changed\": {\"fields\": [\"ProductShipping\"]}}]',13,'6b432032276146bc8e08143e4a1c9707'),(100,'2025-08-05 14:50:30.330002','16164e71-6e7b-4ac8-8be4-31e761db7021','Mini 2.4G Punk Wireless Keyboard',2,'[{\"changed\": {\"fields\": [\"ProductShipping\"]}}]',13,'6b432032276146bc8e08143e4a1c9707'),(101,'2025-08-06 05:53:20.032773','d9626fa9-ad7e-4c31-8719-2b155cb20a1b','Image for d9626fa9-ad7e-4c31-8719-2b155cb20a1b',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(102,'2025-08-06 05:53:32.658007','2c96414a-54fd-4ce5-a42f-d8e3b79d9842','Image for 2c96414a-54fd-4ce5-a42f-d8e3b79d9842',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(103,'2025-08-06 05:53:44.644013','764a17b3-187a-40d9-a8d0-c08346dea7f9','Image for 764a17b3-187a-40d9-a8d0-c08346dea7f9',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(104,'2025-08-06 05:54:36.545253','8b669d20-132c-4e42-bdc9-3d1e2dfbd55e','Rabbit LED Night Light',1,'[{\"added\": {}}]',8,'aee2db4b0e9844eb9c21248145715231'),(105,'2025-08-06 05:55:06.459955','6ca2848c-ebe7-44fa-906a-f922184308b6','night lamp',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(106,'2025-08-06 05:55:22.770909','24b61d7a-ee92-4aff-a517-2904fa67e904','cartoon lamp',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(107,'2025-08-06 05:55:38.953886','f82640dd-703d-43ab-b2ad-58cb896ab343','lamp',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(108,'2025-08-06 06:01:16.677074','77c24bfe-8090-4f97-94ea-8fbc9fb7f919','Rabbit LED Night Light – USB Rechargeable Kids Lamp',1,'[{\"added\": {}}]',16,'aee2db4b0e9844eb9c21248145715231'),(109,'2025-08-06 06:01:38.194700','1cb8f5a7-8896-42ce-bdd0-5ec7e08023b8','Rabbit LED Night Light Silicone Animal Cartoon Dimmable Lamp USB Rechargeable For Children Kids Baby Gift Bedside Bedroom',1,'[{\"added\": {}}]',13,'aee2db4b0e9844eb9c21248145715231'),(110,'2025-08-06 06:06:09.336924','05bea4d5-ab07-48ed-9cf1-bf46067c235d','Image for 05bea4d5-ab07-48ed-9cf1-bf46067c235d',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(111,'2025-08-06 06:06:23.897777','ae7c9cb0-8e62-4424-aa3b-de14515ccf71','Image for ae7c9cb0-8e62-4424-aa3b-de14515ccf71',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(112,'2025-08-06 06:06:38.381355','a197fedc-3537-4561-b058-7d96d5964f6f','Image for a197fedc-3537-4561-b058-7d96d5964f6f',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(113,'2025-08-06 06:06:56.390502','88b8df3e-6449-44d6-875a-aad5d8469d42','Image for 88b8df3e-6449-44d6-875a-aad5d8469d42',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(114,'2025-08-06 06:07:28.220923','2777c9de-db0e-438d-b31b-55f6ec8d1ac4','Electric Coffee Mug',1,'[{\"added\": {}}]',8,'aee2db4b0e9844eb9c21248145715231'),(115,'2025-08-06 06:07:55.825710','eed09ef5-852f-4caf-b67f-7bd729fd224f','coffee mug',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(116,'2025-08-06 06:08:23.429068','a4b1e9ec-0ec6-4ee8-9fbf-3014a9bd07f0','kitchen appliances',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(117,'2025-08-06 06:08:37.704927','352d1c81-d815-40a0-9c4c-606738d350e8','electric mug',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(118,'2025-08-06 06:12:09.470038','1988f110-1f0d-4bf3-b1f2-00855c5af7c2','Electric USB Magnetic Coffee Mug – Self-Stirring & Waterproof',1,'[{\"added\": {}}]',16,'aee2db4b0e9844eb9c21248145715231'),(119,'2025-08-06 06:12:31.210855','83832402-960e-48d5-b9dc-6171d34928fa','Electric Coffee Mug USB Rechargeable Automatic Magnetic Cup IP67 Waterproof Food-Safe Stainless Steel For Juice Tea Milksha Kitchen Gadgets',1,'[{\"added\": {}}]',13,'aee2db4b0e9844eb9c21248145715231'),(120,'2025-08-06 09:51:52.142339','8a21139d-c768-4318-8d4f-e6a0bc0dc3dc','Image for 8a21139d-c768-4318-8d4f-e6a0bc0dc3dc',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(121,'2025-08-06 09:52:10.451921','7d0d7bcc-0c7f-48ab-b7fc-d1a78dde8adb','Image for 7d0d7bcc-0c7f-48ab-b7fc-d1a78dde8adb',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(122,'2025-08-06 09:53:12.997230','74ef6cbf-d651-45f8-9315-e17f9c0f417a','Massager',1,'[{\"added\": {}}]',8,'aee2db4b0e9844eb9c21248145715231'),(123,'2025-08-06 09:54:00.385534','13d5d24d-9268-4943-8e84-261409b582b6','fascial massage gun',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(124,'2025-08-06 09:54:22.945314','7c9989a3-959b-4b86-aaeb-be8f63d6334f','deep tissue massager',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(125,'2025-08-06 09:54:47.104250','96059d87-2a20-448a-948c-2a38fdfc52f6','muscle massage gun',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(126,'2025-08-06 09:55:14.542136','cc583a04-19da-4cb4-a513-f8be6cf72ddd','handheld massager',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(127,'2025-08-06 09:58:26.848341','de5616ef-4e0c-416f-8d7a-9da065695bad','Fascial Massage Gun – Deep Tissue Muscle Relief Tool',1,'[{\"added\": {}}]',16,'aee2db4b0e9844eb9c21248145715231'),(128,'2025-08-06 10:02:00.565297','516bb6da-0864-4563-9efc-b31602a9b8f9','Fascial Massage Gun',1,'[{\"added\": {}}]',13,'aee2db4b0e9844eb9c21248145715231'),(129,'2025-08-06 10:09:52.753602','43a367d0-d12a-4507-9a02-114d3a473f82','Image for 43a367d0-d12a-4507-9a02-114d3a473f82',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(130,'2025-08-06 10:10:09.220605','54f89d8c-7838-4a71-b85f-e5b5235ec4d0','Image for 54f89d8c-7838-4a71-b85f-e5b5235ec4d0',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(131,'2025-08-06 10:10:27.455661','8d5048ba-9a75-46df-b6ec-59320b55efc9','Image for 8d5048ba-9a75-46df-b6ec-59320b55efc9',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(132,'2025-08-06 10:10:53.396275','e0fe0408-9560-4abb-b154-c523b91ff32a','Beauty',1,'[{\"added\": {}}]',8,'aee2db4b0e9844eb9c21248145715231'),(133,'2025-08-06 10:11:30.547464','406472b2-3419-4d83-b3a2-015761a5215c','sunscreen lotion',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(134,'2025-08-06 10:11:47.761325','fa802801-c620-4691-9edd-172578425927','UV protection cream',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(135,'2025-08-06 10:12:00.920327','f1f5187a-625c-4cf9-8918-956e5b71d259','SPF lotion',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(136,'2025-08-06 10:12:21.841363','86159f9d-c379-47e8-8b2f-6510ce95419d','daily sunblock',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(137,'2025-08-06 10:12:41.995558','0e317bf6-1b25-49d9-85a0-f2de82844948','moisturizing sunscreen',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(138,'2025-08-06 10:15:53.556919','cbb8d16d-5e82-4f49-b7c1-59501a898efd','Refreshing UV Protection Cream – SPF Sunscreen Lotion',1,'[{\"added\": {}}]',16,'aee2db4b0e9844eb9c21248145715231'),(139,'2025-08-06 10:16:09.771389','7f69f2e1-73b8-4f36-b914-6f8e63ce30a2','UV Protection Refreshing Protective Cream Sunscreen Lotion',1,'[{\"added\": {}}]',13,'aee2db4b0e9844eb9c21248145715231'),(140,'2025-08-06 15:08:14.804000','516bb6da-0864-4563-9efc-b31602a9b8f9','Fascial Massage Gun',3,'',13,'aee2db4b0e9844eb9c21248145715231'),(141,'2025-08-07 10:46:12.873661','79322e0a-1e9a-451c-8260-6d1535bc51fc','Image for 79322e0a-1e9a-451c-8260-6d1535bc51fc',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(142,'2025-08-07 10:46:27.079981','c493f994-a07a-43e3-b739-9964c03194fa','Image for c493f994-a07a-43e3-b739-9964c03194fa',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(143,'2025-08-07 10:46:39.755109','77a4eded-b6ac-4eb1-864c-2d0c40a3e033','Image for 77a4eded-b6ac-4eb1-864c-2d0c40a3e033',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(144,'2025-08-07 10:47:13.112264','d721c6f3-3567-4eb5-b48a-ef518d717523','Body oil',1,'[{\"added\": {}}]',8,'aee2db4b0e9844eb9c21248145715231'),(145,'2025-08-07 10:48:27.628935','3770cdbf-e8c2-42ef-adcf-52a7548ef603','vitamin c body oil',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(146,'2025-08-07 10:48:43.491686','5394556b-808d-4182-ba3e-ea28c8a665d7','skin brightening oil',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(147,'2025-08-07 10:48:59.304928','dd8bb4a2-b2bc-46f2-9e75-4614d7a56dd5','hydrating body oil',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(148,'2025-08-07 10:49:19.117213','8f24b650-7c8e-4e9d-b152-2a3f7fa377ca','vitamin c skincare',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(149,'2025-08-07 10:49:30.947488','278cd946-8182-4e3b-a8fb-55ecb4f770e9','daily moisturizing oil',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(150,'2025-08-07 10:52:28.400109','5442d26e-dfa7-46b2-912a-23c392e02662','Vitamin C Body Oil – Brightening & Hydrating (100ml)',1,'[{\"added\": {}}]',16,'aee2db4b0e9844eb9c21248145715231'),(151,'2025-08-07 10:52:45.236355','336e7bd1-7725-412f-9668-d3951ee08226','Vitamin C Body Oil (100ml)',1,'[{\"added\": {}}]',13,'aee2db4b0e9844eb9c21248145715231'),(152,'2025-08-07 10:54:10.042820','e07534e6-dc1e-463a-8caf-0a7cee772cdf','Image for e07534e6-dc1e-463a-8caf-0a7cee772cdf',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(153,'2025-08-07 10:54:31.555231','3f0e6c39-27f6-45b0-ad8a-5a1d25aa99d1','Image for 3f0e6c39-27f6-45b0-ad8a-5a1d25aa99d1',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(154,'2025-08-07 10:54:42.356169','d18244aa-9899-47a5-8125-d6c5dd6eba44','Image for d18244aa-9899-47a5-8125-d6c5dd6eba44',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(155,'2025-08-07 10:55:12.720940','83dbbe6a-5576-4d72-bd7a-5b84707b7ca3','Headphones',1,'[{\"added\": {}}]',8,'aee2db4b0e9844eb9c21248145715231'),(156,'2025-08-07 10:55:53.572697','4aefdda0-e762-4522-b448-b414762c7565','wireless headphones',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(157,'2025-08-07 10:56:11.892948','640effbe-8cb5-432c-b2b1-3cfb952de58d','noise cancelling headphones',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(158,'2025-08-07 10:56:26.934932','58b35241-0ca6-488f-b3b3-f29871f53072','bluetooth headset',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(159,'2025-08-07 10:56:47.850813','ce94ab75-1012-4ff2-b95e-21370f063fa4','stylish headphones',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(160,'2025-08-07 10:57:05.243079','e198ffe8-e027-4e4d-b9d6-4cbe19278877','over-ear headphones',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(161,'2025-08-07 11:00:28.106600','f3420009-b5da-439c-af9d-9dffa19ee864','Vibe Sphere Headphones – Immersive Sound & Comfort',1,'[{\"added\": {}}]',16,'aee2db4b0e9844eb9c21248145715231'),(162,'2025-08-07 11:00:34.594456','f3a57826-30a7-4336-925c-ec1109e26bb7','Vibe Sphere Headphones',1,'[{\"added\": {}}]',13,'aee2db4b0e9844eb9c21248145715231'),(163,'2025-08-07 11:02:35.237539','b8e73734-26df-48b0-a65d-e4617695dea2','Image for b8e73734-26df-48b0-a65d-e4617695dea2',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(164,'2025-08-07 11:02:48.300743','8e73739d-aa45-4f32-ba52-322f12e69b93','Image for 8e73739d-aa45-4f32-ba52-322f12e69b93',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(165,'2025-08-07 11:03:00.908353','b5c078c8-4276-45a7-b32d-386e44758307','Image for b5c078c8-4276-45a7-b32d-386e44758307',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(166,'2025-08-07 11:06:19.585953','5f719c4a-9e42-4041-a719-901d671003b5','car accessories',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(167,'2025-08-07 11:06:32.682776','5278e1f2-fe5a-4e48-90f5-4fdd6220bfa3','car interior accessories',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(168,'2025-08-07 11:06:42.956778','2f9a201b-6688-4f9b-9f52-d799f204413e','car gadgets',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(169,'2025-08-07 11:06:58.218626','3c6dc04c-0b7e-4cd0-85d8-f3d89dbd2af0','dashboard accessories',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(170,'2025-08-07 11:07:21.346253','b93e5c1f-95be-498d-a46a-bd60223b7647','universal car accessories',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(171,'2025-08-07 11:08:09.175269','72aac0bb-2e07-40a4-b293-ca93536a2c75','Car Assessories',1,'[{\"added\": {}}]',11,'aee2db4b0e9844eb9c21248145715231'),(172,'2025-08-07 11:08:57.620290','ff57996e-d803-4d54-a7f5-6c9767f1e7a7','car interior accessories',1,'[{\"added\": {}}]',8,'aee2db4b0e9844eb9c21248145715231'),(173,'2025-08-07 11:10:03.684661','72aac0bb-2e07-40a4-b293-ca93536a2c75','Car Accessories',2,'[{\"changed\": {\"fields\": [\"CollectionName\"]}}]',11,'aee2db4b0e9844eb9c21248145715231'),(174,'2025-08-07 11:10:49.895870','a6058943-6420-43be-95b1-dfa390a2f05e','Image for a6058943-6420-43be-95b1-dfa390a2f05e',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(175,'2025-08-07 11:11:03.122797','48df31e1-df2c-4871-adec-4ce65eda9262','Image for 48df31e1-df2c-4871-adec-4ce65eda9262',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(176,'2025-08-07 11:11:15.523556','7af1a325-dafa-4e1e-9060-389e447870aa','Image for 7af1a325-dafa-4e1e-9060-389e447870aa',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(177,'2025-08-07 11:12:42.956047','e9ef8190-af25-4473-9264-514deaba0f23','AutoEssentials',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(178,'2025-08-07 11:15:44.964312','078c72df-77ec-4649-8b83-86fea65fdff0','hands-free phone holder',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(179,'2025-08-07 11:16:04.522985','bba6a565-2d21-4a1b-824a-bb8ec1a4d40d','phone cradle for car',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(180,'2025-08-07 11:16:09.355636','6fa2d78b-11f2-4d45-8410-51e904802b56','Hoco HW8 Car Holder – Center Console Phone Mount',1,'[{\"added\": {}}]',16,'aee2db4b0e9844eb9c21248145715231'),(181,'2025-08-07 11:16:14.308903','843c9455-ee71-4dcf-8195-44140c3731a9','Hoco - Center Console Car Holder (HW8)',1,'[{\"added\": {}}]',13,'aee2db4b0e9844eb9c21248145715231'),(182,'2025-08-07 11:55:11.468861','c33b89a7-4867-4230-9173-246339ca151f','Image for c33b89a7-4867-4230-9173-246339ca151f',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(183,'2025-08-07 11:55:22.299331','bc44f1f6-5087-436e-840a-1cffb01f51b0','Image for bc44f1f6-5087-436e-840a-1cffb01f51b0',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(184,'2025-08-07 11:55:31.686100','5887c4e3-6a4f-47d5-8b23-6dd74194cbf4','Image for 5887c4e3-6a4f-47d5-8b23-6dd74194cbf4',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(185,'2025-08-07 11:55:41.931032','0610b25b-1818-408d-bc3f-2f9403ae7f53','Image for 0610b25b-1818-408d-bc3f-2f9403ae7f53',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(186,'2025-08-07 11:57:00.766517','ca1f121b-abc4-4633-aa60-b5ce473ce8ef','Spring Hand Gripper',1,'[{\"added\": {}}]',8,'aee2db4b0e9844eb9c21248145715231'),(187,'2025-08-07 11:57:27.639307','1bb7e8d4-eec3-4dec-8994-d4b6d90526ec','spring grip',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(188,'2025-08-07 11:57:42.080903','51acab36-09f8-4812-a421-47b1fcac5b86','arm strength exerciser',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(189,'2025-08-07 11:57:57.815401','e1e0df3e-086d-4843-b803-f022a90f31d2','forearm trainer',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(190,'2025-08-07 11:58:16.028175','6dda263d-bd38-40ed-8d5a-f70d49f4398b','home gym tool',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(191,'2025-08-07 11:58:34.139101','d17cc2f3-4e59-4edd-b3db-5fd82adb73ba','professional hand gripper',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(192,'2025-08-07 11:59:00.252126','34f96d3e-77cf-44d6-b431-be847b763cf3','hand grip strengthener',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(193,'2025-08-07 12:02:15.633201','e2828e09-8800-46f5-b0bf-5ec916b9d2fc','Spring Grip Arm Exerciser – Men’s Home Fitness Tool',1,'[{\"added\": {}}]',16,'aee2db4b0e9844eb9c21248145715231'),(194,'2025-08-07 12:02:23.452208','c28e83ba-bce7-4dc4-8135-465fd35850bf','Spring Grip Men\'s Professional Exercise Arm Strength Home Fitness Equipment',1,'[{\"added\": {}}]',13,'aee2db4b0e9844eb9c21248145715231'),(195,'2025-08-07 12:04:18.319282','daccbc60-858e-442a-a45f-b6319e045ef3','Image for daccbc60-858e-442a-a45f-b6319e045ef3',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(196,'2025-08-07 12:04:27.620392','5e7125ec-97ca-472d-b56a-488e4bc2e45e','Image for 5e7125ec-97ca-472d-b56a-488e4bc2e45e',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(197,'2025-08-07 12:04:37.888721','5238227a-3eac-42dd-95fe-4a48227a2d1a','Image for 5238227a-3eac-42dd-95fe-4a48227a2d1a',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(198,'2025-08-07 12:06:06.411935','f6197976-44f4-4679-8d59-e34ef33f6f5c','Skin & personal care',1,'[{\"added\": {}}]',8,'aee2db4b0e9844eb9c21248145715231'),(199,'2025-08-07 12:06:53.448485','d8b1d523-3268-46c3-8d28-750a1472dfee','VGR grooming kit',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(200,'2025-08-07 12:07:08.574629','45a7925a-3c06-4cef-a6a6-017bc90c4bb2','men’s grooming set',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(201,'2025-08-07 12:07:19.599094','7c92871f-5a8a-40e6-828c-721d2d7931db','body hair trimmer',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(202,'2025-08-07 12:07:35.017831','f5b89995-2792-4288-87a8-ffeccecd0bbe','men’s personal care',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(203,'2025-08-07 12:07:55.655341','abf643a4-a7ab-42a0-9555-5dc018cfaf8e','beard trimmer',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(204,'2025-08-07 12:11:58.359936','e77b0ec1-1c4c-434f-aa95-398ca447a06f','all-in-one grooming',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(205,'2025-08-07 12:12:01.647612','ace6119c-d465-4573-a79a-791e6fc48f0b','VGR Men’s Grooming Kit – Professional All-in-One Trimmer',1,'[{\"added\": {}}]',16,'aee2db4b0e9844eb9c21248145715231'),(206,'2025-08-07 12:12:12.662598','136cf39d-a4d7-4faf-833e-6be995d0a293','VGR - Professional Grooming Kit For Men',1,'[{\"added\": {}}]',13,'aee2db4b0e9844eb9c21248145715231'),(207,'2025-08-07 17:07:24.323653','c9fe7fa4-3aa7-41df-9245-610c0e9295c2','Image for c9fe7fa4-3aa7-41df-9245-610c0e9295c2',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(208,'2025-08-07 17:07:41.921800','55950bd1-7798-4853-a4ba-336718976ce6','Image for 55950bd1-7798-4853-a4ba-336718976ce6',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(209,'2025-08-07 17:17:32.743178','ec4ae441-a302-414e-adbd-cf07bc8336cd','lipstick',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(210,'2025-08-07 17:17:51.901603','3605b405-bc8d-437d-a7d1-2ff74b01e42e','makeup products',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(211,'2025-08-07 17:18:11.890670','f79dc8b3-cda5-47be-aa99-cf0ca5b0f222','dark color lipstick',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(212,'2025-08-07 17:19:31.076115','6b837085-4e6a-4f02-8313-72e6005615df','Matte Lipstick Set',1,'[{\"added\": {}}]',13,'aee2db4b0e9844eb9c21248145715231'),(213,'2025-08-07 17:22:10.906175','5caf9fa0-b522-452f-b0f5-399f265d09ad','Image for 5caf9fa0-b522-452f-b0f5-399f265d09ad',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(214,'2025-08-07 17:22:51.293394','d19c80d1-d0c5-4022-b304-8a9c92fad717','Image for d19c80d1-d0c5-4022-b304-8a9c92fad717',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(215,'2025-08-07 17:22:57.469825','6b837085-4e6a-4f02-8313-72e6005615df','Matte Lipstick Set',2,'[{\"changed\": {\"fields\": [\"ProductImages\"]}}]',13,'aee2db4b0e9844eb9c21248145715231'),(216,'2025-08-07 17:24:14.032917','6b837085-4e6a-4f02-8313-72e6005615df','Matte Lipstick Set',2,'[{\"changed\": {\"fields\": [\"ProductImages\"]}}]',13,'aee2db4b0e9844eb9c21248145715231'),(217,'2025-08-07 17:26:07.596231','63b53392-693f-44db-aab3-1d2f0b5fc9ad','Image for 63b53392-693f-44db-aab3-1d2f0b5fc9ad',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(218,'2025-08-07 17:26:14.478515','6b837085-4e6a-4f02-8313-72e6005615df','Matte Lipstick Set',2,'[{\"changed\": {\"fields\": [\"ProductImages\"]}}]',13,'aee2db4b0e9844eb9c21248145715231'),(219,'2025-08-09 12:57:38.624154','e971a64b-a041-47bd-8df1-c5f8c82891fa','Image for e971a64b-a041-47bd-8df1-c5f8c82891fa',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(220,'2025-08-09 12:57:53.049661','e6cc8646-c91f-4347-8ab1-af8d016e257d','Image for e6cc8646-c91f-4347-8ab1-af8d016e257d',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(221,'2025-08-09 12:58:06.201336','0dde23d4-14de-44e3-be38-0a6e78e75221','Image for 0dde23d4-14de-44e3-be38-0a6e78e75221',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(222,'2025-08-09 13:01:00.434332','41939b01-41c4-4135-9173-3e74c8acac0b','USB Facial Gun',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(223,'2025-08-09 13:01:30.121663','961f178e-a333-414f-bd56-5a6406779786','Beauty Gadget',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(224,'2025-08-09 13:01:50.508478','8317c564-9941-4978-9fdf-c50c0dc300be','Skincare Massager',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(225,'2025-08-09 13:05:49.234876','e5ea60f3-ba83-46d6-80b7-0cdb7964a8a4','skin tightening device',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(226,'2025-08-09 13:06:45.453732','6eac28b9-3671-4370-b46f-0b40971735bd','USB Facial Gun – Portable Facial Massage & Skin Revitalization Tool',1,'[{\"added\": {}}]',16,'aee2db4b0e9844eb9c21248145715231'),(227,'2025-08-09 13:06:51.694514','f6070702-f97c-4714-850f-4338d72d43b6','USB Facial Gun',1,'[{\"added\": {}}]',13,'aee2db4b0e9844eb9c21248145715231'),(228,'2025-08-09 13:13:43.066133','d215bb2b-b3d5-4df0-ad94-4602891aff8f','Image for d215bb2b-b3d5-4df0-ad94-4602891aff8f',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(229,'2025-08-09 13:13:55.460175','f964534d-7bf5-4ffd-b763-210046471fe4','Image for f964534d-7bf5-4ffd-b763-210046471fe4',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(230,'2025-08-09 13:14:06.903025','e8bee89a-485f-46f6-929c-3f43f1709878','Image for e8bee89a-485f-46f6-929c-3f43f1709878',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(231,'2025-08-09 13:20:52.145376','e2b16e20-d83d-470a-b41c-98f74ef23c89','Minimalist Jewelry',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(232,'2025-08-09 13:21:13.995086','7ec76f50-f2e6-4512-96d0-3a11f34aadf5','Elegant Accessories',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(233,'2025-08-09 13:21:36.198153','5a72d0af-b5c5-4e62-8f7a-7c4f50096021','Daily Wear Jewelry',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(234,'2025-08-09 13:21:55.464704','5f5267d8-f75c-4a44-84fd-ded5f937a479','Fashion Necklace',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(235,'2025-08-09 13:22:13.618339','682e7262-b659-421b-8dfa-7fff13e982eb','Dainty Accessories',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(236,'2025-08-09 13:23:00.868605','a632e37a-523f-4c15-b2b0-9dd8930f2a38','Fashion',1,'[{\"added\": {}}]',11,'aee2db4b0e9844eb9c21248145715231'),(237,'2025-08-09 13:24:07.490596','e0750643-8929-4a6c-9249-a388b380b0c3','Jewellery',1,'[{\"added\": {}}]',8,'aee2db4b0e9844eb9c21248145715231'),(238,'2025-08-09 13:27:41.922915','21db9b51-809f-4ed7-932f-9c6ccfeff86b','Everyday Elegance',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(239,'2025-08-09 13:28:24.632625','656f1a7a-b58f-4a5b-8a4e-3732a882b9a8','Classic Fashion',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(240,'2025-08-09 13:31:30.841063','dee75266-aee7-4b34-85e7-486c9a6fec67','Necklace',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(241,'2025-08-09 13:36:21.721254','afa71f2c-2ea8-4ae1-a141-3cab40320965','925 Sterling Silver Simple Temperament Clavicle Necklace – Elegant Minimalist Jewelry',1,'[{\"added\": {}}]',16,'aee2db4b0e9844eb9c21248145715231'),(242,'2025-08-09 13:36:33.370478','7de361fc-dbd3-4ad7-bd6e-45f3a37af865','925 Sterling Silver Simple Temperament Clavicle Necklace',1,'[{\"added\": {}}]',13,'aee2db4b0e9844eb9c21248145715231'),(243,'2025-08-09 13:38:33.367963','72aac0bb-2e07-40a4-b293-ca93536a2c75','Car Accessories',2,'[{\"changed\": {\"fields\": [\"CollectionDescription\"]}}]',11,'aee2db4b0e9844eb9c21248145715231'),(244,'2025-08-09 13:39:27.853537','989829fd-7855-468a-ad68-bd7d99348746','Health & Beauty',2,'[{\"changed\": {\"fields\": [\"CollectionDescription\"]}}]',11,'aee2db4b0e9844eb9c21248145715231'),(245,'2025-08-09 13:39:57.489531','a0d3ab8a-7188-4e14-b907-dbd354109b18','Toys, Games & Babies',2,'[{\"changed\": {\"fields\": [\"CollectionDescription\"]}}]',11,'aee2db4b0e9844eb9c21248145715231'),(246,'2025-08-09 13:41:43.089199','a632e37a-523f-4c15-b2b0-9dd8930f2a38','Fashion',2,'[{\"changed\": {\"fields\": [\"CollectionDescription\"]}}]',11,'aee2db4b0e9844eb9c21248145715231'),(247,'2025-08-09 13:42:07.473211','b3ab91b1-aac3-4b8f-9cd7-4175c0038254','Home & Kitchen',2,'[{\"changed\": {\"fields\": [\"CollectionDescription\"]}}]',11,'aee2db4b0e9844eb9c21248145715231'),(248,'2025-08-09 13:42:55.224611','ccd6028b-fd79-43ae-833e-c04c05114577','Mobiles, Laptops & Wearables',2,'[{\"changed\": {\"fields\": [\"CollectionDescription\"]}}]',11,'aee2db4b0e9844eb9c21248145715231'),(249,'2025-08-09 13:43:19.149167','dfa0b385-d88c-4844-9c95-e85da83157ce','Fitness, Sports & Outdoors',2,'[{\"changed\": {\"fields\": [\"CollectionDescription\"]}}]',11,'aee2db4b0e9844eb9c21248145715231'),(250,'2025-08-09 13:45:55.629589','e52068a0-40c0-4013-945b-fc40ce3676f2','Image for e52068a0-40c0-4013-945b-fc40ce3676f2',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(251,'2025-08-09 13:46:14.497582','39f11b8c-62d5-432a-8d60-feff926bcae5','Image for 39f11b8c-62d5-432a-8d60-feff926bcae5',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(252,'2025-08-09 13:46:40.557620','569fa2ce-cf7c-44da-9dd8-52c98dcdc8ca','Image for 569fa2ce-cf7c-44da-9dd8-52c98dcdc8ca',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(253,'2025-08-09 13:48:32.726188','f3a57826-30a7-4336-925c-ec1109e26bb7','Vibe Sphere Headphones',2,'[{\"changed\": {\"fields\": [\"ProductImages\", \"ProductDescription\"]}}]',13,'aee2db4b0e9844eb9c21248145715231'),(254,'2025-08-09 14:01:40.798226','7cb5ee38-e6c4-4812-9f28-df2a9702954c','long-lasting lipstick',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(255,'2025-08-09 14:01:57.521024','503002f2-d23a-4e7c-a9d6-90b6baabad6e','matte lip color set',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(256,'2025-08-09 14:02:11.919732','282ed425-6853-4f46-8cfd-0a600c712864','lip makeup essentials',1,'[{\"added\": {}}]',7,'aee2db4b0e9844eb9c21248145715231'),(257,'2025-08-09 14:02:17.113624','b58f9dae-de03-49cb-8df9-9f420d82e796','Matte Lipstick Set – Long-Lasting, Highly Pigmented & Velvet Finish',1,'[{\"added\": {}}]',16,'aee2db4b0e9844eb9c21248145715231'),(258,'2025-08-09 14:02:24.249551','6b837085-4e6a-4f02-8313-72e6005615df','Matte Lipstick Set',2,'[{\"changed\": {\"fields\": [\"ProductDescription\", \"ProductSeo\"]}}]',13,'aee2db4b0e9844eb9c21248145715231'),(259,'2025-08-09 14:03:40.868537','136cf39d-a4d7-4faf-833e-6be995d0a293','VGR - Professional Grooming Kit For Men',3,'',13,'aee2db4b0e9844eb9c21248145715231'),(260,'2025-08-09 14:06:02.245053','c28e83ba-bce7-4dc4-8135-465fd35850bf','Spring Grip Men\'s Professional Exercise Arm Strength Home Fitness Equipment',2,'[{\"changed\": {\"fields\": [\"ProductDescription\"]}}]',13,'aee2db4b0e9844eb9c21248145715231'),(261,'2025-08-09 14:06:36.684317','67974bbb-bef6-4618-b76e-046931f7c8dc','Image for 67974bbb-bef6-4618-b76e-046931f7c8dc',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(262,'2025-08-09 14:06:58.410294','68b0e4c9-def9-4571-8987-f531c148bb40','Image for 68b0e4c9-def9-4571-8987-f531c148bb40',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(263,'2025-08-09 14:07:14.909965','562164aa-92ef-4b01-b16f-97695eb08fcf','Image for 562164aa-92ef-4b01-b16f-97695eb08fcf',1,'[{\"added\": {}}]',9,'aee2db4b0e9844eb9c21248145715231'),(264,'2025-08-09 14:08:54.772204','843c9455-ee71-4dcf-8195-44140c3731a9','Hoco - Center Console Car Holder (HW8)',2,'[{\"changed\": {\"fields\": [\"ProductImages\", \"ProductDescription\"]}}]',13,'aee2db4b0e9844eb9c21248145715231'),(265,'2025-08-09 14:11:04.198213','336e7bd1-7725-412f-9668-d3951ee08226','Vitamin C Body Oil (100ml)',2,'[{\"changed\": {\"fields\": [\"ProductDescription\"]}}]',13,'aee2db4b0e9844eb9c21248145715231'),(266,'2025-08-09 14:12:13.464233','7f69f2e1-73b8-4f36-b914-6f8e63ce30a2','UV Protection Refreshing Protective Cream Sunscreen Lotion',2,'[{\"changed\": {\"fields\": [\"ProductDescription\"]}}]',13,'aee2db4b0e9844eb9c21248145715231'),(267,'2025-08-09 14:15:26.001438','83832402-960e-48d5-b9dc-6171d34928fa','Electric Coffee Mug USB Rechargeable Automatic Magnetic Cup IP67 Waterproof Food-Safe Stainless Steel For Juice Tea Milksha Kitchen Gadgets',2,'[{\"changed\": {\"fields\": [\"ProductDescription\"]}}]',13,'aee2db4b0e9844eb9c21248145715231'),(268,'2025-08-09 14:18:44.019370','1cb8f5a7-8896-42ce-bdd0-5ec7e08023b8','Rabbit LED Night Light Silicone Animal Cartoon Dimmable Lamp USB Rechargeable For Children Kids Baby Gift Bedside Bedroom',2,'[{\"changed\": {\"fields\": [\"ProductDescription\"]}}]',13,'aee2db4b0e9844eb9c21248145715231'),(269,'2025-08-09 14:20:11.738684','16164e71-6e7b-4ac8-8be4-31e761db7021','Mini 2.4G Punk Wireless Keyboard',2,'[{\"changed\": {\"fields\": [\"ProductDescription\"]}}]',13,'aee2db4b0e9844eb9c21248145715231'),(270,'2025-08-09 15:11:38.116382','c64cb65e-2d30-4dd6-bdfe-563da3441dae','Image for c64cb65e-2d30-4dd6-bdfe-563da3441dae',1,'[{\"added\": {}}]',9,'4d47bbb4c6c04cbbb22b5b3517b7d3cb'),(271,'2025-08-09 15:11:46.140400','1423741a-eb6a-43cd-a71b-da6e3c281002','Image for 1423741a-eb6a-43cd-a71b-da6e3c281002',1,'[{\"added\": {}}]',9,'4d47bbb4c6c04cbbb22b5b3517b7d3cb'),(272,'2025-08-09 15:11:53.302116','710e5fb8-1db0-4a55-aa60-c88b60d70f36','Image for 710e5fb8-1db0-4a55-aa60-c88b60d70f36',1,'[{\"added\": {}}]',9,'4d47bbb4c6c04cbbb22b5b3517b7d3cb'),(273,'2025-08-09 15:12:00.932326','4408fa6a-89eb-4320-a227-dc33edf19df7','Image for 4408fa6a-89eb-4320-a227-dc33edf19df7',1,'[{\"added\": {}}]',9,'4d47bbb4c6c04cbbb22b5b3517b7d3cb'),(274,'2025-08-09 15:13:59.869897','fd0e97c5-0c19-4262-9a5b-9fc3eafa31e4','Portable Electric Air Pump',1,'[{\"added\": {}}]',13,'4d47bbb4c6c04cbbb22b5b3517b7d3cb'),(275,'2025-08-09 15:15:37.950315','4c4a5cfc-af28-4647-ac8f-136f6bc9c544','Image for 4c4a5cfc-af28-4647-ac8f-136f6bc9c544',1,'[{\"added\": {}}]',9,'4d47bbb4c6c04cbbb22b5b3517b7d3cb'),(276,'2025-08-09 15:15:47.347158','876445a3-4861-4440-a88d-634a1d72e3d1','Image for 876445a3-4861-4440-a88d-634a1d72e3d1',1,'[{\"added\": {}}]',9,'4d47bbb4c6c04cbbb22b5b3517b7d3cb'),(277,'2025-08-09 15:15:57.955882','817eb606-e9d2-4c80-9be1-1edfe1612dd1','Image for 817eb606-e9d2-4c80-9be1-1edfe1612dd1',1,'[{\"added\": {}}]',9,'4d47bbb4c6c04cbbb22b5b3517b7d3cb'),(278,'2025-08-09 15:16:06.387319','784ec995-8591-4ded-a54f-2f79c7d0dc3b','Image for 784ec995-8591-4ded-a54f-2f79c7d0dc3b',1,'[{\"added\": {}}]',9,'4d47bbb4c6c04cbbb22b5b3517b7d3cb'),(279,'2025-08-09 15:19:04.190737','f7ae91f9-5fcc-4801-a2f6-da2dd9895f58','Car Cup Holder With Wireless Charging',1,'[{\"added\": {}}]',13,'4d47bbb4c6c04cbbb22b5b3517b7d3cb'),(280,'2025-08-09 15:20:09.999348','4c0dd049-7795-42ad-b562-970ea412b137','Image for 4c0dd049-7795-42ad-b562-970ea412b137',1,'[{\"added\": {}}]',9,'4d47bbb4c6c04cbbb22b5b3517b7d3cb'),(281,'2025-08-09 15:20:35.477086','bbb39dd3-ec86-4a8b-9e4a-9afe3667c83f','Care Care products',1,'[{\"added\": {}}]',8,'4d47bbb4c6c04cbbb22b5b3517b7d3cb'),(282,'2025-08-09 15:21:52.471614','47a080e8-e5df-4c39-8646-eaef99402857','Leather Repair Cream',1,'[{\"added\": {}}]',13,'4d47bbb4c6c04cbbb22b5b3517b7d3cb'),(283,'2025-08-09 15:24:44.965384','4bb57c3b-bea0-43db-a363-d226aa8d2472','Image for 4bb57c3b-bea0-43db-a363-d226aa8d2472',1,'[{\"added\": {}}]',9,'4d47bbb4c6c04cbbb22b5b3517b7d3cb'),(284,'2025-08-09 15:24:53.953086','7d33ed7f-8504-44e3-a236-fed41b6d909b','Image for 7d33ed7f-8504-44e3-a236-fed41b6d909b',1,'[{\"added\": {}}]',9,'4d47bbb4c6c04cbbb22b5b3517b7d3cb'),(285,'2025-08-09 15:25:01.858198','c1deadf0-c488-4d67-b925-06cafe01b6af','Image for c1deadf0-c488-4d67-b925-06cafe01b6af',1,'[{\"added\": {}}]',9,'4d47bbb4c6c04cbbb22b5b3517b7d3cb'),(286,'2025-08-09 15:25:11.207735','fc1ba72c-af47-4e7c-b5f3-eee8d380d213','Image for fc1ba72c-af47-4e7c-b5f3-eee8d380d213',1,'[{\"added\": {}}]',9,'4d47bbb4c6c04cbbb22b5b3517b7d3cb'),(287,'2025-08-09 15:25:13.362301','452cb121-51d7-4173-b15d-4a5268512977','Rayhong - Car scratch Removel Wax',1,'[{\"added\": {}}]',13,'4d47bbb4c6c04cbbb22b5b3517b7d3cb'),(288,'2025-08-09 15:30:36.698207','af84edac-8e60-4e1b-8219-e60480fc7c24','Samsung Z FOLD2 Flip Split Two-in-one Multi-Function Phone Case',2,'[{\"changed\": {\"fields\": [\"ProductDescription\"]}}]',13,'aee2db4b0e9844eb9c21248145715231');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(6,'core_a','customuser'),(20,'core_b','blogpost'),(19,'core_b','category'),(21,'core_b','comments'),(18,'core_b','tags'),(22,'core_p','discount'),(23,'core_p','discountusage'),(14,'core_p','inventory'),(15,'core_p','inventoryhistory'),(7,'core_p','pctags'),(13,'core_p','product'),(8,'core_p','productcategory'),(11,'core_p','productcollection'),(9,'core_p','productimageschema'),(16,'core_p','productmeta'),(17,'core_p','productreview'),(10,'core_p','productshipping'),(12,'core_p','productvariant'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-08-02 18:34:31.231747'),(2,'contenttypes','0002_remove_content_type_name','2025-08-02 18:34:32.952114'),(3,'auth','0001_initial','2025-08-02 18:34:36.610431'),(4,'auth','0002_alter_permission_name_max_length','2025-08-02 18:34:37.622801'),(5,'auth','0003_alter_user_email_max_length','2025-08-02 18:34:37.957548'),(6,'auth','0004_alter_user_username_opts','2025-08-02 18:34:38.234926'),(7,'auth','0005_alter_user_last_login_null','2025-08-02 18:34:38.728832'),(8,'auth','0006_require_contenttypes_0002','2025-08-02 18:34:38.951634'),(9,'auth','0007_alter_validators_add_error_messages','2025-08-02 18:34:39.181649'),(10,'auth','0008_alter_user_username_max_length','2025-08-02 18:34:39.413128'),(11,'auth','0009_alter_user_last_name_max_length','2025-08-02 18:34:39.638890'),(12,'auth','0010_alter_group_name_max_length','2025-08-02 18:34:40.154977'),(13,'auth','0011_update_proxy_permissions','2025-08-02 18:34:41.121856'),(14,'auth','0012_alter_user_first_name_max_length','2025-08-02 18:34:41.437684'),(15,'core_a','0001_initial','2025-08-02 18:34:45.629460'),(16,'admin','0001_initial','2025-08-02 18:34:47.495179'),(17,'admin','0002_logentry_remove_auto_add','2025-08-02 18:34:47.724277'),(18,'admin','0003_logentry_add_action_flag_choices','2025-08-02 18:34:47.949824'),(19,'core_p','0001_initial','2025-08-02 18:35:02.186695'),(20,'core_p','0002_remove_product_productmetadescription_and_more','2025-08-02 18:35:03.684599'),(21,'core_p','0003_alter_product_productcompareprice_and_more','2025-08-02 18:35:05.747435'),(22,'core_p','0004_alter_product_productimages','2025-08-02 18:35:06.014519'),(23,'core_p','0005_inventory_inventoryhistory','2025-08-02 18:35:08.369225'),(24,'core_p','0006_productmeta_and_more','2025-08-02 18:35:11.645254'),(25,'core_p','0007_remove_product_productrating_and_more','2025-08-02 18:35:14.783599'),(26,'core_p','0008_alter_pctags_id_alter_productcategory_id_and_more','2025-08-02 18:35:27.322618'),(27,'sessions','0001_initial','2025-08-02 18:35:28.324765'),(28,'core_p','0009_product_productisbestselling_and_more','2025-08-03 18:22:53.877663'),(29,'core_p','0010_product_productisforsubscription','2025-08-03 19:22:47.285188'),(30,'core_p','0011_productcollection_collectionslug','2025-08-04 15:33:07.467951'),(31,'core_p','0012_alter_productcollection_collectionslug','2025-08-04 16:13:36.410217'),(32,'core_p','0013_remove_productmeta_metakeywords_and_more','2025-08-06 12:06:02.221789'),(33,'core_p','0014_remove_product_productdescription','2025-08-09 05:24:32.976146'),(34,'core_p','0015_product_productdescription','2025-08-09 05:38:01.336042'),(35,'core_p','0016_alter_product_productdescription','2025-08-09 10:05:31.728011'),(36,'core_b','0001_initial','2025-08-09 10:07:55.485242'),(37,'core_b','0002_alter_blogpost_blogimage_alter_blogpost_slug','2025-08-09 10:11:10.619090'),(38,'core_p','0013_alter_product_productdescription_and_more','2025-08-09 10:48:34.570656'),(39,'core_p','0017_merge_20250809_1048','2025-08-09 10:48:34.590413'),(40,'core_p','0014_discount_discountusage_and_more','2025-08-10 04:58:27.044369'),(41,'core_p','0018_merge_20250810_0458','2025-08-10 04:58:27.058488');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('7nogyud8mbrv90rq6tc9pp61dwc4ha6r','.eJxVzMsOwiAQheF3YW3JAAMDLt37DA0zUFs1bdLLyvju2qQLXZ__Oy_V5m3t222pczsUdVaB0VlwtrEUTIOBpYkVYmPQVcxGEgGp0y_jLI867rbc83ibtEzjOg-s90Qf66KvU6nPy9H-HfR56b-6I_QiJTnimHwp1gAyR4clMpDHxJ6lE08SgqkA5CBSNMWih5qwqvcHRQ0_mQ:1uiblg:JWd1dwbxsDh6nKbjxQ9_NE4tcDkenrBSf4nQ-h7Smn0','2025-08-17 16:41:04.754191'),('cyj38oob7th01sew6tahsycdt85ubpiy','.eJxVzMsOwiAQheF3YW3JAAMDLt37DA0zUFs1bdLLyvju2qQLXZ__Oy_V5m3t222pczsUdVaB0VlwtrEUTIOBpYkVYmPQVcxGEgGp0y_jLI867rbc83ibtEzjOg-s90Qf66KvU6nPy9H-HfR56b-6I_QiJTnimHwp1gAyR4clMpDHxJ6lE08SgqkA5CBSNMWih5qwqvcHRQ0_mQ:1uiTgq:aIHOtggY2Wx96RHTUfKpiPgJlHHrtzbo-OOF5p-0PG8','2025-08-17 08:03:32.463129'),('e1o4e4kzb87l70ledmnozlt7fxc9qxwd','.eJxVjTkOwjAURO_iGlvxjinpOUP059smAZRIWSrE3UmkFDDtvDfzFi2tS9euc5naPouLcNlFAE5y4EY6BiSMgfSwXkfEbBni9KuB-FmG3c0PGu6j4nFYph5qR9TRzuo25vK6HuzfQEdzt9nbYaZkAO2ri2S15pq2nFO151yLNSaBKjXOBNhiiwkeZMHcUKg-ic8XfWhCgQ:1uiyzx:qmoeEAr3RHnmlMaKE93CN_8DfJD0noLBU2qhUtPppeA','2025-08-18 17:29:21.743785'),('g9uhgp39mrl6u4sycgmtt70x4u0w50pf','.eJxVjTkOwjAURO_iGlvxjinpOUP059smAZRIWSrE3UmkFDDtvDfzFi2tS9euc5naPouLcNlFAE5y4EY6BiSMgfSwXkfEbBni9KuB-FmG3c0PGu6j4nFYph5qR9TRzuo25vK6HuzfQEdzt9nbYaZkAO2ri2S15pq2nFO151yLNSaBKjXOBNhiiwkeZMHcUKg-ic8XfWhCgQ:1ukl8A:w1NdgqZAOr0U0Ybirn-4Gner2zZqZzdCh9v-_wrBKNY','2025-08-23 15:05:10.518812'),('kysq5hlfsa19n8k6fxb9pks3w3ca1ywe','.eJxVjDkOwjAQRe_imljex0NJzxmi8YxDWJRIWSrE3UmkFFD94r3336qldenbda5Texd1VpAo2ki1CdlTE0qwDebMjQGfGWwBh1mdfrNC_KzD3sqDhtuoeRyW6V70ruiDzvo6Sn1dDvfvoKe53-rkOg_iXEYyneeILLkWBjSIwAmClYTZRCuGxJENkrYVLClEXzGozxd0JEAY:1ukQv8:c_odi2KumDcpQeuCHpbrjlM-srT0YJdHkgL91QMeQ8A','2025-08-22 17:30:22.085355'),('ofwz4rhdvzenqea50lk326qn2ipu505y','.eJxVzMsOwiAQheF3YW3JAAMDLt37DA0zUFs1bdLLyvju2qQLXZ__Oy_V5m3t222pczsUdVaB0VlwtrEUTIOBpYkVYmPQVcxGEgGp0y_jLI867rbc83ibtEzjOg-s90Qf66KvU6nPy9H-HfR56b-6I_QiJTnimHwp1gAyR4clMpDHxJ6lE08SgqkA5CBSNMWih5qwqvcHRQ0_mQ:1uiWE6:m8bWHkbIWzdTsXdqy3Dsgy4ebLHqUw2gSEwyP9K-HIs','2025-08-17 10:46:02.088485'),('p70j5goo4qmdboku2u72yycqd3xg3u56','.eJxVzMsOwiAQheF3YW3JAAMDLt37DA0zUFs1bdLLyvju2qQLXZ__Oy_V5m3t222pczsUdVaB0VlwtrEUTIOBpYkVYmPQVcxGEgGp0y_jLI867rbc83ibtEzjOg-s90Qf66KvU6nPy9H-HfR56b-6I_QiJTnimHwp1gAyR4clMpDHxJ6lE08SgqkA5CBSNMWih5qwqvcHRQ0_mQ:1ujLYW:xCdfQxBJLup7Kgi6xm340hUIeYzvC_CUWn__Sa9nQdg','2025-08-19 17:34:32.959677'),('pr90325j6pb1wudvhypmhgb8mcywlibx','.eJxVzDkOwjAQheG7uCaWxx5vlPScIfJ4xoRFiZSlQtwdRUoB9fu_91Z92dah3xaZ-zursyoilgmpM5JThyjU5Wqhs5gAfQRvHajTL6NSnzLulh9lvE26TuM630nviT7WRV8nltflaP8OhrIMu3Zg2KCtLREBYpWADL42Khx9gMCuCQswQTTBReGSMIdMGbjkBurzBdelQWY:1uiHEd:qjr0emNTMr_YgXDui4oUJ9TNuphAs-VfD5c51GbYSQk','2025-08-16 18:45:35.089293'),('seolg53jwfdwjo0h2v4z8r2onxvv9pki','.eJxVjTsOwjAQBe_iGltr7zq2Kek5Q7S2NySAEimfCnF3iJQC6jfz5qVa3ta-3RaZ26Gqs2IRVzNlDZKiJpKsU3FWO4qWfLDeoVWnXy1zeci4u_XO420yZRrXechmR8yxLuY6VXleDvbvoOel38sVHYCzmL6NSAkYsItdkwhKwSQgVBrAiL7UEDOnHLwPaD054gCi3h-JJT9T:1uibbK:PkW4m2BKtNGX15ZSRhy7CP0U4XgOOIau0RAF7tSuAPo','2025-08-17 16:30:22.513691'),('wsooeh985lis11c1lzdx0k558uzmuwu0','.eJxVzMsOwiAQheF3YW3JAAMDLt37DA0zUFs1bdLLyvju2qQLXZ__Oy_V5m3t222pczsUdVaB0VlwtrEUTIOBpYkVYmPQVcxGEgGp0y_jLI867rbc83ibtEzjOg-s90Qf66KvU6nPy9H-HfR56b-6I_QiJTnimHwp1gAyR4clMpDHxJ6lE08SgqkA5CBSNMWih5qwqvcHRQ0_mQ:1ujIyV:7A8ko0JS0ncnD3l5Zb6yeTut-AFjWmj-u0WDo08_93Y','2025-08-19 14:49:11.886639'),('xyjswyryl0g6lnp9ocrmh33wci9ki5ua','.eJxVjTsOwjAQBe_iGltr7zq2Kek5Q7S2NySAEimfCnF3iJQC6jfz5qVa3ta-3RaZ26Gqs2IRVzNlDZKiJpKsU3FWO4qWfLDeoVWnXy1zeci4u_XO420yZRrXechmR8yxLuY6VXleDvbvoOel38sVHYCzmL6NSAkYsItdkwhKwSQgVBrAiL7UEDOnHLwPaD054gCi3h-JJT9T:1ujWzV:DMYmYLk7YEhgAfhLgdwMFi773yYCfRL9CltuHw2JFZQ','2025-08-20 05:47:09.711788');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-10  7:20:48
