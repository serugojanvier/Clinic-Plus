-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 18, 2023 at 06:27 PM
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
-- Database: `clinic_plus`
--

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
CREATE TABLE IF NOT EXISTS `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `name`, `phone`, `email`, `tin_number`, `address_line`, `created_by`, `logo`, `created_at`, `deleted_at`, `updated_at`, `reference`, `status`) VALUES
(1, 'Horebu medical clinics', '0781418920', 'horebumedicalclinic@gmail.com', 1118255363, 'Kigali-remera', 1, NULL, '2023-01-13 07:49:29', NULL, '2023-01-17 15:11:50', 'Testing', 1),
(5, 'Horebu', '781418920', 'muhongejohn5@gmail.com', 12345678, 'Gasabo', 1, NULL, '2023-01-17 15:17:41', NULL, '2023-01-17 16:21:35', 'ccea92da4973b72bdfec', 1),
(6, 'Baho', '781418920', 'serugoprogrammer1@gmail.com', 123456, 'Gasabo', 1, NULL, '2023-01-18 07:10:22', '2023-01-18 09:32:51', '2023-01-18 09:32:51', '1f4f773743609fe6dd4b', 1),
(7, 'Test Hospital', '781418920', 'serugoprogrammer1@gmail.com', 7895247, 'Gasabo', 1, NULL, '2023-01-18 07:11:03', '2023-01-18 09:32:51', '2023-01-18 09:32:51', '294fda94484db438b610', 1);

-- --------------------------------------------------------

--
-- Table structure for table `insurances`
--

DROP TABLE IF EXISTS `insurances`;
CREATE TABLE IF NOT EXISTS `insurances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_ref` enum('RHIA','PRIVATE','INTERNATIONAL','OTHER') NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `discount` float DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `insurances`
--

INSERT INTO `insurances` (`id`, `group_ref`, `name`, `description`, `discount`, `status`) VALUES
(1, 'RHIA', 'RSSB', 'Test', NULL, 1),
(2, 'RHIA', 'UAP', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `code` varchar(100) NOT NULL,
  `reference` varchar(20) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `cost_price` double DEFAULT NULL,
  `rhia_price` double DEFAULT NULL,
  `private_price` double DEFAULT NULL,
  `inter_price` double(18,2) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `company_id`, `code`, `reference`, `name`, `unit_id`, `cost_price`, `rhia_price`, `private_price`, `inter_price`, `category_id`, `status`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, '343RE', '34656', 'Paracetamol 500MG', 1, 2000, 4500, 5000, 6000.00, 1, 1, 1, '2023-01-14 09:43:38', '2023-01-14 09:44:06', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

DROP TABLE IF EXISTS `product_categories`;
CREATE TABLE IF NOT EXISTS `product_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product_categories`
--

INSERT INTO `product_categories` (`id`, `company_id`, `parent_id`, `name`, `description`) VALUES
(1, 1, NULL, 'Drugs', 'All Drugs'),
(3, 1, NULL, 'Drugs', 'All Drugs');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `permissions` text,
  `company_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `permissions`, `company_id`, `status`) VALUES
(1, 'Admin', 'can_delete_user', 1, 1),
(2, 'Admin', 'can_create_user', 1, 1),
(3, 'Admin', 'can_manage_users', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
CREATE TABLE IF NOT EXISTS `stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` double NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `deleted_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stockin_histories`
--

DROP TABLE IF EXISTS `stockin_histories`;
CREATE TABLE IF NOT EXISTS `stockin_histories` (
  `id` int(11) NOT NULL,
  `stockin_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` double NOT NULL,
  `price` double DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `barcode` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stockout_items`
--

DROP TABLE IF EXISTS `stockout_items`;
CREATE TABLE IF NOT EXISTS `stockout_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stockout_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` double NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `stock_out`
--

DROP TABLE IF EXISTS `stock_out`;
CREATE TABLE IF NOT EXISTS `stock_out` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `date_taken` date NOT NULL,
  `category` enum('SALES','PRESCRIPTIONS') NOT NULL,
  `patient_id` int(11) NOT NULL,
  `insurance_id` int(11) NOT NULL,
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `date_receives` date NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `vat` enum('inclusive','exclusive') NOT NULL,
  `file_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE IF NOT EXISTS `suppliers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `tin_number` int(11) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `company_id`, `name`, `phone`, `email`, `tin_number`, `address`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'VINE PHARMACY', '0781418920', 'vinepharmacy@gmail.com', 1252415, 'Kigali-GASABO-REMERA', 1, '2023-01-13 09:16:03', '2023-01-13 09:16:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
CREATE TABLE IF NOT EXISTS `units` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `name`, `description`) VALUES
(1, 'PC', 'test 2'),
(4, 'PC', 'test 4');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `remember_token` varchar(50) DEFAULT NULL,
  `email_verified_at` datetime DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `last_login` date DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`,`phone`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `company_id`, `first_name`, `last_name`, `name`, `email`, `password`, `phone`, `remember_token`, `email_verified_at`, `role_id`, `last_login`, `status`, `created_by`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, 'Webmaster', 'Admin', 'Webmaster Admin', 'webmaster@gmail.com', '$2y$10$/sPmt73SgNEORz2bQdyx2ea.jmAiOF7RVGJDDYHHsrRXL8MyOSHTS', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(2, 5, 'Serugo', 'Javnvier', 'Serugo Javnvier', 'serugojanvier@gmail.com', '$2y$10$V6IWWclmMuWBXuMPxFqJtexcCM00KstGyDgv.cfpoedqfkHCLZGwy', '788543365', NULL, NULL, 1, NULL, 1, 1, '2023-01-18 15:17:15', '2023-01-18 15:17:15', NULL),
(3, 5, 'Vah', 'Kwizera', 'Vah Kwizera', 'vah@gmail.com', '$2y$10$VlJ0PYH5dGWFxdDFYTfi4ewxJA45eTRDMx2/Z./9lf.U0.S3g3YLe', '788254478', NULL, NULL, 1, NULL, 1, 1, '2023-01-18 16:15:50', '2023-01-18 16:15:50', NULL);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
