-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 10, 2023 at 03:43 PM
-- Server version: 5.7.36
-- PHP Version: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `itemezepro`
--

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
CREATE TABLE IF NOT EXISTS `companies` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `tin_number` int(11) DEFAULT NULL,
  `address_line` varchar(100) NOT NULL,
  `created_by` int(11) NOT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `reference` varchar(20) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `name`, `phone`, `email`, `tin_number`, `address_line`, `created_by`, `logo`, `created_at`, `deleted_at`, `updated_at`, `reference`, `status`) VALUES
(1, 'Polyclinic de le etoile', '781418920', 'etoile@gmail.com', 123456789, 'Gasabo', 1, NULL, '2023-06-30 16:05:37', NULL, '2023-06-30 16:05:37', '4510393743BC9BE61372', 1);

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
CREATE TABLE IF NOT EXISTS `departments` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `leader_id` int(10) UNSIGNED DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `company_id`, `name`, `description`, `leader_id`, `status`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Nursing', NULL, NULL, 1, 2, '2023-07-03 09:21:46', '2023-07-03 09:21:46', NULL),
(2, 1, 'Corporate', NULL, 7, 1, 2, '2023-07-05 13:39:44', '2023-07-05 13:39:44', NULL),
(3, 1, 'Laboratory', NULL, 5, 1, 2, '2023-07-06 07:23:05', '2023-07-06 07:23:05', NULL),
(4, 1, 'Stock Admin', NULL, 3, 1, 2, '2023-07-06 07:23:45', '2023-07-06 07:23:45', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

DROP TABLE IF EXISTS `expenses`;
CREATE TABLE IF NOT EXISTS `expenses` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `amount` bigint(20) NOT NULL,
  `payment_method` bigint(20) NOT NULL,
  `created_by` bigint(20) NOT NULL,
  `committed_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

DROP TABLE IF EXISTS `expense_categories`;
CREATE TABLE IF NOT EXISTS `expense_categories` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `insurances`
--

DROP TABLE IF EXISTS `insurances`;
CREATE TABLE IF NOT EXISTS `insurances` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `group_ref` enum('RHIA','PRIVATE','INTERNATIONAL','OTHER') NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `discount` double UNSIGNED DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('6c8ffb38-fc71-4f49-a826-d21a5200ce89', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 2, '{\"id\":\"6c8ffb38-fc71-4f49-a826-d21a5200ce89\",\"notification\":{\"id\":2,\"slug\":\"28U1B7KWL89WKWW0OC\",\"type\":\"Requisition\",\"message\":\"New Requisition from <b>Laboratory<\\/b> of <b>2<\\/b> items created by <b>SAKINDI SAMUEL<\\/b>\"}}', NULL, '2023-07-07 11:55:45', '2023-07-07 11:55:45'),
('16860cd4-9888-4a8b-80bf-9e513b25f3d5', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 3, '{\"id\":\"16860cd4-9888-4a8b-80bf-9e513b25f3d5\",\"notification\":{\"id\":2,\"slug\":\"28U1B7KWL89WKWW0OC\",\"type\":\"Requisition\",\"message\":\"New Requisition from <b>Laboratory<\\/b> of <b>2<\\/b> items created by <b>SAKINDI SAMUEL<\\/b>\"}}', '2023-07-07 11:56:34', '2023-07-07 11:55:45', '2023-07-07 11:56:34'),
('44e13221-1abd-4a44-93b6-5d1a364450c6', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 4, '{\"id\":\"44e13221-1abd-4a44-93b6-5d1a364450c6\",\"notification\":{\"id\":2,\"slug\":\"28U1B7KWL89WKWW0OC\",\"type\":\"Requisition\",\"message\":\"New Requisition from <b>Laboratory<\\/b> of <b>2<\\/b> items created by <b>SAKINDI SAMUEL<\\/b>\"}}', NULL, '2023-07-07 11:55:45', '2023-07-07 11:55:45'),
('e19679b5-dadc-49a3-a477-1001b772354f', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 6, '{\"id\":\"e19679b5-dadc-49a3-a477-1001b772354f\",\"notification\":{\"id\":2,\"slug\":\"28U1B7KWL89WKWW0OC\",\"type\":\"Requisition\",\"message\":\"New Requisition from <b>Laboratory<\\/b> of <b>2<\\/b> items created by <b>SAKINDI SAMUEL<\\/b>\"}}', '2023-07-08 09:19:13', '2023-07-07 11:55:45', '2023-07-08 09:19:13'),
('48cf7e6a-2c2d-4299-b861-a83bee077362', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 7, '{\"id\":\"48cf7e6a-2c2d-4299-b861-a83bee077362\",\"notification\":{\"id\":2,\"slug\":\"28U1B7KWL89WKWW0OC\",\"type\":\"Requisition\",\"message\":\"New Requisition from <b>Laboratory<\\/b> of <b>2<\\/b> items created by <b>SAKINDI SAMUEL<\\/b>\"}}', NULL, '2023-07-07 11:55:46', '2023-07-07 11:55:46'),
('3265135e-b6a1-4b0a-9052-9758ca368e1c', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 2, '{\"id\":\"3265135e-b6a1-4b0a-9052-9758ca368e1c\",\"notification\":{\"id\":3,\"slug\":\"18TN7WN4N4F4GSGK8G\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>3<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 10:08:31', '2023-07-10 10:08:31'),
('589b4cd0-927f-4344-909b-5bab7f697aab', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 4, '{\"id\":\"589b4cd0-927f-4344-909b-5bab7f697aab\",\"notification\":{\"id\":3,\"slug\":\"18TN7WN4N4F4GSGK8G\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>3<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 10:08:31', '2023-07-10 10:08:31'),
('c4048679-3906-4b35-8d78-c4be304041f5', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 5, '{\"id\":\"c4048679-3906-4b35-8d78-c4be304041f5\",\"notification\":{\"id\":3,\"slug\":\"18TN7WN4N4F4GSGK8G\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>3<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 10:08:31', '2023-07-10 10:08:31'),
('3d5759d1-bdbc-45d2-a8dc-116173bf6a94', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 6, '{\"id\":\"3d5759d1-bdbc-45d2-a8dc-116173bf6a94\",\"notification\":{\"id\":3,\"slug\":\"18TN7WN4N4F4GSGK8G\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>3<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 10:08:31', '2023-07-10 10:08:31'),
('e072736d-a4b4-4f96-9c8d-7b138044ddf2', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 7, '{\"id\":\"e072736d-a4b4-4f96-9c8d-7b138044ddf2\",\"notification\":{\"id\":3,\"slug\":\"18TN7WN4N4F4GSGK8G\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>3<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 10:08:31', '2023-07-10 10:08:31'),
('6fa45c79-9c99-403e-8e00-e52220bcefd6', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 2, '{\"id\":\"6fa45c79-9c99-403e-8e00-e52220bcefd6\",\"notification\":{\"id\":4,\"slug\":\"4WLOUIEOPGYS40C\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>2<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 11:42:29', '2023-07-10 11:42:29'),
('cf340343-7367-4f87-9e83-2fb60ad481af', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 4, '{\"id\":\"cf340343-7367-4f87-9e83-2fb60ad481af\",\"notification\":{\"id\":4,\"slug\":\"4WLOUIEOPGYS40C\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>2<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 11:42:29', '2023-07-10 11:42:29'),
('fbe4a186-b6e9-4187-a823-dd44f8b2b6f0', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 5, '{\"id\":\"fbe4a186-b6e9-4187-a823-dd44f8b2b6f0\",\"notification\":{\"id\":4,\"slug\":\"4WLOUIEOPGYS40C\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>2<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 11:42:29', '2023-07-10 11:42:29'),
('7ab07ce3-c8e8-4855-b849-2378b9529371', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 6, '{\"id\":\"7ab07ce3-c8e8-4855-b849-2378b9529371\",\"notification\":{\"id\":4,\"slug\":\"4WLOUIEOPGYS40C\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>2<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 11:42:29', '2023-07-10 11:42:29'),
('cd24f7e3-3b44-4427-bcb9-9e964080d3dc', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 7, '{\"id\":\"cd24f7e3-3b44-4427-bcb9-9e964080d3dc\",\"notification\":{\"id\":4,\"slug\":\"4WLOUIEOPGYS40C\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>2<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 11:42:29', '2023-07-10 11:42:29'),
('e2c088b5-ea56-46d7-bbef-fd508a9af470', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 2, '{\"id\":\"e2c088b5-ea56-46d7-bbef-fd508a9af470\",\"notification\":{\"id\":5,\"slug\":\"26FT0M3RJWKGO8C8CK\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>3<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 12:04:37', '2023-07-10 12:04:37'),
('defb7f6f-329e-4a82-973b-1567abee5c84', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 4, '{\"id\":\"defb7f6f-329e-4a82-973b-1567abee5c84\",\"notification\":{\"id\":5,\"slug\":\"26FT0M3RJWKGO8C8CK\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>3<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 12:04:37', '2023-07-10 12:04:37'),
('193074af-2cb8-4e31-ad04-59a6e720c111', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 5, '{\"id\":\"193074af-2cb8-4e31-ad04-59a6e720c111\",\"notification\":{\"id\":5,\"slug\":\"26FT0M3RJWKGO8C8CK\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>3<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 12:04:37', '2023-07-10 12:04:37'),
('d7e2cc6f-2e56-47dc-96bc-e4c4449319e6', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 6, '{\"id\":\"d7e2cc6f-2e56-47dc-96bc-e4c4449319e6\",\"notification\":{\"id\":5,\"slug\":\"26FT0M3RJWKGO8C8CK\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>3<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 12:04:37', '2023-07-10 12:04:37'),
('fa35c5f7-82a3-4e43-8681-d0bb7aae62d6', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 7, '{\"id\":\"fa35c5f7-82a3-4e43-8681-d0bb7aae62d6\",\"notification\":{\"id\":5,\"slug\":\"26FT0M3RJWKGO8C8CK\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>3<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 12:04:37', '2023-07-10 12:04:37'),
('d03328d6-38e3-4480-847a-c5a4bdcfb263', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 2, '{\"id\":\"d03328d6-38e3-4480-847a-c5a4bdcfb263\",\"notification\":{\"id\":6,\"slug\":\"3VKW8Z2A55Q8W0K4W\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 12:37:58', '2023-07-10 12:37:58'),
('3965d17a-427c-4878-bdf6-64bd535c6cfb', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 4, '{\"id\":\"3965d17a-427c-4878-bdf6-64bd535c6cfb\",\"notification\":{\"id\":6,\"slug\":\"3VKW8Z2A55Q8W0K4W\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 12:37:58', '2023-07-10 12:37:58'),
('f0fa7119-432a-42ce-8f8c-916c5cf6eb7a', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 5, '{\"id\":\"f0fa7119-432a-42ce-8f8c-916c5cf6eb7a\",\"notification\":{\"id\":6,\"slug\":\"3VKW8Z2A55Q8W0K4W\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 12:37:58', '2023-07-10 12:37:58'),
('77c94a79-e700-49fb-aed8-e7aab6516638', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 6, '{\"id\":\"77c94a79-e700-49fb-aed8-e7aab6516638\",\"notification\":{\"id\":6,\"slug\":\"3VKW8Z2A55Q8W0K4W\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 12:37:58', '2023-07-10 12:37:58'),
('8cbd1c79-505d-4b8a-9332-af0251f6d510', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 7, '{\"id\":\"8cbd1c79-505d-4b8a-9332-af0251f6d510\",\"notification\":{\"id\":6,\"slug\":\"3VKW8Z2A55Q8W0K4W\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 12:37:59', '2023-07-10 12:37:59'),
('a3bce5a5-50d2-43b1-a8b3-711c1ebe6299', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 2, '{\"id\":\"a3bce5a5-50d2-43b1-a8b3-711c1ebe6299\",\"notification\":{\"id\":7,\"slug\":\"1PQRQW0AOL3448OKWG\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 12:59:20', '2023-07-10 12:59:20'),
('9df5b231-95e1-4fe3-a127-6c64ff6e670d', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 4, '{\"id\":\"9df5b231-95e1-4fe3-a127-6c64ff6e670d\",\"notification\":{\"id\":7,\"slug\":\"1PQRQW0AOL3448OKWG\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 12:59:20', '2023-07-10 12:59:20'),
('bd29af35-b6da-476d-9498-d8beec33d55d', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 5, '{\"id\":\"bd29af35-b6da-476d-9498-d8beec33d55d\",\"notification\":{\"id\":7,\"slug\":\"1PQRQW0AOL3448OKWG\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 12:59:20', '2023-07-10 12:59:20'),
('256399d1-fac4-4bff-b3c0-59cc9b948e3b', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 6, '{\"id\":\"256399d1-fac4-4bff-b3c0-59cc9b948e3b\",\"notification\":{\"id\":7,\"slug\":\"1PQRQW0AOL3448OKWG\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 12:59:20', '2023-07-10 12:59:20'),
('db1bc349-0519-4069-af74-ac01eda0b69d', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 7, '{\"id\":\"db1bc349-0519-4069-af74-ac01eda0b69d\",\"notification\":{\"id\":7,\"slug\":\"1PQRQW0AOL3448OKWG\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 12:59:20', '2023-07-10 12:59:20'),
('6dca53ad-45aa-46d9-a10c-c68abdc44339', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 2, '{\"id\":\"6dca53ad-45aa-46d9-a10c-c68abdc44339\",\"notification\":{\"id\":8,\"slug\":\"M30SM1OS4HS40SK84\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:01:34', '2023-07-10 13:01:34'),
('4f13dd8c-4468-43a5-888a-c66904c1d5bc', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 4, '{\"id\":\"4f13dd8c-4468-43a5-888a-c66904c1d5bc\",\"notification\":{\"id\":8,\"slug\":\"M30SM1OS4HS40SK84\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:01:34', '2023-07-10 13:01:34'),
('804737ae-cfea-48d4-a368-44fb657933ef', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 5, '{\"id\":\"804737ae-cfea-48d4-a368-44fb657933ef\",\"notification\":{\"id\":8,\"slug\":\"M30SM1OS4HS40SK84\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:01:34', '2023-07-10 13:01:34'),
('d0e0eca0-2a5e-4e25-b209-7a944cea5a28', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 6, '{\"id\":\"d0e0eca0-2a5e-4e25-b209-7a944cea5a28\",\"notification\":{\"id\":8,\"slug\":\"M30SM1OS4HS40SK84\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:01:34', '2023-07-10 13:01:34'),
('bf63f557-305d-4d80-8ea9-04e865a385bf', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 7, '{\"id\":\"bf63f557-305d-4d80-8ea9-04e865a385bf\",\"notification\":{\"id\":8,\"slug\":\"M30SM1OS4HS40SK84\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:01:34', '2023-07-10 13:01:34'),
('09add2a4-5f9f-4461-90fb-ef377964152f', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 2, '{\"id\":\"09add2a4-5f9f-4461-90fb-ef377964152f\",\"notification\":{\"id\":9,\"slug\":\"MDPF2OU6Y2O008W04\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:10:57', '2023-07-10 13:10:57'),
('da39a057-77ba-4049-bbcc-46bb64358e7b', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 4, '{\"id\":\"da39a057-77ba-4049-bbcc-46bb64358e7b\",\"notification\":{\"id\":9,\"slug\":\"MDPF2OU6Y2O008W04\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:10:57', '2023-07-10 13:10:57'),
('f3d9aca4-a070-492e-bdc9-c8fce4845c81', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 5, '{\"id\":\"f3d9aca4-a070-492e-bdc9-c8fce4845c81\",\"notification\":{\"id\":9,\"slug\":\"MDPF2OU6Y2O008W04\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:10:57', '2023-07-10 13:10:57'),
('4b50006c-bb3e-4688-9a65-5668995535d8', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 6, '{\"id\":\"4b50006c-bb3e-4688-9a65-5668995535d8\",\"notification\":{\"id\":9,\"slug\":\"MDPF2OU6Y2O008W04\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:10:57', '2023-07-10 13:10:57'),
('dbc7faf9-a3f2-45b7-b8a5-2dffc351ac96', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 7, '{\"id\":\"dbc7faf9-a3f2-45b7-b8a5-2dffc351ac96\",\"notification\":{\"id\":9,\"slug\":\"MDPF2OU6Y2O008W04\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:10:57', '2023-07-10 13:10:57'),
('27f31be4-9669-4843-93e4-3698a0e699d8', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 2, '{\"id\":\"27f31be4-9669-4843-93e4-3698a0e699d8\",\"notification\":{\"id\":10,\"slug\":\"1LBTPYZG4O5CW8SC4O\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:12:54', '2023-07-10 13:12:54'),
('62e88bc9-e0cf-4127-b3c9-86a534541115', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 4, '{\"id\":\"62e88bc9-e0cf-4127-b3c9-86a534541115\",\"notification\":{\"id\":10,\"slug\":\"1LBTPYZG4O5CW8SC4O\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:12:54', '2023-07-10 13:12:54'),
('a7a435cd-98f9-45dd-a0d3-ad3d98e7220d', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 5, '{\"id\":\"a7a435cd-98f9-45dd-a0d3-ad3d98e7220d\",\"notification\":{\"id\":10,\"slug\":\"1LBTPYZG4O5CW8SC4O\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:12:54', '2023-07-10 13:12:54'),
('60187fe7-278d-47cd-a2aa-4704ee357769', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 6, '{\"id\":\"60187fe7-278d-47cd-a2aa-4704ee357769\",\"notification\":{\"id\":10,\"slug\":\"1LBTPYZG4O5CW8SC4O\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:12:54', '2023-07-10 13:12:54'),
('3a6fad1f-7d64-4c96-99e9-9c0eac7d92b5', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 7, '{\"id\":\"3a6fad1f-7d64-4c96-99e9-9c0eac7d92b5\",\"notification\":{\"id\":10,\"slug\":\"1LBTPYZG4O5CW8SC4O\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:12:54', '2023-07-10 13:12:54'),
('fc41d670-9daa-4b49-baeb-ddb08e1e06f3', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 2, '{\"id\":\"fc41d670-9daa-4b49-baeb-ddb08e1e06f3\",\"notification\":{\"id\":1,\"slug\":\"1KO75LUEE6QS848KSO\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>2<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:24:54', '2023-07-10 13:24:54'),
('2e9a2e85-3d5a-4a7e-bbdf-c3ca5da6cf54', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 4, '{\"id\":\"2e9a2e85-3d5a-4a7e-bbdf-c3ca5da6cf54\",\"notification\":{\"id\":1,\"slug\":\"1KO75LUEE6QS848KSO\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>2<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:24:54', '2023-07-10 13:24:54'),
('e5580375-3be0-4305-910d-34612299e354', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 5, '{\"id\":\"e5580375-3be0-4305-910d-34612299e354\",\"notification\":{\"id\":1,\"slug\":\"1KO75LUEE6QS848KSO\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>2<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:24:54', '2023-07-10 13:24:54'),
('ca9eb9ce-6b51-44ea-8927-acd31eb1b7bb', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 6, '{\"id\":\"ca9eb9ce-6b51-44ea-8927-acd31eb1b7bb\",\"notification\":{\"id\":1,\"slug\":\"1KO75LUEE6QS848KSO\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>2<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:24:54', '2023-07-10 13:24:54'),
('e1ffc7e1-416b-4331-a727-67eea395c976', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 7, '{\"id\":\"e1ffc7e1-416b-4331-a727-67eea395c976\",\"notification\":{\"id\":1,\"slug\":\"1KO75LUEE6QS848KSO\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>2<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:24:54', '2023-07-10 13:24:54'),
('e16cf439-d920-4842-89f0-f3af128d15e2', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 2, '{\"id\":\"e16cf439-d920-4842-89f0-f3af128d15e2\",\"notification\":{\"id\":2,\"slug\":\"1AI4TO8NJILCKOSWS\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:45:03', '2023-07-10 13:45:03'),
('03391826-1655-4bdc-9f9a-28ab9802f686', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 4, '{\"id\":\"03391826-1655-4bdc-9f9a-28ab9802f686\",\"notification\":{\"id\":2,\"slug\":\"1AI4TO8NJILCKOSWS\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:45:03', '2023-07-10 13:45:03'),
('9011595d-270f-42e2-91f1-12338853a288', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 5, '{\"id\":\"9011595d-270f-42e2-91f1-12338853a288\",\"notification\":{\"id\":2,\"slug\":\"1AI4TO8NJILCKOSWS\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:45:03', '2023-07-10 13:45:03'),
('21517307-8987-4b73-b8e4-244fce076581', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 6, '{\"id\":\"21517307-8987-4b73-b8e4-244fce076581\",\"notification\":{\"id\":2,\"slug\":\"1AI4TO8NJILCKOSWS\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:45:03', '2023-07-10 13:45:03'),
('dea80c24-0d54-4611-ad53-0fdf8746f3dc', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 7, '{\"id\":\"dea80c24-0d54-4611-ad53-0fdf8746f3dc\",\"notification\":{\"id\":2,\"slug\":\"1AI4TO8NJILCKOSWS\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:45:03', '2023-07-10 13:45:03'),
('ae6e943a-2fff-4a69-a04b-7faa6beb2e0d', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 2, '{\"id\":\"ae6e943a-2fff-4a69-a04b-7faa6beb2e0d\",\"notification\":{\"id\":3,\"slug\":\"8PRY5M0QEGKCCGKGS\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:59:21', '2023-07-10 13:59:21'),
('941693bb-953e-4935-821e-e07505b92cb5', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 4, '{\"id\":\"941693bb-953e-4935-821e-e07505b92cb5\",\"notification\":{\"id\":3,\"slug\":\"8PRY5M0QEGKCCGKGS\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:59:21', '2023-07-10 13:59:21'),
('abb18d2e-3bc7-498c-bb91-d177ddf07d51', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 5, '{\"id\":\"abb18d2e-3bc7-498c-bb91-d177ddf07d51\",\"notification\":{\"id\":3,\"slug\":\"8PRY5M0QEGKCCGKGS\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:59:21', '2023-07-10 13:59:21'),
('4e6c247b-ebbf-43b1-a34f-ecd31e143b09', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 6, '{\"id\":\"4e6c247b-ebbf-43b1-a34f-ecd31e143b09\",\"notification\":{\"id\":3,\"slug\":\"8PRY5M0QEGKCCGKGS\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:59:21', '2023-07-10 13:59:21'),
('2330e14e-5a16-404c-a754-235251d4fb9e', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 7, '{\"id\":\"2330e14e-5a16-404c-a754-235251d4fb9e\",\"notification\":{\"id\":3,\"slug\":\"8PRY5M0QEGKCCGKGS\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 13:59:21', '2023-07-10 13:59:21'),
('dad4e8f3-b3ba-4512-b64e-742e9a355473', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 2, '{\"id\":\"dad4e8f3-b3ba-4512-b64e-742e9a355473\",\"notification\":{\"id\":1,\"slug\":\"3QFEG8JC25MOGOGO4\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>3<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 14:03:45', '2023-07-10 14:03:45'),
('74eac2e8-d871-4a06-a1f9-c35aac8945c4', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 4, '{\"id\":\"74eac2e8-d871-4a06-a1f9-c35aac8945c4\",\"notification\":{\"id\":1,\"slug\":\"3QFEG8JC25MOGOGO4\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>3<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 14:03:46', '2023-07-10 14:03:46'),
('a45e4af1-d80e-473f-90dd-daa685b4918f', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 5, '{\"id\":\"a45e4af1-d80e-473f-90dd-daa685b4918f\",\"notification\":{\"id\":1,\"slug\":\"3QFEG8JC25MOGOGO4\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>3<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 14:03:46', '2023-07-10 14:03:46'),
('a332afa5-b59d-41d6-9b4e-9da5f6abb349', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 6, '{\"id\":\"a332afa5-b59d-41d6-9b4e-9da5f6abb349\",\"notification\":{\"id\":1,\"slug\":\"3QFEG8JC25MOGOGO4\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>3<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 14:03:46', '2023-07-10 14:03:46'),
('70dffa1b-8ab8-40b6-b7ff-5f74640f976a', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 7, '{\"id\":\"70dffa1b-8ab8-40b6-b7ff-5f74640f976a\",\"notification\":{\"id\":1,\"slug\":\"3QFEG8JC25MOGOGO4\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>3<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 14:03:46', '2023-07-10 14:03:46'),
('62406ca7-f0b6-4899-8f92-f1ce7ea769d4', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 2, '{\"id\":\"62406ca7-f0b6-4899-8f92-f1ce7ea769d4\",\"notification\":{\"id\":2,\"slug\":\"657XLEZJH0WSWGGC8\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 15:21:48', '2023-07-10 15:21:48'),
('ec4dba76-eb67-49b9-a130-5ce47a9308c0', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 4, '{\"id\":\"ec4dba76-eb67-49b9-a130-5ce47a9308c0\",\"notification\":{\"id\":2,\"slug\":\"657XLEZJH0WSWGGC8\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 15:21:48', '2023-07-10 15:21:48'),
('d47e92e0-57eb-4625-bd0b-39dd7103a883', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 5, '{\"id\":\"d47e92e0-57eb-4625-bd0b-39dd7103a883\",\"notification\":{\"id\":2,\"slug\":\"657XLEZJH0WSWGGC8\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 15:21:48', '2023-07-10 15:21:48'),
('d7443e83-fd17-442e-9942-4e7fae9f1de4', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 6, '{\"id\":\"d7443e83-fd17-442e-9942-4e7fae9f1de4\",\"notification\":{\"id\":2,\"slug\":\"657XLEZJH0WSWGGC8\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 15:21:48', '2023-07-10 15:21:48'),
('8e6cd162-81b1-4881-8398-8e16e8f86b8c', 'App\\Notifications\\ChannelServices', 'App\\Models\\User', 7, '{\"id\":\"8e6cd162-81b1-4881-8398-8e16e8f86b8c\",\"notification\":{\"id\":2,\"slug\":\"657XLEZJH0WSWGGC8\",\"type\":\"Purchase Order\",\"link\":\"purchase-order\",\"message\":\"New Purchase Order from <b>Mahoro Mariam<\\/b> of <b>1<\\/b> items!<\\/b>\"}}', NULL, '2023-07-10 15:21:48', '2023-07-10 15:21:48');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `committed_date` date NOT NULL,
  `transaction_id` bigint(20) DEFAULT NULL,
  `reference` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount_paid` double(18,3) UNSIGNED NOT NULL,
  `payment_type` int(11) DEFAULT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_user` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PAID_SALE` (`transaction_id`),
  KEY `PAYMENT_MODE` (`payment_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

DROP TABLE IF EXISTS `payment_methods`;
CREATE TABLE IF NOT EXISTS `payment_methods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED DEFAULT NULL,
  `code` varchar(100) DEFAULT NULL,
  `reference` varchar(20) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `unit_id` int(10) UNSIGNED DEFAULT NULL,
  `cost_price` double UNSIGNED DEFAULT '0',
  `rhia_price` double UNSIGNED DEFAULT '0',
  `private_price` double UNSIGNED DEFAULT '0',
  `inter_price` double(18,2) UNSIGNED DEFAULT '0.00',
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `quantity` double UNSIGNED NOT NULL DEFAULT '0',
  `status` tinyint(1) DEFAULT '1',
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=182 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `company_id`, `code`, `reference`, `name`, `unit_id`, `cost_price`, `rhia_price`, `private_price`, `inter_price`, `category_id`, `quantity`, `status`, `created_by`, `created_at`, `updated_at`, `deleted_at`, `image`) VALUES
(1, 1, '13TF0FWZ', 'B9D697F74721B0ED0CF3', 'Adrenaline', NULL, 0, 0, 0, 0.00, 1, 242, 1, 3, '2023-07-02 18:17:34', '2023-07-10 11:47:54', NULL, NULL),
(2, 1, '28QY6Z3D', '0944FACA42C08095E2BF', 'Abacavir', NULL, 200, 0, 0, 0.00, 1, 32, 1, 3, '2023-07-02 18:17:34', '2023-07-10 13:02:24', NULL, NULL),
(3, 1, '1HO4MI1A', 'D2F195124226A8CED587', 'Ampicillin Inj', NULL, 140, 0, 0, 0.00, 1, 176, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:17', NULL, NULL),
(4, 1, 'CZ7WC6P2', 'DF9EF3834F2D8D0BF32C', 'Atazanavir', NULL, 0, 0, 0, 0.00, 1, 16, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(5, 1, 'KW27BXR3', 'BDF4E543480FA830B6F7', 'Artesunate', NULL, 0, 0, 0, 0.00, 1, 195, 1, 3, '2023-07-02 18:17:34', '2023-07-07 14:20:22', NULL, NULL),
(6, 1, 'KDM059KQ', '05AF44834F229823D447', 'Buscopan', NULL, 0, 0, 0, 0.00, 1, 40, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:16', NULL, NULL),
(7, 1, '1N9EYYVZ', '59900424486AAA31F982', 'Cefotaxime', NULL, 0, 0, 0, 0.00, 1, 110, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(8, 1, '144DHJK0', '6B9B21454CF1909D6609', 'Ceftriaxone', NULL, 0, 0, 0, 0.00, 1, 200, 1, 3, '2023-07-02 18:17:34', '2023-07-07 14:38:10', NULL, NULL),
(9, 1, '7BYUGA0J', '4E31174C4F08ADE60E5C', 'Chlorexidine 1000ML', NULL, 0, 0, 0, 0.00, 1, 1, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(10, 1, '1D7XDEWO', '7D94701B40E3A1558CA8', 'Cloxacillin', NULL, 0, 0, 0, 0.00, 1, 45, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(11, 1, '36ZO71L7', '9ED99C86451B88781B88', 'Chlorpramazine Inj 25mg/ml', NULL, 800, 0, 0, 0.00, 1, 30, 1, 3, '2023-07-02 18:17:34', '2023-07-07 14:20:22', NULL, NULL),
(12, 1, '1F2JN5QN', '5A2BB6E0439AA391A603', 'Cimetidine Injection', NULL, 0, 0, 0, 0.00, 1, 110, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:16', NULL, NULL),
(13, 1, 'EWMZPP4A', 'D7B61D594C7DB79A6BE7', 'Ciproflaxocine Inj 100ml', NULL, 0, 0, 0, 0.00, 1, 85, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(14, 1, '13Y9R3BC', '12F0139345E09DCDB8C4', 'Co-trimoxazole', NULL, 0, 0, 0, 0.00, 1, 530, 1, 3, '2023-07-02 18:17:34', '2023-07-07 17:21:11', NULL, NULL),
(15, 1, 'EM239MUH', '0DC107BA46C0ABE0B56C', 'Dolutegravir/Lamividine', NULL, 0, 0, 0, 0.00, 1, 8, 1, 3, '2023-07-02 18:17:34', '2023-07-07 17:18:46', NULL, NULL),
(16, 1, 'AHGKL9AE', '1E8CF9DC4C1A859D1297', 'Dicynone 250mg/2ml', NULL, 0, 0, 0, 0.00, 1, 32, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(17, 1, '8Q5W89U2', 'D74095D8411ABDEAEB74', 'Depo-Provera', NULL, 0, 0, 0, 0.00, 1, 280, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(18, 1, '7I2V69M1', 'CC63666D48E4BAF9E42C', 'Dexamethozone', NULL, 0, 0, 0, 0.00, 1, 0, 1, 3, '2023-07-02 18:17:34', '2023-07-07 17:17:43', NULL, NULL),
(19, 1, '9Q37OJSH', '4034AA64433C83EF6FF9', 'Diasepan Inj', NULL, 0, 0, 0, 0.00, 1, 60, 1, 3, '2023-07-02 18:17:34', '2023-07-07 16:28:30', NULL, NULL),
(20, 1, 'MNW91RYR', '5892E931487D9FF96095', 'Diclofenac Inj', NULL, 0, 0, 0, 0.00, 1, 190, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:16', NULL, NULL),
(21, 1, 'H97ETZYD', 'E0CDA6D74D27BB61DF22', 'Oxytocine', NULL, 0, 0, 0, 0.00, 1, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(22, 1, 'HOWII8ZG', '00A2AA3B427983036CAB', 'Esonium Inj', NULL, 0, 0, 0, 0.00, 1, 15, 1, 3, '2023-07-02 18:17:34', '2023-07-07 14:54:22', NULL, NULL),
(23, 1, '1LAP1RGT', 'C26782444921AF8BF6AE', 'Eau Oxygenee 100ml', NULL, 0, 0, 0, 0.00, 1, 1, 1, 3, '2023-07-02 18:17:34', '2023-07-08 09:58:15', NULL, NULL),
(24, 1, 'N0N03R1Q', 'D9E735EF40AC9BCADA8C', 'Flammazine Crème', NULL, 0, 0, 0, 0.00, 1, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(25, 1, '13UXL5ZA', 'FA7B1D79430DA4E39ABF', 'Formol 40%', NULL, 0, 0, 0, 0.00, 1, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(26, 1, 'N0TBVIFX', 'DB5D302546D2A29BF6B9', 'Furosemide(Lasix)', NULL, 0, 0, 0, 0.00, 1, 40, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(27, 1, '18IFDF1R', 'F2B2EED64375B5DD3503', 'Favipiravir', NULL, 0, 0, 0, 0.00, 1, 22, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(28, 1, '14988BHI', '1C42C3124A26ABCA73FB', 'Gentamicyne', NULL, 0, 0, 0, 0.00, 1, 40, 1, 3, '2023-07-02 18:17:34', '2023-07-07 15:08:11', NULL, NULL),
(29, 1, '2L0FD29I', 'FD9ECD764860AAA79D83', 'Glucose 5% 500ml', NULL, 0, 0, 0, 0.00, 1, 10, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:16', NULL, NULL),
(30, 1, 'AD0GU6NE', '5A08AA8446608E4B471D', 'Glucose 10% 250ml', NULL, 0, 0, 0, 0.00, 1, 20, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(31, 1, '5NJ7ZGM6', '4E1946ED4438B6205A78', 'Glucose 50% 100ml', NULL, 0, 0, 0, 0.00, 1, 32, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(32, 1, '1B0I01A5', 'DBBD33954B01AAC12AC8', 'Haloperidol 5mg/1ml', NULL, 0, 0, 0, 0.00, 1, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(33, 1, '160H1E96', '612AFA154BE08B131C0C', 'Hydrocortisone 100mg', NULL, 350, 0, 0, 0.00, 1, 100, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:16', NULL, NULL),
(34, 1, '12WF44NH', 'B4F01F564281849CBE90', 'Implanon Inj 68mg', NULL, 0, 0, 0, 0.00, 1, 3, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(35, 1, '1KT8SIGO', '4B1988FD4979A7C84932', 'Jadelle', NULL, 0, 0, 0, 0.00, 1, 10, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(36, 1, '16M0FV6Y', '2697427F4DC58B1B8A85', 'KLY Lubrificant Gel 42G', NULL, 0, 0, 0, 0.00, 1, 2, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:17', NULL, NULL),
(37, 1, '18NQY4J8', 'FD6624B44C588AFC2858', 'Lidocaine 30ml', NULL, 0, 0, 0, 0.00, 1, 13, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:17', NULL, NULL),
(38, 1, 'FPEQEF8I', '41979E1246FC8F7B560D', 'Morphine Sufate', NULL, 0, 0, 0, 0.00, 1, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(39, 1, '26WIJLZY', '4F41114C47A08EE8D0B4', 'Metoclapramide Inj', NULL, 0, 0, 0, 0.00, 1, 60, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:17', NULL, NULL),
(40, 1, 'JNZWIK0T', '480BFE124B73B0EBCA7A', 'Metronidazole Inj(Flaggl)', NULL, 0, 0, 0, 0.00, 1, 30, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(41, 1, '26GMGKZZ', 'BD67374F40F6BAA6BF64', 'Noristera', NULL, 0, 0, 0, 0.00, 1, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(42, 1, '9WVVL40I', 'AEE74E734414B067E6B8', 'Normal Saline', NULL, 0, 0, 0, 0.00, 1, 15, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:16', NULL, NULL),
(43, 1, '13JAAUHI', 'DFAE10E14545BEB869AA', 'Paracetamol Complimes', NULL, 0, 0, 0, 0.00, 1, 640, 1, 3, '2023-07-02 18:17:34', '2023-07-07 14:54:22', NULL, NULL),
(44, 1, '1D7Y6ZFE', 'A12E1BC64139A0DFC2AD', 'Paracetamol Inj(Perfalgan)', NULL, 0, 0, 0, 0.00, 1, 165, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:16', NULL, NULL),
(45, 1, '1I37M351', '586A4372474AB8EAFEED', 'Paracetamol Supp 125mg', NULL, 0, 0, 0, 0.00, 1, 190, 1, 3, '2023-07-02 18:17:34', '2023-07-07 12:49:51', NULL, NULL),
(46, 1, '1JYL12HS', '2F6582D540D7AA33A05C', 'Pommade 10% 50g', NULL, 0, 0, 0, 0.00, 1, 3, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(47, 1, '1NRLOHUU', '4A572AF74577B38253EA', 'Pethidine', NULL, 0, 0, 0, 0.00, 1, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(48, 1, '1AF3NPUK', '30B7E1DD45E6B4584B87', 'Paracetamol Supp 250mg', NULL, 0, 0, 0, 0.00, 1, 20, 1, 3, '2023-07-02 18:17:34', '2023-07-07 15:08:11', NULL, NULL),
(49, 1, '1MIUILN6', '4138A06F4491B3EC0057', 'Ondansetron Injection', NULL, 0, 0, 0, 0.00, 1, 20, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:16', NULL, NULL),
(50, 1, '9RDACGUW', 'D793C212469ABB3B261F', 'Povidone 200ml', NULL, 0, 0, 0, 0.00, 1, 3, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:17', NULL, NULL),
(51, 1, '1OSVIY7R', '2621399D4491B3FBC05E', 'Ringer Lectate 500ml', NULL, 0, 0, 0, 0.00, 1, 50, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:16', NULL, NULL),
(52, 1, '15UCE31S', '2A25AAC643F1BA8CE707', 'Tenofov300MG+Lamivud300', NULL, 0, 0, 0, 0.00, 1, 12, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(53, 1, 'JTRNHHKW', 'E477A7164635A2350E32', 'Tenofovir Disoproxil Fumarate', NULL, 0, 0, 0, 0.00, 1, 9, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(54, 1, '5MD5G1XD', '39DA73EE4A478DEEBB7D', 'Topical Anethesia Gel', NULL, 0, 0, 0, 0.00, 1, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(55, 1, '12SO6CTR', '6FE3659640E3BFD72955', 'Tetracycline Hydro', NULL, 0, 0, 0, 0.00, 1, 30, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(56, 1, '7DLQCLDW', '73F739EF4ADBA8B45BF2', 'Tramadol Inject', NULL, 0, 0, 0, 0.00, 1, 40, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(57, 1, '1N390HU5', 'FDE8DDD3497E80F7F14B', 'Vitamin B complex', NULL, 0, 0, 0, 0.00, 1, 20, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:16', NULL, NULL),
(58, 1, '1IPH0ZQB', '2BB4BC9F4E1DAF4FAB55', 'Ventoline 2.5mg/ml', NULL, 0, 0, 0, 0.00, 1, 4, 1, 3, '2023-07-02 18:17:34', '2023-07-06 08:20:10', NULL, NULL),
(59, 1, '26EKEFM0', '60D628A04D08B5DA5273', 'Water for Injection 10ml', NULL, 0, 0, 0, 0.00, 1, 400, 1, 3, '2023-07-02 18:17:34', '2023-07-07 15:08:11', NULL, NULL),
(60, 1, '1Q1K6KO3', '91480CDF4B2C9CDC321F', 'Abaisse Langue', NULL, 0, 0, 0, 0.00, 2, 700, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(61, 1, '1ORF56ZT', '931F18E44DDA980ADAF2', 'Alcohol de natures', NULL, 0, 0, 0, 0.00, 2, 15, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(62, 1, '1IFKPYUM', 'C5B9AD0A4C69829B816B', 'Bande Jersey', NULL, 150, 0, 0, 0.00, 2, 10, 1, 3, '2023-07-02 18:17:34', '2023-07-10 13:13:32', NULL, NULL),
(63, 1, 'C8LQA2F1', '2395A89D4A099F46F87C', 'Bande 10&20cm', NULL, 15, 0, 0, 0.00, 2, 129, 1, 3, '2023-07-02 18:17:34', '2023-07-10 15:17:03', NULL, NULL),
(64, 1, '26039LF2', '75B4493F48E3BB38480B', 'Bande de Gauze', NULL, 250, 0, 0, 0.00, 2, 55, 1, 3, '2023-07-02 18:17:34', '2023-07-10 15:17:03', NULL, NULL),
(65, 1, '13OZLU5A', 'D79323F44CA6891244FF', 'Bande Platrees 10&20cm', NULL, 0, 0, 0, 0.00, 2, 50, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(66, 1, '1KOTMDEZ', 'A0C98DCF4F32A330F072', 'Catheter G22', NULL, 0, 0, 0, 0.00, 2, 500, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(67, 1, 'H1K969Y6', '3FEC5F9649E6A483644B', 'Catheter G24', NULL, 0, 0, 0, 0.00, 2, 100, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:16', NULL, NULL),
(68, 1, 'I9OTIXCH', '74CFB0F54094B555DA82', 'Cotton', NULL, 0, 0, 0, 0.00, 2, 3, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:17', NULL, NULL),
(69, 1, 'B595EJ69', 'AD340014487FB8D55957', 'Ecouvillan(Sterile Swab)', NULL, 0, 0, 0, 0.00, 2, 100, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:17', NULL, NULL),
(70, 1, '1P4HMNJD', 'CDF4B1EB419DB410DE13', 'Facemask', NULL, 0, 0, 0, 0.00, 2, 50, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(71, 1, '26VIUSHL', '980B56744FB0B6D0FC14', 'Feeding Tube no 6', NULL, 0, 0, 0, 0.00, 2, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(72, 1, 'JOAKGIU4', '5B7CD8294C2E8DE2E278', 'Feeding Tube no 8', NULL, 0, 0, 0, 0.00, 2, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(73, 1, '1DOWLCXN', '3425606D4D0B8A5430C3', 'Feeding Tube no 18', NULL, 0, 0, 0, 0.00, 2, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(74, 1, 'AJSV7MLS', 'AC20B5B3477BACB2535F', 'Files de Suture 2/0&3/0', NULL, 0, 0, 0, 0.00, 2, 60, 1, 3, '2023-07-02 18:17:34', '2023-07-07 14:20:22', NULL, NULL),
(75, 1, '16R1HDH5', '06D96DBD4E658FA91401', 'Foley Catheter CH10', NULL, 0, 0, 0, 0.00, 2, 5, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(76, 1, '7S9OXIV6', '9BFD2A5C47F280DA57A2', 'Foley Catheter CH14', NULL, 0, 0, 0, 0.00, 2, 5, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(77, 1, 'FV5HQSER', 'DA945D344FD2BEAFBFF6', 'Foley Catheter CH12', NULL, 0, 0, 0, 0.00, 2, 6, 1, 3, '2023-07-02 18:17:34', '2023-07-10 11:45:03', NULL, NULL),
(78, 1, '17YABM6L', 'B1E5545445F1BEE1537E', 'Foley Catheter CH16', NULL, 0, 0, 0, 0.00, 2, 7, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(79, 1, '1K878MVA', '581DA96144DDB141C3F3', 'Foley Catheter CH18', NULL, 0, 0, 0, 0.00, 2, 10, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(80, 1, '1AO0A180', '3451D92E4676B80B1AF6', 'Foley Catheter CH20', NULL, 0, 0, 0, 0.00, 2, 8, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(81, 1, 'DJ6WUZWB', 'B561AC3E49EFA74D7C64', 'Foley Catheter CH22', NULL, 0, 0, 0, 0.00, 2, 5, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(82, 1, '8AEDURMV', '66DC677A4457B43E9F9A', 'Forehead Thermometer', NULL, 0, 0, 0, 0.00, 2, 4, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(83, 1, '194HQ537', '3441A9DF44EE9BF8EB10', 'Gant non-Sterile', NULL, 0, 0, 0, 0.00, 2, 2800, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:17', NULL, NULL),
(84, 1, '31PPXNJP', 'B4599BF14D3882FB9428', 'Gant Sterile', NULL, 0, 0, 0, 0.00, 2, 32, 1, 3, '2023-07-02 18:17:34', '2023-07-07 16:28:30', NULL, NULL),
(85, 1, '1MCOT7TR', '3C487C194533BF58D251', 'Gauze Roll', NULL, 0, 0, 0, 0.00, 2, 6, 1, 3, '2023-07-02 18:17:34', '2023-07-08 09:59:33', NULL, NULL),
(86, 1, '28D8X1WE', 'FE7686714DB4B9F69812', 'Gel pour Eco', NULL, 0, 0, 0, 0.00, 2, 0, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:17', NULL, NULL),
(87, 1, '1JZBA6HE', '7F1E9A1D42F594C9C789', 'Kidney Bowls', NULL, 0, 0, 0, 0.00, 2, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(88, 1, '8P512TDR', '4A2F72B847B090082971', 'Needle Holder', NULL, 0, 0, 0, 0.00, 2, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(89, 1, '1F8XUEG7', 'C8F17CB74903837ABD39', 'Non-Absorbable Sature', NULL, 0, 0, 0, 0.00, 2, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(90, 1, 'KFW2M1PH', 'C7759B8E43E5A79F781E', 'Polyvol Buretteset', NULL, 0, 0, 0, 0.00, 2, 20, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(91, 1, 'HIL8P6C2', '4C6CBEF94ABFB18551B0', 'Neb.Mask Adult', NULL, 0, 0, 0, 0.00, 2, 16, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(92, 1, '1A98PLB7', '4F1A59494163BE0A96B3', 'Neb.Mask Pédiatrie', NULL, 0, 0, 0, 0.00, 2, 15, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(93, 1, 'HS8OY9IY', '4D70AB094DFBA03A3B0B', 'Otoscope', NULL, 0, 0, 0, 0.00, 2, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(94, 1, 'M1S1Y1OA', '9DCF34EF4A60B302A57F', 'Sac a Urine(Urine Bag)', NULL, 0, 0, 0, 0.00, 2, 10, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(95, 1, '4VVE5PNN', '60D321284A0E8165F8C3', 'Seringue 20ml', NULL, 0, 0, 0, 0.00, 2, 300, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(96, 1, '1DJJUFAL', '62948D2F4A8193F3C514', 'Seringue a Insuline', NULL, 0, 0, 0, 0.00, 2, 85, 1, 3, '2023-07-02 18:17:34', '2023-07-07 14:54:22', NULL, NULL),
(97, 1, 'A98BPYUV', '75E068674F83B927FCC7', 'Spardra', NULL, 0, 0, 0, 0.00, 2, 3, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:17', NULL, NULL),
(98, 1, 'KQHFKU2M', '9BA1E3684AD2B82DACF4', 'Sterile(Intra.Contrac Device)', NULL, 0, 0, 0, 0.00, 2, 0, 1, 3, '2023-07-02 18:17:34', '2023-07-07 14:38:10', NULL, NULL),
(99, 1, 'FEJ7QA3U', 'D38A0A90434585762D02', 'Surgical Blades', NULL, 0, 0, 0, 0.00, 2, 640, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:17', NULL, NULL),
(100, 1, 'DE3W0J8H', '5C5CAAEA4B1AA0CC04CB', 'Syringue 10ml', NULL, 43, 0, 0, 0.00, 2, 300, 1, 3, '2023-07-02 18:17:34', '2023-07-08 15:50:16', NULL, NULL),
(101, 1, '1FNSAS94', 'FEB73C714884891C910B', 'Syringue 50ml', NULL, 0, 0, 0, 0.00, 2, 20, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(102, 1, '18AFVEB3', 'A67782954E21A1E3C019', 'Syringue 60ml', NULL, 0, 0, 0, 0.00, 2, 13, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(103, 1, '1N4O3O7P', '13E37AD2439DB96BCA8B', 'Syringue 2ml', NULL, 28, 0, 0, 0.00, 2, 200, 1, 3, '2023-07-02 18:17:34', '2023-07-07 12:44:43', NULL, NULL),
(104, 1, '185MRP7D', '79352C3045B6AB7E617C', 'Syringue 5ml', NULL, 0, 0, 0, 0.00, 2, 200, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(105, 1, 'C827N0NB', '6CBC6D214E39872E862C', 'Trousse', NULL, 0, 0, 0, 0.00, 2, 175, 1, 3, '2023-07-02 18:17:34', '2023-07-07 14:20:23', NULL, NULL),
(106, 1, '14624TPW', 'B4CFD2D0409EA4F6CBD5', 'Tulles Gras', NULL, 0, 0, 0, 0.00, 2, 25, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(107, 1, 'H6H4GB3W', 'B17DA51C453AB60DC51D', 'Adhesive Plaster', NULL, 0, 0, 0, 0.00, 5, 500, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(108, 1, '1PVTGQ28', '2F4263BF4534B981111F', 'AFP FIA', NULL, 0, 0, 0, 0.00, 5, 33, 1, 3, '2023-07-02 18:17:34', '2023-07-10 11:47:54', NULL, NULL),
(109, 1, '18VZLK8Y', 'B2415EEF497BB9A1E306', 'Aiguille G21', NULL, 0, 0, 0, 0.00, 5, 5000, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(110, 1, 'K919ARI9', 'BBE325BC47A9B4CCA3E1', 'Aiguille G23', NULL, 15, 0, 0, 0.00, 5, 400, 1, 3, '2023-07-02 18:17:34', '2023-07-08 16:15:14', NULL, NULL),
(111, 1, '1GEOYRHI', '2C0C0EE94BB180A97FF5', 'Alcohol Pad', NULL, 0, 0, 0, 0.00, 5, 2000, 1, 3, '2023-07-02 18:17:34', '2023-07-07 16:32:18', NULL, NULL),
(112, 1, 'JLL3IQPH', 'D667CA17492E867DB1F2', 'Bandelette de glycemie', NULL, 200, 0, 0, 0.00, 5, 150, 1, 3, '2023-07-02 18:17:34', '2023-07-08 16:15:14', NULL, NULL),
(113, 1, 'CWW32RUU', '5EA966124DDF93146D33', 'B-HCG FIA', NULL, 120, 0, 0, 0.00, 5, 111, 1, 3, '2023-07-02 18:17:34', '2023-07-10 15:17:03', NULL, NULL),
(114, 1, '1AKHB0D7', '17B005B146DE9EC072F5', 'Blue tips', NULL, 0, 0, 0, 0.00, 5, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(115, 1, '1PDLI0BT', 'AE92C15E41A68DBB995E', 'Buette de Security', NULL, 0, 0, 0, 0.00, 5, 48, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(116, 1, '5U81CROI', '77CEC8D04627B7BA4A5C', 'Chlamydia Test Device', NULL, 300, 0, 0, 0.00, 5, 321, 1, 3, '2023-07-02 18:17:34', '2023-07-10 12:35:03', NULL, NULL),
(117, 1, '2714PCX5', '32B4564642DF80F70FB9', 'Cholesterol Test Device', NULL, 2400, 0, 0, 0.00, 5, 75, 1, 3, '2023-07-02 18:17:34', '2023-07-07 16:32:18', NULL, NULL),
(118, 1, '141FFZMF', '21B0983A4EECA6BEEBAF', 'EAU DISTILLEE', NULL, 0, 0, 0, 0.00, 5, 20, 1, 3, '2023-07-02 18:17:34', '2023-07-07 09:48:31', NULL, NULL),
(119, 1, '7TNJEVRE', '0C656CB24940A0A2E65F', 'EDTA Tube', NULL, 48, 0, 0, 0.00, 5, 900, 1, 3, '2023-07-02 18:17:34', '2023-07-08 16:15:14', NULL, NULL),
(120, 1, '18AEQJIN', 'C983E24C400093C68E4B', 'H.Pylori AB', NULL, 0, 0, 0, 0.00, 5, 50, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(121, 1, '7B02BC88', '2866C989492A806D3359', 'H.PYLORI AB FIA', NULL, 0, 0, 0, 0.00, 5, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(122, 1, '7DMVBTS1', '032EE7B9483789ED1D6A', 'H.Pylori AG', NULL, 1200, 0, 0, 0.00, 5, 80, 1, 3, '2023-07-02 18:17:34', '2023-07-08 16:15:14', NULL, NULL),
(123, 1, 'N4ZTKEHX', '3FDF1D7F4D6499834539', 'HBA1C', NULL, 2600, 0, 0, 0.00, 5, 25, 1, 3, '2023-07-02 18:17:34', '2023-07-07 11:44:40', NULL, NULL),
(124, 1, '138XO2TX', 'C1BE52614E74B451A49C', 'HBsAG', NULL, 0, 0, 0, 0.00, 5, 690, 1, 3, '2023-07-02 18:17:34', '2023-07-07 11:44:40', NULL, NULL),
(125, 1, 'CI6QIQGJ', '2A2B6A5F4DA5A621161A', 'HBsAG FIA', NULL, 0, 0, 0, 0.00, 5, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(126, 1, 'D8SW8N5T', 'CA17654D4C8A805F7CC0', 'HCV', NULL, 0, 0, 0, 0.00, 5, 50, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(127, 1, 'M3ODHG9B', '230B80D042C38F349D2C', 'HCV FIA', NULL, 0, 0, 0, 0.00, 5, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(128, 1, '1IRPM1ZW', 'ECCE843B4D809F912D05', 'HIV 1/2 Stat pak CHEMBO', NULL, 0, 0, 0, 0.00, 5, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(129, 1, '538UGDCH', '6B0CC20847B4A7A682A8', 'HIV Combo', NULL, 0, 0, 0, 0.00, 5, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(130, 1, 'ACPIZ440', '4CAB6B71489D81029FBC', 'Hepatite A', NULL, 0, 0, 0, 0.00, 5, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(131, 1, '1IEGEYF1', '179EBB104A2EAE9D1CFE', 'Lamelles', NULL, 0, 0, 0, 0.00, 5, 0, 1, 3, '2023-07-02 18:17:34', '2023-07-07 11:44:39', NULL, NULL),
(132, 1, '50GOT9LP', '91C6ABA44120A66BFBF6', 'LH FIA', NULL, 0, 0, 0, 0.00, 5, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(133, 1, '13KARLOG', 'A2C4359F4953AB39D2BB', 'Pipette Pasteur', NULL, 0, 0, 0, 0.00, 5, 250, 1, 3, '2023-07-02 18:17:34', '2023-07-07 10:13:39', NULL, NULL),
(134, 1, '1KOK710L', '27B46E6C4FE7A2E1F62C', 'Pregnancy Test', NULL, 0, 0, 0, 0.00, 5, 50, 1, 3, '2023-07-02 18:17:34', '2023-07-07 10:13:39', NULL, NULL),
(135, 1, '13NZNOCJ', 'ECA1F6944AC1BF893FC4', 'Progesterone FIA', NULL, 0, 0, 0, 0.00, 5, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(136, 1, '1OYAK5S3', '12858A1E42CDB0C710D8', 'Prolactine FIA', NULL, 3040, 0, 0, 0.00, 5, 0, 1, 3, '2023-07-02 18:17:34', '2023-07-07 11:44:40', NULL, NULL),
(137, 1, '1FUILLI2', '11EB00844020976F32F9', 'PSA FIA', NULL, 0, 0, 0, 0.00, 5, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(138, 1, 'I2UMKQ6K', 'D7A2EBD24E3EAF1FA27F', 'Rubeola IGG/IGM', NULL, 0, 0, 0, 0.00, 5, 40, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(139, 1, '2QH305U5', 'A29BC8614CCBB891253E', 'Stool Container', NULL, 0, 0, 0, 0.00, 5, 700, 1, 3, '2023-07-02 18:17:34', '2023-07-08 16:15:13', NULL, NULL),
(140, 1, 'JT1EZV98', '546FA9884BF6A6D13D27', 'SYR Rapid Test', NULL, 240, 0, 0, 0.00, 5, 100, 1, 3, '2023-07-02 18:17:34', '2023-07-07 11:33:17', NULL, NULL),
(141, 1, '1DEP6QPJ', '3ADC19114AFE92CCB5EB', 'TDR', NULL, 800, 0, 0, 0.00, 5, 175, 1, 3, '2023-07-02 18:17:34', '2023-07-07 16:32:18', NULL, NULL),
(142, 1, '1839E2HR', '3000459C4155A91FE8BB', 'Testosterone FIA', NULL, 0, 0, 0, 0.00, 5, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(143, 1, '5RZ2U7YZ', '4D7869D040CAABE4CF3A', 'Toxo IGM/IGG', NULL, 0, 0, 0, 0.00, 5, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(144, 1, '7NVTAHN0', '81C2DA8B4FFFAF476E3C', 'TSH FIA', NULL, 0, 0, 0, 0.00, 5, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(145, 1, '1AKIQJXN', 'C613E6C2413282A6C3B9', 'TT3 FIA', NULL, 0, 0, 0, 0.00, 5, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(146, 1, '2IM9AY64', '6C96C5044478900EB70D', 'TT4', NULL, 0, 0, 0, 0.00, 5, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(147, 1, 'JLX2EUTK', 'D4D49286467586E655D0', 'TUBE Sec', NULL, 0, 0, 0, 0.00, 5, 200, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(148, 1, 'TS049WSQ', 'E071B45A4736A4C8CCAC', 'Uric Acid', NULL, 0, 0, 0, 0.00, 5, 25, 1, 3, '2023-07-02 18:17:34', '2023-07-07 10:13:39', NULL, NULL),
(149, 1, '1OYQLXVK', '5C9D0BA940F6A26A902A', 'Urinalysis 3P', NULL, 0, 0, 0, 0.00, 5, 100, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(150, 1, '5IA6RUGC', 'BA41BB9A427E8B491C6C', 'Urine Container', NULL, 0, 0, 0, 0.00, 5, 400, 1, 3, '2023-07-02 18:17:34', '2023-07-07 09:54:30', NULL, NULL),
(151, 1, 'MZAQG715', '94AD5DAB4F2BA7231DA2', 'Vacteneur Needle', NULL, 0, 0, 0, 0.00, 5, 500, 1, 3, '2023-07-02 18:17:34', '2023-07-07 09:54:30', NULL, NULL),
(152, 1, '5T93T7VP', '198BC00C4513B014BFF6', 'ALAT', NULL, 0, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(153, 1, '7U1IWWSJ', '3170979F41D08B3F5977', 'ASAT', NULL, 0, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(154, 1, '1IV5GWMX', 'F2B204D5486F98FA3858', 'ASLO', NULL, 250, 0, 0, 0.00, 6, 100, 1, 3, '2023-07-02 18:17:34', '2023-07-10 13:59:57', NULL, NULL),
(155, 1, '1MF1B09D', 'B6A362CF434A914E65C6', 'Albumine', NULL, 0, 0, 0, 0.00, 6, 100, 1, 3, '2023-07-02 18:17:34', '2023-07-10 11:42:54', NULL, NULL),
(156, 1, '1E1W3NQ3', '62C8FAB84FD9B5F4C8B5', 'Amylase', NULL, 0, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(157, 1, 'DFAOKIOA', 'A0C1DFDA4639A7E4C3A2', 'Alkaline phosphatase', NULL, 0, 0, 0, 0.00, 6, 110, 1, 3, '2023-07-02 18:17:34', '2023-07-10 11:42:54', NULL, NULL),
(158, 1, '7Z5ORUT2', '561DAB06441A8BE6A883', 'Blood grouping sera', NULL, 300, 0, 0, 0.00, 6, 3, 1, 3, '2023-07-02 18:17:34', '2023-07-10 13:11:19', NULL, NULL),
(159, 1, '3QCJDE1I', '066BC4114DF290B4E58E', 'Cell Pack', NULL, 200, 0, 0, 0.00, 6, 100, 1, 3, '2023-07-02 18:17:34', '2023-07-10 12:35:03', NULL, NULL),
(160, 1, '1PLMHV2H', 'D94D24154C4696EF9AC1', 'Creatinine', NULL, 0, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(161, 1, '1DO6N4D5', 'D366C3B14B218ECC8973', 'Chloride 50ML', NULL, 120, 0, 0, 0.00, 6, 1021, 1, 3, '2023-07-02 18:17:34', '2023-07-10 12:35:03', NULL, NULL),
(162, 1, '1KF830XI', '33B8473240F58D951BD7', 'CRP Test', NULL, 12000, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', '2023-07-07 09:48:31', NULL, NULL),
(163, 1, 'M46DEGHP', '837071FD43388799735B', 'Calcium', NULL, 0, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(164, 1, '28OTZJLG', 'E2C4CE754268850C65F9', 'Estradiol FIA', NULL, 0, 0, 0, 0.00, 6, 48, 1, 3, '2023-07-02 18:17:34', '2023-07-10 12:40:45', NULL, NULL),
(165, 1, '1CXKW0GX', 'EA1403F84F55A0C0BE56', 'FSH FIA', NULL, 0, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(166, 1, '1B4MNGYD', '6E5D862441BBBEB699F4', 'Gram Stain', NULL, 0, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(167, 1, 'H95TY26V', 'F631428E4DBC8F4573FE', 'Gamma GT', NULL, 0, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(168, 1, '3TSARYAR', '5D2EACDB415DAB42A5A7', 'Lipase', NULL, 0, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(169, 1, '1AK8XTRL', '70FBD5C84D0A9CB1D9FD', 'Magnesium', NULL, 0, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(170, 1, '1B5QLIGJ', '65394A954CA582789A52', 'Potassium', NULL, 0, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(171, 1, '1LCDIGVJ', '07363A484326B39A5366', 'RF', NULL, 0, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(172, 1, 'FK06HNN6', '5F656BDB4420B5A25A78', 'Sodium', NULL, 0, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(173, 1, '26PR8V11', '86B41AE9428595287C1D', 'Stromatoyser 4DS 42ml', NULL, 0, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', '2023-07-07 12:33:35', NULL, NULL),
(174, 1, '8QN0BX8Q', '57EBD1574A6AAA04F133', 'Stromatoyser 4DL 2l', NULL, 0, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', '2023-07-07 16:52:31', NULL, NULL),
(175, 1, '28E9XO67', 'B0E3AA23451089808E44', 'Sulfolyser 500ml', NULL, 0, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', '2023-07-07 16:52:31', NULL, NULL),
(176, 1, '15CI1H90', '78CAA3614EDBAFDEEA54', 'Urea', NULL, 0, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(177, 1, 'M790H50M', '245836B74C01831024BB', 'Uric Acid', NULL, 0, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(178, 1, '1AJIUUXU', '7B8AD8D94E12BD173D89', 'Widal Test', NULL, 0, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(179, 1, '168EYTNF', '85917F504A65B65B4888', 'Lames', NULL, 0, 0, 0, 0.00, 7, 200, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(180, 1, '57MZ60KM', '5156A3DA43EDB818191B', 'Western G.Tubes(VS)', NULL, 0, 0, 0, 0.00, 7, 16, 1, 3, '2023-07-02 18:17:34', NULL, NULL, NULL),
(181, 1, '1KKRZ6QT', '160A59BB4E2289F4961B', 'Giemsa Stain Solution 50ml', 4, 13000, 0, 0, 0.00, 6, 0, 1, 3, '2023-07-07 08:38:57', '2023-07-07 10:07:07', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

DROP TABLE IF EXISTS `product_categories`;
CREATE TABLE IF NOT EXISTS `product_categories` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product_categories`
--

INSERT INTO `product_categories` (`id`, `company_id`, `parent_id`, `name`, `description`, `created_by`, `created_at`, `deleted_at`, `updated_at`) VALUES
(1, 1, NULL, 'Drugs', NULL, 2, '2023-07-02 21:33:12', NULL, '2023-07-02 21:33:12'),
(2, 1, NULL, 'Consummables', NULL, 2, '2023-07-02 21:33:26', NULL, '2023-07-02 21:33:26'),
(3, 1, NULL, 'Laboratory', NULL, 2, '2023-07-02 21:33:37', NULL, '2023-07-02 21:33:37'),
(4, 1, NULL, 'Hygiene Materials', NULL, 2, '2023-07-02 21:33:55', NULL, '2023-07-02 21:33:55'),
(5, 1, 3, 'Labo Consumables', 'null', 2, '2023-07-02 21:35:14', NULL, '2023-07-02 21:36:52'),
(6, 1, 3, 'Labo Reactif', NULL, 2, '2023-07-02 21:35:25', NULL, '2023-07-02 21:35:25'),
(7, 1, 3, 'Labo Non-Consumables', 'null', 2, '2023-07-02 21:35:49', NULL, '2023-07-02 21:37:02');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_order`
--

DROP TABLE IF EXISTS `purchase_order`;
CREATE TABLE IF NOT EXISTS `purchase_order` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `reference` varchar(30) DEFAULT NULL,
  `company_id` int(10) UNSIGNED DEFAULT NULL,
  `date_initiated` date NOT NULL,
  `amount` double NOT NULL,
  `status` enum('PENDING','CANCELLED','ACCEPTED','VERIFIED') NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `purchase_order`
--

INSERT INTO `purchase_order` (`id`, `reference`, `company_id`, `date_initiated`, `amount`, `status`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '3QFEG8JC25MOGOGO4', 1, '2023-07-10', 17320, 'ACCEPTED', 3, '2023-07-10 14:03:45', '2023-07-10 15:17:03', NULL),
(2, '657XLEZJH0WSWGGC8', 1, '2023-07-10', 200, 'PENDING', 3, '2023-07-10 15:21:48', '2023-07-10 15:22:35', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_order_items`
--

DROP TABLE IF EXISTS `purchase_order_items`;
CREATE TABLE IF NOT EXISTS `purchase_order_items` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `order_qty` double UNSIGNED NOT NULL,
  `price` double UNSIGNED NOT NULL,
  `requested_qty` double UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `purchase_order_items`
--

INSERT INTO `purchase_order_items` (`id`, `order_id`, `product_id`, `order_qty`, `price`, `requested_qty`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 64, 10, 250, 10, '2023-07-10 14:03:45', '2023-07-10 14:03:45', NULL),
(2, 1, 63, 100, 15, 15, '2023-07-10 14:03:45', '2023-07-10 14:03:45', NULL),
(3, 1, 113, 111, 120, 120, '2023-07-10 14:03:45', '2023-07-10 14:03:45', NULL),
(4, 2, 159, 1, 200, 1, '2023-07-10 15:21:48', '2023-07-10 15:22:35', '2023-07-10 15:22:35');

-- --------------------------------------------------------

--
-- Table structure for table `requisitions`
--

DROP TABLE IF EXISTS `requisitions`;
CREATE TABLE IF NOT EXISTS `requisitions` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `reference` varchar(30) DEFAULT NULL,
  `company_id` int(10) UNSIGNED DEFAULT NULL,
  `department_id` int(10) UNSIGNED NOT NULL,
  `date_initiated` date NOT NULL,
  `amount` double NOT NULL,
  `status` enum('PENDING','CANCELLED','ACCEPTED') NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `requisitions`
--

INSERT INTO `requisitions` (`id`, `reference`, `company_id`, `department_id`, `date_initiated`, `amount`, `status`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '1MZN0AIBURTWWC0W8W', 1, 1, '2023-07-03', 400, 'PENDING', 2, '2023-07-03 09:40:13', '2023-07-05 08:44:50', '2023-07-05 08:44:50'),
(2, '28U1B7KWL89WKWW0OC', 1, 3, '2023-07-07', 10800, 'PENDING', 5, '2023-07-07 11:55:44', '2023-07-08 09:26:30', '2023-07-08 09:26:30');

-- --------------------------------------------------------

--
-- Table structure for table `requisition_items`
--

DROP TABLE IF EXISTS `requisition_items`;
CREATE TABLE IF NOT EXISTS `requisition_items` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `requisition_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `requested_qty` double UNSIGNED NOT NULL,
  `price` double UNSIGNED NOT NULL,
  `received_qty` double UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `permissions` text,
  `company_id` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `permissions`, `company_id`, `status`, `description`) VALUES
(1, 'IT Support', '{\"dashboard\":{\"accessible\":true},\"companies\":{\"accessible\":false},\"leads\":{\"accessible\":true,\"users\":[\"C\",\"R\",\"U\"],\"suppliers\":[\"C\",\"R\",\"U\"],\"Clients\":[\"C\",\"R\",\"U\"]},\"inventory\":{\"accessible\":true,\"categories\":[\"C\",\"R\",\"U\"],\"products\":[\"C\",\"R\",\"U\"],\"receive_items\":[\"C\",\"R\",\"U\"],\"transfer_items\":[\"C\",\"R\",\"U\"],\"requisitions\":[\"C\",\"R\",\"U\"],\"purchase_order\":[\"C\",\"R\",\"U\",\"D\"],\"adjustments\":[\"C\",\"R\",\"U\"]},\"expenses\":{\"accessible\":true,\"expenses_categories\":[\"C\",\"R\",\"U\"],\"expenses\":[\"C\",\"R\",\"U\"]},\"reports\":{\"accessible\":true,\"receiving_report\":[\"C\",\"R\",\"U\"],\"transfers_report\":[\"C\",\"R\",\"U\"],\"requisition_report\":[\"C\",\"R\",\"U\"],\"purchase_order_report\":[\"C\",\"R\",\"U\",\"D\"],\"stock_status_report\":[\"C\",\"R\",\"U\"],\"adjustments_report\":[\"C\",\"R\",\"U\"],\"exipired_products\":[\"C\",\"R\",\"U\"],\"sales_report\":[],\"Payment_History_report\":[]},\"settings\":{\"accessible\":true,\"users_roles\":[\"C\",\"R\",\"U\"],\"items_units\":[\"C\",\"R\",\"U\"],\"insurances\":[],\"departments\":[\"C\",\"R\",\"U\"]},\"POS\":{\"accessible\":false}}', NULL, 1, 'IT account to support others'),
(3, 'Chef Nurse', '{\"dashboard\":{\"accessible\":false},\"companies\":{\"accessible\":false},\"leads\":{\"accessible\":false,\"users\":[],\"suppliers\":[],\"Clients\":[]},\"inventory\":{\"accessible\":true,\"categories\":[],\"products\":[],\"receive_items\":[],\"transfer_items\":[],\"requisitions\":[\"C\",\"R\"],\"adjustments\":[]},\"expenses\":{\"accessible\":false,\"expenses_categories\":[],\"expenses\":[]},\"reports\":{\"accessible\":true,\"receiving_report\":[],\"transfers_report\":[],\"requisition_report\":[\"C\",\"R\"],\"stock_status_report\":[],\"adjustments_report\":[],\"exipired_products\":[],\"sales_report\":[],\"Payment_History_report\":[]},\"settings\":{\"accessible\":false,\"users_roles\":[],\"items_units\":[],\"insurances\":[],\"departments\":[]},\"POS\":{\"accessible\":false}}', 1, 1, 'Department of Nursing'),
(4, 'Chef Laboratory', '{\"dashboard\":{\"accessible\":false},\"companies\":{\"accessible\":false},\"leads\":{\"accessible\":false,\"users\":[],\"suppliers\":[],\"Clients\":[]},\"inventory\":{\"accessible\":true,\"categories\":[],\"products\":[],\"receive_items\":[],\"transfer_items\":[],\"requisitions\":[\"C\",\"R\"],\"adjustments\":[]},\"expenses\":{\"accessible\":false,\"expenses_categories\":[],\"expenses\":[]},\"reports\":{\"accessible\":true,\"receiving_report\":[],\"transfers_report\":[],\"requisition_report\":[\"C\",\"R\"],\"stock_status_report\":[],\"adjustments_report\":[],\"exipired_products\":[],\"sales_report\":[],\"Payment_History_report\":[]},\"settings\":{\"accessible\":false,\"users_roles\":[],\"items_units\":[],\"insurances\":[],\"departments\":[]},\"POS\":{\"accessible\":false}}', 1, 1, 'Department of Laboratory'),
(6, 'Corporate', '{\"dashboard\":{\"accessible\":true},\"companies\":{\"accessible\":true},\"leads\":{\"accessible\":true,\"users\":[\"C\",\"R\",\"U\",\"D\"],\"suppliers\":[\"C\",\"R\",\"U\",\"D\"],\"Clients\":[\"C\",\"R\",\"U\",\"D\"]},\"inventory\":{\"accessible\":true,\"categories\":[\"C\",\"R\",\"U\",\"D\"],\"products\":[\"C\",\"R\",\"U\",\"D\"],\"receive_items\":[\"C\",\"R\",\"U\",\"D\"],\"transfer_items\":[\"C\",\"R\",\"U\",\"D\"],\"requisitions\":[\"C\",\"R\",\"U\",\"D\"],\"adjustments\":[\"C\",\"R\",\"U\",\"D\"]},\"expenses\":{\"accessible\":true,\"expenses_categories\":[\"C\",\"R\",\"U\",\"D\"],\"expenses\":[\"C\",\"R\",\"U\",\"D\"]},\"reports\":{\"accessible\":true,\"receiving_report\":[\"C\",\"R\",\"U\",\"D\"],\"transfers_report\":[\"C\",\"R\",\"U\",\"D\"],\"requisition_report\":[\"C\",\"R\",\"U\",\"D\"],\"stock_status_report\":[\"C\",\"R\",\"U\",\"D\"],\"adjustments_report\":[\"C\",\"R\",\"U\",\"D\"],\"exipired_products\":[\"C\",\"R\",\"U\",\"D\"],\"sales_report\":[],\"Payment_History_report\":[]},\"settings\":{\"accessible\":true,\"users_roles\":[\"C\",\"R\",\"U\",\"D\"],\"items_units\":[\"C\",\"R\",\"U\",\"D\"],\"insurances\":[\"C\",\"R\",\"U\",\"D\"],\"departments\":[\"C\",\"R\",\"U\",\"D\"]},\"POS\":{\"accessible\":false}}', 1, 1, 'Corporate'),
(2, 'Stock Admin', '{\"dashboard\":{\"accessible\":true},\"companies\":{\"accessible\":false},\"leads\":{\"accessible\":true,\"users\":[\"C\",\"R\",\"U\",\"D\"],\"suppliers\":[\"C\",\"R\",\"U\",\"D\"],\"Clients\":[\"C\",\"R\",\"U\",\"D\"]},\"inventory\":{\"accessible\":true,\"categories\":[\"C\",\"R\",\"U\",\"D\"],\"products\":[\"C\",\"R\",\"U\",\"D\"],\"receive_items\":[\"C\",\"R\",\"U\",\"D\"],\"transfer_items\":[\"C\",\"R\",\"U\",\"D\"],\"requisitions\":[\"C\",\"R\",\"U\",\"D\"],\"purchase_order\":[\"C\",\"R\",\"U\",\"D\"],\"adjustments\":[\"C\",\"R\",\"U\",\"D\"]},\"expenses\":{\"accessible\":true,\"expenses_categories\":[\"C\",\"R\",\"U\",\"D\"],\"expenses\":[\"C\",\"R\",\"U\",\"D\"]},\"reports\":{\"accessible\":true,\"receiving_report\":[\"C\",\"R\",\"U\",\"D\"],\"transfers_report\":[\"C\",\"R\",\"U\",\"D\"],\"requisition_report\":[\"C\",\"R\",\"U\",\"D\"],\"purchase_order_report\":[\"C\",\"R\",\"U\",\"D\"],\"stock_status_report\":[\"C\",\"R\",\"U\",\"D\"],\"adjustments_report\":[\"C\",\"R\",\"U\",\"D\"],\"exipired_products\":[\"C\",\"R\",\"U\",\"D\"],\"sales_report\":[],\"Payment_History_report\":[]},\"settings\":{\"accessible\":true,\"users_roles\":[],\"items_units\":[\"C\",\"R\",\"U\",\"D\"],\"insurances\":[],\"departments\":[\"C\",\"R\",\"U\",\"D\"]},\"POS\":{\"accessible\":false}}', 1, 1, NULL),
(5, 'Administration', '{\"dashboard\":{\"accessible\":true},\"companies\":{\"accessible\":false},\"leads\":{\"accessible\":true,\"users\":[\"C\",\"R\",\"U\",\"D\"],\"suppliers\":[\"C\",\"R\",\"U\",\"D\"],\"Clients\":[\"C\",\"R\",\"U\",\"D\"]},\"inventory\":{\"accessible\":true,\"categories\":[\"C\",\"R\",\"U\",\"D\"],\"products\":[\"C\",\"R\",\"U\",\"D\"],\"receive_items\":[\"C\",\"R\",\"U\",\"D\"],\"transfer_items\":[\"C\",\"R\",\"U\",\"D\"],\"requisitions\":[\"C\",\"R\",\"U\",\"D\"],\"purchase_order\":[\"C\",\"R\",\"U\",\"D\"],\"adjustments\":[\"C\",\"R\",\"U\",\"D\"]},\"expenses\":{\"accessible\":true,\"expenses_categories\":[\"C\",\"R\",\"U\",\"D\"],\"expenses\":[\"C\",\"R\",\"U\",\"D\"]},\"reports\":{\"accessible\":true,\"receiving_report\":[\"C\",\"R\",\"U\",\"D\"],\"transfers_report\":[\"C\",\"R\",\"U\",\"D\"],\"requisition_report\":[\"C\",\"R\",\"U\",\"D\"],\"purchase_order_report\":[\"C\",\"R\",\"U\",\"D\"],\"stock_status_report\":[\"C\",\"R\",\"U\",\"D\"],\"adjustments_report\":[\"C\",\"R\",\"U\",\"D\"],\"exipired_products\":[\"C\",\"R\",\"U\",\"D\"],\"sales_report\":[],\"Payment_History_report\":[]},\"settings\":{\"accessible\":true,\"users_roles\":[\"C\",\"R\",\"U\",\"D\"],\"items_units\":[\"C\",\"R\",\"U\",\"D\"],\"insurances\":[],\"departments\":[\"C\",\"R\",\"U\",\"D\"]},\"POS\":{\"accessible\":false}}', NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
CREATE TABLE IF NOT EXISTS `sales` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `committed_date` date NOT NULL,
  `total_amount` double(18,3) UNSIGNED NOT NULL,
  `discounted_total` double(18,3) UNSIGNED DEFAULT NULL,
  `create_user` int(11) NOT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount_paid` double(18,3) UNSIGNED NOT NULL,
  `amount_remain` double(18,3) UNSIGNED NOT NULL,
  `discount_perc` float UNSIGNED DEFAULT NULL,
  `discount_amount` double(18,3) UNSIGNED DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `paid` tinyint(1) NOT NULL DEFAULT '0',
  `branch_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `SALES_CLIENT` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sale_items`
--

DROP TABLE IF EXISTS `sale_items`;
CREATE TABLE IF NOT EXISTS `sale_items` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sale_id` bigint(20) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` float UNSIGNED NOT NULL,
  `price` double(18,2) UNSIGNED NOT NULL,
  `amount` double(18,3) UNSIGNED NOT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `SALE_ITEM_PRODUCT` (`item_id`),
  KEY `SALE_ITEM` (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sheet1`
--

DROP TABLE IF EXISTS `sheet1`;
CREATE TABLE IF NOT EXISTS `sheet1` (
  `A` int(11) DEFAULT NULL,
  `Category` int(11) DEFAULT NULL,
  `Act` varchar(29) DEFAULT NULL,
  `D` varchar(10) DEFAULT NULL,
  `Qty` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sheet1`
--

INSERT INTO `sheet1` (`A`, `Category`, `Act`, `D`, `Qty`) VALUES
(1, 1, 'Adrenaline', '2024-05-30', 40),
(2, 1, 'Abacavir', '2025-01-30', 2),
(3, 1, 'Ampicillin Inj', '2024-09-30', 20),
(4, 1, 'Atazanavir', '2024-05-30', 16),
(5, 1, 'Artesunate', '2026-08-30', 210),
(6, 1, 'Buscopan', '2025-11-30', 70),
(7, 1, 'Cefotaxime', '2025-07-30', 110),
(8, 1, 'Ceftriaxone', '2025-10-30', 230),
(9, 1, 'Chlorexidine 1000ML', '2024-08-30', 1),
(10, 1, 'Cloxacillin', '2026-12-30', 45),
(12, 1, 'Chlorpramazine Inj 25mg/ml', '2024-08-30', 20),
(13, 1, 'Cimetidine Injection', '2024-08-30', 130),
(14, 1, 'Ciproflaxocine Inj 100ml', '2025-07-30', 85),
(15, 1, 'Co-trimoxazole', '2026-04-30', 800),
(16, 1, 'Dolutegravir/Lamividine', '2026-05-30', 20),
(17, 1, 'Dicynone 250mg/2ml', '2024-03-30', 32),
(18, 1, 'Depo-Provera', '2025-07-30', 280),
(19, 1, 'Dexamethozone', '2025-05-30', 40),
(20, 1, 'Diasepan Inj', '2024-04-30', 70),
(21, 1, 'Diclofenac Inj', '2025-05-30', 210),
(22, 1, 'Oxytocine', '2024-06-30', 0),
(23, 1, 'Esonium Inj', '2025-01-30', 20),
(24, 1, 'Eau Oxygenee 100ml', '2023-08-30', 2),
(25, 1, 'Flammazine Crème', '2024-12-30', 0),
(26, 1, 'Formol 40%', '2024-04-30', 0),
(27, 1, 'Furosemide(Lasix)', '2024-09-30', 40),
(28, 1, 'Favipiravir', '2023-07-30', 22),
(29, 1, 'Gentamicyne', '2025-11-30', 90),
(30, 1, 'Glucose 5% 500ml', '2025-07-30', 18),
(31, 1, 'Glucose 10% 250ml', '2024-09-30', 20),
(32, 1, 'Glucose 50% 100ml', '2024-07-30', 32),
(33, 1, 'Haloperidol 5mg/1ml', '2024-09-30', 0),
(34, 1, 'Hydrocortisone 100mg', '2025-09-30', 30),
(35, 1, 'Implanon Inj 68mg', '2026-09-30', 3),
(36, 1, 'Jadelle', '2024-07-30', 10),
(37, 1, 'KLY Lubrificant Gel 42G', '2025-06-30', 3),
(38, 1, 'Lidocaine 30ml', '2024-11-30', 16),
(39, 1, 'Morphine Sufate', '2025-04-30', 0),
(40, 1, 'Metoclapramide Inj', '2023-12-30', 70),
(41, 1, 'Metronidazole Inj(Flaggl)', '2024-09-30', 30),
(42, 1, 'Noristera', '2024-12-30', 0),
(43, 1, 'Normal Saline', '2025-04-30', 70),
(44, 1, 'Paracetamol Complimes', '2025-08-30', 660),
(45, 1, 'Paracetamol Inj(Perfalgan)', '2025-02-30', 230),
(46, 1, 'Paracetamol Supp 125mg', '2024-10-30', 90),
(47, 1, 'Pommade 10% 50g', '2024-10-30', 3),
(48, 1, 'Pethidine', '2025-08-30', 0),
(49, 1, 'Paracetamol Supp 250mg', '2024-10-30', 30),
(50, 1, 'Ondansetron Injection', '2026-06-30', 30),
(51, 1, 'Povidone 200ml', '2025-01-30', 4),
(52, 1, 'Ringer Lectate 500ml', '2026-02-30', 105),
(53, 1, 'Tenofov300MG+Lamivud300', '2023-11-30', 12),
(54, 1, 'Tenofovir Disoproxil Fumarate', '2025-10-30', 9),
(55, 1, 'Topical Anethesia Gel', '2050-12-30', 0),
(56, 1, 'Tetracycline Hydro', '2024-10-30', 30),
(57, 1, 'Tramadol Inject', '2025-05-30', 40),
(58, 1, 'Vitamin B complex', '2024-02-30', 40),
(59, 1, 'Ventoline 2.5mg/ml', '2025-10-30', 5),
(60, 1, 'Water for Injection 10ml', '2025-06-30', 500),
(61, 2, 'Abaisse Langue', '2050-12-30', 700),
(62, 2, 'Alcohol de natures', '2024-02-30', 15),
(63, 2, 'Bande Jersey', '2024-05-30', 0),
(64, 2, 'Bande 10&20cm', '2026-09-30', 29),
(65, 2, 'Bande de Gauze', '2025-05-30', 45),
(66, 2, 'Bande Platrees 10&20cm', '2050-12-30', 50),
(67, 2, 'Catheter G22', '2026-01-30', 500),
(68, 2, 'Catheter G24', '2026-01-30', 300),
(69, 2, 'Cotton', '2026-06-30', 5),
(70, 2, 'Ecouvillan(Sterile Swab)', '2027-02-30', 130),
(71, 2, 'Facemask', '2024-07-30', 50),
(72, 2, 'Feeding Tube no 6', '2025-11-30', 0),
(73, 2, 'Feeding Tube no 8', '2025-11-30', 0),
(74, 2, 'Feeding Tube no 18', '2024-09-30', 0),
(75, 2, 'Files de Suture 2/0&3/0', '2027-04-30', 72),
(76, 2, 'Foley Catheter CH10', '2025-08-30', 5),
(77, 2, 'Foley Catheter CH14', '2025-08-30', 5),
(78, 2, 'Foley Catheter CH12', '2024-06-30', 5),
(79, 2, 'Foley Catheter CH16', '2024-09-30', 7),
(80, 2, 'Foley Catheter CH18', '2027-11-30', 10),
(81, 2, 'Foley Catheter CH20', '2027-11-30', 8),
(82, 2, 'Foley Catheter CH22', '2025-08-30', 5),
(83, 2, 'Forehead Thermometer', '2050-12-30', 4),
(84, 2, 'Gant non-Sterile', '2027-05-30', 1500),
(85, 2, 'Gant Sterile', '2025-05-30', 60),
(86, 2, 'Gauze Roll', '2025-12-30', 7),
(87, 2, 'Gel pour Eco', '2027-02-30', 5),
(88, 2, 'Kidney Bowls', '2050-12-30', 0),
(89, 2, 'Needle Holder', '2050-12-30', 0),
(90, 2, 'Non-Absorbable Sature', '2026-07-30', 0),
(91, 2, 'Polyvol Buretteset', '2025-03-30', 20),
(92, 2, 'Neb.Mask Adult', '2026-11-30', 16),
(93, 2, 'Neb.Mask Pédiatrie', '2026-11-30', 15),
(94, 2, 'Otoscope', '2050-12-30', 0),
(95, 2, 'Sac a Urine(Urine Bag)', '2025-10-30', 10),
(96, 2, 'Seringue 20ml', '2026-07-30', 300),
(97, 2, 'Seringue a Insuline', '2027-03-30', 95),
(98, 2, 'Spardra', '2027-10-30', 6),
(99, 2, 'Sterile(Intra.Contrac Device)', '2025-07-30', 10),
(100, 2, 'Surgical Blades', '2026-08-30', 680),
(101, 2, 'Syringue 10ml', '2027-09-30', 100),
(102, 2, 'Syringue 50ml', '2024-06-30', 20),
(103, 2, 'Syringue 60ml', '2024-06-30', 13),
(104, 2, 'Syringue 2ml', '2027-06-30', 100),
(105, 2, 'Syringue 5ml', '2027-09-30', 200),
(106, 2, 'Trousse', NULL, 275),
(107, 2, 'Tulles Gras', '2027-06-30', 25),
(108, 5, 'Adhesive Plaster', '2024-03-30', 500),
(109, 5, 'AFP FIA', '2023-10-30', 0),
(110, 5, 'Aiguille G21', '2023-07-30', 5000),
(111, 5, 'Aiguille G23', '2027-05-30', 0),
(112, 5, 'Alcohol Pad', '2027-11-30', 2500),
(113, 5, 'Bandelette de glycemie', '2024-03-30', 150),
(114, 5, 'B-HCG FIA', '2027-03-30', 0),
(115, 5, 'Blue tips', '2027-03-30', 0),
(116, 5, 'Buette de Security', '2050-01-30', 48),
(117, 5, 'Chlamydia Test Device', '2024-08-30', 0),
(118, 5, 'Cholesterol Test Device', '2024-09-30', 0),
(119, 5, 'EAU DISTILLEE', '2023-11-30', 40),
(120, 5, 'EDTA Tube', '2024-12-30', 300),
(121, 5, 'H.Pylori AB', '2024-07-30', 50),
(122, 5, 'H.PYLORI AB FIA', NULL, 0),
(123, 5, 'H.Pylori AG', '2024-11-30', 50),
(124, 5, 'HBA1C', '2024-07-30', 0),
(125, 5, 'HBsAG', '2023-10-30', 720),
(126, 5, 'HBsAG FIA', '2023-12-30', 0),
(127, 5, 'HCV', '2025-01-30', 50),
(128, 5, 'HCV FIA', '2023-09-30', 0),
(129, 5, 'HIV 1/2 Stat pak CHEMBO', '2024-04-30', 0),
(130, 5, 'HIV Combo', '2023-12-30', 0),
(131, 5, 'Hepatite A', '2024-04-30', 0),
(132, 5, 'Lamelles', '2024-03-30', 100),
(133, 5, 'LH FIA', '2024-05-30', 0),
(134, 5, 'Pipette Pasteur', '2027-12-30', 500),
(135, 5, 'Pregnancy Test', '2024-06-30', 100),
(136, 5, 'Progesterone FIA', '2023-12-30', 0),
(137, 5, 'Prolactine FIA', '2024-05-30', 0),
(138, 5, 'PSA FIA', '2024-05-30', 0),
(139, 5, 'Rubeola IGG/IGM', '2024-04-30', 40),
(140, 5, 'Stool Container', '2027-12-30', 900),
(141, 5, 'SYR Rapid Test', '2024-12-30', 0),
(142, 5, 'TDR', '2026-03-30', 25),
(143, 5, 'Testosterone FIA', '2024-02-30', 0),
(144, 5, 'Toxo IGM/IGG', '2024-02-30', 0),
(145, 5, 'TSH FIA', '2023-09-30', 0),
(146, 5, 'TT3 FIA', '2023-09-30', 0),
(147, 5, 'TT4', '2023-09-30', 0),
(148, 5, 'TUBE Sec', '2024-09-30', 200),
(149, 5, 'Uric Acid', '2024-05-30', 50),
(150, 5, 'Urinalysis 3P', '2024-07-30', 100),
(151, 5, 'Urine Container', '2028-02-30', 600),
(152, 5, 'Vacteneur Needle', '2027-08-30', 600),
(153, 6, 'ALAT', NULL, 0),
(154, 6, 'ASAT', NULL, 0),
(155, 6, 'ASLO', NULL, 0),
(156, 6, 'Albumine', NULL, 0),
(157, 6, 'Amylase', NULL, 0),
(158, 6, 'Alkaline phosphatase', NULL, 0),
(159, 6, 'Blood grouping sera', NULL, 0),
(160, 6, 'Cell Pack', NULL, 0),
(161, 6, 'Creatinine', NULL, 0),
(162, 6, 'Chloride 50ML', NULL, 0),
(163, 6, 'CRP Test', NULL, 0),
(164, 6, 'Calcium', NULL, 0),
(165, 6, 'Estradiol FIA', NULL, 0),
(166, 6, 'FSH FIA', NULL, 0),
(167, 6, 'Gram Stain', NULL, 0),
(168, 6, 'Gamma GT', NULL, 0),
(169, 6, 'Lipase', NULL, 0),
(170, 6, 'Magnesium', NULL, 0),
(171, 6, 'Potassium', NULL, 0),
(172, 6, 'RF', NULL, 0),
(173, 6, 'Sodium', NULL, 0),
(174, 6, 'Stromatoyser 4DS 42ml', '2023-10-30', 1),
(175, 6, 'Stromatoyser 4DL 2l', NULL, 0),
(176, 6, 'Sulfolyser 500ml', NULL, 0),
(177, 6, 'Urea', NULL, 0),
(178, 6, 'Uric Acid', NULL, 0),
(179, 6, 'Widal Test', NULL, 0),
(180, 7, 'Lames', '2024-08-30', 200),
(181, 7, 'Western G.Tubes(VS)', '2026-05-30', 16);

-- --------------------------------------------------------

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
CREATE TABLE IF NOT EXISTS `stock` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED DEFAULT NULL,
  `department_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` double UNSIGNED NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=76 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stock`
--

INSERT INTO `stock` (`id`, `company_id`, `department_id`, `product_id`, `quantity`) VALUES
(1, 1, 1, 1, 10),
(2, 1, 1, 6, 30),
(3, 1, 1, 14, 270),
(4, 1, 1, 15, 9),
(5, 1, 1, 18, 40),
(6, 1, 1, 84, 28),
(7, 1, 1, 33, 30),
(8, 1, 1, 37, 3),
(9, 1, 1, 44, 65),
(10, 1, 1, 105, 100),
(11, 1, 1, 58, 1),
(12, 1, 3, 112, 250),
(13, 1, 3, 162, 3),
(14, 1, 3, 119, 400),
(15, 1, 3, 118, 20),
(16, 1, 3, 122, 70),
(17, 1, 3, 139, 200),
(18, 1, 3, 141, 100),
(19, 1, 3, 150, 200),
(20, 1, 3, 151, 100),
(21, 1, 3, 117, 75),
(22, 1, 3, 181, 1),
(23, 1, 3, 134, 50),
(24, 1, 3, 133, 250),
(25, 1, 3, 148, 25),
(26, 1, 3, 159, 1),
(27, 1, 3, 131, 100),
(28, 1, 3, 97, 1),
(29, 1, 3, 124, 30),
(30, 1, 3, 123, 25),
(31, 1, 3, 136, 25),
(32, 1, 3, 173, 1),
(33, 1, 1, 3, 44),
(34, 1, 1, 5, 15),
(35, 1, 1, 67, 200),
(36, 1, 1, 11, 10),
(37, 1, 1, 12, 20),
(38, 1, 1, 74, 12),
(39, 1, 1, 83, 1200),
(40, 1, 1, 28, 30),
(41, 1, 1, 42, 55),
(42, 1, 1, 51, 55),
(43, 1, 1, 59, 100),
(44, 1, 1, 99, 40),
(45, 1, 3, 8, 30),
(46, 1, 3, 15, 3),
(47, 1, 3, 20, 10),
(48, 1, 3, 28, 20),
(49, 1, 3, 98, 10),
(50, 1, 3, 57, 10),
(51, 1, 1, 22, 5),
(52, 1, 1, 43, 20),
(53, 1, 1, 96, 10),
(54, 1, 1, 100, 200),
(55, 1, 3, 69, 10),
(56, 1, 3, 83, 500),
(57, 1, 1, 48, 10),
(58, 1, 1, 68, 2),
(59, 1, 1, 19, 10),
(60, 1, 1, 29, 8),
(61, 1, 3, 111, 500),
(62, 1, 3, 175, 1),
(63, 1, 3, 174, 1),
(64, 1, 3, 23, 1),
(65, 1, 1, 85, 1),
(66, 1, 1, 49, 10),
(67, 1, 1, 57, 10),
(68, 1, 1, 20, 10),
(69, 1, 1, 39, 10),
(70, 1, 1, 50, 1),
(71, 1, 1, 86, 5),
(72, 1, 1, 69, 20),
(73, 1, 1, 97, 2),
(74, 1, 1, 36, 1),
(75, 1, 3, 110, 100);

-- --------------------------------------------------------

--
-- Table structure for table `stockin_histories`
--

DROP TABLE IF EXISTS `stockin_histories`;
CREATE TABLE IF NOT EXISTS `stockin_histories` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `stockin_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` double UNSIGNED NOT NULL,
  `price` double UNSIGNED DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `consumed_qty` double DEFAULT '0',
  `status` enum('IN_STOCK','EXPIRED','CONSUMED') DEFAULT 'IN_STOCK',
  `barcode` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=225 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stockin_histories`
--

INSERT INTO `stockin_histories` (`id`, `stockin_id`, `product_id`, `quantity`, `price`, `expiration_date`, `consumed_qty`, `status`, `barcode`, `created_at`, `deleted_at`, `updated_at`) VALUES
(1, 1, 1, 40, 0, NULL, 10, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-06 08:20:10'),
(2, 1, 2, 2, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(3, 1, 3, 20, 0, NULL, 20, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 14:20:22'),
(4, 1, 4, 16, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(5, 1, 5, 210, 0, NULL, 15, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 14:20:22'),
(6, 1, 6, 70, 0, NULL, 30, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:16'),
(7, 1, 7, 110, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(8, 1, 8, 230, 0, NULL, 30, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 14:38:10'),
(9, 1, 9, 1, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(10, 1, 10, 45, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(11, 1, 11, 20, 0, NULL, 10, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 14:20:22'),
(12, 1, 12, 130, 0, NULL, 20, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:16'),
(13, 1, 13, 85, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(14, 1, 14, 800, 0, NULL, 270, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 17:21:11'),
(15, 1, 15, 20, 0, NULL, 12, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 17:18:46'),
(16, 1, 16, 32, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(17, 1, 17, 280, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(18, 1, 18, 40, 0, NULL, 40, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 17:17:43'),
(19, 1, 19, 70, 0, NULL, 10, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 16:28:30'),
(20, 1, 20, 210, 0, NULL, 20, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:16'),
(21, 1, 21, 5, 100, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-10 13:00:34'),
(22, 1, 22, 2, 200, NULL, 5, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-10 13:02:24'),
(23, 1, 23, 5, 300, NULL, 1, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-10 13:11:19'),
(24, 1, 24, 10, 150, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-10 13:13:32'),
(25, 1, 25, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(26, 1, 26, 40, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(27, 1, 27, 22, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(28, 1, 28, 90, 0, NULL, 50, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 15:08:11'),
(29, 1, 29, 18, 0, NULL, 8, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:16'),
(30, 1, 30, 20, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(31, 1, 31, 32, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(32, 1, 32, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(33, 1, 33, 30, 0, NULL, 30, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:16'),
(34, 1, 34, 3, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(35, 1, 35, 10, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(36, 1, 36, 3, 0, NULL, 1, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:17'),
(37, 1, 37, 16, 0, NULL, 3, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:17'),
(38, 1, 38, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(39, 1, 39, 70, 0, NULL, 10, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:17'),
(40, 1, 40, 30, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(41, 1, 41, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(42, 1, 42, 70, 0, NULL, 55, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:16'),
(43, 1, 43, 660, 0, NULL, 20, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 14:54:22'),
(44, 1, 44, 230, 0, NULL, 65, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:16'),
(45, 1, 45, 90, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(46, 1, 46, 3, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(47, 1, 47, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(48, 1, 48, 30, 0, NULL, 10, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 15:08:11'),
(49, 1, 49, 30, 0, NULL, 10, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:16'),
(50, 1, 50, 4, 0, NULL, 1, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:17'),
(51, 1, 51, 105, 0, NULL, 55, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:16'),
(52, 1, 52, 12, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(53, 1, 53, 9, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(54, 1, 54, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(55, 1, 55, 30, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(56, 1, 56, 40, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(57, 1, 57, 40, 0, NULL, 20, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:16'),
(58, 1, 58, 5, 0, NULL, 1, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-06 08:20:10'),
(59, 1, 59, 500, 0, NULL, 100, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 15:08:12'),
(60, 1, 60, 700, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(61, 1, 61, 15, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(62, 1, 62, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(63, 1, 63, 29, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(64, 1, 64, 45, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(65, 1, 65, 50, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(66, 1, 66, 500, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(67, 1, 67, 300, 0, NULL, 200, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:16'),
(68, 1, 68, 5, 0, NULL, 2, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:17'),
(69, 1, 69, 130, 0, NULL, 30, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:17'),
(70, 1, 70, 50, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(71, 1, 71, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(72, 1, 72, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(73, 1, 73, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(74, 1, 74, 72, 0, NULL, 12, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 14:20:22'),
(75, 1, 75, 5, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(76, 1, 76, 5, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(77, 1, 77, 5, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(78, 1, 78, 7, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(79, 1, 79, 10, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(80, 1, 80, 8, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(81, 1, 81, 5, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(82, 1, 82, 4, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(83, 1, 83, 1500, 0, NULL, 1500, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 16:32:18'),
(84, 1, 84, 60, 0, NULL, 28, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 16:28:30'),
(85, 1, 85, 7, 0, NULL, 1, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 09:59:33'),
(86, 1, 86, 5, 0, NULL, 5, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:17'),
(87, 1, 87, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(88, 1, 88, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(89, 1, 89, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(90, 1, 90, 20, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(91, 1, 91, 16, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(92, 1, 92, 15, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(93, 1, 93, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(94, 1, 94, 10, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(95, 1, 95, 300, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(96, 1, 96, 95, 0, NULL, 10, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 14:54:22'),
(97, 1, 97, 6, 0, NULL, 3, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:17'),
(98, 1, 98, 10, 0, NULL, 10, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 14:38:10'),
(99, 1, 99, 680, 0, NULL, 40, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 15:50:17'),
(100, 1, 100, 100, 0, NULL, 100, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 14:54:22'),
(101, 1, 101, 20, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(102, 1, 102, 13, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(103, 1, 103, 100, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(104, 1, 104, 200, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(105, 1, 105, 275, 0, NULL, 100, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 14:20:23'),
(106, 1, 106, 25, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(107, 1, 107, 500, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(108, 1, 108, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(109, 1, 109, 5000, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(110, 1, 110, 0, 0, NULL, 0, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 16:15:14'),
(111, 1, 111, 2500, 0, NULL, 500, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 16:32:18'),
(112, 1, 112, 150, 0, NULL, 150, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 10:13:39'),
(113, 1, 113, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(114, 1, 114, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(115, 1, 115, 48, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(116, 1, 116, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(117, 1, 117, 0, 0, NULL, 0, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 09:59:27'),
(118, 1, 118, 40, 0, NULL, 20, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 09:48:31'),
(119, 1, 119, 300, 0, NULL, 300, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 16:32:18'),
(120, 1, 120, 50, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(121, 1, 121, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(122, 1, 122, 50, 0, NULL, 50, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 11:44:40'),
(123, 1, 123, 0, 0, NULL, 0, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 11:44:40'),
(124, 1, 124, 720, 0, NULL, 30, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 11:44:40'),
(125, 1, 125, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(126, 1, 126, 50, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(127, 1, 127, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(128, 1, 128, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(129, 1, 129, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(130, 1, 130, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(131, 1, 131, 100, 0, NULL, 100, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 11:44:39'),
(132, 1, 132, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(133, 1, 133, 500, 0, NULL, 250, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 10:13:39'),
(134, 1, 134, 100, 0, NULL, 50, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 10:13:39'),
(135, 1, 135, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(136, 1, 136, 0, 0, NULL, 0, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 11:44:40'),
(137, 1, 137, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(138, 1, 138, 40, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(139, 1, 139, 900, 0, NULL, 200, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-08 16:15:14'),
(140, 1, 140, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(141, 1, 141, 25, 0, NULL, 25, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 09:48:31'),
(142, 1, 142, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(143, 1, 143, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(144, 1, 144, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(145, 1, 145, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(146, 1, 146, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(147, 1, 147, 200, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(148, 1, 148, 50, 0, NULL, 25, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 10:13:39'),
(149, 1, 149, 100, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(150, 1, 150, 600, 0, NULL, 200, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 09:54:30'),
(151, 1, 151, 600, 0, NULL, 100, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 09:54:30'),
(152, 1, 152, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(153, 1, 153, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(154, 1, 154, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(155, 1, 155, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(156, 1, 156, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(157, 1, 157, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(158, 1, 158, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(159, 1, 159, 0, 0, NULL, 0, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 11:17:55'),
(160, 1, 160, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(161, 1, 161, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(162, 1, 162, 0, 0, NULL, 0, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 09:48:31'),
(163, 1, 163, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(164, 1, 164, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(165, 1, 165, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(166, 1, 166, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(167, 1, 167, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(168, 1, 168, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(169, 1, 169, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(170, 1, 170, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(171, 1, 171, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(172, 1, 172, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(173, 1, 173, 1, 0, NULL, 1, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 12:33:35'),
(174, 1, 174, 0, 0, NULL, 0, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 16:52:31'),
(175, 1, 175, 0, 0, NULL, 0, 'CONSUMED', NULL, '2023-07-02 18:17:34', NULL, '2023-07-07 16:52:31'),
(176, 1, 176, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(177, 1, 177, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(178, 1, 178, 0, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(179, 1, 179, 200, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(180, 1, 180, 16, 0, NULL, 0, 'IN_STOCK', NULL, '2023-07-02 18:17:34', NULL, NULL),
(181, 2, 112, 250, 200, '2024-12-01', 100, 'IN_STOCK', NULL, '2023-07-07 09:16:32', NULL, '2023-07-08 16:15:14'),
(182, 2, 117, 75, 2400, '2024-09-30', 75, 'CONSUMED', NULL, '2023-07-07 09:16:32', NULL, '2023-07-07 16:32:18'),
(183, 2, 162, 3, 12000, '2024-08-31', 3, 'CONSUMED', NULL, '2023-07-07 09:16:32', NULL, '2023-07-07 09:48:31'),
(184, 2, 181, 1, 13000, '2023-11-30', 1, 'CONSUMED', NULL, '2023-07-07 09:16:32', NULL, '2023-07-07 10:07:07'),
(185, 2, 141, 125, 800, '2026-03-31', 75, 'IN_STOCK', NULL, '2023-07-07 09:16:32', NULL, '2023-07-07 16:32:18'),
(186, 2, 119, 1000, 48, '2024-12-31', 100, 'IN_STOCK', NULL, '2023-07-07 09:16:32', NULL, '2023-07-08 16:15:14'),
(187, 3, 122, 100, 1200, '2025-07-01', 20, 'IN_STOCK', NULL, '2023-07-07 09:23:49', NULL, '2023-07-08 16:15:14'),
(188, 4, 159, 1, 0, '2024-05-27', 1, 'CONSUMED', NULL, '2023-07-07 11:14:22', NULL, '2023-07-07 11:17:55'),
(189, 4, 174, 1, 0, '2023-10-12', 1, 'CONSUMED', NULL, '2023-07-07 11:14:22', NULL, '2023-07-07 16:52:31'),
(190, 4, 175, 1, 0, '2024-03-15', 1, 'CONSUMED', NULL, '2023-07-07 11:14:22', NULL, '2023-07-07 16:52:31'),
(191, 5, 110, 500, 15, '2027-05-29', 100, 'IN_STOCK', NULL, '2023-07-07 11:33:16', NULL, '2023-07-08 16:15:14'),
(192, 5, 117, 75, 2400, '2024-09-30', 0, 'IN_STOCK', NULL, '2023-07-07 11:33:16', NULL, '2023-07-07 11:33:16'),
(193, 5, 123, 50, 2600, '2024-07-31', 25, 'IN_STOCK', NULL, '2023-07-07 11:33:16', NULL, '2023-07-07 11:44:40'),
(194, 5, 136, 25, 3040, '2024-05-31', 25, 'CONSUMED', NULL, '2023-07-07 11:33:16', NULL, '2023-07-07 11:44:40'),
(195, 5, 140, 100, 240, '2025-01-31', 0, 'IN_STOCK', NULL, '2023-07-07 11:33:17', NULL, '2023-07-07 11:33:17'),
(196, 5, 141, 125, 800, '2026-03-31', 0, 'IN_STOCK', NULL, '2023-07-07 11:33:17', NULL, '2023-07-07 11:33:17'),
(197, 6, 3, 200, 140, '2024-09-10', 24, 'IN_STOCK', NULL, '2023-07-07 12:39:13', NULL, '2023-07-08 15:50:17'),
(198, 6, 11, 20, 800, '2024-08-31', 0, 'IN_STOCK', NULL, '2023-07-07 12:39:13', NULL, '2023-07-07 12:39:13'),
(199, 7, 1, 200, 250, '2025-10-31', 0, 'IN_STOCK', NULL, '2023-07-07 12:44:43', NULL, '2023-07-07 12:44:43'),
(200, 7, 33, 100, 350, '2025-09-30', 0, 'IN_STOCK', NULL, '2023-07-07 12:44:43', NULL, '2023-07-07 12:44:43'),
(201, 7, 100, 400, 43, '2026-10-31', 100, 'IN_STOCK', NULL, '2023-07-07 12:44:43', NULL, '2023-07-08 15:50:16'),
(202, 7, 103, 100, 28, '2027-06-15', 0, 'IN_STOCK', NULL, '2023-07-07 12:44:43', NULL, '2023-07-07 12:44:43'),
(203, 8, 83, 3000, 0, '2027-04-30', 200, 'IN_STOCK', NULL, '2023-07-07 12:49:51', NULL, '2023-07-08 15:50:17'),
(204, 8, 45, 100, 0, '2024-06-30', 0, 'IN_STOCK', NULL, '2023-07-07 12:49:51', NULL, '2023-07-07 12:49:51'),
(205, 3, 2, 41, 0, '2023-08-16', 0, 'IN_STOCK', NULL, '2023-07-10 10:14:19', NULL, '2023-07-10 10:14:19'),
(206, 3, 1, 10, 0, '2023-08-24', 0, 'IN_STOCK', NULL, '2023-07-10 10:14:19', NULL, '2023-07-10 10:14:19'),
(207, 3, 108, 31, 0, '2023-08-03', 0, 'IN_STOCK', NULL, '2023-07-10 10:14:19', NULL, '2023-07-10 10:14:19'),
(208, 9, 155, 100, 0, '2023-07-27', 0, 'IN_STOCK', NULL, '2023-07-10 11:42:54', NULL, '2023-07-10 11:42:54'),
(209, 9, 157, 110, 0, '2023-08-05', 0, 'IN_STOCK', NULL, '2023-07-10 11:42:54', NULL, '2023-07-10 11:42:54'),
(210, 10, 77, 1, 0, '2023-08-02', 0, 'IN_STOCK', NULL, '2023-07-10 11:45:03', NULL, '2023-07-10 11:45:03'),
(211, 11, 2, 2, 0, '2023-08-09', 0, 'IN_STOCK', NULL, '2023-07-10 11:47:54', NULL, '2023-07-10 11:47:54'),
(212, 11, 1, 2, 0, '2023-08-18', 0, 'IN_STOCK', NULL, '2023-07-10 11:47:54', NULL, '2023-07-10 11:47:54'),
(213, 11, 108, 2, 0, '2023-09-07', 0, 'IN_STOCK', NULL, '2023-07-10 11:47:54', NULL, '2023-07-10 11:47:54'),
(214, 12, 159, 100, 200, '2023-08-16', 0, 'IN_STOCK', NULL, '2023-07-10 12:35:03', NULL, '2023-07-10 12:35:03'),
(215, 12, 116, 321, 300, '2023-09-06', 0, 'IN_STOCK', NULL, '2023-07-10 12:35:03', NULL, '2023-07-10 12:35:03'),
(216, 12, 161, 1021, 120, '2023-09-06', 0, 'IN_STOCK', NULL, '2023-07-10 12:35:03', NULL, '2023-07-10 12:35:03'),
(217, 13, 164, 12, 0, '2023-08-09', 0, 'IN_STOCK', NULL, '2023-07-10 12:38:17', NULL, '2023-07-10 12:38:17'),
(218, 14, 164, 12, 0, '2023-08-09', 0, 'IN_STOCK', NULL, '2023-07-10 12:38:27', NULL, '2023-07-10 12:38:27'),
(219, 15, 164, 12, 0, '2023-08-09', 0, 'IN_STOCK', NULL, '2023-07-10 12:39:15', NULL, '2023-07-10 12:39:15'),
(220, 16, 164, 12, 0, '2023-08-09', 0, 'IN_STOCK', NULL, '2023-07-10 12:40:45', NULL, '2023-07-10 12:40:45'),
(221, 27, 154, 100, 250, '2023-09-06', 0, 'IN_STOCK', NULL, '2023-07-10 13:59:57', NULL, '2023-07-10 13:59:57'),
(222, 28, 64, 10, 250, '2023-08-02', 0, 'IN_STOCK', NULL, '2023-07-10 15:17:03', NULL, '2023-07-10 15:17:03'),
(223, 28, 63, 100, 15, '2023-08-04', 0, 'IN_STOCK', NULL, '2023-07-10 15:17:03', NULL, '2023-07-10 15:17:03'),
(224, 28, 113, 111, 120, '2023-08-05', 0, 'IN_STOCK', NULL, '2023-07-10 15:17:03', NULL, '2023-07-10 15:17:03');

-- --------------------------------------------------------

--
-- Table structure for table `stockout_items`
--

DROP TABLE IF EXISTS `stockout_items`;
CREATE TABLE IF NOT EXISTS `stockout_items` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `stockout_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` double UNSIGNED NOT NULL,
  `price` double UNSIGNED NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stock_adjustments`
--

DROP TABLE IF EXISTS `stock_adjustments`;
CREATE TABLE IF NOT EXISTS `stock_adjustments` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `reference` varchar(30) DEFAULT NULL,
  `company_id` int(10) UNSIGNED NOT NULL,
  `adjustment_date` date DEFAULT NULL,
  `reason` varchar(100) DEFAULT NULL,
  `department_id` int(10) UNSIGNED DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stock_adjustment_items`
--

DROP TABLE IF EXISTS `stock_adjustment_items`;
CREATE TABLE IF NOT EXISTS `stock_adjustment_items` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `adjustment_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` double NOT NULL,
  `details` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stock_out`
--

DROP TABLE IF EXISTS `stock_out`;
CREATE TABLE IF NOT EXISTS `stock_out` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NOT NULL,
  `date_taken` date NOT NULL,
  `category` enum('SALES','PRESCRIPTIONS','EXPIRED','DAMAGED') NOT NULL,
  `patient_id` int(11) NOT NULL,
  `insurance_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`,`patient_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stock_receives`
--

DROP TABLE IF EXISTS `stock_receives`;
CREATE TABLE IF NOT EXISTS `stock_receives` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `reference` varchar(30) DEFAULT NULL,
  `company_id` int(10) UNSIGNED DEFAULT NULL,
  `date_received` date NOT NULL,
  `supplier_id` int(10) UNSIGNED NOT NULL,
  `amount` double UNSIGNED NOT NULL,
  `vat` enum('inclusive','exclusive') NOT NULL,
  `file_url` varchar(255) DEFAULT NULL,
  `amount_paid` double UNSIGNED DEFAULT NULL,
  `paid` tinyint(1) DEFAULT '0',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stock_receives`
--

INSERT INTO `stock_receives` (`id`, `reference`, `company_id`, `date_received`, `supplier_id`, `amount`, `vat`, `file_url`, `amount_paid`, `paid`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'C62854154B81B8D3CA58', 1, '2023-07-02', 1, 0, 'exclusive', NULL, 0, 1, 2, '2023-07-02 18:17:34', NULL, NULL),
(2, '88E49760434D8AB8D9D7', 1, '2023-07-01', 2, 427000, 'exclusive', NULL, NULL, 0, 3, '2023-07-07 09:16:32', '2023-07-07 09:16:32', NULL),
(4, '7882534549EE9E2476D8', 1, '2023-07-06', 6, 0, 'exclusive', NULL, NULL, 0, 3, '2023-07-07 11:14:22', '2023-07-07 11:14:22', NULL),
(5, 'FFC0C72E4B6799BF51A7', 1, '2023-07-06', 2, 517500, 'exclusive', NULL, NULL, 0, 3, '2023-07-07 11:33:16', '2023-07-07 11:33:16', NULL),
(6, 'BD9C64B44ECA85E3DECE', 1, '2023-07-06', 7, 44000, 'exclusive', NULL, NULL, 0, 3, '2023-07-07 12:39:13', '2023-07-07 12:39:13', NULL),
(7, '9A565109439F9E82508C', 1, '2023-07-06', 4, 105000, 'exclusive', NULL, NULL, 0, 3, '2023-07-07 12:44:43', '2023-07-07 12:44:43', NULL),
(8, '07780072409995C67667', 1, '2023-07-06', 5, 0, 'exclusive', NULL, NULL, 0, 3, '2023-07-07 12:49:51', '2023-07-07 12:49:51', NULL),
(28, '8D0A03AB43809638E438', 1, '2023-07-10', 3, 17320, 'exclusive', NULL, NULL, 0, 3, '2023-07-10 15:17:03', '2023-07-10 15:17:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `stock_transfers`
--

DROP TABLE IF EXISTS `stock_transfers`;
CREATE TABLE IF NOT EXISTS `stock_transfers` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED DEFAULT NULL,
  `department_id` int(10) UNSIGNED NOT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `date_transfered` date NOT NULL,
  `amount` double UNSIGNED NOT NULL,
  `taken_by` int(10) UNSIGNED DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `requisition_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stock_transfers`
--

INSERT INTO `stock_transfers` (`id`, `company_id`, `department_id`, `reference`, `date_transfered`, `amount`, `taken_by`, `created_by`, `requisition_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, '7458899149A3BC7DC6E5', '2023-07-05', 0, 4, 3, NULL, '2023-07-06 08:20:09', '2023-07-06 08:20:09', NULL),
(2, 1, 3, '76D52C954788B009B587', '2023-07-01', 94800, 5, 3, NULL, '2023-07-07 09:48:30', '2023-07-07 09:48:30', NULL),
(3, 1, 3, 'B2F887B64B1AAD583703', '2023-07-04', 34800, 5, 3, NULL, '2023-07-07 09:54:29', '2023-07-07 09:54:29', NULL),
(4, 1, 3, '4452F8474D09B9AC61DC', '2023-07-03', 60000, 5, 3, NULL, '2023-07-07 09:59:27', '2023-07-07 09:59:27', NULL),
(5, 1, 3, 'DECB6A6A432E828562FC', '2023-07-01', 13000, 5, 3, NULL, '2023-07-07 10:07:07', '2023-07-07 10:07:07', NULL),
(6, 1, 3, 'E15E95754D4D82247AE5', '2023-07-05', 90000, 5, 3, NULL, '2023-07-07 10:13:39', '2023-07-07 10:13:39', NULL),
(7, 1, 3, '5808F13A4A7D8539367D', '2023-07-06', 0, 5, 3, NULL, '2023-07-07 11:17:55', '2023-07-07 11:17:55', NULL),
(8, 1, 3, 'AFABACA44B5AB4C85D21', '2023-07-06', 177000, 5, 3, NULL, '2023-07-07 11:44:39', '2023-07-07 11:44:39', NULL),
(9, 1, 3, '0532561741CB8D42B7E0', '2023-07-06', 0, 5, 3, NULL, '2023-07-07 12:33:35', '2023-07-07 12:33:35', NULL),
(10, 1, 1, 'D3CF3D2846E98106F936', '2023-07-01', 14300, 4, 3, NULL, '2023-07-07 14:20:22', '2023-07-07 14:20:22', NULL),
(11, 1, 1, '9DEA60574183883C7991', '2023-07-01', 0, 4, 3, NULL, '2023-07-07 14:25:27', '2023-07-07 14:25:27', NULL),
(12, 1, 3, 'A9C22A95464AABF1E136', '2023-07-03', 0, 4, 3, NULL, '2023-07-07 14:38:10', '2023-07-07 14:38:10', NULL),
(13, 1, 1, '724AD4484FDCA2A9786F', '2023-07-04', 4300, 4, 3, NULL, '2023-07-07 14:54:22', '2023-07-07 14:54:22', NULL),
(14, 1, 3, '55B13C97413F9729AE46', '2023-07-03', 0, 5, 3, NULL, '2023-07-07 15:02:47', '2023-07-07 15:02:47', NULL),
(15, 1, 1, 'FB1794B9423982E5BD3D', '2023-07-06', 1960, 4, 3, NULL, '2023-07-07 15:08:11', '2023-07-07 15:08:11', NULL),
(16, 1, 1, 'E5DDFA744A41A0C682A4', '2023-07-07', 0, 4, 3, NULL, '2023-07-07 16:28:30', '2023-07-07 16:28:30', NULL),
(17, 1, 3, '9C86EF3B4DB3B3D670CA', '2023-07-07', 94800, 5, 3, NULL, '2023-07-07 16:32:18', '2023-07-07 16:32:18', NULL),
(18, 1, 3, '81B34FCB4FEBA7646FE9', '2023-07-07', 0, 5, 3, NULL, '2023-07-07 16:52:31', '2023-07-07 16:52:31', NULL),
(19, 1, 1, 'D803005042ED8F012ABA', '2023-07-06', 0, 4, 3, NULL, '2023-07-07 17:17:43', '2023-07-07 17:17:43', NULL),
(20, 1, 1, 'AE49029C4FF1B910D1BC', '2023-07-07', 0, 4, 3, NULL, '2023-07-07 17:18:46', '2023-07-07 17:18:46', NULL),
(21, 1, 1, 'C72618744FAE92541B96', '2023-07-07', 0, 4, 3, NULL, '2023-07-07 17:20:34', '2023-07-07 17:20:34', NULL),
(22, 1, 1, '817A03584BAE9D7C1245', '2023-07-06', 0, 4, 3, NULL, '2023-07-07 17:21:11', '2023-07-07 17:21:11', NULL),
(23, 1, 3, '25F0EE0143BF9BA060B7', '2023-07-06', 0, 5, 3, NULL, '2023-07-08 09:58:15', '2023-07-08 09:58:15', NULL),
(24, 1, 1, '4241BC734ADE8AD17631', '2023-07-07', 0, 4, 3, NULL, '2023-07-08 09:59:33', '2023-07-08 09:59:33', NULL),
(25, 1, 1, 'E481DB4342E6B49F294E', '2023-07-08', 9200, 4, 3, NULL, '2023-07-08 15:50:15', '2023-07-08 15:50:15', NULL),
(26, 1, 3, '2CE02B8441C186DF69C7', '2023-07-08', 40300, 5, 3, NULL, '2023-07-08 16:15:13', '2023-07-08 16:15:13', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `stock_transfer_items`
--

DROP TABLE IF EXISTS `stock_transfer_items`;
CREATE TABLE IF NOT EXISTS `stock_transfer_items` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `transfer_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `quantity` double UNSIGNED NOT NULL,
  `price` double UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=193 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stock_transfer_items`
--

INSERT INTO `stock_transfer_items` (`id`, `transfer_id`, `product_id`, `quantity`, `price`, `created_at`, `updated_at`, `deleted_at`) VALUES
(57, 1, 1, 10, 0, '2023-07-06 08:20:10', '2023-07-06 08:20:10', NULL),
(58, 1, 6, 10, 0, '2023-07-06 08:20:10', '2023-07-06 08:20:10', NULL),
(59, 1, 14, 60, 0, '2023-07-06 08:20:10', '2023-07-06 08:20:10', NULL),
(60, 1, 15, 2, 0, '2023-07-06 08:20:10', '2023-07-06 08:20:10', NULL),
(61, 1, 18, 10, 0, '2023-07-06 08:20:10', '2023-07-06 08:20:10', NULL),
(62, 1, 84, 8, 0, '2023-07-06 08:20:10', '2023-07-06 08:20:10', NULL),
(63, 1, 33, 10, 0, '2023-07-06 08:20:10', '2023-07-06 08:20:10', NULL),
(64, 1, 37, 2, 0, '2023-07-06 08:20:10', '2023-07-06 08:20:10', NULL),
(65, 1, 44, 15, 0, '2023-07-06 08:20:10', '2023-07-06 08:20:10', NULL),
(66, 1, 105, 50, 0, '2023-07-06 08:20:10', '2023-07-06 08:20:10', NULL),
(67, 1, 58, 1, 0, '2023-07-06 08:20:10', '2023-07-06 08:20:10', NULL),
(68, 2, 112, 50, 200, '2023-07-07 09:48:31', '2023-07-07 09:48:31', NULL),
(69, 2, 162, 3, 12000, '2023-07-07 09:48:31', '2023-07-07 09:48:31', NULL),
(70, 2, 119, 100, 48, '2023-07-07 09:48:31', '2023-07-07 09:48:31', NULL),
(71, 2, 118, 20, 0, '2023-07-07 09:48:31', '2023-07-07 09:48:31', NULL),
(72, 2, 122, 20, 1200, '2023-07-07 09:48:31', '2023-07-07 09:48:31', NULL),
(73, 2, 139, 100, 0, '2023-07-07 09:48:31', '2023-07-07 09:48:31', NULL),
(74, 2, 141, 25, 800, '2023-07-07 09:48:31', '2023-07-07 09:48:31', NULL),
(75, 2, 150, 100, 0, '2023-07-07 09:48:31', '2023-07-07 09:48:31', NULL),
(76, 3, 112, 50, 200, '2023-07-07 09:54:29', '2023-07-07 09:54:29', NULL),
(77, 3, 119, 100, 48, '2023-07-07 09:54:30', '2023-07-07 09:54:30', NULL),
(78, 3, 141, 25, 800, '2023-07-07 09:54:30', '2023-07-07 09:54:30', NULL),
(79, 3, 150, 100, 0, '2023-07-07 09:54:30', '2023-07-07 09:54:30', NULL),
(80, 3, 151, 100, 0, '2023-07-07 09:54:30', '2023-07-07 09:54:30', NULL),
(81, 4, 117, 25, 2400, '2023-07-07 09:59:27', '2023-07-07 09:59:27', NULL),
(82, 5, 181, 1, 13000, '2023-07-07 10:07:07', '2023-07-07 10:07:07', NULL),
(83, 6, 112, 50, 200, '2023-07-07 10:13:39', '2023-07-07 10:13:39', NULL),
(84, 6, 117, 25, 2400, '2023-07-07 10:13:39', '2023-07-07 10:13:39', NULL),
(85, 6, 134, 50, 0, '2023-07-07 10:13:39', '2023-07-07 10:13:39', NULL),
(86, 6, 133, 250, 0, '2023-07-07 10:13:39', '2023-07-07 10:13:39', NULL),
(87, 6, 141, 25, 800, '2023-07-07 10:13:39', '2023-07-07 10:13:39', NULL),
(88, 6, 148, 25, 0, '2023-07-07 10:13:39', '2023-07-07 10:13:39', NULL),
(89, 7, 159, 1, 0, '2023-07-07 11:17:55', '2023-07-07 11:17:55', NULL),
(90, 8, 131, 100, 0, '2023-07-07 11:44:39', '2023-07-07 11:44:39', NULL),
(91, 8, 97, 1, 0, '2023-07-07 11:44:40', '2023-07-07 11:44:40', NULL),
(92, 8, 122, 30, 1200, '2023-07-07 11:44:40', '2023-07-07 11:44:40', NULL),
(93, 8, 124, 30, 0, '2023-07-07 11:44:40', '2023-07-07 11:44:40', NULL),
(94, 8, 123, 25, 2600, '2023-07-07 11:44:40', '2023-07-07 11:44:40', NULL),
(95, 8, 136, 25, 3040, '2023-07-07 11:44:40', '2023-07-07 11:44:40', NULL),
(96, 9, 173, 1, 0, '2023-07-07 12:33:35', '2023-07-07 12:33:35', NULL),
(97, 10, 3, 20, 140, '2023-07-07 14:20:22', '2023-07-07 14:20:22', NULL),
(98, 10, 5, 15, 0, '2023-07-07 14:20:22', '2023-07-07 14:20:22', NULL),
(99, 10, 67, 100, 0, '2023-07-07 14:20:22', '2023-07-07 14:20:22', NULL),
(100, 10, 11, 10, 800, '2023-07-07 14:20:22', '2023-07-07 14:20:22', NULL),
(101, 10, 12, 10, 0, '2023-07-07 14:20:22', '2023-07-07 14:20:22', NULL),
(102, 10, 14, 60, 0, '2023-07-07 14:20:22', '2023-07-07 14:20:22', NULL),
(103, 10, 18, 10, 0, '2023-07-07 14:20:22', '2023-07-07 14:20:22', NULL),
(104, 10, 74, 12, 0, '2023-07-07 14:20:22', '2023-07-07 14:20:22', NULL),
(105, 10, 83, 300, 0, '2023-07-07 14:20:22', '2023-07-07 14:20:22', NULL),
(106, 10, 84, 10, 0, '2023-07-07 14:20:22', '2023-07-07 14:20:22', NULL),
(107, 10, 28, 10, 0, '2023-07-07 14:20:22', '2023-07-07 14:20:22', NULL),
(108, 10, 33, 10, 350, '2023-07-07 14:20:23', '2023-07-07 14:20:23', NULL),
(109, 10, 42, 10, 0, '2023-07-07 14:20:23', '2023-07-07 14:20:23', NULL),
(110, 10, 44, 20, 0, '2023-07-07 14:20:23', '2023-07-07 14:20:23', NULL),
(111, 10, 51, 20, 0, '2023-07-07 14:20:23', '2023-07-07 14:20:23', NULL),
(112, 10, 105, 50, 0, '2023-07-07 14:20:23', '2023-07-07 14:20:23', NULL),
(113, 10, 59, 50, 0, '2023-07-07 14:20:23', '2023-07-07 14:20:23', NULL),
(114, 11, 15, 1, 0, '2023-07-07 14:25:27', '2023-07-07 14:25:27', NULL),
(115, 11, 99, 20, 0, '2023-07-07 14:25:27', '2023-07-07 14:25:27', NULL),
(116, 12, 8, 30, 0, '2023-07-07 14:38:10', '2023-07-07 14:38:10', NULL),
(117, 12, 15, 3, 0, '2023-07-07 14:38:10', '2023-07-07 14:38:10', NULL),
(118, 12, 20, 10, 0, '2023-07-07 14:38:10', '2023-07-07 14:38:10', NULL),
(119, 12, 28, 20, 0, '2023-07-07 14:38:10', '2023-07-07 14:38:10', NULL),
(120, 12, 98, 10, 0, '2023-07-07 14:38:10', '2023-07-07 14:38:10', NULL),
(121, 12, 57, 10, 0, '2023-07-07 14:38:11', '2023-07-07 14:38:11', NULL),
(122, 13, 15, 1, 0, '2023-07-07 14:54:22', '2023-07-07 14:54:22', NULL),
(123, 13, 22, 5, 0, '2023-07-07 14:54:22', '2023-07-07 14:54:22', NULL),
(124, 13, 83, 500, 0, '2023-07-07 14:54:22', '2023-07-07 14:54:22', NULL),
(125, 13, 42, 15, 0, '2023-07-07 14:54:22', '2023-07-07 14:54:22', NULL),
(126, 13, 43, 20, 0, '2023-07-07 14:54:22', '2023-07-07 14:54:22', NULL),
(127, 13, 44, 10, 0, '2023-07-07 14:54:22', '2023-07-07 14:54:22', NULL),
(128, 13, 51, 15, 0, '2023-07-07 14:54:22', '2023-07-07 14:54:22', NULL),
(129, 13, 96, 10, 0, '2023-07-07 14:54:22', '2023-07-07 14:54:22', NULL),
(130, 13, 100, 100, 43, '2023-07-07 14:54:22', '2023-07-07 14:54:22', NULL),
(131, 14, 69, 10, 0, '2023-07-07 15:02:47', '2023-07-07 15:02:47', NULL),
(132, 14, 83, 200, 0, '2023-07-07 15:02:47', '2023-07-07 15:02:47', NULL),
(133, 15, 28, 20, 0, '2023-07-07 15:08:11', '2023-07-07 15:08:11', NULL),
(134, 15, 18, 10, 0, '2023-07-07 15:08:11', '2023-07-07 15:08:11', NULL),
(135, 15, 3, 14, 140, '2023-07-07 15:08:11', '2023-07-07 15:08:11', NULL),
(136, 15, 48, 10, 0, '2023-07-07 15:08:11', '2023-07-07 15:08:11', NULL),
(137, 15, 67, 50, 0, '2023-07-07 15:08:11', '2023-07-07 15:08:11', NULL),
(138, 15, 59, 50, 0, '2023-07-07 15:08:12', '2023-07-07 15:08:12', NULL),
(139, 15, 42, 5, 0, '2023-07-07 15:08:12', '2023-07-07 15:08:12', NULL),
(140, 15, 83, 200, 0, '2023-07-07 15:08:12', '2023-07-07 15:08:12', NULL),
(141, 15, 68, 1, 0, '2023-07-07 15:08:12', '2023-07-07 15:08:12', NULL),
(142, 16, 19, 10, 0, '2023-07-07 16:28:30', '2023-07-07 16:28:30', NULL),
(143, 16, 42, 10, 0, '2023-07-07 16:28:30', '2023-07-07 16:28:30', NULL),
(144, 16, 51, 10, 0, '2023-07-07 16:28:30', '2023-07-07 16:28:30', NULL),
(145, 16, 6, 10, 0, '2023-07-07 16:28:30', '2023-07-07 16:28:30', NULL),
(146, 16, 99, 10, 0, '2023-07-07 16:28:30', '2023-07-07 16:28:30', NULL),
(147, 16, 84, 10, 0, '2023-07-07 16:28:30', '2023-07-07 16:28:30', NULL),
(148, 16, 29, 5, 0, '2023-07-07 16:28:30', '2023-07-07 16:28:30', NULL),
(149, 16, 44, 10, 0, '2023-07-07 16:28:30', '2023-07-07 16:28:30', NULL),
(150, 17, 111, 500, 0, '2023-07-07 16:32:18', '2023-07-07 16:32:18', NULL),
(151, 17, 112, 50, 200, '2023-07-07 16:32:18', '2023-07-07 16:32:18', NULL),
(152, 17, 117, 25, 2400, '2023-07-07 16:32:18', '2023-07-07 16:32:18', NULL),
(153, 17, 83, 300, 0, '2023-07-07 16:32:18', '2023-07-07 16:32:18', NULL),
(154, 17, 141, 25, 800, '2023-07-07 16:32:18', '2023-07-07 16:32:18', NULL),
(155, 17, 119, 100, 48, '2023-07-07 16:32:18', '2023-07-07 16:32:18', NULL),
(156, 18, 175, 1, 0, '2023-07-07 16:52:31', '2023-07-07 16:52:31', NULL),
(157, 18, 174, 1, 0, '2023-07-07 16:52:31', '2023-07-07 16:52:31', NULL),
(158, 19, 18, 10, 0, '2023-07-07 17:17:43', '2023-07-07 17:17:43', NULL),
(159, 19, 15, 2, 0, '2023-07-07 17:17:43', '2023-07-07 17:17:43', NULL),
(160, 20, 15, 3, 0, '2023-07-07 17:18:46', '2023-07-07 17:18:46', NULL),
(161, 21, 14, 90, 0, '2023-07-07 17:20:34', '2023-07-07 17:20:34', NULL),
(162, 22, 14, 60, 0, '2023-07-07 17:21:11', '2023-07-07 17:21:11', NULL),
(163, 23, 23, 1, 0, '2023-07-08 09:58:15', '2023-07-08 09:58:15', NULL),
(164, 24, 85, 1, 0, '2023-07-08 09:59:33', '2023-07-08 09:59:33', NULL),
(165, 25, 49, 10, 0, '2023-07-08 15:50:16', '2023-07-08 15:50:16', NULL),
(166, 25, 100, 100, 43, '2023-07-08 15:50:16', '2023-07-08 15:50:16', NULL),
(167, 25, 57, 10, 0, '2023-07-08 15:50:16', '2023-07-08 15:50:16', NULL),
(168, 25, 12, 10, 0, '2023-07-08 15:50:16', '2023-07-08 15:50:16', NULL),
(169, 25, 6, 10, 0, '2023-07-08 15:50:16', '2023-07-08 15:50:16', NULL),
(170, 25, 20, 10, 0, '2023-07-08 15:50:16', '2023-07-08 15:50:16', NULL),
(171, 25, 44, 10, 0, '2023-07-08 15:50:16', '2023-07-08 15:50:16', NULL),
(172, 25, 33, 10, 350, '2023-07-08 15:50:16', '2023-07-08 15:50:16', NULL),
(173, 25, 42, 15, 0, '2023-07-08 15:50:16', '2023-07-08 15:50:16', NULL),
(174, 25, 51, 10, 0, '2023-07-08 15:50:16', '2023-07-08 15:50:16', NULL),
(175, 25, 29, 3, 0, '2023-07-08 15:50:16', '2023-07-08 15:50:16', NULL),
(176, 25, 67, 50, 0, '2023-07-08 15:50:17', '2023-07-08 15:50:17', NULL),
(177, 25, 39, 10, 0, '2023-07-08 15:50:17', '2023-07-08 15:50:17', NULL),
(178, 25, 3, 10, 140, '2023-07-08 15:50:17', '2023-07-08 15:50:17', NULL),
(179, 25, 83, 200, 0, '2023-07-08 15:50:17', '2023-07-08 15:50:17', NULL),
(180, 25, 50, 1, 0, '2023-07-08 15:50:17', '2023-07-08 15:50:17', NULL),
(181, 25, 37, 1, 0, '2023-07-08 15:50:17', '2023-07-08 15:50:17', NULL),
(182, 25, 99, 10, 0, '2023-07-08 15:50:17', '2023-07-08 15:50:17', NULL),
(183, 25, 86, 5, 0, '2023-07-08 15:50:17', '2023-07-08 15:50:17', NULL),
(184, 25, 69, 20, 0, '2023-07-08 15:50:17', '2023-07-08 15:50:17', NULL),
(185, 25, 97, 2, 0, '2023-07-08 15:50:17', '2023-07-08 15:50:17', NULL),
(186, 25, 36, 1, 0, '2023-07-08 15:50:17', '2023-07-08 15:50:17', NULL),
(187, 25, 68, 1, 0, '2023-07-08 15:50:17', '2023-07-08 15:50:17', NULL),
(188, 26, 139, 100, 0, '2023-07-08 16:15:14', '2023-07-08 16:15:14', NULL),
(189, 26, 119, 100, 48, '2023-07-08 16:15:14', '2023-07-08 16:15:14', NULL),
(190, 26, 110, 100, 15, '2023-07-08 16:15:14', '2023-07-08 16:15:14', NULL),
(191, 26, 112, 50, 200, '2023-07-08 16:15:14', '2023-07-08 16:15:14', NULL),
(192, 26, 122, 20, 1200, '2023-07-08 16:15:14', '2023-07-08 16:15:14', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
CREATE TABLE IF NOT EXISTS `subscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `phone` bigint(20) NOT NULL,
  `email` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `organization` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE IF NOT EXISTS `suppliers` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `tin_number` double DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `company_id`, `name`, `phone`, `email`, `tin_number`, `address`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'SYSTEM INITIALIZATION', '0781418920', 'null', 123456, 'null', 2, '2023-07-02 22:21:42', '2023-07-04 14:45:40', NULL),
(2, 1, 'VIDAPHARMA LTD', '0788308076', NULL, 106600120, NULL, 3, '2023-07-07 09:04:42', '2023-07-07 09:04:42', NULL),
(3, 1, 'MNR EAST AFRICA LTD', '0788309352', NULL, 102780391, NULL, 3, '2023-07-07 09:05:51', '2023-07-07 09:05:51', NULL),
(4, 1, 'Depot Pharmaceutique uBUMWE', '100176659', NULL, 788777477, NULL, 3, '2023-07-07 09:07:13', '2023-07-07 09:07:13', NULL),
(5, 1, 'DEPOT PHARMACEUTIQUE LE MEDICAL', '0788595700', NULL, 100607090, NULL, 3, '2023-07-07 09:08:32', '2023-07-07 09:08:32', NULL),
(6, 1, 'PYRAMID PHARMA LIMITED', '0788583083', NULL, 1026522018, NULL, 3, '2023-07-07 11:08:46', '2023-07-07 11:08:46', NULL),
(7, 1, 'SANA MEDICAL STORES', '0788687992', NULL, 106729487, NULL, 3, '2023-07-07 12:36:25', '2023-07-07 12:36:25', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
CREATE TABLE IF NOT EXISTS `units` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `name`, `description`, `deleted_at`, `updated_at`, `created_at`) VALUES
(1, 'G', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(2, 'Mg', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(3, 'L', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(4, 'Ml', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(5, '%', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(6, 'Number', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(7, 'Meter', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(8, 'Cm', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(9, 'Piece', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(10, 'Tablet', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(11, 'Flacon', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(12, 'Strip', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(13, 'Bottle', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(14, 'Vial', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(15, 'Ampoule', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(16, 'Roll', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(17, 'Box', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(18, 'Pair', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(19, 'Set', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(20, 'Blister', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(21, 'Catheter', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(22, 'Blad', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(23, 'Sterile', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(24, 'Lancet', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(25, 'Tip', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(26, 'Container', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(27, 'Cell', NULL, NULL, NULL, '2023-03-14 09:33:49'),
(28, 'SAC', NULL, NULL, '2023-05-21 19:00:06', '2023-05-21 19:00:06'),
(29, 'Kg', NULL, NULL, '2023-05-25 16:45:47', '2023-05-25 16:45:47'),
(30, 'AMPOULE', NULL, NULL, '2023-06-30 16:04:38', '2023-06-30 16:04:38');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `company_id` int(10) UNSIGNED DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `remember_token` varchar(50) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`,`phone`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `company_id`, `department_id`, `first_name`, `last_name`, `name`, `email`, `password`, `phone`, `remember_token`, `email_verified_at`, `role_id`, `last_login`, `status`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, NULL, 'Webmaster', 'Admin', 'Webmaster Admin', 'webmaster@gmail.com', '$2y$10$/sPmt73SgNEORz2bQdyx2ea.jmAiOF7RVGJDDYHHsrRXL8MyOSHTS', NULL, NULL, NULL, NULL, '2023-07-10 12:03:25', 1, NULL, NULL, '2023-07-10 10:03:25', NULL),
(2, 1, NULL, 'Mike', 'Vedaste Buhiga', 'Mike Vedaste Buhiga', 'mikevedaste@gmail.com', '$2y$10$7K7T0l0t8fbg.rw0AymZ7.roLEDkyDxVOYJ.ABkj5JM6Kw2U0zYhC', NULL, NULL, NULL, 1, '2023-07-10 10:40:42', 1, 1, '2023-06-30 16:10:28', '2023-07-10 08:40:42', NULL),
(3, 1, NULL, 'Mahoro', 'Mariam', 'Mahoro Mariam', 'mariam@gmail.com', '$2y$10$ZeRGNHhDoWkuziQTSjBXgusfPrBtTDloysQW59SRNGqYZK69ZQ.vq', NULL, NULL, NULL, 2, '2023-07-10 12:06:36', 1, 2, '2023-07-03 08:54:53', '2023-07-10 10:06:36', NULL),
(4, 1, NULL, 'Manirafasha', 'Phocas', 'Manirafasha Phocas', 'phocas@gmail.com', '$2y$10$76dT.I3LUJYLA/y4BvBH4.XZdFt8e.jD5KCKps1AIH5Q2fVtdxnD.', NULL, NULL, NULL, 3, '2023-07-05 17:15:32', 1, 2, '2023-07-05 11:27:16', '2023-07-05 15:18:15', NULL),
(5, 1, NULL, 'SAKINDI', 'SAMUEL', 'SAKINDI SAMUEL', 'samuel@gmail.com', '$2y$10$iTViEjJuXBOjRIia48CpseJGoTEuj55Rms0mgybCk1a1hrjbSR6Me', NULL, NULL, NULL, 4, '2023-07-07 13:54:35', 1, 2, '2023-07-05 11:37:28', '2023-07-07 11:54:35', NULL),
(6, 1, NULL, 'MINDJE', 'CHRISTIAN', 'MINDJE CHRISTIAN', 'christian@gmail.com', '$2y$10$ibif3o44HNriq4q7zwPhj.T52ABZ3JUAZYtmxZvrcx6k1H4bHS38a', NULL, NULL, NULL, 5, '2023-07-05 17:08:04', 1, 2, '2023-07-05 11:45:03', '2023-07-05 15:08:04', NULL),
(7, 1, 2, 'UWAMARIYA', 'JEANNE D\'ARC', 'UWAMARIYA JEANNE D\'ARC', 'uwamariya@gmail.com', '$2y$10$bbd2R5qoMWVMbgsmp6csVO6WfR3U1zG9FFyALEjb25pipISXh.hTO', 'null', NULL, NULL, 6, NULL, 1, 2, '2023-07-05 11:54:39', '2023-07-05 13:40:04', NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `PAID_SALE` FOREIGN KEY (`transaction_id`) REFERENCES `sales` (`id`),
  ADD CONSTRAINT `PAYMENT_MODE` FOREIGN KEY (`payment_type`) REFERENCES `payment_methods` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
