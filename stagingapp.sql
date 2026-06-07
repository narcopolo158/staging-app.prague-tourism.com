-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Počítač: localhost
-- Vytvořeno: Ned 07. čen 2026, 08:14
-- Verze serveru: 10.11.14-MariaDB-0+deb12u2-log
-- Verze PHP: 8.1.34

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `stagingapp`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `admins`
--

DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins` (
  `id` int(10) UNSIGNED NOT NULL,
  `email` varchar(190) NOT NULL,
  `name` varchar(120) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `totp_secret` varchar(64) DEFAULT NULL,
  `totp_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `pin_hash` varchar(255) DEFAULT NULL,
  `home_tenant_id` int(10) UNSIGNED DEFAULT NULL,
  `role` enum('owner','manager') NOT NULL,
  `status` enum('active','inactive','archived') NOT NULL DEFAULT 'active',
  `last_login_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `admins`
--

INSERT INTO `admins` (`id`, `email`, `name`, `password_hash`, `totp_secret`, `totp_enabled`, `pin_hash`, `home_tenant_id`, `role`, `status`, `last_login_at`, `created_at`, `updated_at`) VALUES
(1, 'michal@prague-tourism.com', 'Michal', '$2y$12$UMufEs7cfTqS5SzW70d3mu69hu4G7S71P/gPKEHFu3gw3vCv0OKPe', 'V6TJUE3IMHVQJC4P2MKX5LS4OZLVTH3C', 1, NULL, NULL, 'owner', 'active', '2026-06-06 19:28:17', '2026-05-31 17:04:45', '2026-06-06 19:28:17'),
(2, 'ux@prague-tourism.com', 'UX Expert', '$2y$10$Mqo8bcMVtTub7CdNwQbuHuX.B9bgcGv6c4Y6u20UVKCtuC21xmQhC', NULL, 0, NULL, 1, 'manager', 'active', NULL, '2026-06-03 19:40:53', '2026-06-03 19:40:53'),
(3, 'it@prague-tourism.com', 'Admin', '$2y$12$AOGdrJLHyQWLlCCwb3XbmeF.d6fi56ALvw5JYHK/7bldwF1BVo.ry', NULL, 0, NULL, NULL, 'manager', 'active', '2026-06-03 21:01:55', '2026-06-03 20:33:44', '2026-06-03 21:01:55'),
(4, 'heligon@gmail.com', 'Jarry', '$2y$12$iS/Djox8WiRHeTMgmCiDBeggBsCRxKgAP/XOHo9WqU1ahgOZiGTeu', NULL, 0, NULL, NULL, 'owner', 'active', '2026-06-06 11:36:09', '2026-06-04 12:11:33', '2026-06-06 11:36:09'),
(5, 'bahriberk.kayali@gmail.com', 'Bahri', '$2y$12$mvRhVRrT0ZFlrOu42ihOcOaUm.RcDZc2GoDQcl1gJA7GZ8862.uLq', NULL, 0, NULL, NULL, 'manager', 'active', '2026-06-06 13:52:02', '2026-06-04 14:48:44', '2026-06-06 13:52:02'),
(6, 'bahri@prague-tourism.com', 'Bahri', '$2y$12$I1MRI/wbW440XhCjcnPnG.idF/C1.HgbRFrf80xeluLemxWBFBiD.', NULL, 0, NULL, NULL, 'manager', 'active', NULL, '2026-06-05 11:01:15', '2026-06-05 11:01:29');

-- --------------------------------------------------------

--
-- Struktura tabulky `admin_recovery_codes`
--

DROP TABLE IF EXISTS `admin_recovery_codes`;
CREATE TABLE `admin_recovery_codes` (
  `id` int(10) UNSIGNED NOT NULL,
  `admin_id` int(10) UNSIGNED NOT NULL,
  `code_hash` varchar(255) NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `admin_recovery_codes`
--

INSERT INTO `admin_recovery_codes` (`id`, `admin_id`, `code_hash`, `used_at`, `created_at`) VALUES
(1, 1, '$2y$12$Gd/cNyiy0YJB9OcwHfOZiO8Of1ACqub4KPF.q3bU08IIM1tdLwxcm', NULL, '2026-05-31 17:04:45'),
(2, 1, '$2y$12$kxCPC/1tRAXBR/B9shOTK.mxQi25kCzMsW3W6FluHCKM1sOxosN/m', NULL, '2026-05-31 17:04:45'),
(3, 1, '$2y$12$HjO018vhqAx4iq38vHerhuYbEPvKg1hwE6FqsQhzbDcPm4441A8hC', NULL, '2026-05-31 17:04:46'),
(4, 1, '$2y$12$pMK9fI.bmeCt8ZDzAxvnYOj6w05fFcDb18p7OroM8fltkPUBZWZoG', NULL, '2026-05-31 17:04:46'),
(5, 1, '$2y$12$TulxChFJxsU9YyxmdXymzuZAy0bahyrbhm3Hrnti6y5sPjuG5/kDy', NULL, '2026-05-31 17:04:46'),
(6, 1, '$2y$12$5zxzHkBE/OOUbN4H1hmZ0uQiOFhZ3QGHwTXrmF9qWbg.8bbKO6wGG', NULL, '2026-05-31 17:04:46'),
(7, 1, '$2y$12$nQGx3OP9SjE70nwVg5rGPeDiJYiSEg5N2Y5EiWxBf9uoTZ42Xwmt.', NULL, '2026-05-31 17:04:47'),
(8, 1, '$2y$12$eg/GS1LmIqi./aqNtb5Z6utUHPgjnaIZ/7MH1vVNxlB1D9r3cYHfe', NULL, '2026-05-31 17:04:47');

-- --------------------------------------------------------

--
-- Struktura tabulky `agencies`
--

DROP TABLE IF EXISTS `agencies`;
CREATE TABLE `agencies` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `brand_color` varchar(9) DEFAULT NULL,
  `logo_url` varchar(255) DEFAULT NULL,
  `contact_name` varchar(120) DEFAULT NULL,
  `contact_email` varchar(190) DEFAULT NULL,
  `contact_phone` varchar(40) DEFAULT NULL,
  `order_instructions` text DEFAULT NULL,
  `default_commission_pct` decimal(5,2) NOT NULL DEFAULT 0.00,
  `payment_model` enum('commission','net_rate','prepaid') NOT NULL DEFAULT 'commission',
  `is_internal` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('active','inactive','archived') NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deposit_enabled` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `agencies`
--

INSERT INTO `agencies` (`id`, `name`, `brand_color`, `logo_url`, `contact_name`, `contact_email`, `contact_phone`, `order_instructions`, `default_commission_pct`, `payment_model`, `is_internal`, `status`, `created_at`, `updated_at`, `deposit_enabled`) VALUES
(1, 'Big Bus Tours', NULL, NULL, NULL, 'info@hopon-hopoff.cz', '+420 602405701', 'No need to call', 25.00, 'prepaid', 0, 'active', '2026-06-01 06:07:44', '2026-06-06 13:42:34', 0),
(2, 'Premiant', NULL, NULL, NULL, 'info@premiant.cz', '+420 606 600 123', NULL, 20.00, 'prepaid', 0, 'active', '2026-06-01 06:07:44', '2026-06-01 08:37:00', 0),
(3, 'Best Tour', NULL, NULL, 'Jitka Bílá', 'besttour@besttour.cz', '+420 602 322 603', 'Volat do agentury\r\nPoslat potvrzovací email do agentury', 20.00, 'prepaid', 0, 'active', '2026-06-01 06:07:44', '2026-06-06 12:29:52', 0),
(4, 'Martin Tour', NULL, NULL, NULL, 'info@martintour.cz', '+420 224 212 473', NULL, 20.00, 'prepaid', 0, 'active', '2026-06-01 06:07:44', '2026-06-01 08:37:00', 0),
(5, 'Agency Artistic Intl (AAI)', NULL, NULL, 'Jitka Horská', 'aai-concert@aai-concert.cz', '+420 224 224 706', 'Call the agency to \r\n+420 224 224 706\r\n+420 602 201 309', 20.00, 'prepaid', 0, 'active', '2026-06-01 06:07:44', '2026-06-06 12:20:26', 0),
(6, 'Marie Tycová', NULL, NULL, NULL, NULL, '+420 774 427 600', NULL, 20.00, 'prepaid', 0, 'active', '2026-06-01 06:07:44', '2026-06-01 08:37:00', 0),
(7, 'Mozart Dinner', NULL, NULL, NULL, 'info@mozartdinner.cz', '+420 778 091 222', NULL, 20.00, 'prepaid', 0, 'active', '2026-06-01 06:07:44', '2026-06-01 08:37:00', 0),
(8, 'McGee\'s Trips & Tickets', NULL, NULL, 'Ladislav Procházka', 'info@mcgeesghosttours.com', '+420 723 306 963', 'Zavolat na +420 723 306 963', 30.00, 'prepaid', 0, 'active', '2026-06-01 06:07:44', '2026-06-03 20:20:44', 1),
(9, 'Prague Boats', NULL, NULL, NULL, 'info@pragueboats.cz', '+420 724 202 505', 'Okružní plavby lze prodat přímo. U gastronomických plaveb (oběd/večeře) potvrď rezervaci telefonicky předem.', 20.00, 'prepaid', 0, 'active', '2026-06-01 06:07:44', '2026-06-01 14:47:34', 0),
(10, 'Prague Venice', NULL, NULL, NULL, 'info@prazskebenatky.cz', NULL, NULL, 20.00, 'prepaid', 0, 'active', '2026-06-01 06:07:44', '2026-06-02 13:11:36', 0),
(11, 'U Pavouka', NULL, NULL, NULL, 'groups@upavouka.com', '+420 702 154 432', NULL, 20.00, 'prepaid', 0, 'active', '2026-06-01 06:07:44', '2026-06-02 13:08:48', 0),
(12, 'bm art', NULL, NULL, 'Jiří Fiedler', 'bmart@bmart.cz', '+420 603 465 561', 'Volat do agentury \r\n+420 603 465 561\r\n+420 603 710 411', 30.00, 'prepaid', 0, 'active', '2026-06-01 06:07:44', '2026-06-06 12:34:02', 0),
(13, 'Folklore Garden', NULL, NULL, NULL, 'info@folkloregarden.cz', '+420 724 334 340', NULL, 20.00, 'prepaid', 0, 'active', '2026-06-01 06:07:44', '2026-06-02 13:05:51', 0),
(14, 'Magical Prague', NULL, NULL, NULL, 'info@magicalprague.com', '+420 773 777 477', 'Volat agentuře \r\n+420 773 777 477', 20.00, 'prepaid', 0, 'active', '2026-06-01 06:07:44', '2026-06-06 12:53:41', 1),
(15, 'PragueWay', NULL, NULL, NULL, 'info@pragueway.com', '+420 731 238 264', NULL, 25.00, 'prepaid', 1, 'active', '2026-06-01 06:07:44', '2026-06-03 20:19:33', 1),
(16, 'Image Black Light Theatre', NULL, NULL, NULL, 'image@imagetheatre.cz', '+420 222 314 448', 'Call the agency\r\n+420 732 156 343\r\n+420 222 314 448', 20.00, 'prepaid', 0, 'active', '2026-06-01 06:07:44', '2026-06-06 12:51:37', 0),
(17, 'Srnec Theatre', NULL, NULL, NULL, 'tickets@srnectheatre.com', '+420 774 574 475', NULL, 20.00, 'prepaid', 0, 'active', '2026-06-01 06:07:44', '2026-06-02 13:11:36', 0),
(18, 'WOW Show', NULL, NULL, NULL, NULL, '+420 777 061 623 / +420 225 113 194', NULL, 20.00, 'prepaid', 0, 'active', '2026-06-01 06:07:44', '2026-06-02 13:11:36', 0),
(19, 'Pilsner Beer Experience', NULL, NULL, NULL, NULL, NULL, NULL, 20.00, 'prepaid', 0, 'inactive', '2026-06-01 06:07:44', '2026-06-01 08:37:00', 0),
(20, 'Story of Prague', NULL, NULL, NULL, NULL, NULL, NULL, 20.00, 'prepaid', 0, 'inactive', '2026-06-01 06:07:44', '2026-06-01 08:37:00', 0),
(21, 'Bohemia Adventures', NULL, NULL, NULL, 'info@bohemiadventures.com', '+420 702 046 321', 'Volat do agntury\r\n+420 702 046 321\r\n+420 601 383 876\r\n+420 792 323 895', 20.00, 'prepaid', 0, 'active', '2026-06-02 13:11:36', '2026-06-06 12:37:30', 0);

-- --------------------------------------------------------

--
-- Struktura tabulky `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
CREATE TABLE `audit_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `actor_type` enum('seller','admin','system') NOT NULL,
  `actor_id` int(10) UNSIGNED DEFAULT NULL,
  `tenant_id` int(10) UNSIGNED DEFAULT NULL,
  `action` varchar(80) NOT NULL,
  `target_type` varchar(60) DEFAULT NULL,
  `target_id` varchar(60) DEFAULT NULL,
  `diff_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`diff_json`)),
  `reason` varchar(255) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `audit_log`
--

INSERT INTO `audit_log` (`id`, `actor_type`, `actor_id`, `tenant_id`, `action`, `target_type`, `target_id`, `diff_json`, `reason`, `ip_address`, `created_at`) VALUES
(1, 'admin', 1, 1, 'seller.create', 'seller', '1', NULL, NULL, '90.180.55.48', '2026-05-31 17:09:35'),
(2, 'admin', 1, NULL, 'product.update', 'product', '6', NULL, NULL, '90.180.55.48', '2026-06-01 07:03:44'),
(3, 'admin', 1, NULL, 'product.update', 'product', '118', NULL, NULL, '90.180.55.48', '2026-06-01 17:34:03'),
(4, 'admin', 1, NULL, 'product.update', 'product', '17', NULL, NULL, '90.180.55.48', '2026-06-02 16:05:26'),
(5, 'seller', 1, NULL, 'sale.cancel', 'sale', '13', '{\"status\":{\"from\":\"paid\",\"to\":\"cancelled\"},\"voucher\":\"PTI-2026-000013\",\"total_czk\":\"6460.00\",\"realised\":false,\"approved_by\":null}', 'Debil', NULL, '2026-06-02 17:22:04'),
(6, 'admin', 1, NULL, 'product.update', 'product', '17', NULL, NULL, '90.180.55.48', '2026-06-02 18:08:32'),
(7, 'admin', 1, NULL, 'product.update', 'product', '118', NULL, NULL, '90.180.55.48', '2026-06-03 14:10:53'),
(8, 'admin', 1, NULL, 'product.update', 'product', '118', NULL, NULL, '90.180.55.48', '2026-06-03 16:28:15'),
(9, 'admin', 1, NULL, 'product.update', 'product', '79', NULL, NULL, '90.180.55.48', '2026-06-03 16:44:36'),
(10, 'admin', 1, NULL, 'product.update', 'product', '11', NULL, NULL, '90.180.55.48', '2026-06-03 17:06:42'),
(11, 'admin', 1, NULL, 'product.update', 'product', '18', NULL, NULL, '90.180.55.48', '2026-06-03 17:34:27'),
(12, 'admin', 1, NULL, 'agency.update', 'agency', '15', NULL, NULL, '90.180.55.48', '2026-06-03 20:19:33'),
(13, 'admin', 1, NULL, 'agency.update', 'agency', '8', NULL, NULL, '90.180.55.48', '2026-06-03 20:20:44'),
(14, 'admin', 1, NULL, 'product.update', 'product', '12', NULL, NULL, '90.180.55.48', '2026-06-03 20:26:26'),
(15, 'admin', 1, NULL, 'product.update', 'product', '13', NULL, NULL, '90.180.55.48', '2026-06-03 20:28:31'),
(16, 'admin', 1, NULL, 'admin.create', 'admin', '3', '{\"email\":\"it@prague-tourism.com\",\"role\":\"manager\",\"2fa\":false}', NULL, NULL, '2026-06-03 20:33:44'),
(17, 'admin', 1, NULL, 'product.update', 'product', '14', NULL, NULL, '90.180.55.48', '2026-06-03 20:36:13'),
(18, 'admin', 1, NULL, 'product.update', 'product', '110', NULL, NULL, '90.180.55.48', '2026-06-03 20:44:03'),
(19, 'admin', 1, NULL, 'product.update', 'product', '114', NULL, NULL, '90.180.55.48', '2026-06-03 20:44:41'),
(20, 'admin', 1, NULL, 'product.update', 'product', '94', NULL, NULL, '90.180.55.48', '2026-06-03 20:51:29'),
(21, 'admin', 1, NULL, 'product.update', 'product', '92', NULL, NULL, '90.180.55.48', '2026-06-03 20:52:05'),
(22, 'admin', 1, NULL, 'product.update', 'product', '98', NULL, NULL, '90.180.55.48', '2026-06-03 20:52:32'),
(23, 'admin', 1, NULL, 'product.update', 'product', '96', NULL, NULL, '90.180.55.48', '2026-06-03 20:53:14'),
(24, 'admin', 1, NULL, 'product.update', 'product', '108', NULL, NULL, '90.180.55.48', '2026-06-03 20:54:07'),
(25, 'admin', 1, NULL, 'product.update', 'product', '11', NULL, NULL, '90.180.55.48', '2026-06-04 09:36:08'),
(26, 'admin', 1, NULL, 'product.update', 'product', '105', NULL, NULL, '90.180.55.48', '2026-06-04 09:50:17'),
(27, 'system', NULL, NULL, 'sale.reservation.confirm', 'sale', '39', '{\"via\":\"dashboard\"}', NULL, NULL, '2026-06-04 09:51:54'),
(28, 'system', NULL, NULL, 'sale.reservation.confirm', 'sale', '40', '{\"via\":\"dashboard\"}', NULL, NULL, '2026-06-04 09:52:05'),
(29, 'system', NULL, NULL, 'sale.reservation.confirm', 'sale', '41', '{\"via\":\"dashboard\"}', NULL, NULL, '2026-06-04 10:25:04'),
(30, 'system', NULL, NULL, 'sale.reservation.confirm', 'sale', '42', '{\"via\":\"dashboard\"}', NULL, NULL, '2026-06-04 10:25:11'),
(31, 'admin', 1, NULL, 'admin.create', 'admin', '4', '{\"email\":\"heligon@gmail.com\",\"role\":\"owner\",\"2fa\":false}', NULL, NULL, '2026-06-04 12:11:33'),
(32, 'admin', 1, NULL, 'admin.create', 'admin', '5', '{\"email\":\"bahriberk.kayali@gmail.com\",\"role\":\"manager\",\"2fa\":false}', NULL, NULL, '2026-06-04 14:48:44'),
(33, 'system', NULL, NULL, 'sale.reservation.confirm', 'sale', '43', '{\"via\":\"dashboard\"}', NULL, NULL, '2026-06-04 14:59:00'),
(34, 'system', NULL, NULL, 'sale.reservation.confirm', 'sale', '44', '{\"via\":\"dashboard\"}', NULL, NULL, '2026-06-04 14:59:01'),
(35, 'system', NULL, NULL, 'sale.reservation.confirm', 'sale', '44', '{\"via\":\"dashboard\"}', NULL, NULL, '2026-06-04 14:59:02'),
(36, 'system', NULL, NULL, 'sale.reservation.confirm', 'sale', '44', '{\"via\":\"dashboard\"}', NULL, NULL, '2026-06-04 14:59:02'),
(37, 'system', NULL, NULL, 'sale.reservation.confirm', 'sale', '45', '{\"via\":\"dashboard\"}', NULL, NULL, '2026-06-04 14:59:03'),
(38, 'admin', 1, NULL, 'admin.create', 'admin', '6', '{\"email\":\"bahri@prague-tourism.com\",\"role\":\"manager\",\"2fa\":true}', NULL, NULL, '2026-06-05 11:01:17'),
(39, 'admin', 1, NULL, 'admin.2fa.disable', 'admin', '6', '[]', NULL, NULL, '2026-06-05 11:01:29'),
(40, 'admin', 5, NULL, 'product.update', 'product', '81', NULL, NULL, '185.249.112.67', '2026-06-05 12:17:40'),
(41, 'admin', 5, NULL, 'product.update', 'product', '81', NULL, NULL, '185.249.112.67', '2026-06-05 12:22:46'),
(42, 'admin', 5, NULL, 'product.update', 'product', '81', NULL, NULL, '185.249.112.67', '2026-06-05 12:26:51'),
(43, 'admin', 5, NULL, 'product.update', 'product', '81', NULL, NULL, '185.249.112.67', '2026-06-05 12:28:04'),
(44, 'admin', 5, NULL, 'product.update', 'product', '82', NULL, NULL, '185.249.112.67', '2026-06-05 12:39:57'),
(45, 'admin', 5, NULL, 'product.update', 'product', '79', NULL, NULL, '185.249.112.67', '2026-06-05 12:51:09'),
(46, 'admin', 5, NULL, 'product.update', 'product', '72', NULL, NULL, '185.249.112.67', '2026-06-05 12:54:08'),
(47, 'admin', 5, NULL, 'product.update', 'product', '72', NULL, NULL, '185.249.112.67', '2026-06-05 12:54:43'),
(48, 'admin', 5, NULL, 'product.update', 'product', '77', NULL, NULL, '185.249.112.67', '2026-06-05 13:07:45'),
(49, 'admin', 5, NULL, 'product.update', 'product', '78', NULL, NULL, '185.249.112.67', '2026-06-05 13:09:18'),
(50, 'admin', 5, NULL, 'product.update', 'product', '80', NULL, NULL, '185.249.112.67', '2026-06-05 13:10:44'),
(51, 'admin', 5, NULL, 'product.update', 'product', '73', NULL, NULL, '185.249.112.67', '2026-06-05 13:11:41'),
(52, 'admin', 5, NULL, 'product.update', 'product', '74', NULL, NULL, '185.249.112.67', '2026-06-05 13:16:31'),
(53, 'admin', 5, NULL, 'product.update', 'product', '76', NULL, NULL, '185.249.112.67', '2026-06-05 13:23:02'),
(54, 'admin', 5, NULL, 'product.update', 'product', '75', NULL, NULL, '185.249.112.67', '2026-06-05 13:33:04'),
(55, 'admin', 5, NULL, 'product.update', 'product', '81', NULL, NULL, '185.249.112.67', '2026-06-05 13:43:02'),
(56, 'admin', 5, NULL, 'dimension.update', 'pricing', '234', NULL, NULL, '185.249.112.67', '2026-06-05 13:45:33'),
(57, 'admin', 5, NULL, 'dimension.update', 'pricing', '234', NULL, NULL, '185.249.112.67', '2026-06-05 13:47:17'),
(58, 'admin', 5, NULL, 'dimension.update', 'pricing', '234', NULL, NULL, '185.249.112.67', '2026-06-05 13:51:09'),
(59, 'admin', 5, NULL, 'dimension.update', 'pricing', '234', NULL, NULL, '185.249.112.67', '2026-06-05 13:51:19'),
(60, 'admin', 5, NULL, 'pricing.matrix.save', 'version', '242', NULL, NULL, '185.249.112.67', '2026-06-05 13:51:49'),
(61, 'admin', 5, NULL, 'product.update', 'product', '83', NULL, NULL, '185.249.112.67', '2026-06-05 14:43:48'),
(62, 'system', NULL, NULL, 'sale.reservation.confirm', 'sale', '58', '{\"via\":\"dashboard\"}', NULL, NULL, '2026-06-05 14:46:29'),
(63, 'admin', 5, NULL, 'product.update', 'product', '88', NULL, NULL, '185.249.112.67', '2026-06-05 14:58:21'),
(64, 'admin', 5, NULL, 'product.update', 'product', '66', NULL, NULL, '185.249.112.67', '2026-06-05 15:02:39'),
(65, 'admin', 5, NULL, 'product.update', 'product', '67', NULL, NULL, '185.249.112.67', '2026-06-05 15:04:53'),
(66, 'admin', 5, NULL, 'product.update', 'product', '69', NULL, NULL, '185.249.112.67', '2026-06-05 15:08:03'),
(67, 'admin', 5, NULL, 'product.update', 'product', '65', NULL, NULL, '185.249.112.67', '2026-06-05 15:12:31'),
(68, 'admin', 5, NULL, 'product.update', 'product', '68', NULL, NULL, '185.249.112.67', '2026-06-05 15:13:51'),
(69, 'admin', 5, NULL, 'product.update', 'product', '70', NULL, NULL, '185.249.112.67', '2026-06-05 15:14:58'),
(70, 'admin', 5, NULL, 'product.update', 'product', '71', NULL, NULL, '185.249.112.67', '2026-06-05 15:16:47'),
(71, 'admin', 5, NULL, 'product.update', 'product', '104', NULL, NULL, '185.249.112.67', '2026-06-05 15:28:26'),
(72, 'admin', 5, NULL, 'product.update', 'product', '107', NULL, NULL, '185.249.112.67', '2026-06-05 15:32:50'),
(73, 'admin', 5, NULL, 'product.update', 'product', '111', NULL, NULL, '185.249.112.67', '2026-06-05 15:33:21'),
(74, 'admin', 5, NULL, 'product.update', 'product', '105', NULL, NULL, '185.249.112.67', '2026-06-05 15:35:05'),
(75, 'admin', 5, NULL, 'product.update', 'product', '104', NULL, NULL, '185.249.112.67', '2026-06-05 15:35:15'),
(76, 'admin', 5, NULL, 'product.update', 'product', '122', NULL, NULL, '185.249.112.67', '2026-06-05 15:37:28'),
(77, 'admin', 5, NULL, 'product.update', 'product', '109', NULL, NULL, '185.249.112.67', '2026-06-05 15:38:02'),
(78, 'admin', 5, NULL, 'product.update', 'product', '103', NULL, NULL, '185.249.112.67', '2026-06-05 15:38:37'),
(79, 'admin', 5, NULL, 'product.update', 'product', '106', NULL, NULL, '185.249.112.67', '2026-06-05 15:40:33'),
(80, 'admin', 5, NULL, 'product.update', 'product', '113', NULL, NULL, '185.249.112.67', '2026-06-05 15:41:32'),
(81, 'admin', 5, NULL, 'product.update', 'product', '112', NULL, NULL, '185.249.112.67', '2026-06-05 15:42:34'),
(82, 'admin', 5, NULL, 'product.update', 'product', '121', NULL, NULL, '185.249.112.67', '2026-06-05 15:43:40'),
(83, 'admin', 5, NULL, 'product.update', 'product', '113', NULL, NULL, '185.249.112.67', '2026-06-05 15:46:22'),
(84, 'admin', 5, NULL, 'product.update', 'product', '59', NULL, NULL, '185.249.112.67', '2026-06-05 15:50:55'),
(85, 'admin', 5, NULL, 'product.update', 'product', '117', NULL, NULL, '185.249.112.67', '2026-06-06 08:41:38'),
(86, 'admin', 5, NULL, 'product.update', 'product', '116', NULL, NULL, '185.249.112.67', '2026-06-06 08:43:22'),
(87, 'admin', 5, NULL, 'product.update', 'product', '20', NULL, NULL, '185.249.112.67', '2026-06-06 08:46:18'),
(88, 'admin', 5, NULL, 'product.update', 'product', '21', NULL, NULL, '185.249.112.67', '2026-06-06 08:46:27'),
(89, 'admin', 5, NULL, 'product.update', 'product', '22', NULL, NULL, '185.249.112.67', '2026-06-06 08:46:48'),
(90, 'admin', 5, NULL, 'product.update', 'product', '19', NULL, NULL, '185.249.112.67', '2026-06-06 08:48:32'),
(91, 'admin', 5, NULL, 'product.update', 'product', '23', NULL, NULL, '185.249.112.67', '2026-06-06 08:49:35'),
(92, 'admin', 5, NULL, 'product.update', 'product', '24', NULL, NULL, '185.249.112.67', '2026-06-06 08:49:44'),
(93, 'admin', 5, NULL, 'product.update', 'product', '25', NULL, NULL, '185.249.112.67', '2026-06-06 08:49:54'),
(94, 'admin', 5, NULL, 'product.update', 'product', '26', NULL, NULL, '185.249.112.67', '2026-06-06 08:50:43'),
(95, 'admin', 5, NULL, 'product.update', 'product', '27', NULL, NULL, '185.249.112.67', '2026-06-06 08:50:49'),
(96, 'admin', 5, NULL, 'product.update', 'product', '29', NULL, NULL, '185.249.112.67', '2026-06-06 08:51:00'),
(97, 'admin', 5, NULL, 'product.update', 'product', '28', NULL, NULL, '185.249.112.67', '2026-06-06 08:51:18'),
(98, 'admin', 5, NULL, 'product.update', 'product', '91', NULL, NULL, '185.249.112.67', '2026-06-06 09:11:22'),
(99, 'admin', 5, NULL, 'product.update', 'product', '93', NULL, NULL, '185.249.112.67', '2026-06-06 09:11:56'),
(100, 'admin', 5, NULL, 'product.update', 'product', '100', NULL, NULL, '185.249.112.67', '2026-06-06 09:12:01'),
(101, 'admin', 5, NULL, 'product.update', 'product', '101', NULL, NULL, '185.249.112.67', '2026-06-06 09:12:46'),
(102, 'admin', 5, NULL, 'product.update', 'product', '99', NULL, NULL, '185.249.112.67', '2026-06-06 09:12:53'),
(103, 'admin', 5, NULL, 'product.update', 'product', '97', NULL, NULL, '185.249.112.67', '2026-06-06 09:14:26'),
(104, 'admin', 5, NULL, 'product.update', 'product', '95', NULL, NULL, '185.249.112.67', '2026-06-06 09:14:32'),
(105, 'admin', 5, NULL, 'product.update', 'product', '90', NULL, NULL, '185.249.112.67', '2026-06-06 09:14:57'),
(106, 'admin', 5, NULL, 'product.update', 'product', '89', NULL, NULL, '185.249.112.67', '2026-06-06 09:15:02'),
(107, 'admin', 5, NULL, 'product.update', 'product', '102', NULL, NULL, '185.249.112.67', '2026-06-06 09:15:46'),
(108, 'admin', 5, NULL, 'product.update', 'product', '125', NULL, NULL, '185.249.112.67', '2026-06-06 09:18:42'),
(109, 'admin', 5, NULL, 'product.update', 'product', '124', NULL, NULL, '185.249.112.67', '2026-06-06 09:19:24'),
(110, 'admin', 5, NULL, 'product.update', 'product', '123', NULL, NULL, '185.249.112.67', '2026-06-06 09:19:58'),
(111, 'admin', 5, NULL, 'product.update', 'product', '126', NULL, NULL, '185.249.112.67', '2026-06-06 09:20:24'),
(112, 'admin', 5, NULL, 'product.update', 'product', '133', NULL, NULL, '185.249.112.67', '2026-06-06 09:21:31'),
(113, 'admin', 5, NULL, 'product.update', 'product', '134', NULL, NULL, '185.249.112.67', '2026-06-06 09:21:38'),
(114, 'admin', 5, NULL, 'product.update', 'product', '136', NULL, NULL, '185.249.112.67', '2026-06-06 09:22:10'),
(115, 'admin', 5, NULL, 'product.update', 'product', '135', NULL, NULL, '185.249.112.67', '2026-06-06 09:22:32'),
(116, 'admin', 5, NULL, 'product.update', 'product', '127', NULL, NULL, '185.249.112.67', '2026-06-06 09:23:16'),
(117, 'admin', 5, NULL, 'product.update', 'product', '128', NULL, NULL, '185.249.112.67', '2026-06-06 09:23:38'),
(118, 'admin', 5, NULL, 'product.update', 'product', '132', NULL, NULL, '185.249.112.67', '2026-06-06 09:24:18'),
(119, 'admin', 5, NULL, 'product.update', 'product', '129', NULL, NULL, '185.249.112.67', '2026-06-06 09:24:36'),
(120, 'admin', 5, NULL, 'product.update', 'product', '131', NULL, NULL, '185.249.112.67', '2026-06-06 09:25:12'),
(121, 'admin', 5, NULL, 'product.update', 'product', '130', NULL, NULL, '185.249.112.67', '2026-06-06 09:25:41'),
(122, 'admin', 5, NULL, 'product.update', 'product', '142', NULL, NULL, '185.249.112.67', '2026-06-06 09:26:23'),
(123, 'admin', 5, NULL, 'product.update', 'product', '141', NULL, NULL, '185.249.112.67', '2026-06-06 09:26:35'),
(124, 'admin', 5, NULL, 'product.update', 'product', '140', NULL, NULL, '185.249.112.67', '2026-06-06 09:27:06'),
(125, 'admin', 5, NULL, 'product.update', 'product', '137', NULL, NULL, '185.249.112.67', '2026-06-06 09:27:52'),
(126, 'admin', 5, NULL, 'product.update', 'product', '138', NULL, NULL, '185.249.112.67', '2026-06-06 09:28:43'),
(127, 'admin', 5, NULL, 'product.update', 'product', '139', NULL, NULL, '185.249.112.67', '2026-06-06 09:28:49'),
(128, 'admin', 5, NULL, 'product.update', 'product', '115', NULL, NULL, '185.249.112.67', '2026-06-06 09:42:44'),
(129, 'admin', 5, NULL, 'product.update', 'product', '58', NULL, NULL, '185.249.112.67', '2026-06-06 09:43:47'),
(130, 'admin', 5, NULL, 'product.update', 'product', '57', NULL, NULL, '185.249.112.67', '2026-06-06 09:45:58'),
(131, 'admin', 5, NULL, 'product.update', 'product', '34', NULL, NULL, '185.249.112.67', '2026-06-06 09:55:11'),
(132, 'admin', 5, NULL, 'product.update', 'product', '36', NULL, NULL, '185.249.112.67', '2026-06-06 09:56:51'),
(133, 'admin', 5, NULL, 'product.update', 'product', '36', NULL, NULL, '185.249.112.67', '2026-06-06 09:56:51'),
(134, 'admin', 5, NULL, 'product.update', 'product', '35', NULL, NULL, '185.249.112.67', '2026-06-06 09:56:59'),
(135, 'admin', 5, NULL, 'product.update', 'product', '37', NULL, NULL, '185.249.112.67', '2026-06-06 09:57:10'),
(136, 'admin', 5, NULL, 'product.update', 'product', '38', NULL, NULL, '185.249.112.67', '2026-06-06 09:57:22'),
(137, 'admin', 5, NULL, 'product.update', 'product', '41', NULL, NULL, '185.249.112.67', '2026-06-06 09:59:00'),
(138, 'admin', 5, NULL, 'product.update', 'product', '46', NULL, NULL, '185.249.112.67', '2026-06-06 09:59:11'),
(139, 'admin', 5, NULL, 'product.update', 'product', '47', NULL, NULL, '185.249.112.67', '2026-06-06 09:59:19'),
(140, 'admin', 5, NULL, 'product.update', 'product', '39', NULL, NULL, '185.249.112.67', '2026-06-06 10:00:05'),
(141, 'admin', 5, NULL, 'product.update', 'product', '45', NULL, NULL, '185.249.112.67', '2026-06-06 10:00:25'),
(142, 'admin', 5, NULL, 'product.update', 'product', '33', NULL, NULL, '185.249.112.67', '2026-06-06 10:03:22'),
(143, 'admin', 5, NULL, 'product.update', 'product', '44', NULL, NULL, '185.249.112.67', '2026-06-06 10:04:00'),
(144, 'admin', 5, NULL, 'product.update', 'product', '32', NULL, NULL, '185.249.112.67', '2026-06-06 10:07:30'),
(145, 'admin', 5, NULL, 'product.update', 'product', '42', NULL, NULL, '185.249.112.67', '2026-06-06 10:08:00'),
(146, 'admin', 5, NULL, 'product.update', 'product', '44', NULL, NULL, '185.249.112.67', '2026-06-06 10:08:42'),
(147, 'admin', 5, NULL, 'product.update', 'product', '43', NULL, NULL, '185.249.112.67', '2026-06-06 10:09:12'),
(148, 'admin', 5, NULL, 'product.update', 'product', '40', NULL, NULL, '185.249.112.67', '2026-06-06 10:10:11'),
(149, 'admin', 5, NULL, 'product.update', 'product', '63', NULL, NULL, '185.249.112.67', '2026-06-06 10:20:03'),
(150, 'admin', 5, NULL, 'product.update', 'product', '62', NULL, NULL, '185.249.112.67', '2026-06-06 10:20:10'),
(151, 'admin', 5, NULL, 'product.update', 'product', '60', NULL, NULL, '185.249.112.67', '2026-06-06 10:20:17'),
(152, 'admin', 5, NULL, 'product.update', 'product', '61', NULL, NULL, '185.249.112.67', '2026-06-06 10:20:28'),
(153, 'admin', 5, NULL, 'product.update', 'product', '64', NULL, NULL, '185.249.112.67', '2026-06-06 10:20:34'),
(154, 'admin', 5, NULL, 'product.update', 'product', '8', NULL, NULL, '185.249.112.67', '2026-06-06 10:22:24'),
(155, 'admin', 5, NULL, 'product.update', 'product', '10', NULL, NULL, '185.249.112.67', '2026-06-06 10:23:21'),
(156, 'admin', 5, NULL, 'product.update', 'product', '9', NULL, NULL, '185.249.112.67', '2026-06-06 10:23:26'),
(157, 'admin', 5, NULL, 'product.update', 'product', '15', NULL, NULL, '185.249.112.67', '2026-06-06 10:24:02'),
(158, 'admin', 5, NULL, 'product.update', 'product', '16', NULL, NULL, '185.249.112.67', '2026-06-06 10:24:09'),
(159, 'admin', 5, NULL, 'product.update', 'product', '17', NULL, NULL, '185.249.112.67', '2026-06-06 10:24:40'),
(160, 'admin', 5, NULL, 'product.update', 'product', '5', NULL, NULL, '185.249.112.67', '2026-06-06 10:25:08'),
(161, 'admin', 5, NULL, 'product.update', 'product', '7', NULL, NULL, '185.249.112.67', '2026-06-06 10:25:25'),
(162, 'admin', 5, NULL, 'product.update', 'product', '84', NULL, NULL, '185.249.112.67', '2026-06-06 10:27:26'),
(163, 'admin', 5, NULL, 'product.update', 'product', '85', NULL, NULL, '185.249.112.67', '2026-06-06 10:27:35'),
(164, 'admin', 5, NULL, 'product.update', 'product', '87', NULL, NULL, '185.249.112.67', '2026-06-06 10:27:40'),
(165, 'admin', 5, NULL, 'product.update', 'product', '86', NULL, NULL, '185.249.112.67', '2026-06-06 10:28:09'),
(166, 'admin', 5, NULL, 'product.update', 'product', '49', NULL, NULL, '185.249.112.67', '2026-06-06 10:31:06'),
(167, 'admin', 5, NULL, 'product.update', 'product', '48', NULL, NULL, '185.249.112.67', '2026-06-06 10:31:10'),
(168, 'admin', 5, NULL, 'product.update', 'product', '55', NULL, NULL, '185.249.112.67', '2026-06-06 10:32:11'),
(169, 'admin', 5, NULL, 'product.update', 'product', '52', NULL, NULL, '185.249.112.67', '2026-06-06 10:32:50'),
(170, 'admin', 5, NULL, 'product.update', 'product', '50', NULL, NULL, '185.249.112.67', '2026-06-06 10:34:41'),
(171, 'admin', 5, NULL, 'product.update', 'product', '51', NULL, NULL, '185.249.112.67', '2026-06-06 10:35:36'),
(172, 'admin', 5, NULL, 'product.update', 'product', '54', NULL, NULL, '185.249.112.67', '2026-06-06 10:38:54'),
(173, 'admin', 5, NULL, 'product.update', 'product', '53', NULL, NULL, '185.249.112.67', '2026-06-06 10:42:53'),
(174, 'admin', 5, NULL, 'product.update', 'product', '119', NULL, NULL, '185.249.112.67', '2026-06-06 10:45:35'),
(175, 'admin', 5, NULL, 'product.update', 'product', '120', NULL, NULL, '185.249.112.67', '2026-06-06 10:45:41'),
(176, 'admin', 5, NULL, 'product.update', 'product', '31', NULL, NULL, '185.249.112.67', '2026-06-06 11:02:53'),
(177, 'admin', 4, NULL, 'product.update', 'product', '118', NULL, NULL, '185.249.112.67', '2026-06-06 11:57:11'),
(178, 'admin', 4, NULL, 'product.update', 'product', '118', NULL, NULL, '185.249.112.67', '2026-06-06 11:57:21'),
(179, 'admin', 4, NULL, 'agency.update', 'agency', '1', NULL, NULL, '185.249.112.67', '2026-06-06 12:05:14'),
(180, 'admin', 4, NULL, 'agency.update', 'agency', '5', NULL, NULL, '185.249.112.67', '2026-06-06 12:11:13'),
(181, 'admin', 1, NULL, 'product.update', 'product', '82', NULL, NULL, '90.180.55.48', '2026-06-06 12:12:56'),
(182, 'admin', 1, NULL, 'product.update', 'product', '65', NULL, NULL, '90.180.55.48', '2026-06-06 12:14:36'),
(183, 'admin', 1, NULL, 'product.update', 'product', '65', NULL, NULL, '90.180.55.48', '2026-06-06 12:14:47'),
(184, 'admin', 1, NULL, 'product.update', 'product', '116', NULL, NULL, '90.180.55.48', '2026-06-06 12:15:40'),
(185, 'admin', 1, NULL, 'product.update', 'product', '69', NULL, NULL, '90.180.55.48', '2026-06-06 12:16:31'),
(186, 'admin', 1, NULL, 'product.update', 'product', '136', NULL, NULL, '90.180.55.48', '2026-06-06 12:18:31'),
(187, 'admin', 1, NULL, 'product.update', 'product', '123', NULL, NULL, '90.180.55.48', '2026-06-06 12:19:34'),
(188, 'admin', 4, NULL, 'agency.update', 'agency', '5', NULL, NULL, '185.249.112.67', '2026-06-06 12:20:26'),
(189, 'admin', 1, NULL, 'product.update', 'product', '17', NULL, NULL, '90.180.55.48', '2026-06-06 12:20:49'),
(190, 'admin', 1, NULL, 'product.update', 'product', '72', NULL, NULL, '90.180.55.48', '2026-06-06 12:22:48'),
(191, 'admin', 4, NULL, 'agency.update', 'agency', '3', NULL, NULL, '185.249.112.67', '2026-06-06 12:29:52'),
(192, 'admin', 4, NULL, 'agency.update', 'agency', '1', NULL, NULL, '185.249.112.67', '2026-06-06 12:30:17'),
(193, 'admin', 4, NULL, 'agency.update', 'agency', '12', NULL, NULL, '185.249.112.67', '2026-06-06 12:34:02'),
(194, 'admin', 4, NULL, 'agency.update', 'agency', '21', NULL, NULL, '185.249.112.67', '2026-06-06 12:37:30'),
(195, 'admin', 4, NULL, 'agency.update', 'agency', '13', NULL, NULL, '185.249.112.67', '2026-06-06 12:46:29'),
(196, 'admin', 4, NULL, 'agency.update', 'agency', '16', NULL, NULL, '185.249.112.67', '2026-06-06 12:51:37'),
(197, 'admin', 4, NULL, 'agency.update', 'agency', '14', NULL, NULL, '185.249.112.67', '2026-06-06 12:53:41'),
(198, 'admin', 1, NULL, 'agency.update', 'agency', '1', NULL, NULL, '90.180.55.48', '2026-06-06 13:42:34'),
(199, 'admin', 5, NULL, 'product.update', 'product', '104', NULL, NULL, '185.249.112.67', '2026-06-06 14:48:14'),
(200, 'admin', 5, NULL, 'product.update', 'product', '108', NULL, NULL, '185.249.112.67', '2026-06-06 15:37:34'),
(201, 'admin', 5, NULL, 'product.update', 'product', '107', NULL, NULL, '185.249.112.67', '2026-06-06 15:38:18'),
(202, 'admin', 5, NULL, 'product.update', 'product', '109', NULL, NULL, '185.249.112.67', '2026-06-06 15:39:13'),
(203, 'admin', 5, NULL, 'product.update', 'product', '110', NULL, NULL, '185.249.112.67', '2026-06-06 15:56:52'),
(204, 'admin', 5, NULL, 'product.update', 'product', '114', NULL, NULL, '185.249.112.67', '2026-06-06 16:07:18'),
(205, 'admin', 5, NULL, 'product.update', 'product', '112', NULL, NULL, '185.249.112.67', '2026-06-06 16:25:39'),
(206, 'admin', 5, NULL, 'product.update', 'product', '113', NULL, NULL, '185.249.112.67', '2026-06-06 16:26:20'),
(207, 'admin', 5, NULL, 'product.update', 'product', '121', NULL, NULL, '185.249.112.67', '2026-06-06 16:26:33'),
(208, 'system', NULL, NULL, 'voucher.edit', 'sale', '64', '{\"language\":{\"from\":\"de\",\"to\":\"en\"}}', NULL, NULL, '2026-06-06 20:05:05');

-- --------------------------------------------------------

--
-- Struktura tabulky `bonus_payouts`
--

DROP TABLE IF EXISTS `bonus_payouts`;
CREATE TABLE `bonus_payouts` (
  `id` int(10) UNSIGNED NOT NULL,
  `tenant_id` int(10) UNSIGNED NOT NULL,
  `seller_id` int(10) UNSIGNED NOT NULL,
  `payout_day` date NOT NULL,
  `bonus_czk` decimal(10,2) NOT NULL DEFAULT 0.00,
  `sales_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `confirmed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `bonus_payouts`
--

INSERT INTO `bonus_payouts` (`id`, `tenant_id`, `seller_id`, `payout_day`, `bonus_czk`, `sales_count`, `confirmed_at`) VALUES
(1, 1, 1, '2026-06-05', 478.20, 7, '2026-06-05 10:44:36');

-- --------------------------------------------------------

--
-- Struktura tabulky `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name_cs` varchar(100) NOT NULL,
  `name_en` varchar(100) DEFAULT NULL,
  `name_de` varchar(100) DEFAULT NULL,
  `icon` varchar(60) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` enum('active','inactive','archived') NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `categories`
--

INSERT INTO `categories` (`id`, `name_cs`, `name_en`, `name_de`, `icon`, `sort_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Prohlídkové jízdy', 'Sightseeing', 'Stadtrundfahrten', 'bus', 10, 'active', '2026-05-31 16:40:47', '2026-05-31 16:40:47'),
(2, 'Procházky', 'Walking tours', 'Stadtführungen', 'walk', 20, 'active', '2026-05-31 16:40:47', '2026-05-31 16:40:47'),
(3, 'Lodě a plavby', 'Boats & cruises', 'Bootsfahrten', 'ship', 30, 'active', '2026-05-31 16:40:47', '2026-05-31 16:40:47'),
(4, 'Koncerty', 'Concerts', 'Konzerte', 'music', 40, 'active', '2026-05-31 16:40:47', '2026-05-31 16:40:47'),
(5, 'Divadlo a show', 'Theatre & shows', 'Theater & Shows', 'masks-theater', 50, 'active', '2026-05-31 16:40:47', '2026-05-31 16:40:47'),
(6, 'Večeře a zážitky', 'Dinner & experiences', 'Dinner & Erlebnisse', 'tools-kitchen-2', 60, 'active', '2026-05-31 16:40:47', '2026-05-31 16:40:47'),
(7, 'Výlety z Prahy', 'Day trips', 'Tagesausflüge', 'map-pin', 70, 'active', '2026-05-31 16:40:47', '2026-05-31 16:40:47'),
(8, 'Ghost tours', 'Ghost tours', 'Geistertouren', 'ghost', 80, 'active', '2026-05-31 16:40:47', '2026-05-31 16:40:47'),
(9, 'Aktivity', 'Activities', 'Aktivitäten', 'run', 90, 'active', '2026-06-01 06:52:56', '2026-06-01 06:52:56');

-- --------------------------------------------------------

--
-- Struktura tabulky `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(190) DEFAULT NULL,
  `email` varchar(190) DEFAULT NULL,
  `phone` varchar(60) DEFAULT NULL,
  `language` enum('cs','en','de') NOT NULL DEFAULT 'en',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `phone`, `language`, `notes`, `created_at`) VALUES
(1, 'Dušan', NULL, NULL, 'en', NULL, '2026-06-01 17:54:43'),
(2, 'Josef', NULL, NULL, 'en', NULL, '2026-06-01 17:57:20'),
(3, 'Pepa', NULL, NULL, 'en', NULL, '2026-06-01 19:54:32'),
(4, 'Fanda', NULL, NULL, 'en', NULL, '2026-06-01 20:00:51'),
(5, 'Grundza', NULL, NULL, 'en', NULL, '2026-06-01 20:06:40'),
(6, 'Frantusek', NULL, NULL, 'en', NULL, '2026-06-01 21:12:52'),
(7, 'Karel Vyskočil', NULL, NULL, 'en', NULL, '2026-06-02 13:20:12'),
(8, 'Karel Fetak', NULL, NULL, 'en', NULL, '2026-06-02 15:13:28'),
(9, 'Karel Čurák', NULL, NULL, 'en', NULL, '2026-06-02 16:15:54'),
(10, 'Ada', 'fggt@hjuu', NULL, 'en', NULL, '2026-06-02 17:17:12'),
(11, 'Sdr', NULL, NULL, 'en', NULL, '2026-06-02 17:21:50'),
(12, 'AdA', NULL, NULL, 'en', NULL, '2026-06-02 17:26:06'),
(13, 'Josef', NULL, NULL, 'en', NULL, '2026-06-02 17:27:35'),
(14, 'Dušan Kedluben', NULL, NULL, 'en', NULL, '2026-06-02 18:15:50'),
(15, 'Kedluben', NULL, NULL, 'en', NULL, '2026-06-02 18:35:21'),
(16, 'Zeli', NULL, NULL, 'en', NULL, '2026-06-02 18:45:54'),
(17, 'Straka', NULL, NULL, 'en', NULL, '2026-06-02 18:58:07'),
(18, 'Fero', NULL, NULL, 'en', NULL, '2026-06-02 19:02:32'),
(19, 'Eva Bärtlovà', NULL, NULL, 'en', NULL, '2026-06-02 19:06:27'),
(20, 'Jan', NULL, NULL, 'en', NULL, '2026-06-02 20:04:29'),
(21, 'Frank', NULL, NULL, 'en', NULL, '2026-06-03 11:58:04'),
(22, 'Frank Drebin', NULL, NULL, 'en', NULL, '2026-06-03 14:14:49'),
(23, 'Kreten', NULL, NULL, 'en', NULL, '2026-06-03 14:16:34'),
(24, 'Karel', NULL, NULL, 'en', NULL, '2026-06-03 14:41:46'),
(25, 'Michal Novák', 'info@charlesbridgehostel.com', '774155746', 'en', NULL, '2026-06-03 14:43:16'),
(26, 'Adolf', NULL, NULL, 'en', NULL, '2026-06-03 15:33:39'),
(27, 'Fena', NULL, NULL, 'en', NULL, '2026-06-03 15:35:51'),
(28, 'Dušan Kedluben', NULL, NULL, 'en', NULL, '2026-06-03 17:08:04'),
(29, 'Ludvík', NULL, NULL, 'en', NULL, '2026-06-03 17:26:47'),
(30, 'vb', 'michal@prague-tourism.com', NULL, 'en', NULL, '2026-06-03 20:01:12'),
(31, NULL, 'michal@prague-tourism.com', NULL, 'en', NULL, '2026-06-03 20:08:31'),
(32, 'Fenek', 'michal@prague-tourism.com', NULL, 'en', NULL, '2026-06-03 21:00:02'),
(36, 'Viktor', NULL, NULL, 'en', NULL, '2026-06-04 07:15:42'),
(37, 'Frank', NULL, NULL, 'en', NULL, '2026-06-04 09:03:43'),
(38, 'Karl Marx', NULL, NULL, 'en', NULL, '2026-06-04 09:25:05'),
(39, 'Dušan Kedluben', 'michal.prague.info@gmail.com', '+420774155746', 'en', NULL, '2026-06-04 10:18:13'),
(40, 'Dušan Kedluben', 'michal.prague.info@gmail.com', '+420774155746', 'en', NULL, '2026-06-04 10:19:05'),
(41, 'Karel Urban', NULL, NULL, 'en', NULL, '2026-06-04 10:47:19'),
(42, 'Pepa', 'michal@prague-tourism.com', NULL, 'en', NULL, '2026-06-04 12:26:36'),
(43, 'Bahri', 'michal@prague-tourism.com', NULL, 'en', NULL, '2026-06-04 15:01:51'),
(44, 'Frank', NULL, NULL, 'en', NULL, '2026-06-04 18:08:27'),
(45, NULL, 'michal@prague-tourism.com', NULL, 'en', NULL, '2026-06-05 10:33:10'),
(46, NULL, 'michal@prague-tourism.com', NULL, 'en', NULL, '2026-06-05 10:34:02'),
(47, NULL, 'michal@prague-tourism.com', NULL, 'en', NULL, '2026-06-05 10:35:11'),
(48, NULL, 'michal@prague-tourism.com', NULL, 'en', NULL, '2026-06-05 10:35:40'),
(49, NULL, 'michal@prague-tourism.com', NULL, 'en', NULL, '2026-06-05 10:38:59'),
(50, NULL, 'michal@prague-tourism.com', NULL, 'en', NULL, '2026-06-05 10:39:56'),
(51, NULL, 'michal@prague-tourism.com', NULL, 'en', NULL, '2026-06-05 10:40:47'),
(52, NULL, 'michal@prague-tourism.com', NULL, 'en', NULL, '2026-06-05 10:44:53'),
(53, NULL, 'michal@prague-tourism.com', NULL, 'en', NULL, '2026-06-05 10:45:18'),
(54, NULL, 'michal@prague-tourism.com', NULL, 'en', NULL, '2026-06-05 10:45:49'),
(55, NULL, 'michal@prague-tourism.com', NULL, 'en', NULL, '2026-06-05 10:46:10'),
(56, NULL, 'michal@prague-tourism.com', NULL, 'en', NULL, '2026-06-05 16:00:22'),
(57, 'Frank', NULL, NULL, 'en', NULL, '2026-06-06 16:49:04'),
(58, 'Jitka', NULL, NULL, 'en', NULL, '2026-06-06 17:11:08'),
(59, 'Karel Vyskočil', NULL, NULL, 'en', NULL, '2026-06-06 18:37:11'),
(60, 'Dušan', 'michal.prague.info@gmail.com', NULL, 'de', NULL, '2026-06-06 20:03:56'),
(61, 'Dušan', 'michal.prague.info@gmail.com', NULL, 'en', NULL, '2026-06-06 20:10:09'),
(62, 'Dušan', 'michal.prague.info@gmail.com', NULL, 'en', NULL, '2026-06-06 20:49:58'),
(63, 'Dušan', 'michal.prague.info@gmail.com', NULL, 'en', NULL, '2026-06-06 20:53:31'),
(64, 'Michal Novák', 'michal.prague.info@gmail.com', NULL, 'en', NULL, '2026-06-07 04:46:02');

-- --------------------------------------------------------

--
-- Struktura tabulky `login_attempts`
--

DROP TABLE IF EXISTS `login_attempts`;
CREATE TABLE `login_attempts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `scope` enum('pin','admin','escalation') NOT NULL,
  `identifier` varchar(190) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `success` tinyint(1) NOT NULL DEFAULT 0,
  `attempted_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `login_attempts`
--

INSERT INTO `login_attempts` (`id`, `scope`, `identifier`, `ip_address`, `success`, `attempted_at`) VALUES
(1, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-05-31 17:08:12'),
(2, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-05-31 17:11:44'),
(3, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-05-31 17:25:41'),
(4, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-05-31 17:27:44'),
(5, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-05-31 17:28:16'),
(6, 'pin', 'tenant:1', '37.188.140.44', 1, '2026-05-31 17:39:00'),
(7, 'pin', 'tenant:2', '37.188.140.44', 0, '2026-05-31 17:39:33'),
(8, 'pin', 'tenant:1', '37.188.140.44', 1, '2026-05-31 17:40:09'),
(9, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-01 04:32:06'),
(10, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-01 05:50:30'),
(11, 'admin', 'michal@prague-tourism.com', '37.188.201.156', 1, '2026-06-01 06:26:05'),
(12, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-01 07:05:40'),
(13, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-01 07:10:17'),
(14, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-01 08:08:24'),
(15, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-01 08:37:34'),
(16, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-01 08:53:35'),
(17, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-01 10:12:07'),
(18, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-01 10:16:49'),
(19, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-01 16:43:24'),
(20, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-01 17:31:28'),
(21, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-01 17:34:18'),
(22, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-01 17:43:11'),
(23, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-01 17:54:06'),
(24, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-01 19:53:07'),
(25, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-02 04:53:16'),
(26, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-02 05:59:46'),
(27, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-02 06:25:14'),
(28, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-02 13:13:43'),
(29, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-02 13:43:57'),
(30, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-02 16:02:29'),
(31, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-02 16:05:58'),
(32, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-02 16:14:28'),
(33, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-02 17:14:05'),
(34, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 05:50:23'),
(35, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 13:53:49'),
(36, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-03 14:09:39'),
(37, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 14:11:15'),
(38, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 14:13:35'),
(39, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 14:39:58'),
(40, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-03 14:40:11'),
(41, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 15:33:03'),
(42, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 15:33:39'),
(43, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 15:33:58'),
(44, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 15:35:51'),
(45, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 15:36:10'),
(46, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 15:39:03'),
(47, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-03 15:48:39'),
(48, 'pin', 'tenant:1', '185.249.112.67', 0, '2026-06-03 15:59:32'),
(49, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-03 16:16:07'),
(50, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 16:45:06'),
(51, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 17:07:00'),
(52, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 17:08:04'),
(53, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 17:24:40'),
(54, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 17:26:47'),
(55, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-03 18:25:26'),
(56, 'pin', 'tenant:1', '31.30.166.85', 1, '2026-06-03 18:36:35'),
(57, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 19:46:54'),
(58, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 19:47:43'),
(59, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-03 19:51:26'),
(60, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-03 19:56:40'),
(61, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 19:59:31'),
(62, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 20:01:12'),
(63, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 20:01:43'),
(64, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 20:08:31'),
(65, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-03 20:16:36'),
(66, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 20:21:34'),
(67, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-03 20:25:12'),
(68, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 20:26:47'),
(69, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-03 20:27:22'),
(70, 'admin', 'itl@prague-tourism.com', '90.180.55.48', 0, '2026-06-03 20:34:19'),
(71, 'admin', 'it@prague-tourism.com', '90.180.55.48', 1, '2026-06-03 20:34:36'),
(72, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-03 20:34:55'),
(73, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 20:36:29'),
(74, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-03 20:40:25'),
(75, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 20:44:57'),
(76, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-03 20:45:40'),
(77, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 20:47:53'),
(78, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-03 20:50:17'),
(79, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 20:54:30'),
(80, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 21:00:02'),
(81, 'admin', 'it@prague-tourism.com', '90.180.55.48', 1, '2026-06-03 21:01:49'),
(82, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 21:02:47'),
(83, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-03 21:42:32'),
(84, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-04 05:24:21'),
(85, 'pin', 'tenant:1', '37.188.237.16', 1, '2026-06-04 07:08:04'),
(86, 'pin', 'tenant:1', '37.188.237.16', 1, '2026-06-04 07:09:30'),
(87, 'pin', 'tenant:1', '37.188.237.16', 1, '2026-06-04 07:10:52'),
(88, 'pin', 'tenant:1', '37.188.237.16', 1, '2026-06-04 07:14:35'),
(89, 'pin', 'tenant:1', '37.188.237.16', 1, '2026-06-04 07:15:42'),
(90, 'pin', 'tenant:1', '37.188.237.16', 1, '2026-06-04 07:16:25'),
(91, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-04 09:02:58'),
(92, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-04 09:03:43'),
(93, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-04 09:15:31'),
(94, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-04 09:25:05'),
(95, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-04 09:25:59'),
(96, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-04 09:36:29'),
(97, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-04 09:43:05'),
(98, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-04 09:50:41'),
(99, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-04 10:18:13'),
(100, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-04 10:19:05'),
(101, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-04 10:24:36'),
(102, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-04 10:25:56'),
(103, 'pin', 'tenant:1', '37.188.236.163', 0, '2026-06-04 10:44:42'),
(104, 'pin', 'tenant:1', '37.188.236.163', 1, '2026-06-04 10:44:47'),
(105, 'pin', 'tenant:1', '37.188.236.163', 1, '2026-06-04 10:47:19'),
(106, 'pin', 'tenant:1', '37.188.236.163', 1, '2026-06-04 10:49:03'),
(107, 'admin', 'michal@prague-tourism.com', '185.249.112.67', 1, '2026-06-04 12:08:45'),
(108, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-04 12:21:29'),
(109, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-04 12:21:51'),
(110, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-04 12:26:36'),
(111, 'pin', 'tenant:1', '185.249.114.234', 1, '2026-06-04 12:56:33'),
(112, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-04 14:45:06'),
(113, 'admin', 'michal@prague-tourism.com', '185.249.112.67', 0, '2026-06-04 14:46:54'),
(114, 'admin', 'michal@prague-tourism.com', '185.249.112.67', 0, '2026-06-04 14:47:08'),
(115, 'admin', 'michal@prague-tourism.com', '185.249.112.67', 1, '2026-06-04 14:47:35'),
(116, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-04 14:50:55'),
(117, 'admin', 'michal@prague-tourism.com', '185.249.112.67', 1, '2026-06-04 14:52:30'),
(118, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-04 14:57:01'),
(119, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-04 14:59:47'),
(120, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-04 15:01:51'),
(121, 'pin', 'tenant:1', '37.188.156.90', 1, '2026-06-04 17:28:32'),
(122, 'pin', 'tenant:1', '37.188.156.90', 1, '2026-06-04 17:31:48'),
(123, 'pin', 'tenant:1', '37.188.156.90', 1, '2026-06-04 17:33:31'),
(124, 'pin', 'tenant:1', '37.188.156.90', 1, '2026-06-04 18:08:27'),
(125, 'pin', 'tenant:1', '37.188.156.90', 1, '2026-06-04 18:09:07'),
(126, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:32:04'),
(127, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:32:17'),
(128, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:32:31'),
(129, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:33:10'),
(130, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:33:19'),
(131, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:34:02'),
(132, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:34:10'),
(133, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:35:11'),
(134, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:35:24'),
(135, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:35:40'),
(136, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:35:46'),
(137, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:38:59'),
(138, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:39:08'),
(139, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:39:56'),
(140, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:40:04'),
(141, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:40:47'),
(142, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:40:52'),
(143, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:44:31'),
(144, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:44:35'),
(145, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:44:36'),
(146, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:44:36'),
(147, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:44:53'),
(148, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:45:18'),
(149, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:45:49'),
(150, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:46:10'),
(151, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:46:15'),
(152, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 10:47:22'),
(153, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-05 10:58:30'),
(154, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 11:02:27'),
(155, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 11:06:20'),
(156, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 11:37:21'),
(157, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 11:37:58'),
(158, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 11:38:53'),
(159, 'admin', 'bahriberk.kayali@gmail.com', '185.249.112.67', 1, '2026-06-05 11:39:51'),
(160, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 12:23:22'),
(161, 'admin', 'bahriberk.kayali@gmail.com', '185.249.112.67', 1, '2026-06-05 12:25:07'),
(162, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 13:33:49'),
(163, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 13:43:19'),
(164, 'admin', 'bahriberk.kayali@gmail.com', '185.249.112.67', 1, '2026-06-05 13:44:11'),
(165, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 13:46:23'),
(166, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 14:39:24'),
(167, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 15:17:15'),
(168, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 15:45:06'),
(169, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 15:59:51'),
(170, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 16:00:03'),
(171, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 16:00:22'),
(172, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-05 16:00:32'),
(173, 'pin', 'tenant:1', '37.188.163.165', 1, '2026-06-06 05:08:50'),
(174, 'admin', 'bahriberk.kayali@gmail.com', '185.249.112.67', 1, '2026-06-06 08:34:58'),
(175, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-06 08:43:48'),
(176, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 10:43:03'),
(177, 'admin', 'bahriberk.kayali@gmail.com', '185.249.112.67', 1, '2026-06-06 11:31:51'),
(178, 'admin', 'heligon@gmail.com', '185.249.112.67', 0, '2026-06-06 11:33:35'),
(179, 'admin', 'michal@prague-tourism.com', '185.249.112.67', 0, '2026-06-06 11:33:38'),
(180, 'admin', 'michal@prague-tourism.com', '185.249.112.67', 0, '2026-06-06 11:33:42'),
(181, 'admin', 'bahriberk.kayali@gmail.com', '185.249.112.67', 0, '2026-06-06 11:34:35'),
(182, 'admin', 'bahriberk.kayali@gmail.com', '185.249.112.67', 1, '2026-06-06 11:34:43'),
(183, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-06 11:34:55'),
(184, 'admin', 'heligon@gmail.com', '185.249.112.67', 0, '2026-06-06 11:35:41'),
(185, 'admin', 'heligon@gmail.com', '185.249.112.67', 1, '2026-06-06 11:36:00'),
(186, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 12:00:57'),
(187, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-06 12:06:42'),
(188, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-06 12:06:43'),
(189, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 12:23:07'),
(190, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-06 13:34:38'),
(191, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-06 13:34:39'),
(192, 'admin', 'bahriberk.kayali@gmail.com', '185.249.112.67', 1, '2026-06-06 13:51:56'),
(193, 'admin', 'bahriberk.kayali@gmail.com', '185.249.112.67', 1, '2026-06-06 13:51:57'),
(194, 'pin', 'tenant:1', '185.249.112.67', 1, '2026-06-06 13:52:45'),
(195, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 14:22:24'),
(196, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 15:55:04'),
(197, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 16:35:46'),
(198, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 16:35:55'),
(199, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-06 16:36:38'),
(200, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 16:42:35'),
(201, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 16:49:04'),
(202, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 16:50:15'),
(203, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 16:50:24'),
(204, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 16:56:24'),
(205, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-06 16:57:09'),
(206, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 17:08:13'),
(207, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 17:08:39'),
(208, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 17:11:08'),
(209, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 17:47:29'),
(210, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 18:37:11'),
(211, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-06 18:54:39'),
(212, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 19:19:02'),
(213, 'admin', 'michal@prague-tourism.com', '90.180.55.48', 1, '2026-06-06 19:28:01'),
(214, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 19:30:40'),
(215, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 20:03:56'),
(216, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 20:10:09'),
(217, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 20:26:42'),
(218, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 20:49:58'),
(219, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 20:53:31'),
(220, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-06 21:00:07'),
(221, 'pin', 'tenant:1', '90.180.55.48', 1, '2026-06-07 04:46:02');

-- --------------------------------------------------------

--
-- Struktura tabulky `pickups`
--

DROP TABLE IF EXISTS `pickups`;
CREATE TABLE `pickups` (
  `id` int(10) UNSIGNED NOT NULL,
  `sale_item_id` int(10) UNSIGNED NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `pickup_time` varchar(60) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `status` enum('pending','confirmed','done','cancelled') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `pickups`
--

INSERT INTO `pickups` (`id`, `sale_item_id`, `address`, `pickup_time`, `notes`, `status`, `created_at`) VALUES
(1, 23, 'Brix', '8:15', NULL, 'pending', '2026-06-02 18:58:07'),
(2, 25, 'Hotel Avion', '8:00', NULL, 'pending', '2026-06-02 19:06:27'),
(3, 37, 'Domus Balthasar', '8:15', NULL, 'pending', '2026-06-03 17:26:47'),
(4, 38, 'Domus Balthasar', '8:15', NULL, 'pending', '2026-06-03 17:26:47'),
(5, 50, 'u šuterů', '7:30', NULL, 'pending', '2026-06-04 10:47:19'),
(6, 51, 'u šuterů', '7:30', NULL, 'pending', '2026-06-04 10:47:19'),
(7, 52, 'u šuterů', '7:30', NULL, 'pending', '2026-06-04 10:47:19'),
(8, 54, 'Domus Balthasar', '8:00', NULL, 'pending', '2026-06-04 15:01:51'),
(9, 55, 'Domus Balthasar', '8:00', NULL, 'pending', '2026-06-04 15:01:51'),
(10, 56, 'Domus Balthasar', '8:00', NULL, 'pending', '2026-06-04 15:01:51');

-- --------------------------------------------------------

--
-- Struktura tabulky `prices`
--

DROP TABLE IF EXISTS `prices`;
CREATE TABLE `prices` (
  `id` int(10) UNSIGNED NOT NULL,
  `pricing_version_id` int(10) UNSIGNED NOT NULL,
  `cell_key` varchar(255) NOT NULL,
  `dimension_values_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`dimension_values_json`)),
  `czk` decimal(10,2) NOT NULL,
  `eur` decimal(10,2) DEFAULT NULL,
  `is_override` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `prices`
--

INSERT INTO `prices` (`id`, `pricing_version_id`, `cell_key`, `dimension_values_json`, `czk`, `eur`, `is_override`, `created_at`, `updated_at`) VALUES
(71, 11, '{\"15\":\"Adult\"}', '{\"15\":\"Adult\"}', 780.00, 31.00, 0, '2026-06-01 07:39:56', '2026-06-01 07:39:56'),
(72, 11, '{\"15\":\"Family (2A+3C 5-15)\"}', '{\"15\":\"Family (2A+3C 5-15)\"}', 1820.00, 73.00, 0, '2026-06-01 07:39:56', '2026-06-01 07:39:56'),
(73, 12, '{\"16\":\"Adult\"}', '{\"16\":\"Adult\"}', 900.00, 36.00, 0, '2026-06-01 07:39:56', '2026-06-01 07:39:56'),
(74, 12, '{\"16\":\"Family (2A+3C 5-15)\"}', '{\"16\":\"Family (2A+3C 5-15)\"}', 2070.00, 83.00, 0, '2026-06-01 07:39:56', '2026-06-01 07:39:56'),
(75, 13, '{\"17\":\"Adult\"}', '{\"17\":\"Adult\"}', 1020.00, 41.00, 0, '2026-06-01 07:39:56', '2026-06-01 07:39:56'),
(76, 13, '{\"17\":\"Family (2A+3C 5-15)\"}', '{\"17\":\"Family (2A+3C 5-15)\"}', 2400.00, 96.00, 0, '2026-06-01 07:39:56', '2026-06-01 07:39:56'),
(115, 19, '{\"27\":\"Lowest seating\"}', '{\"27\":\"Lowest seating\"}', 5890.00, 236.00, 0, '2026-06-01 07:39:56', '2026-06-01 07:39:56'),
(116, 19, '{\"27\":\"Premium seating\"}', '{\"27\":\"Premium seating\"}', 7890.00, 316.00, 0, '2026-06-01 07:39:56', '2026-06-01 07:39:56'),
(117, 20, '{\"28\":\"Lowest seating\"}', '{\"28\":\"Lowest seating\"}', 11990.00, 480.00, 0, '2026-06-01 07:39:56', '2026-06-01 07:39:56'),
(118, 20, '{\"28\":\"Premium seating\"}', '{\"28\":\"Premium seating\"}', 15990.00, 640.00, 0, '2026-06-01 07:39:56', '2026-06-01 07:39:56'),
(125, 23, '[]', '[]', 1990.00, 80.00, 0, '2026-06-01 07:39:56', '2026-06-01 07:39:56'),
(174, 48, '{\"56\":\"Dospělý\"}', '{\"56\":\"Dospělý\"}', 800.00, 32.00, 0, '2026-06-01 07:39:56', '2026-06-01 07:39:56'),
(175, 48, '{\"56\":\"Dítě\"}', '{\"56\":\"Dítě\"}', 400.00, 16.00, 0, '2026-06-01 07:39:56', '2026-06-01 07:39:56'),
(332, 121, '{\"101\":\"Discover\",\"102\":\"Adult\"}', '{\"101\":\"Discover\",\"102\":\"Adult\"}', 780.00, 31.00, 0, '2026-06-01 13:46:16', '2026-06-01 13:46:16'),
(333, 121, '{\"101\":\"Discover\",\"102\":\"Family (2A+3C 5-15)\"}', '{\"101\":\"Discover\",\"102\":\"Family (2A+3C 5-15)\"}', 1820.00, 73.00, 0, '2026-06-01 13:46:16', '2026-06-01 13:46:16'),
(334, 121, '{\"101\":\"Essential\",\"102\":\"Adult\"}', '{\"101\":\"Essential\",\"102\":\"Adult\"}', 900.00, 36.00, 0, '2026-06-01 13:46:16', '2026-06-01 13:46:16'),
(335, 121, '{\"101\":\"Essential\",\"102\":\"Family (2A+3C 5-15)\"}', '{\"101\":\"Essential\",\"102\":\"Family (2A+3C 5-15)\"}', 2070.00, 83.00, 0, '2026-06-01 13:46:16', '2026-06-01 13:46:16'),
(336, 121, '{\"101\":\"Explore\",\"102\":\"Adult\"}', '{\"101\":\"Explore\",\"102\":\"Adult\"}', 1020.00, 41.00, 0, '2026-06-01 13:46:16', '2026-06-01 13:46:16'),
(337, 121, '{\"101\":\"Explore\",\"102\":\"Family (2A+3C 5-15)\"}', '{\"101\":\"Explore\",\"102\":\"Family (2A+3C 5-15)\"}', 2400.00, 96.00, 0, '2026-06-01 13:46:16', '2026-06-01 13:46:16'),
(338, 121, '{\"101\":\"Panoramic\",\"102\":\"Adult\"}', '{\"101\":\"Panoramic\",\"102\":\"Adult\"}', 380.00, 15.00, 0, '2026-06-01 13:46:16', '2026-06-01 13:46:16'),
(339, 121, '{\"101\":\"Panoramic\",\"102\":\"Child 5-15\"}', '{\"101\":\"Panoramic\",\"102\":\"Child 5-15\"}', 270.00, 11.00, 0, '2026-06-01 13:46:16', '2026-06-01 13:46:16'),
(340, 121, '{\"101\":\"Panoramic\",\"102\":\"Infant 0-4\"}', '{\"101\":\"Panoramic\",\"102\":\"Infant 0-4\"}', 0.00, 0.00, 0, '2026-06-01 13:46:16', '2026-06-01 13:46:16'),
(395, 131, '{\"115\":\"Letní (od 1.5.)\",\"116\":\"Table 8\"}', '{\"115\":\"Letní (od 1.5.)\",\"116\":\"Table 8\"}', 2900.00, 116.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(396, 131, '{\"115\":\"Zimní (do 30.4.)\",\"116\":\"Table 8\"}', '{\"115\":\"Zimní (do 30.4.)\",\"116\":\"Table 8\"}', 2340.00, 94.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(397, 131, '{\"115\":\"Letní (od 1.5.)\",\"116\":\"Table 2\"}', '{\"115\":\"Letní (od 1.5.)\",\"116\":\"Table 2\"}', 3500.00, 140.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(398, 131, '{\"115\":\"Zimní (do 30.4.)\",\"116\":\"Table 2\"}', '{\"115\":\"Zimní (do 30.4.)\",\"116\":\"Table 2\"}', 2990.00, 120.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(399, 131, '{\"115\":\"Letní (od 1.5.)\",\"116\":\"Table 2 front row\"}', '{\"115\":\"Letní (od 1.5.)\",\"116\":\"Table 2 front row\"}', 4000.00, 160.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(400, 131, '{\"115\":\"Zimní (do 30.4.)\",\"116\":\"Table 2 front row\"}', '{\"115\":\"Zimní (do 30.4.)\",\"116\":\"Table 2 front row\"}', 3990.00, 160.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(401, 131, '{\"115\":\"Letní (od 1.5.)\",\"116\":\"Balcony box\"}', '{\"115\":\"Letní (od 1.5.)\",\"116\":\"Balcony box\"}', 4000.00, 160.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(402, 131, '{\"115\":\"Zimní (do 30.4.)\",\"116\":\"Balcony box\"}', '{\"115\":\"Zimní (do 30.4.)\",\"116\":\"Balcony box\"}', 3990.00, 160.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(403, 131, '{\"115\":\"Letní (od 1.5.)\",\"116\":\"Child <12\"}', '{\"115\":\"Letní (od 1.5.)\",\"116\":\"Child <12\"}', 1590.00, 64.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(404, 131, '{\"115\":\"Zimní (do 30.4.)\",\"116\":\"Child <12\"}', '{\"115\":\"Zimní (do 30.4.)\",\"116\":\"Child <12\"}', 1590.00, 64.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(405, 132, '{\"117\":\"Letní (od 1.5.)\",\"118\":\"Table 8\"}', '{\"117\":\"Letní (od 1.5.)\",\"118\":\"Table 8\"}', 2300.00, 92.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(406, 132, '{\"117\":\"Zimní (do 30.4.)\",\"118\":\"Table 8\"}', '{\"117\":\"Zimní (do 30.4.)\",\"118\":\"Table 8\"}', 1740.00, 70.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(407, 132, '{\"117\":\"Letní (od 1.5.)\",\"118\":\"Table 2\"}', '{\"117\":\"Letní (od 1.5.)\",\"118\":\"Table 2\"}', 2900.00, 116.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(408, 132, '{\"117\":\"Zimní (do 30.4.)\",\"118\":\"Table 2\"}', '{\"117\":\"Zimní (do 30.4.)\",\"118\":\"Table 2\"}', 2390.00, 96.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(409, 132, '{\"117\":\"Letní (od 1.5.)\",\"118\":\"Table 2 front row\"}', '{\"117\":\"Letní (od 1.5.)\",\"118\":\"Table 2 front row\"}', 3400.00, 136.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(410, 132, '{\"117\":\"Zimní (do 30.4.)\",\"118\":\"Table 2 front row\"}', '{\"117\":\"Zimní (do 30.4.)\",\"118\":\"Table 2 front row\"}', 3390.00, 136.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(411, 132, '{\"117\":\"Letní (od 1.5.)\",\"118\":\"Balcony box\"}', '{\"117\":\"Letní (od 1.5.)\",\"118\":\"Balcony box\"}', 3400.00, 136.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(412, 132, '{\"117\":\"Zimní (do 30.4.)\",\"118\":\"Balcony box\"}', '{\"117\":\"Zimní (do 30.4.)\",\"118\":\"Balcony box\"}', 3390.00, 136.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(413, 132, '{\"117\":\"Letní (od 1.5.)\",\"118\":\"Child <12\"}', '{\"117\":\"Letní (od 1.5.)\",\"118\":\"Child <12\"}', 1290.00, 52.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(414, 132, '{\"117\":\"Zimní (do 30.4.)\",\"118\":\"Child <12\"}', '{\"117\":\"Zimní (do 30.4.)\",\"118\":\"Child <12\"}', 1290.00, 52.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(415, 133, '{\"119\":\"Letní (od 1.5.)\",\"120\":\"Balcony box\"}', '{\"119\":\"Letní (od 1.5.)\",\"120\":\"Balcony box\"}', 8000.00, 320.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(416, 133, '{\"119\":\"Zimní (do 30.4.)\",\"120\":\"Balcony box\"}', '{\"119\":\"Zimní (do 30.4.)\",\"120\":\"Balcony box\"}', 7990.00, 320.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(417, 134, '{\"121\":\"Triple Pack\",\"122\":\"1-9 osob\"}', '{\"121\":\"Triple Pack\",\"122\":\"1-9 osob\"}', 2300.00, 95.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(418, 134, '{\"121\":\"Triple Pack\",\"122\":\"10-14 osob\"}', '{\"121\":\"Triple Pack\",\"122\":\"10-14 osob\"}', 2100.00, 85.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(419, 134, '{\"121\":\"Triple Pack\",\"122\":\"15+ osob\"}', '{\"121\":\"Triple Pack\",\"122\":\"15+ osob\"}', 2000.00, 80.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(420, 134, '{\"121\":\"Four Pack\",\"122\":\"1-9 osob\"}', '{\"121\":\"Four Pack\",\"122\":\"1-9 osob\"}', 2700.00, 110.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(421, 134, '{\"121\":\"Four Pack\",\"122\":\"10-14 osob\"}', '{\"121\":\"Four Pack\",\"122\":\"10-14 osob\"}', 2500.00, 100.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(422, 134, '{\"121\":\"Four Pack\",\"122\":\"15+ osob\"}', '{\"121\":\"Four Pack\",\"122\":\"15+ osob\"}', 2400.00, 95.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(423, 134, '{\"121\":\"Five Pack\",\"122\":\"1-9 osob\"}', '{\"121\":\"Five Pack\",\"122\":\"1-9 osob\"}', 3000.00, 125.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(424, 134, '{\"121\":\"Five Pack\",\"122\":\"10-14 osob\"}', '{\"121\":\"Five Pack\",\"122\":\"10-14 osob\"}', 2800.00, 115.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(425, 134, '{\"121\":\"Five Pack\",\"122\":\"15+ osob\"}', '{\"121\":\"Five Pack\",\"122\":\"15+ osob\"}', 2700.00, 110.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(426, 134, '{\"121\":\"Big Six\",\"122\":\"1-9 osob\"}', '{\"121\":\"Big Six\",\"122\":\"1-9 osob\"}', 3400.00, 140.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(427, 134, '{\"121\":\"Big Six\",\"122\":\"10-14 osob\"}', '{\"121\":\"Big Six\",\"122\":\"10-14 osob\"}', 3200.00, 130.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(428, 134, '{\"121\":\"Big Six\",\"122\":\"15+ osob\"}', '{\"121\":\"Big Six\",\"122\":\"15+ osob\"}', 3100.00, 125.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(429, 134, '{\"121\":\"Seven Pack\",\"122\":\"1-9 osob\"}', '{\"121\":\"Seven Pack\",\"122\":\"1-9 osob\"}', 3900.00, 160.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(430, 134, '{\"121\":\"Seven Pack\",\"122\":\"10-14 osob\"}', '{\"121\":\"Seven Pack\",\"122\":\"10-14 osob\"}', 3700.00, 150.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(431, 134, '{\"121\":\"Seven Pack\",\"122\":\"15+ osob\"}', '{\"121\":\"Seven Pack\",\"122\":\"15+ osob\"}', 3600.00, 145.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(432, 134, '{\"121\":\"Top Ten\",\"122\":\"1-9 osob\"}', '{\"121\":\"Top Ten\",\"122\":\"1-9 osob\"}', 4700.00, 190.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(433, 134, '{\"121\":\"Top Ten\",\"122\":\"10-14 osob\"}', '{\"121\":\"Top Ten\",\"122\":\"10-14 osob\"}', 4400.00, 180.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(434, 134, '{\"121\":\"Top Ten\",\"122\":\"15+ osob\"}', '{\"121\":\"Top Ten\",\"122\":\"15+ osob\"}', 4300.00, 175.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(435, 134, '{\"121\":\"Badass Pack\",\"122\":\"1-9 osob\"}', '{\"121\":\"Badass Pack\",\"122\":\"1-9 osob\"}', 5800.00, 240.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(436, 134, '{\"121\":\"Badass Pack\",\"122\":\"10-14 osob\"}', '{\"121\":\"Badass Pack\",\"122\":\"10-14 osob\"}', 5500.00, 225.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(437, 134, '{\"121\":\"Badass Pack\",\"122\":\"15+ osob\"}', '{\"121\":\"Badass Pack\",\"122\":\"15+ osob\"}', 5400.00, 220.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(438, 134, '{\"121\":\"Ladies Pack\",\"122\":\"1-9 osob\"}', '{\"121\":\"Ladies Pack\",\"122\":\"1-9 osob\"}', 2300.00, 95.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(439, 134, '{\"121\":\"Ladies Pack\",\"122\":\"10-14 osob\"}', '{\"121\":\"Ladies Pack\",\"122\":\"10-14 osob\"}', 2200.00, 90.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(440, 134, '{\"121\":\"Ladies Pack\",\"122\":\"15+ osob\"}', '{\"121\":\"Ladies Pack\",\"122\":\"15+ osob\"}', 2100.00, 85.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(441, 135, '{\"123\":\"Adult\"}', '{\"123\":\"Adult\"}', 1300.00, 52.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(442, 135, '{\"123\":\"Child 3-12\"}', '{\"123\":\"Child 3-12\"}', 825.00, 33.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(443, 135, '{\"123\":\"Infant 0-2\"}', '{\"123\":\"Infant 0-2\"}', 0.00, 0.00, 0, '2026-06-02 13:05:51', '2026-06-02 13:05:51'),
(444, 136, '{\"124\":\"Tandem Skydiving\"}', '{\"124\":\"Tandem Skydiving\"}', 6200.00, 258.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(445, 136, '{\"124\":\"Tandem + Photos & Video\"}', '{\"124\":\"Tandem + Photos & Video\"}', 8700.00, 368.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(446, 136, '{\"124\":\"Tandem + Photos & Video & Selfie\"}', '{\"124\":\"Tandem + Photos & Video & Selfie\"}', 9200.00, 388.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(447, 137, '{\"125\":\"40-minute horse ride\"}', '{\"125\":\"40-minute horse ride\"}', 2000.00, 80.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(448, 138, '{\"126\":\"Chomutov (62 m bridge)\"}', '{\"126\":\"Chomutov (62 m bridge)\"}', 3800.00, 150.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(449, 138, '{\"126\":\"Harrachov (36 m TV tower)\"}', '{\"126\":\"Harrachov (36 m TV tower)\"}', 4300.00, 170.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(450, 139, '{\"127\":\"2 rides (20 min)\"}', '{\"127\":\"2 rides (20 min)\"}', 1200.00, 46.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(451, 139, '{\"127\":\"3 rides (30 min)\"}', '{\"127\":\"3 rides (30 min)\"}', 1500.00, 59.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(452, 140, '{\"128\":\"5 rides\"}', '{\"128\":\"5 rides\"}', 1000.00, 39.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(453, 141, '{\"129\":\"4-6 osob\"}', '{\"129\":\"4-6 osob\"}', 2400.00, 100.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(454, 141, '{\"129\":\"7+ osob\"}', '{\"129\":\"7+ osob\"}', 1950.00, 80.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(455, 142, '{\"130\":\"1-hour balloon flight\"}', '{\"130\":\"1-hour balloon flight\"}', 6000.00, 240.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(456, 143, '{\"131\":\"2 osoby\"}', '{\"131\":\"2 osoby\"}', 3500.00, 140.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(457, 143, '{\"131\":\"3-4 osoby\"}', '{\"131\":\"3-4 osoby\"}', 3300.00, 132.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(458, 143, '{\"131\":\"5+ osob\"}', '{\"131\":\"5+ osob\"}', 3200.00, 128.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(459, 144, '{\"132\":\"1-4 osoby\"}', '{\"132\":\"1-4 osoby\"}', 2500.00, 98.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(460, 144, '{\"132\":\"5-8 osob\"}', '{\"132\":\"5-8 osob\"}', 2300.00, 90.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(461, 144, '{\"132\":\"9-12 osob\"}', '{\"132\":\"9-12 osob\"}', 2100.00, 82.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(462, 144, '{\"132\":\"13+ osob\"}', '{\"132\":\"13+ osob\"}', 2000.00, 78.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(463, 145, '{\"133\":\"100 bullets\"}', '{\"133\":\"100 bullets\"}', 1200.00, 46.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(464, 145, '{\"133\":\"200 bullets\"}', '{\"133\":\"200 bullets\"}', 1400.00, 55.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(465, 145, '{\"133\":\"300 bullets\"}', '{\"133\":\"300 bullets\"}', 1600.00, 63.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(466, 146, '{\"134\":\"2-3 osoby\"}', '{\"134\":\"2-3 osoby\"}', 1600.00, 63.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(467, 146, '{\"134\":\"4-5 osob\"}', '{\"134\":\"4-5 osob\"}', 1400.00, 55.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(468, 146, '{\"134\":\"6-7 osob\"}', '{\"134\":\"6-7 osob\"}', 1200.00, 47.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(469, 146, '{\"134\":\"8+ osob\"}', '{\"134\":\"8+ osob\"}', 1000.00, 39.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(470, 147, '{\"135\":\"15-minute flyboarding\"}', '{\"135\":\"15-minute flyboarding\"}', 2700.00, 105.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(471, 148, '{\"136\":\"Short ride (30 min)\",\"137\":\"1-4 osoby\"}', '{\"136\":\"Short ride (30 min)\",\"137\":\"1-4 osoby\"}', 2000.00, 78.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(472, 148, '{\"136\":\"Short ride (30 min)\",\"137\":\"5-10 osob\"}', '{\"136\":\"Short ride (30 min)\",\"137\":\"5-10 osob\"}', 1700.00, 67.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(473, 148, '{\"136\":\"Short ride (30 min)\",\"137\":\"11+ osob\"}', '{\"136\":\"Short ride (30 min)\",\"137\":\"11+ osob\"}', 1600.00, 63.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(474, 148, '{\"136\":\"Medium ride (45 min)\",\"137\":\"1-4 osoby\"}', '{\"136\":\"Medium ride (45 min)\",\"137\":\"1-4 osoby\"}', 2400.00, 94.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(475, 148, '{\"136\":\"Medium ride (45 min)\",\"137\":\"5-10 osob\"}', '{\"136\":\"Medium ride (45 min)\",\"137\":\"5-10 osob\"}', 2100.00, 82.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(476, 148, '{\"136\":\"Medium ride (45 min)\",\"137\":\"11+ osob\"}', '{\"136\":\"Medium ride (45 min)\",\"137\":\"11+ osob\"}', 2000.00, 78.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(477, 148, '{\"136\":\"Long ride (60 min)\",\"137\":\"1-4 osoby\"}', '{\"136\":\"Long ride (60 min)\",\"137\":\"1-4 osoby\"}', 2800.00, 110.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(478, 148, '{\"136\":\"Long ride (60 min)\",\"137\":\"5-10 osob\"}', '{\"136\":\"Long ride (60 min)\",\"137\":\"5-10 osob\"}', 2500.00, 98.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(479, 148, '{\"136\":\"Long ride (60 min)\",\"137\":\"11+ osob\"}', '{\"136\":\"Long ride (60 min)\",\"137\":\"11+ osob\"}', 2400.00, 94.00, 0, '2026-06-02 13:06:52', '2026-06-02 13:06:52'),
(480, 149, '{\"138\":\"Per person\"}', '{\"138\":\"Per person\"}', 1400.00, 56.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(481, 150, '{\"139\":\"Per person\"}', '{\"139\":\"Per person\"}', 1300.00, 52.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(482, 151, '{\"140\":\"Per person\"}', '{\"140\":\"Per person\"}', 1300.00, 52.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(483, 152, '{\"141\":\"Per person\"}', '{\"141\":\"Per person\"}', 1300.00, 52.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(484, 153, '{\"142\":\"Per person\"}', '{\"142\":\"Per person\"}', 650.00, 26.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(485, 154, '{\"143\":\"Per person\"}', '{\"143\":\"Per person\"}', 1000.00, 40.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(486, 155, '{\"144\":\"Per person\"}', '{\"144\":\"Per person\"}', 800.00, 32.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(487, 156, '{\"145\":\"Per person\"}', '{\"145\":\"Per person\"}', 1700.00, 68.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(488, 157, '{\"146\":\"Per person\"}', '{\"146\":\"Per person\"}', 1400.00, 56.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(489, 158, '{\"147\":\"Per person\"}', '{\"147\":\"Per person\"}', 700.00, 28.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(490, 159, '{\"148\":\"Per person\"}', '{\"148\":\"Per person\"}', 1550.00, 62.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(491, 160, '{\"149\":\"Per person\"}', '{\"149\":\"Per person\"}', 1250.00, 50.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(492, 161, '{\"150\":\"Per person\"}', '{\"150\":\"Per person\"}', 1399.00, 56.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(493, 162, '{\"151\":\"Per person\"}', '{\"151\":\"Per person\"}', 1799.00, 72.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(494, 163, '{\"152\":\"Adult\"}', '{\"152\":\"Adult\"}', 1100.00, 44.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(495, 163, '{\"152\":\"Student\"}', '{\"152\":\"Student\"}', 1000.00, 40.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(496, 163, '{\"152\":\"Child 5-15\"}', '{\"152\":\"Child 5-15\"}', 900.00, 36.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(497, 163, '{\"152\":\"Infant 0-4\"}', '{\"152\":\"Infant 0-4\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(498, 164, '{\"153\":\"Adult\"}', '{\"153\":\"Adult\"}', 950.00, 38.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(499, 164, '{\"153\":\"Student\"}', '{\"153\":\"Student\"}', 850.00, 34.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(500, 164, '{\"153\":\"Child 5-15\"}', '{\"153\":\"Child 5-15\"}', 750.00, 30.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(501, 164, '{\"153\":\"Infant 0-4\"}', '{\"153\":\"Infant 0-4\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(502, 165, '{\"154\":\"Adult\"}', '{\"154\":\"Adult\"}', 450.00, 18.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(503, 165, '{\"154\":\"Student\"}', '{\"154\":\"Student\"}', 450.00, 18.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(504, 165, '{\"154\":\"Child 5-15\"}', '{\"154\":\"Child 5-15\"}', 350.00, 14.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(505, 165, '{\"154\":\"Infant 0-4\"}', '{\"154\":\"Infant 0-4\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(506, 166, '{\"155\":\"Adult\"}', '{\"155\":\"Adult\"}', 1300.00, 52.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(507, 166, '{\"155\":\"Student\"}', '{\"155\":\"Student\"}', 1300.00, 52.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(508, 166, '{\"155\":\"Child 5-15\"}', '{\"155\":\"Child 5-15\"}', 1050.00, 42.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(509, 166, '{\"155\":\"Infant 0-4\"}', '{\"155\":\"Infant 0-4\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(510, 167, '{\"156\":\"Adult\"}', '{\"156\":\"Adult\"}', 390.00, 16.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(511, 167, '{\"156\":\"Student\"}', '{\"156\":\"Student\"}', 390.00, 16.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(512, 167, '{\"156\":\"Child 5-15\"}', '{\"156\":\"Child 5-15\"}', 200.00, 8.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(513, 167, '{\"156\":\"Infant 0-4\"}', '{\"156\":\"Infant 0-4\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(514, 168, '{\"157\":\"Adult\"}', '{\"157\":\"Adult\"}', 1300.00, 52.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(515, 168, '{\"157\":\"Student\"}', '{\"157\":\"Student\"}', 1300.00, 52.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(516, 168, '{\"157\":\"Child 5-15\"}', '{\"157\":\"Child 5-15\"}', 800.00, 32.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(517, 168, '{\"157\":\"Infant 0-4\"}', '{\"157\":\"Infant 0-4\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(518, 169, '{\"158\":\"Adult\"}', '{\"158\":\"Adult\"}', 1950.00, 78.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(519, 169, '{\"158\":\"Student\"}', '{\"158\":\"Student\"}', 1850.00, 74.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(520, 169, '{\"158\":\"Child 5-15\"}', '{\"158\":\"Child 5-15\"}', 1650.00, 66.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(521, 169, '{\"158\":\"Infant 0-4\"}', '{\"158\":\"Infant 0-4\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(522, 170, '{\"159\":\"Adult\"}', '{\"159\":\"Adult\"}', 1900.00, 76.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(523, 170, '{\"159\":\"Student\"}', '{\"159\":\"Student\"}', 1800.00, 72.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(524, 170, '{\"159\":\"Child 5-15\"}', '{\"159\":\"Child 5-15\"}', 1600.00, 64.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(525, 170, '{\"159\":\"Infant 0-4\"}', '{\"159\":\"Infant 0-4\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(526, 171, '{\"160\":\"Adult\"}', '{\"160\":\"Adult\"}', 1350.00, 54.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(527, 171, '{\"160\":\"Student\"}', '{\"160\":\"Student\"}', 1350.00, 54.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(528, 171, '{\"160\":\"Child 5-15\"}', '{\"160\":\"Child 5-15\"}', 1050.00, 42.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(529, 171, '{\"160\":\"Infant 0-4\"}', '{\"160\":\"Infant 0-4\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(530, 172, '{\"161\":\"Adult\"}', '{\"161\":\"Adult\"}', 1450.00, 58.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(531, 172, '{\"161\":\"Student\"}', '{\"161\":\"Student\"}', 1350.00, 54.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(532, 172, '{\"161\":\"Child 5-15\"}', '{\"161\":\"Child 5-15\"}', 1150.00, 46.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(533, 172, '{\"161\":\"Infant 0-4\"}', '{\"161\":\"Infant 0-4\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(534, 173, '{\"162\":\"Adult\"}', '{\"162\":\"Adult\"}', 1650.00, 66.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(535, 173, '{\"162\":\"Student\"}', '{\"162\":\"Student\"}', 1550.00, 62.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(536, 173, '{\"162\":\"Child 5-15\"}', '{\"162\":\"Child 5-15\"}', 1350.00, 54.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(537, 173, '{\"162\":\"Infant 0-4\"}', '{\"162\":\"Infant 0-4\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(538, 174, '{\"163\":\"Adult\"}', '{\"163\":\"Adult\"}', 1150.00, 46.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(539, 174, '{\"163\":\"Student\"}', '{\"163\":\"Student\"}', 1150.00, 46.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(540, 174, '{\"163\":\"Child 5-15\"}', '{\"163\":\"Child 5-15\"}', 950.00, 38.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(541, 174, '{\"163\":\"Infant 0-4\"}', '{\"163\":\"Infant 0-4\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(542, 175, '{\"164\":\"Adult\"}', '{\"164\":\"Adult\"}', 990.00, 40.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(543, 175, '{\"164\":\"Student\"}', '{\"164\":\"Student\"}', 990.00, 40.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(544, 175, '{\"164\":\"Child 5-15\"}', '{\"164\":\"Child 5-15\"}', 750.00, 30.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(545, 175, '{\"164\":\"Infant 0-4\"}', '{\"164\":\"Infant 0-4\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(546, 176, '{\"165\":\"Adult\"}', '{\"165\":\"Adult\"}', 2080.00, 83.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(547, 176, '{\"165\":\"Student & Senior\"}', '{\"165\":\"Student & Senior\"}', 1940.00, 78.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(548, 176, '{\"165\":\"Child 4-6\"}', '{\"165\":\"Child 4-6\"}', 1790.00, 72.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(549, 176, '{\"165\":\"Infant 0-3\"}', '{\"165\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(550, 177, '{\"166\":\"Adult\"}', '{\"166\":\"Adult\"}', 1530.00, 61.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(551, 177, '{\"166\":\"Student & Senior\"}', '{\"166\":\"Student & Senior\"}', 1390.00, 56.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(552, 177, '{\"166\":\"Child 4-6\"}', '{\"166\":\"Child 4-6\"}', 1190.00, 48.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(553, 177, '{\"166\":\"Infant 0-3\"}', '{\"166\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(554, 178, '{\"167\":\"Adult\"}', '{\"167\":\"Adult\"}', 1890.00, 76.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(555, 178, '{\"167\":\"Student & Senior\"}', '{\"167\":\"Student & Senior\"}', 1790.00, 72.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(556, 178, '{\"167\":\"Child 4-6\"}', '{\"167\":\"Child 4-6\"}', 1690.00, 68.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(557, 178, '{\"167\":\"Infant 0-3\"}', '{\"167\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(558, 179, '{\"168\":\"Adult\"}', '{\"168\":\"Adult\"}', 1750.00, 70.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(559, 179, '{\"168\":\"Student & Senior\"}', '{\"168\":\"Student & Senior\"}', 1600.00, 64.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(560, 179, '{\"168\":\"Child 4-6\"}', '{\"168\":\"Child 4-6\"}', 1490.00, 60.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(561, 179, '{\"168\":\"Infant 0-3\"}', '{\"168\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(562, 180, '{\"169\":\"Adult\"}', '{\"169\":\"Adult\"}', 1640.00, 66.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(563, 180, '{\"169\":\"Student & Senior\"}', '{\"169\":\"Student & Senior\"}', 1500.00, 60.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(564, 180, '{\"169\":\"Child 4-6\"}', '{\"169\":\"Child 4-6\"}', 1390.00, 56.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(565, 180, '{\"169\":\"Infant 0-3\"}', '{\"169\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(566, 181, '{\"170\":\"Adult\"}', '{\"170\":\"Adult\"}', 2590.00, 104.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(567, 181, '{\"170\":\"Student & Senior\"}', '{\"170\":\"Student & Senior\"}', 2390.00, 96.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(568, 181, '{\"170\":\"Child 4-6\"}', '{\"170\":\"Child 4-6\"}', 1990.00, 80.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(569, 181, '{\"170\":\"Infant 0-3\"}', '{\"170\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(570, 182, '{\"171\":\"Adult\"}', '{\"171\":\"Adult\"}', 1090.00, 44.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(571, 182, '{\"171\":\"Student & Senior\"}', '{\"171\":\"Student & Senior\"}', 950.00, 38.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(572, 182, '{\"171\":\"Child 4-6\"}', '{\"171\":\"Child 4-6\"}', 890.00, 36.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(573, 182, '{\"171\":\"Infant 0-3\"}', '{\"171\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(574, 183, '{\"172\":\"Adult\"}', '{\"172\":\"Adult\"}', 680.00, 27.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(575, 183, '{\"172\":\"Student & Senior\"}', '{\"172\":\"Student & Senior\"}', 600.00, 24.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(576, 183, '{\"172\":\"Child 4-6\"}', '{\"172\":\"Child 4-6\"}', 550.00, 22.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(577, 183, '{\"172\":\"Infant 0-3\"}', '{\"172\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(578, 184, '{\"173\":\"Adult\"}', '{\"173\":\"Adult\"}', 1690.00, 68.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(579, 184, '{\"173\":\"Student & Senior\"}', '{\"173\":\"Student & Senior\"}', 1490.00, 60.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(580, 184, '{\"173\":\"Child 4-6\"}', '{\"173\":\"Child 4-6\"}', 1290.00, 52.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(581, 184, '{\"173\":\"Infant 0-3\"}', '{\"173\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(582, 185, '{\"174\":\"Adult\"}', '{\"174\":\"Adult\"}', 1890.00, 76.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(583, 185, '{\"174\":\"Student & Senior\"}', '{\"174\":\"Student & Senior\"}', 1690.00, 68.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(584, 185, '{\"174\":\"Child 4-6\"}', '{\"174\":\"Child 4-6\"}', 1490.00, 60.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(585, 185, '{\"174\":\"Infant 0-3\"}', '{\"174\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(586, 186, '{\"175\":\"Adult\"}', '{\"175\":\"Adult\"}', 1900.00, 76.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(587, 186, '{\"175\":\"Student & Senior\"}', '{\"175\":\"Student & Senior\"}', 1700.00, 68.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(588, 186, '{\"175\":\"Child 4-6\"}', '{\"175\":\"Child 4-6\"}', 1190.00, 48.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(589, 186, '{\"175\":\"Infant 0-3\"}', '{\"175\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(590, 187, '{\"176\":\"One-way\"}', '{\"176\":\"One-way\"}', 380.00, 15.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(591, 187, '{\"176\":\"Both-way\"}', '{\"176\":\"Both-way\"}', 700.00, 28.00, 0, '2026-06-02 13:08:48', '2026-06-02 13:08:48'),
(592, 188, '{\"177\":\"Adult\"}', '{\"177\":\"Adult\"}', 500.00, 22.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(593, 188, '{\"177\":\"Student 12-26\"}', '{\"177\":\"Student 12-26\"}', 400.00, 17.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(594, 188, '{\"177\":\"Child 4-12\"}', '{\"177\":\"Child 4-12\"}', 300.00, 13.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(595, 188, '{\"177\":\"Infant 0-3\"}', '{\"177\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(596, 188, '{\"177\":\"Family (2A+2C)\"}', '{\"177\":\"Family (2A+2C)\"}', 1400.00, 61.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(597, 189, '{\"178\":\"Adult\"}', '{\"178\":\"Adult\"}', 900.00, 39.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(598, 189, '{\"178\":\"Infant 0-3\"}', '{\"178\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(599, 190, '{\"179\":\"Adult\"}', '{\"179\":\"Adult\"}', 2000.00, 87.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(600, 190, '{\"179\":\"Student 12-26\"}', '{\"179\":\"Student 12-26\"}', 1800.00, 78.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(601, 190, '{\"179\":\"Child 4-12\"}', '{\"179\":\"Child 4-12\"}', 1500.00, 65.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(602, 190, '{\"179\":\"Infant 0-3\"}', '{\"179\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(603, 191, '{\"180\":\"Adult\"}', '{\"180\":\"Adult\"}', 1300.00, 57.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(604, 191, '{\"180\":\"Student 12-26\"}', '{\"180\":\"Student 12-26\"}', 1000.00, 43.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(605, 191, '{\"180\":\"Child 4-12\"}', '{\"180\":\"Child 4-12\"}', 700.00, 30.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(606, 191, '{\"180\":\"Infant 0-3\"}', '{\"180\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(607, 192, '{\"181\":\"Adult\"}', '{\"181\":\"Adult\"}', 1900.00, 83.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(608, 192, '{\"181\":\"Student 12-26\"}', '{\"181\":\"Student 12-26\"}', 1750.00, 76.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(609, 192, '{\"181\":\"Child 4-12\"}', '{\"181\":\"Child 4-12\"}', 1300.00, 57.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(610, 192, '{\"181\":\"Infant 0-3\"}', '{\"181\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(611, 193, '{\"182\":\"Adult\"}', '{\"182\":\"Adult\"}', 1400.00, 61.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(612, 193, '{\"182\":\"Student 12-26\"}', '{\"182\":\"Student 12-26\"}', 1100.00, 48.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(613, 193, '{\"182\":\"Child 4-12\"}', '{\"182\":\"Child 4-12\"}', 700.00, 30.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(614, 193, '{\"182\":\"Infant 0-3\"}', '{\"182\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(615, 194, '{\"183\":\"Adult\"}', '{\"183\":\"Adult\"}', 1400.00, 61.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(616, 194, '{\"183\":\"Student 12-26\"}', '{\"183\":\"Student 12-26\"}', 1200.00, 52.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(617, 194, '{\"183\":\"Child 4-12\"}', '{\"183\":\"Child 4-12\"}', 1000.00, 43.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(618, 194, '{\"183\":\"Infant 0-3\"}', '{\"183\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(619, 195, '{\"184\":\"Adult\"}', '{\"184\":\"Adult\"}', 1400.00, 61.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(620, 195, '{\"184\":\"Student 12-26\"}', '{\"184\":\"Student 12-26\"}', 1200.00, 52.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(621, 195, '{\"184\":\"Child 4-12\"}', '{\"184\":\"Child 4-12\"}', 1000.00, 43.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(622, 195, '{\"184\":\"Infant 0-3\"}', '{\"184\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(623, 196, '{\"185\":\"Adult\"}', '{\"185\":\"Adult\"}', 900.00, 39.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(624, 196, '{\"185\":\"Infant 0-3\"}', '{\"185\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(625, 197, '{\"186\":\"Adult\"}', '{\"186\":\"Adult\"}', 400.00, 18.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(626, 197, '{\"186\":\"Student 12-26\"}', '{\"186\":\"Student 12-26\"}', 350.00, 15.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(627, 197, '{\"186\":\"Child 4-12\"}', '{\"186\":\"Child 4-12\"}', 250.00, 11.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(628, 197, '{\"186\":\"Infant 0-3\"}', '{\"186\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(629, 197, '{\"186\":\"Family (2A+2C)\"}', '{\"186\":\"Family (2A+2C)\"}', 1100.00, 48.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(630, 198, '{\"187\":\"Adult\"}', '{\"187\":\"Adult\"}', 800.00, 35.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(631, 198, '{\"187\":\"Student 12-26\"}', '{\"187\":\"Student 12-26\"}', 600.00, 26.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(632, 198, '{\"187\":\"Child 4-12\"}', '{\"187\":\"Child 4-12\"}', 400.00, 17.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(633, 198, '{\"187\":\"Infant 0-3\"}', '{\"187\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(634, 198, '{\"187\":\"Family (2A+2C)\"}', '{\"187\":\"Family (2A+2C)\"}', 1900.00, 83.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(635, 199, '{\"188\":\"Adult\"}', '{\"188\":\"Adult\"}', 400.00, 18.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(636, 199, '{\"188\":\"Student 12-26\"}', '{\"188\":\"Student 12-26\"}', 350.00, 15.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(637, 199, '{\"188\":\"Child 4-12\"}', '{\"188\":\"Child 4-12\"}', 300.00, 13.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(638, 199, '{\"188\":\"Infant 0-3\"}', '{\"188\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(639, 199, '{\"188\":\"Family (2A+2C)\"}', '{\"188\":\"Family (2A+2C)\"}', 1200.00, 52.00, 0, '2026-06-02 13:11:35', '2026-06-02 13:11:35'),
(640, 200, '{\"189\":\"Adult\"}', '{\"189\":\"Adult\"}', 700.00, 30.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(641, 200, '{\"189\":\"Student 12-26\"}', '{\"189\":\"Student 12-26\"}', 500.00, 22.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(642, 200, '{\"189\":\"Child 4-12\"}', '{\"189\":\"Child 4-12\"}', 400.00, 17.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(643, 200, '{\"189\":\"Infant 0-3\"}', '{\"189\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(644, 200, '{\"189\":\"Family (2A+2C)\"}', '{\"189\":\"Family (2A+2C)\"}', 1700.00, 74.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(645, 201, '{\"190\":\"Adult\"}', '{\"190\":\"Adult\"}', 1800.00, 78.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(646, 201, '{\"190\":\"Student 12-26\"}', '{\"190\":\"Student 12-26\"}', 1700.00, 74.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(647, 201, '{\"190\":\"Child 4-12\"}', '{\"190\":\"Child 4-12\"}', 1500.00, 65.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(648, 201, '{\"190\":\"Infant 0-3\"}', '{\"190\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(649, 202, '{\"191\":\"Adult\"}', '{\"191\":\"Adult\"}', 1100.00, 48.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(650, 202, '{\"191\":\"Student 12-26\"}', '{\"191\":\"Student 12-26\"}', 800.00, 35.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(651, 202, '{\"191\":\"Child 4-12\"}', '{\"191\":\"Child 4-12\"}', 600.00, 26.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(652, 202, '{\"191\":\"Infant 0-3\"}', '{\"191\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(653, 203, '{\"192\":\"Adult\"}', '{\"192\":\"Adult\"}', 1500.00, 65.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(654, 203, '{\"192\":\"Student 12-26\"}', '{\"192\":\"Student 12-26\"}', 1300.00, 57.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(655, 203, '{\"192\":\"Child 4-12\"}', '{\"192\":\"Child 4-12\"}', 900.00, 39.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(656, 203, '{\"192\":\"Infant 0-3\"}', '{\"192\":\"Infant 0-3\"}', 0.00, 0.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(657, 204, '{\"193\":\"Per person\"}', '{\"193\":\"Per person\"}', 650.00, 27.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(658, 205, '{\"194\":\"Adult\"}', '{\"194\":\"Adult\"}', 5750.00, 239.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(659, 205, '{\"194\":\"Child\"}', '{\"194\":\"Child\"}', 4490.00, 187.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(660, 206, '{\"195\":\"Per person\"}', '{\"195\":\"Per person\"}', 3750.00, 150.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(661, 207, '{\"196\":\"Per person\"}', '{\"196\":\"Per person\"}', 4225.00, 169.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(662, 208, '{\"197\":\"Per person\"}', '{\"197\":\"Per person\"}', 4875.00, 195.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(663, 209, '{\"198\":\"Per person\"}', '{\"198\":\"Per person\"}', 4125.00, 165.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(664, 210, '{\"199\":\"Per person\"}', '{\"199\":\"Per person\"}', 4625.00, 185.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(665, 211, '{\"200\":\"Per person\"}', '{\"200\":\"Per person\"}', 4875.00, 195.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(666, 212, '{\"201\":\"Per person\"}', '{\"201\":\"Per person\"}', 4625.00, 185.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(667, 213, '{\"202\":\"Per person\"}', '{\"202\":\"Per person\"}', 4500.00, 180.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(668, 214, '{\"203\":\"Per person\"}', '{\"203\":\"Per person\"}', 4875.00, 195.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(669, 215, '{\"204\":\"Per person\"}', '{\"204\":\"Per person\"}', 5125.00, 205.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(670, 216, '{\"205\":\"Per person\"}', '{\"205\":\"Per person\"}', 5375.00, 215.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(671, 217, '{\"206\":\"Per person\"}', '{\"206\":\"Per person\"}', 5500.00, 220.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(672, 218, '{\"207\":\"Per person\"}', '{\"207\":\"Per person\"}', 5500.00, 220.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(673, 219, '{\"208\":\"Per person\"}', '{\"208\":\"Per person\"}', 5500.00, 220.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(674, 220, '{\"209\":\"Per person\"}', '{\"209\":\"Per person\"}', 3500.00, 140.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(675, 221, '{\"210\":\"Per person\"}', '{\"210\":\"Per person\"}', 5500.00, 220.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(676, 222, '{\"211\":\"Per person\"}', '{\"211\":\"Per person\"}', 7250.00, 290.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(677, 223, '{\"212\":\"Per person\"}', '{\"212\":\"Per person\"}', 18750.00, 750.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(678, 224, '{\"213\":\"Per person\"}', '{\"213\":\"Per person\"}', 17050.00, 682.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(679, 225, '{\"214\":\"Per person\"}', '{\"214\":\"Per person\"}', 40000.00, 1600.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(684, 228, '{\"217\":\"Public (per person)\"}', '{\"217\":\"Public (per person)\"}', 700.00, 28.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(686, 229, '{\"218\":\"Public (per person)\"}', '{\"218\":\"Public (per person)\"}', 1200.00, 48.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(688, 230, '{\"219\":\"Public (per person)\"}', '{\"219\":\"Public (per person)\"}', 700.00, 28.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(690, 231, '{\"220\":\"Public (per person)\"}', '{\"220\":\"Public (per person)\"}', 2450.00, 98.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(692, 232, '{\"221\":\"Public (per person)\"}', '{\"221\":\"Public (per person)\"}', 500.00, 20.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(694, 233, '{\"222\":\"Adult\"}', '{\"222\":\"Adult\"}', 450.00, 18.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(695, 233, '{\"222\":\"Child 3-11\"}', '{\"222\":\"Child 3-11\"}', 300.00, 12.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(696, 234, '{\"223\":\"Adult\"}', '{\"223\":\"Adult\"}', 700.00, 28.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(697, 234, '{\"223\":\"Child 3-11\"}', '{\"223\":\"Child 3-11\"}', 480.00, 19.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(698, 235, '{\"224\":\"Adult\"}', '{\"224\":\"Adult\"}', 450.00, 18.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(699, 235, '{\"224\":\"Child 3-11\"}', '{\"224\":\"Child 3-11\"}', 300.00, 12.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(700, 236, '{\"225\":\"Adult\"}', '{\"225\":\"Adult\"}', 600.00, 24.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(701, 236, '{\"225\":\"Child 3-11\"}', '{\"225\":\"Child 3-11\"}', 400.00, 16.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(702, 237, '{\"226\":\"Adult\"}', '{\"226\":\"Adult\"}', 1029.00, 41.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(703, 237, '{\"226\":\"Child 3-11\"}', '{\"226\":\"Child 3-11\"}', 550.00, 22.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(704, 238, '{\"227\":\"Adult\"}', '{\"227\":\"Adult\"}', 550.00, 22.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(705, 238, '{\"227\":\"Child 3-11\"}', '{\"227\":\"Child 3-11\"}', 380.00, 15.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(706, 239, '{\"228\":\"Essential\",\"229\":\"Adult\"}', '{\"228\":\"Essential\",\"229\":\"Adult\"}', 1230.00, 49.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(707, 239, '{\"228\":\"Essential\",\"229\":\"Child 3-11\"}', '{\"228\":\"Essential\",\"229\":\"Child 3-11\"}', 830.00, 33.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(708, 239, '{\"228\":\"Exclusive\",\"229\":\"Adult\"}', '{\"228\":\"Exclusive\",\"229\":\"Adult\"}', 1480.00, 59.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(709, 239, '{\"228\":\"Exclusive\",\"229\":\"Child 3-11\"}', '{\"228\":\"Exclusive\",\"229\":\"Child 3-11\"}', 1000.00, 40.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(710, 240, '{\"230\":\"Essential\",\"231\":\"Adult\"}', '{\"230\":\"Essential\",\"231\":\"Adult\"}', 1980.00, 79.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(711, 240, '{\"230\":\"Essential\",\"231\":\"Child 3-11\"}', '{\"230\":\"Essential\",\"231\":\"Child 3-11\"}', 1380.00, 55.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(712, 240, '{\"230\":\"Exclusive\",\"231\":\"Adult\"}', '{\"230\":\"Exclusive\",\"231\":\"Adult\"}', 2480.00, 99.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(713, 240, '{\"230\":\"Exclusive\",\"231\":\"Child 3-11\"}', '{\"230\":\"Exclusive\",\"231\":\"Child 3-11\"}', 1880.00, 75.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(714, 240, '{\"230\":\"De Luxe\",\"231\":\"Adult\"}', '{\"230\":\"De Luxe\",\"231\":\"Adult\"}', 3230.00, 129.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(715, 240, '{\"230\":\"De Luxe\",\"231\":\"Child 3-11\"}', '{\"230\":\"De Luxe\",\"231\":\"Child 3-11\"}', 2480.00, 99.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(716, 241, '{\"232\":\"Essential\",\"233\":\"Adult\"}', '{\"232\":\"Essential\",\"233\":\"Adult\"}', 1730.00, 69.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(717, 241, '{\"232\":\"Essential\",\"233\":\"Child 3-11\"}', '{\"232\":\"Essential\",\"233\":\"Child 3-11\"}', 1230.00, 49.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(718, 241, '{\"232\":\"Exclusive\",\"233\":\"Adult\"}', '{\"232\":\"Exclusive\",\"233\":\"Adult\"}', 2230.00, 89.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(719, 241, '{\"232\":\"Exclusive\",\"233\":\"Child 3-11\"}', '{\"232\":\"Exclusive\",\"233\":\"Child 3-11\"}', 1730.00, 69.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(720, 242, '{\"234\":\"Adult\"}', '{\"234\":\"Adult\"}', 550.00, 22.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(722, 243, '{\"235\":\"Abrakadabra\",\"236\":\"Adult 15+\"}', '{\"235\":\"Abrakadabra\",\"236\":\"Adult 15+\"}', 590.00, 24.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(723, 243, '{\"235\":\"Abrakadabra\",\"236\":\"Child 3-14\"}', '{\"235\":\"Abrakadabra\",\"236\":\"Child 3-14\"}', 450.00, 18.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(724, 243, '{\"235\":\"Abrakadabra\",\"236\":\"Student ISIC\"}', '{\"235\":\"Abrakadabra\",\"236\":\"Student ISIC\"}', 500.00, 20.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(725, 243, '{\"235\":\"Abrakadabra\",\"236\":\"Family (2A+2C)\"}', '{\"235\":\"Abrakadabra\",\"236\":\"Family (2A+2C)\"}', 1900.00, 76.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(726, 243, '{\"235\":\"Afrikania\",\"236\":\"Adult 15+\"}', '{\"235\":\"Afrikania\",\"236\":\"Adult 15+\"}', 590.00, 24.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(727, 243, '{\"235\":\"Afrikania\",\"236\":\"Child 3-14\"}', '{\"235\":\"Afrikania\",\"236\":\"Child 3-14\"}', 450.00, 18.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(728, 243, '{\"235\":\"Afrikania\",\"236\":\"Student ISIC\"}', '{\"235\":\"Afrikania\",\"236\":\"Student ISIC\"}', 500.00, 20.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(729, 243, '{\"235\":\"Afrikania\",\"236\":\"Family (2A+2C)\"}', '{\"235\":\"Afrikania\",\"236\":\"Family (2A+2C)\"}', 1900.00, 76.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(730, 243, '{\"235\":\"Cosmic Cabinet\",\"236\":\"Adult 15+\"}', '{\"235\":\"Cosmic Cabinet\",\"236\":\"Adult 15+\"}', 590.00, 24.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(731, 243, '{\"235\":\"Cosmic Cabinet\",\"236\":\"Child 3-14\"}', '{\"235\":\"Cosmic Cabinet\",\"236\":\"Child 3-14\"}', 450.00, 18.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36');
INSERT INTO `prices` (`id`, `pricing_version_id`, `cell_key`, `dimension_values_json`, `czk`, `eur`, `is_override`, `created_at`, `updated_at`) VALUES
(732, 243, '{\"235\":\"Cosmic Cabinet\",\"236\":\"Student ISIC\"}', '{\"235\":\"Cosmic Cabinet\",\"236\":\"Student ISIC\"}', 500.00, 20.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(733, 243, '{\"235\":\"Cosmic Cabinet\",\"236\":\"Family (2A+2C)\"}', '{\"235\":\"Cosmic Cabinet\",\"236\":\"Family (2A+2C)\"}', 1900.00, 76.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(734, 243, '{\"235\":\"The Best of Image\",\"236\":\"Adult 15+\"}', '{\"235\":\"The Best of Image\",\"236\":\"Adult 15+\"}', 590.00, 24.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(735, 243, '{\"235\":\"The Best of Image\",\"236\":\"Child 3-14\"}', '{\"235\":\"The Best of Image\",\"236\":\"Child 3-14\"}', 450.00, 18.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(736, 243, '{\"235\":\"The Best of Image\",\"236\":\"Student ISIC\"}', '{\"235\":\"The Best of Image\",\"236\":\"Student ISIC\"}', 500.00, 20.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(737, 243, '{\"235\":\"The Best of Image\",\"236\":\"Family (2A+2C)\"}', '{\"235\":\"The Best of Image\",\"236\":\"Family (2A+2C)\"}', 1900.00, 76.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(738, 244, '{\"237\":\"Adult\"}', '{\"237\":\"Adult\"}', 650.00, 26.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(739, 244, '{\"237\":\"Student\"}', '{\"237\":\"Student\"}', 550.00, 22.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(740, 244, '{\"237\":\"Child 3-10\"}', '{\"237\":\"Child 3-10\"}', 450.00, 18.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(741, 245, '{\"238\":\"Adult\"}', '{\"238\":\"Adult\"}', 650.00, 26.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(742, 245, '{\"238\":\"Student\"}', '{\"238\":\"Student\"}', 600.00, 24.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(743, 245, '{\"238\":\"Child 3-10\"}', '{\"238\":\"Child 3-10\"}', 500.00, 20.00, 0, '2026-06-02 13:11:36', '2026-06-02 13:11:36'),
(744, 246, '{\"239\":\"3-course welcome drink\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Table 8\"}', '{\"239\":\"3-course welcome drink\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Table 8\"}', 2900.00, 116.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(745, 246, '{\"239\":\"3-course welcome drink\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Table 2\"}', '{\"239\":\"3-course welcome drink\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Table 2\"}', 3500.00, 140.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(746, 246, '{\"239\":\"3-course welcome drink\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Table 2 front row\"}', '{\"239\":\"3-course welcome drink\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Table 2 front row\"}', 4000.00, 160.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(747, 246, '{\"239\":\"3-course welcome drink\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Balcony box\"}', '{\"239\":\"3-course welcome drink\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Balcony box\"}', 4000.00, 160.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(748, 246, '{\"239\":\"3-course welcome drink\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Child <12\"}', '{\"239\":\"3-course welcome drink\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Child <12\"}', 1590.00, 64.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(749, 246, '{\"239\":\"3-course welcome drink\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Table 8\"}', '{\"239\":\"3-course welcome drink\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Table 8\"}', 2340.00, 94.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(750, 246, '{\"239\":\"3-course welcome drink\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Table 2\"}', '{\"239\":\"3-course welcome drink\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Table 2\"}', 2990.00, 120.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(751, 246, '{\"239\":\"3-course welcome drink\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Table 2 front row\"}', '{\"239\":\"3-course welcome drink\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Table 2 front row\"}', 3990.00, 160.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(752, 246, '{\"239\":\"3-course welcome drink\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Balcony box\"}', '{\"239\":\"3-course welcome drink\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Balcony box\"}', 3990.00, 160.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(753, 246, '{\"239\":\"3-course welcome drink\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Child <12\"}', '{\"239\":\"3-course welcome drink\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Child <12\"}', 1590.00, 64.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(754, 246, '{\"239\":\"3-course unlimited drinks\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Table 8\"}', '{\"239\":\"3-course unlimited drinks\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Table 8\"}', 3590.00, 144.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(755, 246, '{\"239\":\"3-course unlimited drinks\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Table 2\"}', '{\"239\":\"3-course unlimited drinks\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Table 2\"}', 4190.00, 168.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(756, 246, '{\"239\":\"3-course unlimited drinks\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Table 2 front row\"}', '{\"239\":\"3-course unlimited drinks\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Table 2 front row\"}', 4690.00, 188.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(757, 246, '{\"239\":\"3-course unlimited drinks\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Balcony box\"}', '{\"239\":\"3-course unlimited drinks\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Balcony box\"}', 4690.00, 188.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(758, 246, '{\"239\":\"3-course unlimited drinks\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Child <12\"}', '{\"239\":\"3-course unlimited drinks\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Child <12\"}', 1840.00, 74.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(759, 246, '{\"239\":\"3-course unlimited drinks\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Table 8\"}', '{\"239\":\"3-course unlimited drinks\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Table 8\"}', 2970.00, 119.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(760, 246, '{\"239\":\"3-course unlimited drinks\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Table 2\"}', '{\"239\":\"3-course unlimited drinks\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Table 2\"}', 3620.00, 145.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(761, 246, '{\"239\":\"3-course unlimited drinks\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Table 2 front row\"}', '{\"239\":\"3-course unlimited drinks\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Table 2 front row\"}', 4620.00, 185.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(762, 246, '{\"239\":\"3-course unlimited drinks\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Balcony box\"}', '{\"239\":\"3-course unlimited drinks\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Balcony box\"}', 4620.00, 185.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(763, 246, '{\"239\":\"3-course unlimited drinks\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Child <12\"}', '{\"239\":\"3-course unlimited drinks\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Child <12\"}', 1840.00, 74.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(764, 246, '{\"239\":\"Gold 4-course\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Balcony box\"}', '{\"239\":\"Gold 4-course\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Balcony box\"}', 8000.00, 320.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(765, 246, '{\"239\":\"Gold 4-course\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Balcony box\"}', '{\"239\":\"Gold 4-course\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Balcony box\"}', 7990.00, 320.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(766, 246, '{\"239\":\"Concert only\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Table 8\"}', '{\"239\":\"Concert only\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Table 8\"}', 2300.00, 92.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(767, 246, '{\"239\":\"Concert only\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Table 2\"}', '{\"239\":\"Concert only\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Table 2\"}', 2900.00, 116.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(768, 246, '{\"239\":\"Concert only\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Table 2 front row\"}', '{\"239\":\"Concert only\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Table 2 front row\"}', 3400.00, 136.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(769, 246, '{\"239\":\"Concert only\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Balcony box\"}', '{\"239\":\"Concert only\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Balcony box\"}', 3400.00, 136.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(770, 246, '{\"239\":\"Concert only\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Child <12\"}', '{\"239\":\"Concert only\",\"240\":\"Letní (od 1.5.)\",\"241\":\"Child <12\"}', 1290.00, 52.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(771, 246, '{\"239\":\"Concert only\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Table 8\"}', '{\"239\":\"Concert only\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Table 8\"}', 1740.00, 70.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(772, 246, '{\"239\":\"Concert only\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Table 2\"}', '{\"239\":\"Concert only\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Table 2\"}', 2390.00, 96.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(773, 246, '{\"239\":\"Concert only\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Table 2 front row\"}', '{\"239\":\"Concert only\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Table 2 front row\"}', 3390.00, 136.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(774, 246, '{\"239\":\"Concert only\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Balcony box\"}', '{\"239\":\"Concert only\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Balcony box\"}', 3390.00, 136.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(775, 246, '{\"239\":\"Concert only\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Child <12\"}', '{\"239\":\"Concert only\",\"240\":\"Zimní (do 30.4.)\",\"241\":\"Child <12\"}', 1290.00, 52.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(782, 249, '{\"244\":\"VIP (rows 1-6)\",\"245\":\"Adult\"}', '{\"244\":\"VIP (rows 1-6)\",\"245\":\"Adult\"}', 1200.00, 48.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(783, 249, '{\"244\":\"VIP (rows 1-6)\",\"245\":\"Student\"}', '{\"244\":\"VIP (rows 1-6)\",\"245\":\"Student\"}', 1100.00, 44.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(784, 249, '{\"244\":\"Cat A (rows 7-12)\",\"245\":\"Adult\"}', '{\"244\":\"Cat A (rows 7-12)\",\"245\":\"Adult\"}', 1000.00, 40.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(785, 249, '{\"244\":\"Cat A (rows 7-12)\",\"245\":\"Student\"}', '{\"244\":\"Cat A (rows 7-12)\",\"245\":\"Student\"}', 900.00, 36.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(786, 249, '{\"244\":\"Cat B (rows 13-18)\",\"245\":\"Adult\"}', '{\"244\":\"Cat B (rows 13-18)\",\"245\":\"Adult\"}', 800.00, 32.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(787, 249, '{\"244\":\"Cat B (rows 13-18)\",\"245\":\"Student\"}', '{\"244\":\"Cat B (rows 13-18)\",\"245\":\"Student\"}', 700.00, 28.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(788, 250, '{\"246\":\"VIP (rows 1-6)\",\"247\":\"Adult\"}', '{\"246\":\"VIP (rows 1-6)\",\"247\":\"Adult\"}', 1200.00, 48.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(789, 250, '{\"246\":\"VIP (rows 1-6)\",\"247\":\"Student\"}', '{\"246\":\"VIP (rows 1-6)\",\"247\":\"Student\"}', 1100.00, 44.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(790, 250, '{\"246\":\"Cat A (rows 7-12)\",\"247\":\"Adult\"}', '{\"246\":\"Cat A (rows 7-12)\",\"247\":\"Adult\"}', 1000.00, 40.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(791, 250, '{\"246\":\"Cat A (rows 7-12)\",\"247\":\"Student\"}', '{\"246\":\"Cat A (rows 7-12)\",\"247\":\"Student\"}', 900.00, 36.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(792, 250, '{\"246\":\"Cat B (rows 13-18)\",\"247\":\"Adult\"}', '{\"246\":\"Cat B (rows 13-18)\",\"247\":\"Adult\"}', 800.00, 32.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(793, 250, '{\"246\":\"Cat B (rows 13-18)\",\"247\":\"Student\"}', '{\"246\":\"Cat B (rows 13-18)\",\"247\":\"Student\"}', 700.00, 28.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(794, 251, '{\"248\":\"Standard\"}', '{\"248\":\"Standard\"}', 1000.00, 40.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(795, 251, '{\"248\":\"Senior 65+\"}', '{\"248\":\"Senior 65+\"}', 900.00, 36.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(796, 251, '{\"248\":\"Student 16-21\"}', '{\"248\":\"Student 16-21\"}', 900.00, 36.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(797, 251, '{\"248\":\"Child 7-15\"}', '{\"248\":\"Child 7-15\"}', 500.00, 20.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(798, 251, '{\"248\":\"Child 0-6\"}', '{\"248\":\"Child 0-6\"}', 0.00, 0.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(799, 252, '{\"249\":\"Standard\"}', '{\"249\":\"Standard\"}', 1000.00, 40.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(800, 252, '{\"249\":\"Senior 65+\"}', '{\"249\":\"Senior 65+\"}', 900.00, 36.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(801, 252, '{\"249\":\"Student 16-21\"}', '{\"249\":\"Student 16-21\"}', 900.00, 36.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(802, 252, '{\"249\":\"Child 7-15\"}', '{\"249\":\"Child 7-15\"}', 500.00, 20.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(803, 252, '{\"249\":\"Child 0-6\"}', '{\"249\":\"Child 0-6\"}', 0.00, 0.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(804, 253, '{\"250\":\"Standard\"}', '{\"250\":\"Standard\"}', 1000.00, 40.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(805, 253, '{\"250\":\"Senior 65+\"}', '{\"250\":\"Senior 65+\"}', 900.00, 36.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(806, 253, '{\"250\":\"Student 16-21\"}', '{\"250\":\"Student 16-21\"}', 900.00, 36.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(807, 253, '{\"250\":\"Child 7-15\"}', '{\"250\":\"Child 7-15\"}', 500.00, 20.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(808, 253, '{\"250\":\"Child 0-6\"}', '{\"250\":\"Child 0-6\"}', 0.00, 0.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(809, 254, '{\"251\":\"Standard\"}', '{\"251\":\"Standard\"}', 1000.00, 40.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(810, 254, '{\"251\":\"Senior 65+\"}', '{\"251\":\"Senior 65+\"}', 900.00, 36.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(811, 254, '{\"251\":\"Student 16-21\"}', '{\"251\":\"Student 16-21\"}', 900.00, 36.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(812, 254, '{\"251\":\"Child 7-15\"}', '{\"251\":\"Child 7-15\"}', 500.00, 20.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(813, 254, '{\"251\":\"Child 0-6\"}', '{\"251\":\"Child 0-6\"}', 0.00, 0.00, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(814, 226, '{\"215\":\"Anglicky\"}', '{\"215\":\"Anglicky\"}', 700.00, 28.00, 0, '2026-06-03 11:45:18', '2026-06-03 11:45:18'),
(815, 226, '{\"215\":\"Německy\"}', '{\"215\":\"Německy\"}', 700.00, 28.00, 0, '2026-06-03 11:45:18', '2026-06-03 11:45:18'),
(816, 227, '{\"216\":\"Anglicky\"}', '{\"216\":\"Anglicky\"}', 450.00, 20.00, 0, '2026-06-03 11:45:18', '2026-06-03 11:45:18'),
(817, 227, '{\"216\":\"Německy\"}', '{\"216\":\"Německy\"}', 450.00, 20.00, 0, '2026-06-03 11:45:18', '2026-06-03 11:45:18'),
(819, 242, '{\"234\":\"Child 2-15\"}', '{\"234\":\"Child 2-15\"}', 350.00, 16.00, 0, '2026-06-05 13:51:49', '2026-06-05 13:51:49'),
(820, 255, '{\"252\":\"A\",\"253\":\"Dospělý\"}', '{\"252\":\"A\",\"253\":\"Dospělý\"}', 800.00, 32.00, 0, '2026-06-06 15:54:43', '2026-06-06 15:54:43'),
(821, 255, '{\"252\":\"A\",\"253\":\"Student a senior 64+\"}', '{\"252\":\"A\",\"253\":\"Student a senior 64+\"}', 700.00, 28.00, 0, '2026-06-06 15:54:43', '2026-06-06 15:54:43'),
(822, 255, '{\"252\":\"A\",\"253\":\"Dítě do 12 let\"}', '{\"252\":\"A\",\"253\":\"Dítě do 12 let\"}', 400.00, 16.00, 0, '2026-06-06 15:54:43', '2026-06-06 15:54:43'),
(823, 255, '{\"252\":\"B\",\"253\":\"Dospělý\"}', '{\"252\":\"B\",\"253\":\"Dospělý\"}', 600.00, 24.00, 0, '2026-06-06 15:54:43', '2026-06-06 15:54:43'),
(824, 255, '{\"252\":\"B\",\"253\":\"Student a senior 64+\"}', '{\"252\":\"B\",\"253\":\"Student a senior 64+\"}', 500.00, 20.00, 0, '2026-06-06 15:54:43', '2026-06-06 15:54:43'),
(825, 255, '{\"252\":\"B\",\"253\":\"Dítě do 12 let\"}', '{\"252\":\"B\",\"253\":\"Dítě do 12 let\"}', 300.00, 12.00, 0, '2026-06-06 15:54:43', '2026-06-06 15:54:43'),
(826, 256, '{\"254\":\"VIP\",\"255\":\"Dospělý\"}', '{\"254\":\"VIP\",\"255\":\"Dospělý\"}', 1450.00, 58.00, 0, '2026-06-06 15:54:43', '2026-06-06 15:54:43'),
(827, 256, '{\"254\":\"VIP\",\"255\":\"Student a senior 64+\"}', '{\"254\":\"VIP\",\"255\":\"Student a senior 64+\"}', 1350.00, 54.00, 0, '2026-06-06 15:54:43', '2026-06-06 15:54:43'),
(828, 256, '{\"254\":\"VIP\",\"255\":\"Dítě do 12 let\"}', '{\"254\":\"VIP\",\"255\":\"Dítě do 12 let\"}', 725.00, 29.00, 0, '2026-06-06 15:54:43', '2026-06-06 15:54:43'),
(829, 256, '{\"254\":\"A\",\"255\":\"Dospělý\"}', '{\"254\":\"A\",\"255\":\"Dospělý\"}', 1250.00, 50.00, 0, '2026-06-06 15:54:43', '2026-06-06 15:54:43'),
(830, 256, '{\"254\":\"A\",\"255\":\"Student a senior 64+\"}', '{\"254\":\"A\",\"255\":\"Student a senior 64+\"}', 1150.00, 46.00, 0, '2026-06-06 15:54:43', '2026-06-06 15:54:43'),
(831, 256, '{\"254\":\"A\",\"255\":\"Dítě do 12 let\"}', '{\"254\":\"A\",\"255\":\"Dítě do 12 let\"}', 625.00, 25.00, 0, '2026-06-06 15:54:43', '2026-06-06 15:54:43'),
(832, 256, '{\"254\":\"B\",\"255\":\"Dospělý\"}', '{\"254\":\"B\",\"255\":\"Dospělý\"}', 1050.00, 42.00, 0, '2026-06-06 15:54:43', '2026-06-06 15:54:43'),
(833, 256, '{\"254\":\"B\",\"255\":\"Student a senior 64+\"}', '{\"254\":\"B\",\"255\":\"Student a senior 64+\"}', 950.00, 38.00, 0, '2026-06-06 15:54:43', '2026-06-06 15:54:43'),
(834, 256, '{\"254\":\"B\",\"255\":\"Dítě do 12 let\"}', '{\"254\":\"B\",\"255\":\"Dítě do 12 let\"}', 525.00, 21.00, 0, '2026-06-06 15:54:43', '2026-06-06 15:54:43'),
(835, 256, '{\"254\":\"C\",\"255\":\"Dospělý\"}', '{\"254\":\"C\",\"255\":\"Dospělý\"}', 850.00, 34.00, 0, '2026-06-06 15:54:43', '2026-06-06 15:54:43'),
(836, 256, '{\"254\":\"C\",\"255\":\"Student a senior 64+\"}', '{\"254\":\"C\",\"255\":\"Student a senior 64+\"}', 750.00, 30.00, 0, '2026-06-06 15:54:43', '2026-06-06 15:54:43'),
(837, 256, '{\"254\":\"C\",\"255\":\"Dítě do 12 let\"}', '{\"254\":\"C\",\"255\":\"Dítě do 12 let\"}', 425.00, 17.00, 0, '2026-06-06 15:54:43', '2026-06-06 15:54:43'),
(838, 257, '{\"256\":\"VIP\",\"257\":\"Dospělý\"}', '{\"256\":\"VIP\",\"257\":\"Dospělý\"}', 1450.00, 58.00, 0, '2026-06-06 15:56:14', '2026-06-06 15:56:14'),
(839, 257, '{\"256\":\"VIP\",\"257\":\"Student a senior 64+\"}', '{\"256\":\"VIP\",\"257\":\"Student a senior 64+\"}', 1350.00, 54.00, 0, '2026-06-06 15:56:14', '2026-06-06 15:56:14'),
(840, 257, '{\"256\":\"VIP\",\"257\":\"Dítě do 12 let\"}', '{\"256\":\"VIP\",\"257\":\"Dítě do 12 let\"}', 725.00, 29.00, 0, '2026-06-06 15:56:14', '2026-06-06 15:56:14'),
(841, 257, '{\"256\":\"A\",\"257\":\"Dospělý\"}', '{\"256\":\"A\",\"257\":\"Dospělý\"}', 1250.00, 50.00, 0, '2026-06-06 15:56:14', '2026-06-06 15:56:14'),
(842, 257, '{\"256\":\"A\",\"257\":\"Student a senior 64+\"}', '{\"256\":\"A\",\"257\":\"Student a senior 64+\"}', 1150.00, 46.00, 0, '2026-06-06 15:56:14', '2026-06-06 15:56:14'),
(843, 257, '{\"256\":\"A\",\"257\":\"Dítě do 12 let\"}', '{\"256\":\"A\",\"257\":\"Dítě do 12 let\"}', 625.00, 25.00, 0, '2026-06-06 15:56:14', '2026-06-06 15:56:14'),
(844, 257, '{\"256\":\"B\",\"257\":\"Dospělý\"}', '{\"256\":\"B\",\"257\":\"Dospělý\"}', 1050.00, 42.00, 0, '2026-06-06 15:56:14', '2026-06-06 15:56:14'),
(845, 257, '{\"256\":\"B\",\"257\":\"Student a senior 64+\"}', '{\"256\":\"B\",\"257\":\"Student a senior 64+\"}', 950.00, 38.00, 0, '2026-06-06 15:56:14', '2026-06-06 15:56:14'),
(846, 257, '{\"256\":\"B\",\"257\":\"Dítě do 12 let\"}', '{\"256\":\"B\",\"257\":\"Dítě do 12 let\"}', 525.00, 21.00, 0, '2026-06-06 15:56:14', '2026-06-06 15:56:14'),
(847, 257, '{\"256\":\"C\",\"257\":\"Dospělý\"}', '{\"256\":\"C\",\"257\":\"Dospělý\"}', 850.00, 34.00, 0, '2026-06-06 15:56:14', '2026-06-06 15:56:14'),
(848, 257, '{\"256\":\"C\",\"257\":\"Student a senior 64+\"}', '{\"256\":\"C\",\"257\":\"Student a senior 64+\"}', 750.00, 30.00, 0, '2026-06-06 15:56:14', '2026-06-06 15:56:14'),
(849, 257, '{\"256\":\"C\",\"257\":\"Dítě do 12 let\"}', '{\"256\":\"C\",\"257\":\"Dítě do 12 let\"}', 425.00, 17.00, 0, '2026-06-06 15:56:14', '2026-06-06 15:56:14');

-- --------------------------------------------------------

--
-- Struktura tabulky `pricing_dimensions`
--

DROP TABLE IF EXISTS `pricing_dimensions`;
CREATE TABLE `pricing_dimensions` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `type` varchar(40) NOT NULL,
  `label` varchar(120) NOT NULL,
  `label_en` varchar(190) DEFAULT NULL,
  `values_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`values_json`)),
  `values_json_en` text DEFAULT NULL,
  `value_meta_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`value_meta_json`)),
  `value_meta_json_en` text DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `pricing_dimensions`
--

INSERT INTO `pricing_dimensions` (`id`, `product_id`, `type`, `label`, `label_en`, `values_json`, `values_json_en`, `value_meta_json`, `value_meta_json_en`, `sort_order`, `created_at`, `updated_at`) VALUES
(15, 1, 'passenger_type', 'Typ návštěvníka', 'Visitor type', '[\"Adult\",\"Family (2A+3C 5-15)\"]', NULL, NULL, NULL, 0, '2026-06-01 07:39:56', '2026-06-06 19:23:51'),
(16, 2, 'passenger_type', 'Typ návštěvníka', 'Visitor type', '[\"Adult\",\"Family (2A+3C 5-15)\"]', NULL, NULL, NULL, 0, '2026-06-01 07:39:56', '2026-06-06 19:23:51'),
(17, 3, 'passenger_type', 'Typ návštěvníka', 'Visitor type', '[\"Adult\",\"Family (2A+3C 5-15)\"]', NULL, NULL, NULL, 0, '2026-06-01 07:39:56', '2026-06-06 19:23:51'),
(27, 63, 'seating', 'Sezení', 'Seating', '[\"Lowest seating\",\"Premium seating\"]', NULL, NULL, NULL, 0, '2026-06-01 07:39:56', '2026-06-06 19:23:51'),
(28, 64, 'seating', 'Sezení', 'Seating', '[\"Lowest seating\",\"Premium seating\"]', NULL, NULL, NULL, 0, '2026-06-01 07:39:56', '2026-06-06 19:23:51'),
(56, 30, 'passenger_type', 'Typ pasažéra', 'Passenger type', '[\"Dospělý\",\"Dítě\"]', '[\"Adult\",\"Child\"]', NULL, NULL, 0, '2026-06-01 07:39:56', '2026-06-06 19:23:51'),
(101, 118, 'variant', 'Varianta', 'Variant', '[\"Discover\",\"Essential\",\"Explore\",\"Panoramic\"]', NULL, '{\"Discover\":{\"label\":\"Discover\",\"tone\":\"neutral\",\"desc\":\"24 h, jedna trasa, bez plavby\",\"features\":[{\"l\":\"1 trasa (Red)\",\"v\":\"yes\"},{\"l\":\"Platnost 24 hodin\",\"v\":\"yes\"},{\"l\":\"Plavba po Vltavě\",\"v\":\"no\"}]},\"Essential\":{\"label\":\"Essential\",\"tone\":\"green\",\"desc\":\"24 h, dvě trasy + plavba po Vltavě\",\"badges\":[\"Best value\"],\"features\":[{\"l\":\"2 trasy (Red+Blue)\",\"v\":\"yes\"},{\"l\":\"Platnost 24 hodin\",\"v\":\"yes\"},{\"l\":\"Plavba po Vltavě\",\"v\":\"yes\"}]},\"Explore\":{\"label\":\"Explore\",\"tone\":\"gold\",\"desc\":\"48 h, dvě trasy + plavba a procházky\",\"features\":[{\"l\":\"2 trasy (Red+Blue)\",\"v\":\"yes\"},{\"l\":\"Platnost 48 hodin\",\"v\":\"yes\"},{\"l\":\"Plavba + 3× walking tour\",\"v\":\"yes\"}]},\"Panoramic\":{\"label\":\"Panoramic\",\"tone\":\"purple\",\"desc\":\"Jednorázová panoramatická jízda (~1 h), bez hop-off\",\"badges\":[\"Limited\"],\"features\":[{\"l\":\"1 trasa (Red)\",\"v\":\"yes\"},{\"l\":\"Panoramatická jízda ~1 h\",\"v\":\"yes\"},{\"l\":\"Hop-on hop-off\",\"v\":\"no\"}]}}', '{\"Discover\": {\"label\": \"Discover\", \"tone\": \"neutral\", \"desc\": \"24 h, one route, no cruise\", \"features\": [{\"l\": \"1 route (Red)\", \"v\": \"yes\"}, {\"l\": \"Valid 24 hours\", \"v\": \"yes\"}, {\"l\": \"Vltava river cruise\", \"v\": \"no\"}]}, \"Essential\": {\"label\": \"Essential\", \"tone\": \"green\", \"desc\": \"24 h, two routes + Vltava river cruise\", \"badges\": [\"Best value\"], \"features\": [{\"l\": \"2 routes (Red+Blue)\", \"v\": \"yes\"}, {\"l\": \"Valid 24 hours\", \"v\": \"yes\"}, {\"l\": \"Vltava river cruise\", \"v\": \"yes\"}]}, \"Explore\": {\"label\": \"Explore\", \"tone\": \"gold\", \"desc\": \"48 h, two routes + cruise and walks\", \"features\": [{\"l\": \"2 routes (Red+Blue)\", \"v\": \"yes\"}, {\"l\": \"Valid 48 hours\", \"v\": \"yes\"}, {\"l\": \"Cruise + 3× walking tour\", \"v\": \"yes\"}]}, \"Panoramic\": {\"label\": \"Panoramic\", \"tone\": \"purple\", \"desc\": \"One-time panoramic ride (~1 h), no hop-off\", \"badges\": [\"Limited\"], \"features\": [{\"l\": \"1 route (Red)\", \"v\": \"yes\"}, {\"l\": \"Panoramic ride ~1 h\", \"v\": \"yes\"}, {\"l\": \"Hop-on hop-off\", \"v\": \"no\"}]}}', 0, '2026-06-01 13:46:16', '2026-06-06 19:34:03'),
(102, 118, 'passenger_type', 'Typ pasažéra', 'Passenger type', '[\"Adult\",\"Child 5-15\",\"Infant 0-4\",\"Family (2A+3C 5-15)\"]', NULL, NULL, NULL, 1, '2026-06-01 13:46:16', '2026-06-06 19:23:51'),
(115, 60, 'variant', 'Sezóna', 'Season', '[\"Letní (od 1.5.)\", \"Zimní (do 30.4.)\"]', '[\"Summer (from May 1)\",\"Winter (until Apr 30)\"]', NULL, NULL, 0, '2026-06-02 13:05:51', '2026-06-06 19:23:51'),
(116, 60, 'seating', 'Sezení', 'Seating', '[\"Table 8\", \"Table 2\", \"Table 2 front row\", \"Balcony box\", \"Child <12\"]', NULL, NULL, NULL, 1, '2026-06-02 13:05:51', '2026-06-06 19:23:51'),
(117, 62, 'variant', 'Sezóna', 'Season', '[\"Letní (od 1.5.)\", \"Zimní (do 30.4.)\"]', '[\"Summer (from May 1)\",\"Winter (until Apr 30)\"]', NULL, NULL, 0, '2026-06-02 13:05:51', '2026-06-06 19:23:51'),
(118, 62, 'seating', 'Sezení', 'Seating', '[\"Table 8\", \"Table 2\", \"Table 2 front row\", \"Balcony box\", \"Child <12\"]', NULL, NULL, NULL, 1, '2026-06-02 13:05:51', '2026-06-06 19:23:51'),
(119, 61, 'variant', 'Sezóna', 'Season', '[\"Letní (od 1.5.)\", \"Zimní (do 30.4.)\"]', '[\"Summer (from May 1)\",\"Winter (until Apr 30)\"]', NULL, NULL, 0, '2026-06-02 13:05:51', '2026-06-06 19:23:51'),
(120, 61, 'seating', 'Sezení', 'Seating', '[\"Balcony box\"]', NULL, NULL, NULL, 1, '2026-06-02 13:05:51', '2026-06-06 19:23:51'),
(121, 89, 'variant', 'Balíček (zbraně)', 'Package (guns)', '[\"Triple Pack\", \"Four Pack\", \"Five Pack\", \"Big Six\", \"Seven Pack\", \"Top Ten\", \"Badass Pack\", \"Ladies Pack\"]', NULL, '{\"Triple Pack\": {\"desc\": \"Kalashnikov · Pump Shotgun · Glock 17 (3 zbraně, 25 ran)\"}, \"Four Pack\": {\"desc\": \"Kalashnikov · Pump Shotgun · MP5 · .38 Special (4 zbraně, 30 ran)\"}, \"Five Pack\": {\"desc\": \"Kalashnikov · Pump Shotgun · MP5 · .38 Special · Glock 17 (5 zbraní, 40 ran)\"}, \"Big Six\": {\"desc\": \"Kalashnikov · Dragunov · AR15 · Pump Shotgun · MP5 · .44 Taurus (6 zbraní, 45 ran)\"}, \"Seven Pack\": {\"desc\": \"Kalashnikov · Dragunov · AR15 · Pump Shotgun · MP5 · .44 Taurus · Glock 17 (7 zbraní, 55 ran)\"}, \"Top Ten\": {\"desc\": \"10 zbraní vč. Scorpion EVO, Colt 1911, S&W MP9 (80 ran)\"}, \"Badass Pack\": {\"desc\": \"13 zbraní vč. Desert Eagle .50, P90, G36, Steyr AUG (90 ran)\"}, \"Ladies Pack\": {\"desc\": \"Ruger Mark · Glock 44 · V-AR9 – nízký zpětný ráz (3 zbraně, 30 ran)\"}}', '{\"Triple Pack\": {\"desc\": \"Kalashnikov · Pump Shotgun · Glock 17 (3 guns, 25 rounds)\"}, \"Four Pack\": {\"desc\": \"Kalashnikov · Pump Shotgun · MP5 · .38 Special (4 guns, 30 rounds)\"}, \"Five Pack\": {\"desc\": \"Kalashnikov · Pump Shotgun · MP5 · .38 Special · Glock 17 (5 guns, 40 rounds)\"}, \"Big Six\": {\"desc\": \"Kalashnikov · Dragunov · AR15 · Pump Shotgun · MP5 · .44 Taurus (6 guns, 45 rounds)\"}, \"Seven Pack\": {\"desc\": \"Kalashnikov · Dragunov · AR15 · Pump Shotgun · MP5 · .44 Taurus · Glock 17 (7 guns, 55 rounds)\"}, \"Top Ten\": {\"desc\": \"10 guns incl. Scorpion EVO, Colt 1911, S&W MP9 (80 rounds)\"}, \"Badass Pack\": {\"desc\": \"13 guns incl. Desert Eagle .50, P90, G36, Steyr AUG (90 rounds)\"}, \"Ladies Pack\": {\"desc\": \"Ruger Mark · Glock 44 · V-AR9 – low recoil (3 guns, 30 rounds)\"}}', 0, '2026-06-02 13:05:51', '2026-06-06 19:37:34'),
(122, 89, 'variant', 'Velikost skupiny (sleva)', 'Group size (discount)', '[\"1-9 osob\", \"10-14 osob\", \"15+ osob\"]', '[\"1-9 people\",\"10-14 people\",\"15+ people\"]', NULL, NULL, 1, '2026-06-02 13:05:51', '2026-06-06 19:23:51'),
(123, 88, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Child 3-12\", \"Infant 0-2\"]', NULL, NULL, NULL, 0, '2026-06-02 13:05:51', '2026-06-06 19:23:51'),
(124, 90, 'variant', 'Balíček', 'Package', '[\"Tandem Skydiving\", \"Tandem + Photos & Video\", \"Tandem + Photos & Video & Selfie\"]', NULL, NULL, NULL, 0, '2026-06-02 13:06:52', '2026-06-06 19:23:51'),
(125, 91, 'variant', 'Balíček', 'Package', '[\"40-minute horse ride\"]', NULL, NULL, NULL, 0, '2026-06-02 13:06:52', '2026-06-06 19:23:51'),
(126, 92, 'variant', 'Lokalita', 'Location', '[\"Chomutov (62 m bridge)\", \"Harrachov (36 m TV tower)\"]', NULL, NULL, NULL, 0, '2026-06-02 13:06:52', '2026-06-06 19:23:51'),
(127, 93, 'variant', 'Balíček', 'Package', '[\"2 rides (20 min)\", \"3 rides (30 min)\"]', NULL, NULL, NULL, 0, '2026-06-02 13:06:52', '2026-06-06 19:23:51'),
(128, 94, 'variant', 'Balíček', 'Package', '[\"5 rides\"]', NULL, NULL, NULL, 0, '2026-06-02 13:06:52', '2026-06-06 19:23:51'),
(129, 95, 'variant', 'Velikost skupiny', 'Group size', '[\"4-6 osob\", \"7+ osob\"]', '[\"4-6 people\",\"7+ people\"]', NULL, NULL, 0, '2026-06-02 13:06:52', '2026-06-06 19:23:51'),
(130, 96, 'variant', 'Balíček', 'Package', '[\"1-hour balloon flight\"]', NULL, NULL, NULL, 0, '2026-06-02 13:06:52', '2026-06-06 19:23:51'),
(131, 97, 'variant', 'Velikost skupiny', 'Group size', '[\"2 osoby\", \"3-4 osoby\", \"5+ osob\"]', '[\"2 people\",\"3-4 people\",\"5+ people\"]', NULL, NULL, 0, '2026-06-02 13:06:52', '2026-06-06 19:23:51'),
(132, 98, 'variant', 'Velikost skupiny', 'Group size', '[\"1-4 osoby\", \"5-8 osob\", \"9-12 osob\", \"13+ osob\"]', '[\"1-4 people\",\"5-8 people\",\"9-12 people\",\"13+ people\"]', NULL, NULL, 0, '2026-06-02 13:06:52', '2026-06-06 19:23:51'),
(133, 99, 'variant', 'Balíček', 'Package', '[\"100 bullets\", \"200 bullets\", \"300 bullets\"]', NULL, NULL, NULL, 0, '2026-06-02 13:06:52', '2026-06-06 19:23:51'),
(134, 100, 'variant', 'Velikost skupiny', 'Group size', '[\"2-3 osoby\", \"4-5 osob\", \"6-7 osob\", \"8+ osob\"]', '[\"2-3 people\",\"4-5 people\",\"6-7 people\",\"8+ people\"]', NULL, NULL, 0, '2026-06-02 13:06:52', '2026-06-06 19:23:51'),
(135, 101, 'variant', 'Balíček', 'Package', '[\"15-minute flyboarding\"]', NULL, NULL, NULL, 0, '2026-06-02 13:06:52', '2026-06-06 19:23:51'),
(136, 102, 'variant', 'Délka jízdy', 'Ride length', '[\"Short ride (30 min)\", \"Medium ride (45 min)\", \"Long ride (60 min)\"]', NULL, NULL, NULL, 0, '2026-06-02 13:06:52', '2026-06-06 19:23:51'),
(137, 102, 'variant', 'Velikost skupiny', 'Group size', '[\"1-4 osoby\", \"5-10 osob\", \"11+ osob\"]', '[\"1-4 people\",\"5-10 people\",\"11+ people\"]', NULL, NULL, 1, '2026-06-02 13:06:52', '2026-06-06 19:23:51'),
(138, 103, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(139, 104, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(140, 105, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(141, 106, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(142, 107, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(143, 108, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(144, 109, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(145, 110, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(146, 111, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(147, 112, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(148, 113, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(149, 114, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(150, 82, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(151, 83, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(152, 5, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student\", \"Child 5-15\", \"Infant 0-4\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(153, 6, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student\", \"Child 5-15\", \"Infant 0-4\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(154, 7, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student\", \"Child 5-15\", \"Infant 0-4\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(155, 8, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student\", \"Child 5-15\", \"Infant 0-4\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(156, 9, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student\", \"Child 5-15\", \"Infant 0-4\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(157, 10, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student\", \"Child 5-15\", \"Infant 0-4\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(158, 11, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student\", \"Child 5-15\", \"Infant 0-4\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(159, 12, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student\", \"Child 5-15\", \"Infant 0-4\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(160, 13, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student\", \"Child 5-15\", \"Infant 0-4\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(161, 14, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student\", \"Child 5-15\", \"Infant 0-4\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(162, 15, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student\", \"Child 5-15\", \"Infant 0-4\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(163, 16, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student\", \"Child 5-15\", \"Infant 0-4\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(164, 17, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student\", \"Child 5-15\", \"Infant 0-4\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(165, 18, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student & Senior\", \"Child 4-6\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(166, 19, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student & Senior\", \"Child 4-6\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(167, 20, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student & Senior\", \"Child 4-6\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(168, 21, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student & Senior\", \"Child 4-6\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(169, 22, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student & Senior\", \"Child 4-6\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(170, 23, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student & Senior\", \"Child 4-6\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(171, 24, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student & Senior\", \"Child 4-6\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(172, 25, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student & Senior\", \"Child 4-6\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(173, 26, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student & Senior\", \"Child 4-6\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(174, 27, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student & Senior\", \"Child 4-6\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(175, 28, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student & Senior\", \"Child 4-6\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(176, 29, 'variant', 'Transfer (2-3 os.)', 'Transfer (2-3 pax)', '[\"One-way\", \"Both-way\"]', NULL, NULL, NULL, 0, '2026-06-02 13:08:48', '2026-06-06 19:23:51'),
(177, 32, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student 12-26\", \"Child 4-12\", \"Infant 0-3\", \"Family (2A+2C)\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:35', '2026-06-06 19:23:51'),
(178, 33, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:35', '2026-06-06 19:23:51'),
(179, 34, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student 12-26\", \"Child 4-12\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:35', '2026-06-06 19:23:51'),
(180, 35, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student 12-26\", \"Child 4-12\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:35', '2026-06-06 19:23:51'),
(181, 36, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student 12-26\", \"Child 4-12\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:35', '2026-06-06 19:23:51'),
(182, 37, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student 12-26\", \"Child 4-12\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:35', '2026-06-06 19:23:51'),
(183, 38, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student 12-26\", \"Child 4-12\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:35', '2026-06-06 19:23:51'),
(184, 39, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student 12-26\", \"Child 4-12\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:35', '2026-06-06 19:23:51'),
(185, 40, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:35', '2026-06-06 19:23:51'),
(186, 41, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student 12-26\", \"Child 4-12\", \"Infant 0-3\", \"Family (2A+2C)\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:35', '2026-06-06 19:23:51'),
(187, 42, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student 12-26\", \"Child 4-12\", \"Infant 0-3\", \"Family (2A+2C)\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:35', '2026-06-06 19:23:51'),
(188, 43, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student 12-26\", \"Child 4-12\", \"Infant 0-3\", \"Family (2A+2C)\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:35', '2026-06-06 19:23:51'),
(189, 44, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student 12-26\", \"Child 4-12\", \"Infant 0-3\", \"Family (2A+2C)\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(190, 45, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student 12-26\", \"Child 4-12\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(191, 46, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student 12-26\", \"Child 4-12\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(192, 47, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Student 12-26\", \"Child 4-12\", \"Infant 0-3\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(193, 121, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(194, 122, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Child\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(195, 123, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(196, 124, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(197, 125, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(198, 126, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(199, 127, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(200, 128, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(201, 129, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(202, 130, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(203, 131, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(204, 132, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(205, 133, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(206, 134, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(207, 135, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(208, 136, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(209, 137, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(210, 138, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(211, 139, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(212, 140, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(213, 141, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(214, 142, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Per person\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(215, 65, 'variant', 'Jazyk', 'Language', '[\"Anglicky\",\"Německy\"]', '[\"English\",\"German\"]', '{\"Anglicky\":{\"label\":\"Anglicky\",\"flag\":\"gb\",\"desc\":\"Út/Čt/So/Ne 19:00 (léto) / 18:00 (zima)\",\"tlang\":\"EN\"},\"Německy\":{\"label\":\"Německy\",\"flag\":\"de\",\"desc\":\"Čt/So 19:00 (léto) / 18:00 (zima)\",\"tlang\":\"DE\"}}', '{\"Anglicky\": {\"label\": \"English\", \"flag\": \"gb\", \"desc\": \"Tue/Thu/Sat/Sun 19:00 (summer) / 18:00 (winter)\", \"tlang\": \"EN\"}, \"Německy\": {\"label\": \"German\", \"flag\": \"de\", \"desc\": \"Thu/Sat 19:00 (summer) / 18:00 (winter)\", \"tlang\": \"DE\"}}', 0, '2026-06-02 13:11:36', '2026-06-06 19:37:34'),
(216, 66, 'variant', 'Jazyk', 'Language', '[\"Anglicky\",\"Německy\"]', '[\"English\",\"German\"]', '{\"Anglicky\":{\"label\":\"Anglicky\",\"flag\":\"gb\",\"desc\":\"denně 20:30 (léto) / 19:30 (zima)\",\"tlang\":\"EN\"},\"Německy\":{\"label\":\"Německy\",\"flag\":\"de\",\"desc\":\"St/So 20:00 (celý rok)\",\"tlang\":\"DE\"}}', '{\"Anglicky\": {\"label\": \"English\", \"flag\": \"gb\", \"desc\": \"daily 20:30 (summer) / 19:30 (winter)\", \"tlang\": \"EN\"}, \"Německy\": {\"label\": \"German\", \"flag\": \"de\", \"desc\": \"Wed/Sat 20:00 (year-round)\", \"tlang\": \"DE\"}}', 0, '2026-06-02 13:11:36', '2026-06-06 19:37:34'),
(217, 67, 'variant', 'Možnost', 'Option', '[\"Public (per person)\"]', NULL, '{\"Private group\": {\"desc\": \"celá skupina, max ~8 os.\"}}', '{\"Private group\": {\"desc\": \"whole group, max ~8 people\"}}', 0, '2026-06-02 13:11:36', '2026-06-06 19:37:34'),
(218, 68, 'variant', 'Možnost', 'Option', '[\"Public (per person)\"]', NULL, '{\"Private group\": {\"desc\": \"celá skupina, max ~8 os.\"}}', '{\"Private group\": {\"desc\": \"whole group, max ~8 people\"}}', 0, '2026-06-02 13:11:36', '2026-06-06 19:37:34'),
(219, 69, 'variant', 'Možnost', 'Option', '[\"Public (per person)\"]', NULL, '{\"Private group\": {\"desc\": \"celá skupina, max ~8 os.\"}}', '{\"Private group\": {\"desc\": \"whole group, max ~8 people\"}}', 0, '2026-06-02 13:11:36', '2026-06-06 19:37:34'),
(220, 70, 'variant', 'Možnost', 'Option', '[\"Public (per person)\"]', NULL, '{\"Private group\": {\"desc\": \"celá skupina, max ~8 os.\"}}', '{\"Private group\": {\"desc\": \"whole group, max ~8 people\"}}', 0, '2026-06-02 13:11:36', '2026-06-06 19:37:34'),
(221, 71, 'variant', 'Možnost', 'Option', '[\"Public (per person)\"]', NULL, '{\"Private group\": {\"desc\": \"celá skupina, max ~8 os.\"}}', '{\"Private group\": {\"desc\": \"whole group, max ~8 people\"}}', 0, '2026-06-02 13:11:36', '2026-06-06 19:37:34'),
(222, 72, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Child 3-11\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(223, 73, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Child 3-11\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(224, 74, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Child 3-11\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(225, 75, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Child 3-11\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(226, 76, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Child 3-11\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(227, 77, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Child 3-11\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(228, 78, 'variant', 'Třída', 'Class', '[\"Essential\", \"Exclusive\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(229, 78, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Child 3-11\"]', NULL, NULL, NULL, 1, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(230, 79, 'variant', 'Třída', 'Class', '[\"Essential\", \"Exclusive\", \"De Luxe\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(231, 79, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Child 3-11\"]', NULL, NULL, NULL, 1, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(232, 80, 'variant', 'Třída', 'Class', '[\"Essential\", \"Exclusive\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(233, 80, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\", \"Child 3-11\"]', NULL, NULL, NULL, 1, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(234, 81, 'passenger_type', 'Návštěvník', 'Visitor', '[\"Adult\",\"Child 2-15\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(235, 115, 'variant', 'Představení', 'Show', '[\"Abrakadabra\", \"Afrikania\", \"Cosmic Cabinet\", \"The Best of Image\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(236, 115, 'passenger_type', 'Vstupenka', 'Ticket', '[\"Adult 15+\", \"Child 3-14\", \"Student ISIC\", \"Family (2A+2C)\"]', NULL, NULL, NULL, 1, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(237, 116, 'passenger_type', 'Vstupenka', 'Ticket', '[\"Adult\", \"Student\", \"Child 3-10\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(238, 117, 'passenger_type', 'Vstupenka', 'Ticket', '[\"Adult\", \"Student\", \"Child 3-10\"]', NULL, NULL, NULL, 0, '2026-06-02 13:11:36', '2026-06-06 19:23:51'),
(239, 59, 'variant', 'Package', NULL, '[\"3-course welcome drink\", \"3-course unlimited drinks\", \"Gold 4-course\", \"Concert only\"]', NULL, NULL, NULL, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(240, 59, 'variant', 'Sezóna', 'Season', '[\"Letní (od 1.5.)\", \"Zimní (do 30.4.)\"]', '[\"Summer (from May 1)\",\"Winter (until Apr 30)\"]', NULL, NULL, 1, '2026-06-03 10:39:26', '2026-06-06 19:23:51'),
(241, 59, 'seating', 'Sezení', 'Seating', '[\"Table 8\", \"Table 2\", \"Table 2 front row\", \"Balcony box\", \"Child <12\"]', NULL, NULL, NULL, 2, '2026-06-03 10:39:26', '2026-06-06 19:23:51'),
(244, 57, 'zone', 'Zone', NULL, '[\"VIP (rows 1-6)\", \"Cat A (rows 7-12)\", \"Cat B (rows 13-18)\"]', NULL, NULL, NULL, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(245, 57, 'audience', 'Visitor', NULL, '[\"Adult\", \"Student\"]', NULL, NULL, NULL, 1, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(246, 58, 'zone', 'Zone', NULL, '[\"VIP (rows 1-6)\", \"Cat A (rows 7-12)\", \"Cat B (rows 13-18)\"]', NULL, NULL, NULL, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(247, 58, 'audience', 'Visitor', NULL, '[\"Adult\", \"Student\"]', NULL, NULL, NULL, 1, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(248, 84, 'ticket_type', 'Ticket', NULL, '[\"Standard\", \"Senior 65+\", \"Student 16-21\", \"Child 7-15\", \"Child 0-6\"]', NULL, NULL, NULL, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(249, 85, 'ticket_type', 'Ticket', NULL, '[\"Standard\", \"Senior 65+\", \"Student 16-21\", \"Child 7-15\", \"Child 0-6\"]', NULL, NULL, NULL, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(250, 86, 'ticket_type', 'Ticket', NULL, '[\"Standard\", \"Senior 65+\", \"Student 16-21\", \"Child 7-15\", \"Child 0-6\"]', NULL, NULL, NULL, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(251, 87, 'ticket_type', 'Ticket', NULL, '[\"Standard\", \"Senior 65+\", \"Student 16-21\", \"Child 7-15\", \"Child 0-6\"]', NULL, NULL, NULL, 0, '2026-06-03 10:39:26', '2026-06-03 10:39:26'),
(252, 49, 'zone', 'Zóna', 'Zone', '[\"A\",\"B\"]', NULL, '{\"A\":{\"desc\":\"řada 1–6\"},\"B\":{\"desc\":\"řada 7–12\"}}', '{\"A\": {\"desc\": \"rows 1–6\"}, \"B\": {\"desc\": \"rows 7–12\"}}', 0, '2026-06-06 15:54:43', '2026-06-06 19:37:34'),
(253, 49, 'audience', 'Návštěvník', 'Visitor', '[\"Dospělý\",\"Student a senior 64+\",\"Dítě do 12 let\"]', '[\"Adult\",\"Student & senior 64+\",\"Child under 12\"]', '{\"Student a senior 64+\":{\"desc\":\"studenti a senioři 64+\"},\"Dítě do 12 let\":{\"desc\":\"děti do 12 let včetně\"}}', '{\"Student a senior 64+\": {\"desc\": \"students and seniors 64+\"}, \"Dítě do 12 let\": {\"desc\": \"children up to 12 inclusive\"}}', 1, '2026-06-06 15:54:43', '2026-06-06 19:37:34'),
(254, 48, 'zone', 'Zóna', 'Zone', '[\"VIP\",\"A\",\"B\",\"C\"]', NULL, '{\"VIP\":{\"desc\":\"přízemí řada 5–10\"},\"A\":{\"desc\":\"přízemí řada 1–4 a 11–15\"},\"B\":{\"desc\":\"přízemí řada 16–20, balkón řada 1–7\"},\"C\":{\"desc\":\"přízemí řada 21–26\"}}', '{\"VIP\": {\"desc\": \"stalls rows 5–10\"}, \"A\": {\"desc\": \"stalls rows 1–4 and 11–15\"}, \"B\": {\"desc\": \"stalls rows 16–20, balcony rows 1–7\"}, \"C\": {\"desc\": \"stalls rows 21–26\"}}', 0, '2026-06-06 15:54:43', '2026-06-06 19:37:34'),
(255, 48, 'audience', 'Návštěvník', 'Visitor', '[\"Dospělý\",\"Student a senior 64+\",\"Dítě do 12 let\"]', '[\"Adult\",\"Student & senior 64+\",\"Child under 12\"]', '{\"Student a senior 64+\":{\"desc\":\"studenti a senioři 64+\"},\"Dítě do 12 let\":{\"desc\":\"děti do 12 let včetně\"}}', '{\"Student a senior 64+\": {\"desc\": \"students and seniors 64+\"}, \"Dítě do 12 let\": {\"desc\": \"children up to 12 inclusive\"}}', 1, '2026-06-06 15:54:43', '2026-06-06 19:37:34'),
(256, 143, 'zone', 'Zóna', 'Zone', '[\"VIP\",\"A\",\"B\",\"C\"]', NULL, '{\"VIP\":{\"desc\":\"přízemí řada 5–10\"},\"A\":{\"desc\":\"přízemí řada 1–4 a 11–15\"},\"B\":{\"desc\":\"přízemí řada 16–20, balkón řada 1–7\"},\"C\":{\"desc\":\"přízemí řada 21–26\"}}', '{\"VIP\": {\"desc\": \"stalls rows 5–10\"}, \"A\": {\"desc\": \"stalls rows 1–4 and 11–15\"}, \"B\": {\"desc\": \"stalls rows 16–20, balcony rows 1–7\"}, \"C\": {\"desc\": \"stalls rows 21–26\"}}', 0, '2026-06-06 15:56:14', '2026-06-06 19:37:34'),
(257, 143, 'audience', 'Návštěvník', 'Visitor', '[\"Dospělý\",\"Student a senior 64+\",\"Dítě do 12 let\"]', '[\"Adult\",\"Student & senior 64+\",\"Child under 12\"]', '{\"Student a senior 64+\":{\"desc\":\"studenti a senioři 64+\"},\"Dítě do 12 let\":{\"desc\":\"děti do 12 let včetně\"}}', '{\"Student a senior 64+\": {\"desc\": \"students and seniors 64+\"}, \"Dítě do 12 let\": {\"desc\": \"children up to 12 inclusive\"}}', 1, '2026-06-06 15:56:14', '2026-06-06 19:37:34');

-- --------------------------------------------------------

--
-- Struktura tabulky `pricing_versions`
--

DROP TABLE IF EXISTS `pricing_versions`;
CREATE TABLE `pricing_versions` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `effective_from` date DEFAULT NULL,
  `effective_to` date DEFAULT NULL,
  `status` enum('draft','active','archived') NOT NULL DEFAULT 'draft',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `commission_pct` decimal(5,2) DEFAULT NULL,
  `seller_bonus_pct` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `pricing_versions`
--

INSERT INTO `pricing_versions` (`id`, `product_id`, `name`, `effective_from`, `effective_to`, `status`, `created_at`, `updated_at`, `commission_pct`, `seller_bonus_pct`) VALUES
(11, 1, 'Katalog 2026', NULL, NULL, 'active', '2026-06-01 07:39:56', '2026-06-01 07:39:56', NULL, NULL),
(12, 2, 'Katalog 2026', NULL, NULL, 'active', '2026-06-01 07:39:56', '2026-06-01 07:39:56', NULL, NULL),
(13, 3, 'Katalog 2026', NULL, NULL, 'active', '2026-06-01 07:39:56', '2026-06-01 07:39:56', NULL, NULL),
(19, 63, 'Katalog 2026', NULL, NULL, 'active', '2026-06-01 07:39:56', '2026-06-01 07:39:56', NULL, NULL),
(20, 64, 'Katalog 2026', NULL, NULL, 'active', '2026-06-01 07:39:56', '2026-06-01 07:39:56', NULL, NULL),
(23, 4, 'Katalog 2026', NULL, NULL, 'active', '2026-06-01 07:39:56', '2026-06-01 07:39:56', NULL, NULL),
(48, 30, 'Katalog 2026', NULL, NULL, 'active', '2026-06-01 07:39:56', '2026-06-01 07:39:56', NULL, NULL),
(121, 118, 'Big Bus 2026', NULL, NULL, 'active', '2026-06-01 13:46:16', '2026-06-01 13:46:16', NULL, NULL),
(131, 60, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:05:51', '2026-06-02 13:05:51', NULL, NULL),
(132, 62, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:05:51', '2026-06-02 13:05:51', NULL, NULL),
(133, 61, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:05:51', '2026-06-02 13:05:51', NULL, NULL),
(134, 89, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:05:51', '2026-06-02 13:05:51', NULL, NULL),
(135, 88, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:05:51', '2026-06-02 13:05:51', NULL, NULL),
(136, 90, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:06:52', '2026-06-02 13:06:52', NULL, NULL),
(137, 91, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:06:52', '2026-06-02 13:06:52', NULL, NULL),
(138, 92, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:06:52', '2026-06-02 13:06:52', NULL, NULL),
(139, 93, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:06:52', '2026-06-02 13:06:52', NULL, NULL),
(140, 94, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:06:52', '2026-06-02 13:06:52', NULL, NULL),
(141, 95, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:06:52', '2026-06-02 13:06:52', NULL, NULL),
(142, 96, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:06:52', '2026-06-02 13:06:52', NULL, NULL),
(143, 97, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:06:52', '2026-06-02 13:06:52', NULL, NULL),
(144, 98, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:06:52', '2026-06-02 13:06:52', NULL, NULL),
(145, 99, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:06:52', '2026-06-02 13:06:52', NULL, NULL),
(146, 100, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:06:52', '2026-06-02 13:06:52', NULL, NULL),
(147, 101, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:06:52', '2026-06-02 13:06:52', NULL, NULL),
(148, 102, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:06:52', '2026-06-02 13:06:52', NULL, NULL),
(149, 103, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(150, 104, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(151, 105, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(152, 106, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(153, 107, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(154, 108, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(155, 109, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(156, 110, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(157, 111, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(158, 112, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(159, 113, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(160, 114, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(161, 82, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(162, 83, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(163, 5, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(164, 6, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(165, 7, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(166, 8, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(167, 9, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(168, 10, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(169, 11, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(170, 12, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(171, 13, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(172, 14, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(173, 15, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(174, 16, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(175, 17, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(176, 18, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(177, 19, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(178, 20, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(179, 21, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(180, 22, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(181, 23, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(182, 24, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(183, 25, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(184, 26, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(185, 27, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(186, 28, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(187, 29, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:08:48', '2026-06-02 13:08:48', NULL, NULL),
(188, 32, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:35', '2026-06-02 13:11:35', NULL, NULL),
(189, 33, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:35', '2026-06-02 13:11:35', NULL, NULL),
(190, 34, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:35', '2026-06-02 13:11:35', NULL, NULL),
(191, 35, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:35', '2026-06-02 13:11:35', NULL, NULL),
(192, 36, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:35', '2026-06-02 13:11:35', NULL, NULL),
(193, 37, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:35', '2026-06-02 13:11:35', NULL, NULL),
(194, 38, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:35', '2026-06-02 13:11:35', NULL, NULL),
(195, 39, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:35', '2026-06-02 13:11:35', NULL, NULL),
(196, 40, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:35', '2026-06-02 13:11:35', NULL, NULL),
(197, 41, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:35', '2026-06-02 13:11:35', NULL, NULL),
(198, 42, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:35', '2026-06-02 13:11:35', NULL, NULL),
(199, 43, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:35', '2026-06-02 13:11:35', NULL, NULL),
(200, 44, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(201, 45, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(202, 46, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(203, 47, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(204, 121, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(205, 122, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(206, 123, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(207, 124, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(208, 125, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(209, 126, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(210, 127, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(211, 128, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(212, 129, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(213, 130, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(214, 131, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(215, 132, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(216, 133, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(217, 134, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(218, 135, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(219, 136, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(220, 137, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(221, 138, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(222, 139, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(223, 140, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(224, 141, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(225, 142, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(226, 65, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(227, 66, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(228, 67, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(229, 68, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(230, 69, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(231, 70, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(232, 71, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(233, 72, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(234, 73, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(235, 74, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(236, 75, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(237, 76, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(238, 77, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(239, 78, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(240, 79, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(241, 80, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(242, 81, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(243, 115, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(244, 116, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(245, 117, 'Katalog 2026', NULL, NULL, 'active', '2026-06-02 13:11:36', '2026-06-02 13:11:36', NULL, NULL),
(246, 59, 'Katalog 2026', NULL, NULL, 'active', '2026-06-03 10:39:26', '2026-06-03 10:39:26', NULL, NULL),
(249, 57, 'Katalog 2026', NULL, NULL, 'active', '2026-06-03 10:39:26', '2026-06-03 10:39:26', NULL, NULL),
(250, 58, 'Katalog 2026', NULL, NULL, 'active', '2026-06-03 10:39:26', '2026-06-03 10:39:26', NULL, NULL),
(251, 84, 'Katalog 2026', NULL, NULL, 'active', '2026-06-03 10:39:26', '2026-06-03 10:39:26', NULL, NULL),
(252, 85, 'Katalog 2026', NULL, NULL, 'active', '2026-06-03 10:39:26', '2026-06-03 10:39:26', NULL, NULL),
(253, 86, 'Katalog 2026', NULL, NULL, 'active', '2026-06-03 10:39:26', '2026-06-03 10:39:26', NULL, NULL),
(254, 87, 'Katalog 2026', NULL, NULL, 'active', '2026-06-03 10:39:26', '2026-06-03 10:39:26', NULL, NULL),
(255, 49, 'Katalog 2026', NULL, NULL, 'active', '2026-06-06 15:54:43', '2026-06-06 15:54:43', NULL, NULL),
(256, 48, 'Katalog 2026', NULL, NULL, 'active', '2026-06-06 15:54:43', '2026-06-06 15:54:43', NULL, NULL),
(257, 143, 'Katalog 2026', NULL, NULL, 'active', '2026-06-06 15:56:14', '2026-06-06 15:56:14', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabulky `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `agency_id` int(10) UNSIGNED NOT NULL,
  `commission_pct` decimal(5,2) DEFAULT NULL,
  `seller_bonus_pct` decimal(5,2) DEFAULT NULL,
  `name_cs` varchar(190) NOT NULL,
  `name_en` varchar(190) DEFAULT NULL,
  `name_de` varchar(190) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `variant_diagram_path` varchar(255) DEFAULT NULL,
  `description_cs` text DEFAULT NULL,
  `description_en` text DEFAULT NULL,
  `description_de` text DEFAULT NULL,
  `languages` varchar(255) DEFAULT NULL,
  `languages_en` varchar(190) DEFAULT NULL,
  `order_instructions` text DEFAULT NULL,
  `order_instructions_en` text DEFAULT NULL,
  `booking_url` varchar(500) DEFAULT NULL,
  `has_contingent` tinyint(1) NOT NULL DEFAULT 0,
  `duration_minutes` int(10) UNSIGNED DEFAULT NULL,
  `schedule_type` enum('continuous','fixed_daily','multiple_daily','weekly_pattern','seasonal','specific_dates','on_demand') NOT NULL DEFAULT 'on_demand',
  `voucher_redemption_type` enum('direct_entry','box_office_exchange','bus_activation','agency_call') NOT NULL DEFAULT 'direct_entry',
  `ticket_type` enum('open','date_required') NOT NULL DEFAULT 'date_required',
  `pickup_available` tinyint(1) NOT NULL DEFAULT 0,
  `pickup_required` tinyint(1) NOT NULL DEFAULT 0,
  `pickup_free` tinyint(1) NOT NULL DEFAULT 1,
  `pickup_window_minutes` int(10) UNSIGNED DEFAULT NULL,
  `pickup_confirmation` enum('fixed','tbc_agency') DEFAULT NULL,
  `status` enum('active','inactive','archived') NOT NULL DEFAULT 'active',
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deposit_fixed_czk` decimal(10,2) DEFAULT NULL,
  `deposit_fixed_eur` decimal(10,2) DEFAULT NULL,
  `meeting_point_address` varchar(255) DEFAULT NULL,
  `meeting_point_address_en` varchar(255) DEFAULT NULL,
  `map_url` varchar(255) DEFAULT NULL,
  `included` text DEFAULT NULL,
  `included_en` text DEFAULT NULL,
  `excluded` text DEFAULT NULL,
  `excluded_en` text DEFAULT NULL,
  `what_to_bring` text DEFAULT NULL,
  `what_to_bring_en` text DEFAULT NULL,
  `important_info` text DEFAULT NULL,
  `important_info_en` text DEFAULT NULL,
  `cancellation_policy` varchar(255) DEFAULT NULL,
  `cancellation_policy_en` text DEFAULT NULL,
  `meeting_point_note` varchar(255) DEFAULT NULL,
  `meeting_point_note_en` varchar(255) DEFAULT NULL,
  `meeting_options` text DEFAULT NULL,
  `meeting_options_en` text DEFAULT NULL,
  `seating` tinyint(1) NOT NULL DEFAULT 0,
  `addons` text DEFAULT NULL,
  `seat_map_svg` text DEFAULT NULL,
  `language_options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`language_options`)),
  `attributes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attributes`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `products`
--

INSERT INTO `products` (`id`, `agency_id`, `commission_pct`, `seller_bonus_pct`, `name_cs`, `name_en`, `name_de`, `image_path`, `variant_diagram_path`, `description_cs`, `description_en`, `description_de`, `languages`, `languages_en`, `order_instructions`, `order_instructions_en`, `booking_url`, `has_contingent`, `duration_minutes`, `schedule_type`, `voucher_redemption_type`, `ticket_type`, `pickup_available`, `pickup_required`, `pickup_free`, `pickup_window_minutes`, `pickup_confirmation`, `status`, `is_featured`, `created_at`, `updated_at`, `deposit_fixed_czk`, `deposit_fixed_eur`, `meeting_point_address`, `meeting_point_address_en`, `map_url`, `included`, `included_en`, `excluded`, `excluded_en`, `what_to_bring`, `what_to_bring_en`, `important_info`, `important_info_en`, `cancellation_policy`, `cancellation_policy_en`, `meeting_point_note`, `meeting_point_note_en`, `meeting_options`, `meeting_options_en`, `seating`, `addons`, `seat_map_svg`, `language_options`, `attributes`) VALUES
(1, 1, NULL, NULL, 'Discover 24h', NULL, NULL, 'placeholders/ag-1.svg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1440, 'continuous', 'direct_entry', 'open', 0, 0, 1, NULL, NULL, 'inactive', 0, '2026-06-01 06:52:56', '2026-06-02 18:08:01', NULL, NULL, NULL, NULL, NULL, 'Unlimited hop-on hop-off on both routes (Red and Green) for your ticket validity\nMultilingual audio commentary (24 languages) with earphones\nOn-board staff\nVltava river cruise (where included in your ticket)', NULL, 'Food and drinks\nGratuities', NULL, 'This voucher (print or mobile)\nSun protection in summer', NULL, 'Board at any of the 18 stops — look for the red Big Bus. Audio guide via the earphones provided.', NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(2, 1, NULL, NULL, 'Essential 24h', NULL, NULL, 'placeholders/ag-1.svg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1440, 'continuous', 'direct_entry', 'open', 0, 0, 1, NULL, NULL, 'inactive', 0, '2026-06-01 06:52:56', '2026-06-02 18:08:01', NULL, NULL, NULL, NULL, NULL, 'Unlimited hop-on hop-off on both routes (Red and Green) for your ticket validity\nMultilingual audio commentary (24 languages) with earphones\nOn-board staff\nVltava river cruise (where included in your ticket)', NULL, 'Food and drinks\nGratuities', NULL, 'This voucher (print or mobile)\nSun protection in summer', NULL, 'Board at any of the 18 stops — look for the red Big Bus. Audio guide via the earphones provided.', NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(3, 1, NULL, NULL, 'Explore 48h', NULL, NULL, 'placeholders/ag-1.svg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 2880, 'continuous', 'direct_entry', 'open', 0, 0, 1, NULL, NULL, 'inactive', 0, '2026-06-01 06:52:56', '2026-06-02 18:08:01', NULL, NULL, NULL, NULL, NULL, 'Unlimited hop-on hop-off on both routes (Red and Green) for your ticket validity\nMultilingual audio commentary (24 languages) with earphones\nOn-board staff\nVltava river cruise (where included in your ticket)', NULL, 'Food and drinks\nGratuities', NULL, 'This voucher (print or mobile)\nSun protection in summer', NULL, 'Board at any of the 18 stops — look for the red Big Bus. Audio guide via the earphones provided.', NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(4, 1, NULL, NULL, 'Panoramic 72h', NULL, NULL, 'placeholders/ag-1.svg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 4320, 'continuous', 'direct_entry', 'open', 0, 0, 1, NULL, NULL, 'inactive', 0, '2026-06-01 06:52:56', '2026-06-02 18:08:01', NULL, NULL, NULL, NULL, NULL, 'Unlimited hop-on hop-off on both routes (Red and Green) for your ticket validity\nMultilingual audio commentary (24 languages) with earphones\nOn-board staff\nVltava river cruise (where included in your ticket)', NULL, 'Food and drinks\nGratuities', NULL, 'This voucher (print or mobile)\nSun protection in summer', NULL, 'Board at any of the 18 stops — look for the red Big Bus. Audio guide via the earphones provided.', NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(5, 2, NULL, NULL, 'Grand City Tour – Best of Prague', 'Grand City Tour – Best of Prague', NULL, 'products/5_a29b04d2.webp', NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz: kancelář Premiant, Na Příkopě 23, Praha 1. Přijít 10 min předem. Bus + pěší část + Pražský hrad. Živý průvodce.', 'Meeting point: Premiant office, Na Příkopě 23, Prague 1. Arrive 10 min early. Coach + walking part + Prague Castle. Live guide.', NULL, 0, 240, 'multiple_daily', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Premiant Point — Na Příkopě 23, Praha 1', NULL, NULL, 'Professional guide / multilingual commentary\r\nTransport by coach (and boat where part of the tour)\r\nFree hotel pickup on request', NULL, 'Meals\r\nGratuities\r\nOptional admission fees', NULL, 'This voucher (print or mobile)\r\nComfortable walking shoes', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at the Premiant office (Na Příkopě 23, Praha 1), or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(6, 2, NULL, NULL, 'The Best of Prague (shorter)', 'The Best of Prague (shorter)', NULL, 'products/6_e8b6d883.jpg', NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz: kancelář Premiant, Na Příkopě 23, Praha 1. Přijít 10 min předem. Kratší okruh historickým centrem.', 'Meeting point: Premiant office, Na Příkopě 23, Prague 1. Arrive 10 min early. Shorter loop through the historic centre.', NULL, 0, 210, 'multiple_daily', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Info Centre — Malostranské náměstí 22, Praha 1', NULL, NULL, 'Professional guide / multilingual commentary\nTransport by coach (and boat where part of the tour)\nFree hotel pickup on request', NULL, 'Meals\nGratuities\nOptional admission fees', NULL, 'This voucher (print or mobile)\nComfortable walking shoes', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at the Premiant office (Na Příkopě 23, Praha 1), or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(7, 2, NULL, NULL, 'Walking Tour – Old & Jewish Town', 'Walking Tour – Old & Jewish Town', NULL, 'products/7_176e69c9.webp', NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz: kancelář Premiant, Na Příkopě 23, Praha 1. Přijít 10 min předem. Pěší prohlídka Starého Města a Židovské čtvrti.', 'Meeting point: Premiant office, Na Příkopě 23, Prague 1. Arrive 10 min early. Walking tour of the Old Town and the Jewish Quarter.', NULL, 0, 150, 'fixed_daily', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Premiant Point — Na Příkopě 23, Praha 1', NULL, NULL, 'Professional guide / multilingual commentary\r\nTransport by coach (and boat where part of the tour)\r\nFree hotel pickup on request', NULL, 'Meals\r\nGratuities\r\nOptional admission fees', NULL, 'This voucher (print or mobile)\r\nComfortable walking shoes', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at the Premiant office (Na Příkopě 23, Praha 1), or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(8, 2, NULL, NULL, 'Prague Castle Interiors + boat', 'Prague Castle Interiors + boat', NULL, 'products/8_fd94a9a5.webp', NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz: kancelář Premiant, Na Příkopě 23, Praha 1. Přijít 10 min předem. Vstup do interiérů Pražského hradu + plavba.', 'Meeting point: Premiant office, Na Příkopě 23, Prague 1. Arrive 10 min early. Entry to the Prague Castle interiors + cruise.', NULL, 0, 240, 'fixed_daily', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Premiant Point — Na Příkopě 23, Praha 1', NULL, NULL, 'Round-trip transport from Prague\r\nEnglish-speaking guide', NULL, 'Meals\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes and weather-appropriate clothing', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at the Premiant office (Na Příkopě 23, Praha 1), or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(9, 2, NULL, NULL, 'Panoramic Vltava River Cruise', 'Panoramic Vltava River Cruise', NULL, 'products/9_f770ff90.webp', NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz: kancelář Premiant, Na Příkopě 23, Praha 1. Přijít 10 min předem. Panoramatická plavba po Vltavě.', 'Meeting point: Premiant office, Na Příkopě 23, Prague 1. Arrive 10 min early. Panoramic cruise on the Vltava.', NULL, 0, 55, 'weekly_pattern', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Boat pier — Dvořákovo nábřeží, Pier 17, Praha 1', NULL, NULL, 'Round-trip transport from Prague\r\nEnglish-speaking guide', NULL, 'Meals\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes and weather-appropriate clothing', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at the Premiant office (Na Příkopě 23, Praha 1), or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(10, 2, NULL, NULL, 'Evening Cruise with Dinner', 'Evening Cruise with Dinner', NULL, 'products/10_0f6ea733.webp', NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz: kancelář Premiant, Na Příkopě 23, Praha 1. Nástup 18:30, odplutí 18:50. Večeře v ceně, nápoje zvlášť.', 'Meeting point: Premiant office, Na Příkopě 23, Prague 1. Boarding 18:30, departure 18:50. Dinner included, drinks separate.', NULL, 0, 180, 'fixed_daily', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Boat pier — Dvořákovo nábřeží, Pier 17, Praha 1', NULL, NULL, 'Round-trip transport from Prague\r\nEnglish-speaking guide', NULL, 'Meals\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes and weather-appropriate clothing', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at the Premiant office (Na Příkopě 23, Praha 1), or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(11, 2, NULL, NULL, 'Český Krumlov – UNESCO', 'Český Krumlov – UNESCO', NULL, 'products/11_a093f527.webp', NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz: kancelář Premiant, Na Příkopě 23, Praha 1. Přijít 10 min předem. Celodenní výlet (UNESCO Český Krumlov).', 'Meeting point: Premiant office, Na Příkopě 23, Prague 1. Arrive 10 min early. Full-day trip (UNESCO Český Krumlov).', NULL, 0, 660, 'fixed_daily', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 1, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Premiant Point — Na Příkopě 23, Praha 1', NULL, NULL, 'Round-trip transport from Prague\r\nEnglish-speaking guide', NULL, 'Meals\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes and weather-appropriate clothing', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at the Premiant office (Na Příkopě 23, Praha 1), or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, '[\"en\",\"de\",\"fr\",\"es\",\"it\",\"ru\"]', '[\"bus\",\"walking\",\"guide\",\"family\",\"history\",\"hotelpickup\",\"ticket\"]'),
(12, 2, NULL, NULL, 'Karlovy Vary + Watchtower Diana', 'Karlovy Vary + Watchtower Diana', NULL, 'products/12_fa093109.webp', NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz: kancelář Premiant, Na Příkopě 23, Praha 1. Přijít 10 min předem. Celodenní výlet s živým průvodcem (plná verze).', 'Meeting point: Premiant office, Na Příkopě 23, Prague 1. Arrive 10 min early. Full-day trip with a live guide (full version).', NULL, 0, 570, 'weekly_pattern', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Premiant Point — Na Příkopě 23, Praha 1', NULL, NULL, 'Round-trip transport from Prague\r\nEnglish-speaking guide', NULL, 'Meals\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes and weather-appropriate clothing', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at the Premiant office (Na Příkopě 23, Praha 1), or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(13, 2, NULL, NULL, 'Karlovy Vary – eGuide (self)', 'Karlovy Vary – eGuide (self)', NULL, 'products/13_2fee1522.webp', NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz: kancelář Premiant, Na Příkopě 23, Praha 1. Přijít 10 min předem. Celodenní výlet, eGuide (samostatně, BEZ živého průvodce).', 'Meeting point: Premiant office, Na Příkopě 23, Prague 1. Arrive 10 min early. Full-day trip, eGuide (self-guided, WITHOUT a live guide).', NULL, 0, 570, 'weekly_pattern', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Premiant Point — Na Příkopě 23, Praha 1', NULL, NULL, 'Round-trip transport from Prague\r\nEnglish-speaking guide', NULL, 'Meals\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes and weather-appropriate clothing', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at the Premiant office (Na Příkopě 23, Praha 1), or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(14, 2, NULL, NULL, 'Terezín Memorial', 'Terezín Memorial', NULL, 'products/14_67524422.webp', NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz: kancelář Premiant, Na Příkopě 23, Praha 1. Přijít 10 min předem. Celodenní výlet, pietní místo Terezín.', 'Meeting point: Premiant office, Na Příkopě 23, Prague 1. Arrive 10 min early. Full-day trip, Terezín Memorial.', NULL, 0, 300, 'fixed_daily', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Premiant Point — Na Příkopě 23, Praha 1', NULL, NULL, 'Round-trip transport from Prague\r\nEnglish-speaking guide', NULL, 'Meals\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes and weather-appropriate clothing', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at the Premiant office (Na Příkopě 23, Praha 1), or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(15, 2, NULL, NULL, 'Kutná Hora + Bone Church', 'Kutná Hora + Bone Church', NULL, 'products/15_1512cfa6.webp', NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz: kancelář Premiant, Na Příkopě 23, Praha 1. Přijít 10 min předem. Výlet Kutná Hora (plná verze s průvodcem).', 'Meeting point: Premiant office, Na Příkopě 23, Prague 1. Arrive 10 min early. Kutná Hora trip (full version with a guide).', NULL, 0, 390, 'weekly_pattern', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Premiant Point — Na Příkopě 23, Praha 1', NULL, NULL, 'Round-trip transport from Prague\r\nEnglish-speaking guide', NULL, 'Meals\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes and weather-appropriate clothing', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at the Premiant office (Na Příkopě 23, Praha 1), or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(16, 2, NULL, NULL, 'Kutná Hora – eGuide (self)', 'Kutná Hora – eGuide (self)', NULL, 'products/16_3598f7aa.webp', NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz: kancelář Premiant, Na Příkopě 23, Praha 1. Přijít 10 min předem. Kutná Hora, eGuide (samostatně, BEZ živého průvodce).', 'Meeting point: Premiant office, Na Příkopě 23, Prague 1. Arrive 10 min early. Kutná Hora, eGuide (self-guided, WITHOUT a live guide).', NULL, 0, 390, 'weekly_pattern', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Premiant Point — Na Příkopě 23, Praha 1', NULL, NULL, 'Round-trip transport from Prague\r\nEnglish-speaking guide', NULL, 'Meals\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes and weather-appropriate clothing', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at the Premiant office (Na Příkopě 23, Praha 1), or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(17, 2, NULL, NULL, 'Teplice – Royal Spa City', 'Teplice – Royal Spa City', NULL, 'products/17_73ac25dc.webp', NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz: kancelář Premiant, Na Příkopě 23, Praha 1. Přijít 10 min předem. Lázeňské město Teplice.', 'Meeting point: Premiant office, Na Příkopě 23, Prague 1. Arrive 10 min early. Spa town of Teplice.', NULL, 0, 660, 'continuous', 'direct_entry', 'open', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Premiant Point — Na Příkopě 23, Praha 1', NULL, NULL, 'Self-guided audio eGuide for your mobile phone', NULL, 'Transport\r\nGuide\r\nAdmission fees', NULL, 'This voucher\r\nA smartphone and earphones', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at the Premiant office (Na Příkopě 23, Praha 1), or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, '[\"bus\",\"walking\",\"guide\",\"family\",\"history\",\"hotelpickup\"]'),
(18, 3, NULL, NULL, 'Český Krumlov Day Trip', 'Český Krumlov Day Trip', NULL, 'products/18_d18cab46.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 600, 'weekly_pattern', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-03 17:34:27', NULL, NULL, 'Na Florenci 33, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Meet at Na Florenci 33, or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, '[\"en\",\"de\",\"fr\",\"es\",\"it\",\"ru\"]', NULL),
(19, 3, NULL, NULL, 'Karlštejn Castle', 'Karlštejn Castle', NULL, 'products/19_2e46b86f.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 300, 'weekly_pattern', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 08:48:32', NULL, NULL, 'Na Florenci 33, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Meet at Na Florenci 33, or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(20, 3, NULL, NULL, 'Karlovy Vary Spa Town', 'Karlovy Vary Spa Town', NULL, 'products/20_11416c1d.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 540, 'weekly_pattern', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 08:46:18', NULL, NULL, 'Na Florenci 33, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Meet at Na Florenci 33, or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(21, 3, NULL, NULL, 'Kutná Hora & Bone Church', 'Kutná Hora & Bone Church', NULL, 'products/21_76402be2.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 360, 'fixed_daily', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 08:46:27', NULL, NULL, 'Na Florenci 33, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Meet at Na Florenci 33, or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(22, 3, NULL, NULL, 'Terezín Memorial', 'Terezín Memorial', NULL, 'products/22_863d9881.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 360, 'fixed_daily', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 08:46:48', NULL, NULL, 'Na Florenci 33, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Meet at Na Florenci 33, or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(23, 3, NULL, NULL, 'Best of Prague', 'Best of Prague', NULL, 'products/23_5921574a.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 390, 'weekly_pattern', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 08:49:35', NULL, NULL, 'Na Florenci 33, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Meet at Na Florenci 33, or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(24, 3, NULL, NULL, 'City Tour', 'City Tour', NULL, 'products/24_b0d202a6.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 150, 'weekly_pattern', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 08:49:44', NULL, NULL, 'Na Florenci 33, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Meet at Na Florenci 33, or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(25, 3, NULL, NULL, 'Old Town Prague', 'Old Town Prague', NULL, 'products/25_fd5afb40.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 120, 'fixed_daily', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 08:49:54', NULL, NULL, 'Na Florenci 33, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Meet at Na Florenci 33, or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(26, 3, NULL, NULL, 'Folklore Evening', 'Folklore Evening', NULL, 'products/26_8cc5b195.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 180, 'fixed_daily', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 08:50:43', NULL, NULL, 'Na Florenci 33, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Meet at Na Florenci 33, or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(27, 3, NULL, NULL, 'River Cruise with Dinner', 'River Cruise with Dinner', NULL, 'products/27_aa88f579.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 180, 'fixed_daily', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 08:50:49', NULL, NULL, 'Na Florenci 33, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Meet at Na Florenci 33, or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(28, 3, NULL, NULL, 'Prague Jewish Town', 'Prague Jewish Town', NULL, 'products/28_abf6a453.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 180, 'weekly_pattern', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 08:51:18', NULL, NULL, 'Na Florenci 33, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Meet at Na Florenci 33, or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(29, 3, NULL, NULL, 'Shopping Tour (Fashion Arena)', 'Shopping Tour (Fashion Arena)', NULL, 'products/29_77439ef8.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 150, 'multiple_daily', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 08:51:00', NULL, NULL, 'Na Florenci 33, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Transfer pricing for 2-3 passengers. Larger groups: see brochure / on request.', NULL, NULL, NULL, 'Meet at Na Florenci 33, or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(30, 3, NULL, NULL, 'Airport Transfer', NULL, NULL, 'placeholders/ag-3.svg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'on_demand', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'inactive', 0, '2026-06-01 06:52:56', '2026-06-02 18:08:01', NULL, NULL, 'Na Florenci 1413/33, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Meet at Na Florenci 33, or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(31, 3, NULL, NULL, 'Private Tours', NULL, NULL, 'products/31_5dfb3762.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'on_demand', 'direct_entry', 'date_required', 1, 0, 1, NULL, 'tbc_agency', 'inactive', 0, '2026-06-01 06:52:56', '2026-06-06 11:02:53', NULL, NULL, 'Na Florenci 1413/33, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Meet at Na Florenci 33, or choose free hotel pickup.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(32, 4, NULL, NULL, 'Prague Historical City', 'Prague Historical City', NULL, 'products/32_0b09b750.jpg', NULL, NULL, NULL, NULL, '26 languages (audio); live guide EN', NULL, NULL, NULL, NULL, 0, 120, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Staroměstské náměstí, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz na zvoleném místě (A/B) 10 min před odjezdem. Audio průvodce ve 26 jazycích. Krátká pauza u Pražského hradu (30–40 min).', 'Meet at your chosen stop (A/B) 10 min before departure. Audio guide in 26 languages. Short stop at Prague Castle (30–40 min).', NULL, NULL, 'Vyber nástupní zastávku při rezervaci. A – Staroměstské nám.: roh Pařížská 1 u kostela sv. Mikuláše (Staré Město), metro A „Staroměstská\". B – nám. Republiky 3 naproti Obecnímu domu, metro B „Náměstí Republiky\".', 'Choose your boarding stop when booking. A – Old Town Square: corner of Pařížská 1 by St. Nicholas Church (Old Town), metro A \"Staroměstská\". B – náměstí Republiky 3 opposite the Municipal House, metro B \"Náměstí Republiky\".', 'Stop A – Old Town Square||Old Town Square (corner of Pařížská 1, beside St. Nicholas Church), Praha 1\r\nStop B – náměstí Republiky||náměstí Republiky 3 (in front of the Hybernia Palace), Praha 1', NULL, 0, NULL, NULL, '[\"en\",\"de\",\"fr\",\"es\",\"it\",\"ru\"]', NULL),
(33, 4, NULL, NULL, 'Jewish Prague', 'Jewish Prague', NULL, 'products/33_5dbbf5a0.jpg', NULL, NULL, NULL, NULL, '26 languages (audio); live guide EN', NULL, NULL, NULL, NULL, 0, 180, 'weekly_pattern', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Staroměstské náměstí, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Pěší prohlídka. Vstupné do objektů (synagogy, hřbitov) NENÍ v ceně. Web aktuálně nenabízí.', 'Walking tour. Admission to the sites (synagogues, cemetery) is NOT included. Currently not offered on the web.', NULL, NULL, 'Vyber nástupní zastávku při rezervaci. A – Staroměstské nám.: roh Pařížská 1 u kostela sv. Mikuláše (Staré Město), metro A „Staroměstská\". B – nám. Republiky 3 naproti Obecnímu domu, metro B „Náměstí Republiky\".', 'Choose your boarding stop when booking. A – Old Town Square: corner of Pařížská 1 by St. Nicholas Church (Old Town), metro A \"Staroměstská\". B – náměstí Republiky 3 opposite the Municipal House, metro B \"Náměstí Republiky\".', 'Stop A – Old Town Square||Old Town Square (corner of Pařížská 1, beside St. Nicholas Church), Praha 1\r\nStop B – náměstí Republiky||náměstí Republiky 3 (in front of the Hybernia Palace), Praha 1', NULL, 0, NULL, NULL, '[\"en\",\"de\",\"fr\",\"es\",\"it\",\"ru\"]', NULL),
(34, 4, NULL, NULL, 'Český Krumlov', 'Český Krumlov', NULL, 'products/34_9e86bf8a.jpg', NULL, NULL, NULL, NULL, 'audio průvodce v 26 jazycích', '26 languages (audio), live guide EN', NULL, NULL, NULL, 0, 600, 'weekly_pattern', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Staroměstské náměstí, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Celodenní výlet (10 h). Vstup v ceně (v zimní sezoně místo vstupu oběd). Živý průvodce.', 'Full-day trip (10 h). Admission included (in the winter season, lunch instead of admission). Live guide.', NULL, NULL, 'Vyber nástupní zastávku při rezervaci. A – Staroměstské nám.: roh Pařížská 1 u kostela sv. Mikuláše (Staré Město), metro A „Staroměstská\". B – nám. Republiky 3 naproti Obecnímu domu, metro B „Náměstí Republiky\".', 'Choose your boarding stop when booking. A – Old Town Square: corner of Pařížská 1 by St. Nicholas Church (Old Town), metro A \"Staroměstská\". B – náměstí Republiky 3 opposite the Municipal House, metro B \"Náměstí Republiky\".', 'Stop A – Old Town Square||Old Town Square (corner of Pařížská 1, beside St. Nicholas Church), Praha 1\r\nStop B – náměstí Republiky||náměstí Republiky 3 (in front of the Hybernia Palace), Praha 1', NULL, 0, NULL, NULL, '[\"en\",\"de\",\"fr\",\"es\",\"it\",\"ru\"]', NULL),
(35, 4, NULL, NULL, 'Karlštejn Castle', 'Karlštejn Castle', NULL, 'products/35_6cf44234.jpg', NULL, NULL, NULL, NULL, '26 languages (audio); live guide EN', NULL, NULL, NULL, NULL, 0, 300, 'weekly_pattern', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Staroměstské náměstí, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Pouze léto (IV–X), neděle. Vstup na hrad + ochutnávka Karlštejnské medoviny. Cca 30 min chůze.', 'Summer only (Apr–Oct), Sundays. Castle admission + tasting of Karlštejn mead. About 30 min walk.', NULL, NULL, 'Vyber nástupní zastávku při rezervaci. A – Staroměstské nám.: roh Pařížská 1 u kostela sv. Mikuláše (Staré Město), metro A „Staroměstská\". B – nám. Republiky 3 naproti Obecnímu domu, metro B „Náměstí Republiky\".', 'Choose your boarding stop when booking. A – Old Town Square: corner of Pařížská 1 by St. Nicholas Church (Old Town), metro A \"Staroměstská\". B – náměstí Republiky 3 opposite the Municipal House, metro B \"Náměstí Republiky\".', 'Stop A – Old Town Square||Old Town Square (corner of Pařížská 1, beside St. Nicholas Church), Praha 1\r\nStop B – náměstí Republiky||náměstí Republiky 3 (in front of the Hybernia Palace), Praha 1', NULL, 0, NULL, NULL, '[\"en\",\"de\",\"fr\",\"es\",\"it\",\"ru\"]', NULL),
(36, 4, NULL, NULL, 'Karlovy Vary Spa Town', 'Karlovy Vary Spa Town', NULL, 'products/36_c1bc7fc6.jpg', NULL, NULL, NULL, NULL, '26 languages (audio); live guide EN', NULL, NULL, NULL, NULL, 0, 540, 'weekly_pattern', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Staroměstské náměstí, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Celodenní výlet (9 h). Oběd v ceně. Sraz A/B 10 min předem. Živý průvodce.', 'Full-day trip (9 h). Lunch included. Meet A/B 10 min early. Live guide.', NULL, NULL, 'Vyber nástupní zastávku při rezervaci. A – Staroměstské nám.: roh Pařížská 1 u kostela sv. Mikuláše (Staré Město), metro A „Staroměstská\". B – nám. Republiky 3 naproti Obecnímu domu, metro B „Náměstí Republiky\".', 'Choose your boarding stop when booking. A – Old Town Square: corner of Pařížská 1 by St. Nicholas Church (Old Town), metro A \"Staroměstská\". B – náměstí Republiky 3 opposite the Municipal House, metro B \"Náměstí Republiky\".', 'Stop A – Old Town Square||Old Town Square (corner of Pařížská 1, beside St. Nicholas Church), Praha 1\r\nStop B – náměstí Republiky||náměstí Republiky 3 (in front of the Hybernia Palace), Praha 1', NULL, 0, NULL, NULL, '[\"en\",\"de\",\"fr\",\"es\",\"it\",\"ru\"]', NULL),
(37, 4, NULL, NULL, 'Kutná Hora & Ossuary (Bone Church)', 'Kutná Hora & Ossuary (Bone Church)', NULL, 'products/37_3a6e5698.jpg', NULL, NULL, NULL, NULL, '26 languages (audio); live guide EN', NULL, NULL, NULL, NULL, 0, 360, 'weekly_pattern', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Staroměstské náměstí, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Vstupy (chrám sv. Barbory, kostnice Sedlec) v ceně. Živý průvodce.', 'Admissions (St. Barbara\'s Cathedral, Sedlec Ossuary) included. Live guide.', NULL, NULL, 'Vyber nástupní zastávku při rezervaci. A – Staroměstské nám.: roh Pařížská 1 u kostela sv. Mikuláše (Staré Město), metro A „Staroměstská\". B – nám. Republiky 3 naproti Obecnímu domu, metro B „Náměstí Republiky\".', 'Choose your boarding stop when booking. A – Old Town Square: corner of Pařížská 1 by St. Nicholas Church (Old Town), metro A \"Staroměstská\". B – náměstí Republiky 3 opposite the Municipal House, metro B \"Náměstí Republiky\".', 'Stop A – Old Town Square||Old Town Square (corner of Pařížská 1, beside St. Nicholas Church), Praha 1\r\nStop B – náměstí Republiky||náměstí Republiky 3 (in front of the Hybernia Palace), Praha 1', NULL, 0, NULL, NULL, '[\"en\",\"de\",\"fr\",\"es\",\"it\",\"ru\"]', NULL),
(38, 4, NULL, NULL, 'Terezín Memorial', 'Terezín Memorial', NULL, 'products/38_f84f8ccc.jpg', NULL, NULL, NULL, NULL, '26 languages (audio); live guide EN', NULL, NULL, NULL, NULL, 0, 360, 'weekly_pattern', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Staroměstské náměstí, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Vstupné v ceně. Živý průvodce. Pietní místo bývalého koncentračního tábora.', 'Admission included. Live guide. Memorial site of the former concentration camp.', NULL, NULL, 'Vyber nástupní zastávku při rezervaci. A – Staroměstské nám.: roh Pařížská 1 u kostela sv. Mikuláše (Staré Město), metro A „Staroměstská\". B – nám. Republiky 3 naproti Obecnímu domu, metro B „Náměstí Republiky\".', 'Choose your boarding stop when booking. A – Old Town Square: corner of Pařížská 1 by St. Nicholas Church (Old Town), metro A \"Staroměstská\". B – náměstí Republiky 3 opposite the Municipal House, metro B \"Náměstí Republiky\".', 'Stop A – Old Town Square||Old Town Square (corner of Pařížská 1, beside St. Nicholas Church), Praha 1\r\nStop B – náměstí Republiky||náměstí Republiky 3 (in front of the Hybernia Palace), Praha 1', NULL, 0, NULL, NULL, '[\"en\",\"de\",\"fr\",\"es\",\"it\",\"ru\"]', NULL),
(39, 4, NULL, NULL, 'Prague Castle in detail (incl. Interiors)', 'Prague Castle in detail (incl. Interiors)', NULL, 'products/39_7934fc51.jpg', NULL, NULL, NULL, NULL, '26 languages (audio); live guide EN', NULL, NULL, NULL, NULL, 0, 210, 'weekly_pattern', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Staroměstské náměstí, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz na zvoleném místě (A/B) 10 min před odjezdem. Vstup na Pražský hrad v ceně. Živý průvodce.', 'Meet at your chosen stop (A/B) 10 min before departure. Prague Castle admission included. Live guide.', NULL, NULL, 'Vyber nástupní zastávku při rezervaci. A – Staroměstské nám.: roh Pařížská 1 u kostela sv. Mikuláše (Staré Město), metro A „Staroměstská\". B – nám. Republiky 3 naproti Obecnímu domu, metro B „Náměstí Republiky\".', 'Choose your boarding stop when booking. A – Old Town Square: corner of Pařížská 1 by St. Nicholas Church (Old Town), metro A \"Staroměstská\". B – náměstí Republiky 3 opposite the Municipal House, metro B \"Náměstí Republiky\".', 'Stop A – Old Town Square||Old Town Square (corner of Pařížská 1, beside St. Nicholas Church), Praha 1\r\nStop B – náměstí Republiky||náměstí Republiky 3 (in front of the Hybernia Palace), Praha 1', NULL, 0, NULL, NULL, '[\"en\",\"de\",\"fr\",\"es\",\"it\",\"ru\"]', NULL),
(40, 4, NULL, NULL, 'Live Guided City Tour with Prague Castle', 'Live Guided City Tour with Prague Castle', NULL, 'products/40_2d9bd29a.jpg', NULL, NULL, NULL, NULL, '26 languages (audio); live guide EN', NULL, NULL, NULL, NULL, 0, 210, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Staroměstské náměstí, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Web aktuálně nenabízí. Sraz A/B 10 min předem. Živý průvodce, bez vstupů do interiérů.', 'Currently not offered on the web. Meet A/B 10 min early. Live guide, no interior admissions.', NULL, NULL, 'Vyber nástupní zastávku při rezervaci. A – Staroměstské nám.: roh Pařížská 1 u kostela sv. Mikuláše (Staré Město), metro A „Staroměstská\". B – nám. Republiky 3 naproti Obecnímu domu, metro B „Náměstí Republiky\".', 'Choose your boarding stop when booking. A – Old Town Square: corner of Pařížská 1 by St. Nicholas Church (Old Town), metro A \"Staroměstská\". B – náměstí Republiky 3 opposite the Municipal House, metro B \"Náměstí Republiky\".', 'Stop A – Old Town Square||Old Town Square (corner of Pařížská 1, beside St. Nicholas Church), Praha 1\r\nStop B – náměstí Republiky||náměstí Republiky 3 (in front of the Hybernia Palace), Praha 1', NULL, 0, NULL, NULL, '[\"en\",\"de\",\"fr\",\"es\",\"it\",\"ru\"]', NULL),
(41, 4, NULL, NULL, 'Short River Cruise', 'Short River Cruise', NULL, 'products/41_4d3a99ce.jpg', NULL, NULL, NULL, NULL, '26 languages (audio); live guide EN', NULL, NULL, NULL, NULL, 0, 60, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Staroměstské náměstí, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz na zvoleném místě (A/B) 10 min před odjezdem. Hodinová plavba. Audio průvodce 7 jazyků.', 'Meet at your chosen stop (A/B) 10 min before departure. One-hour cruise. Audio guide in 7 languages.', NULL, NULL, 'Vyber nástupní zastávku při rezervaci. A – Staroměstské nám.: roh Pařížská 1 u kostela sv. Mikuláše (Staré Město), metro A „Staroměstská\". B – nám. Republiky 3 naproti Obecnímu domu, metro B „Náměstí Republiky\".', 'Choose your boarding stop when booking. A – Old Town Square: corner of Pařížská 1 by St. Nicholas Church (Old Town), metro A \"Staroměstská\". B – náměstí Republiky 3 opposite the Municipal House, metro B \"Náměstí Republiky\".', 'Stop A – Old Town Square||Old Town Square (corner of Pařížská 1, beside St. Nicholas Church), Praha 1\r\nStop B – náměstí Republiky||náměstí Republiky 3 (in front of the Hybernia Palace), Praha 1', NULL, 0, NULL, NULL, '[\"en\",\"de\",\"fr\",\"es\",\"it\",\"ru\"]', NULL),
(42, 4, NULL, NULL, 'Prague Historical City + 1 Hour Boat Trip', 'Prague Historical City + 1 Hour Boat Trip', NULL, 'products/42_b7b07756.jpg', NULL, NULL, NULL, NULL, '26 languages (audio); live guide EN', NULL, NULL, NULL, NULL, 0, 180, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Staroměstské náměstí, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz na zvoleném místě (A/B) 10 min před odjezdem. Bus + hodinová plavba. Audio průvodce ve 26 jazycích.', 'Meet at your chosen stop (A/B) 10 min before departure. Coach + one-hour cruise. Audio guide in 26 languages.', NULL, NULL, 'Vyber nástupní zastávku při rezervaci. A – Staroměstské nám.: roh Pařížská 1 u kostela sv. Mikuláše (Staré Město), metro A „Staroměstská\". B – nám. Republiky 3 naproti Obecnímu domu, metro B „Náměstí Republiky\".', 'Choose your boarding stop when booking. A – Old Town Square: corner of Pařížská 1 by St. Nicholas Church (Old Town), metro A \"Staroměstská\". B – náměstí Republiky 3 opposite the Municipal House, metro B \"Náměstí Republiky\".', 'Stop A – Old Town Square||Old Town Square (corner of Pařížská 1, beside St. Nicholas Church), Praha 1\r\nStop B – náměstí Republiky||náměstí Republiky 3 (in front of the Hybernia Palace), Praha 1', NULL, 0, NULL, NULL, '[\"en\",\"de\",\"fr\",\"es\",\"it\",\"ru\"]', NULL),
(43, 4, NULL, NULL, 'Short Prague Old Town City Tour', 'Short Prague Old Town City Tour', NULL, 'products/43_4609131f.jpg', NULL, NULL, NULL, NULL, '26 languages (audio); live guide EN', NULL, NULL, NULL, NULL, 0, 60, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Staroměstské náměstí, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz na zvoleném místě (A/B) 10 min před odjezdem. Bez vystupování z busu. Bez vyzvednutí v hotelu. Audio průvodce 26 jazyků.', 'Meet at your chosen stop (A/B) 10 min before departure. No getting off the bus. No hotel pickup. Audio guide in 26 languages.', NULL, NULL, 'Vyber nástupní zastávku při rezervaci. A – Staroměstské nám.: roh Pařížská 1 u kostela sv. Mikuláše (Staré Město), metro A „Staroměstská\". B – nám. Republiky 3 naproti Obecnímu domu, metro B „Náměstí Republiky\".', 'Choose your boarding stop when booking. A – Old Town Square: corner of Pařížská 1 by St. Nicholas Church (Old Town), metro A \"Staroměstská\". B – náměstí Republiky 3 opposite the Municipal House, metro B \"Náměstí Republiky\".', 'Stop A – Old Town Square||Old Town Square (corner of Pařížská 1, beside St. Nicholas Church), Praha 1\r\nStop B – náměstí Republiky||náměstí Republiky 3 (in front of the Hybernia Palace), Praha 1', NULL, 0, NULL, NULL, '[\"en\",\"de\",\"fr\",\"es\",\"it\",\"ru\"]', NULL),
(44, 4, NULL, NULL, 'Short Old Town City Tour + Short River Cruise', 'Short Old Town City Tour + Short River Cruise', NULL, 'products/44_03062f6e.jpg', NULL, NULL, NULL, NULL, '26 languages (audio); live guide EN', NULL, NULL, NULL, NULL, 0, 120, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Staroměstské náměstí, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz na zvoleném místě (A/B) 10 min před odjezdem. Bus + hodinová plavba. Bez vyzvednutí v hotelu.', 'Meet at your chosen stop (A/B) 10 min before departure. Coach + one-hour cruise. No hotel pickup.', NULL, NULL, 'Vyber nástupní zastávku při rezervaci. A – Staroměstské nám.: roh Pařížská 1 u kostela sv. Mikuláše (Staré Město), metro A „Staroměstská\". B – nám. Republiky 3 naproti Obecnímu domu, metro B „Náměstí Republiky\".', 'Choose your boarding stop when booking. A – Old Town Square: corner of Pařížská 1 by St. Nicholas Church (Old Town), metro A \"Staroměstská\". B – náměstí Republiky 3 opposite the Municipal House, metro B \"Náměstí Republiky\".', 'Stop A – Old Town Square||Old Town Square (corner of Pařížská 1, beside St. Nicholas Church), Praha 1\r\nStop B – náměstí Republiky||náměstí Republiky 3 (in front of the Hybernia Palace), Praha 1', NULL, 0, NULL, NULL, '[\"en\",\"de\",\"fr\",\"es\",\"it\",\"ru\"]', NULL),
(45, 4, NULL, NULL, 'Prague Unlimited Tour – All inclusive', 'Prague Unlimited Tour – All inclusive', NULL, 'products/45_97f1021c.jpg', NULL, NULL, NULL, NULL, '26 languages (audio); live guide EN', NULL, NULL, NULL, NULL, 0, 390, 'weekly_pattern', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Staroměstské náměstí, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz na zvoleném místě (A/B) 10 min před odjezdem. All inclusive: bus, pěší část, loď, Pražský hrad a oběd. Živý průvodce.', 'Meet at your chosen stop (A/B) 10 min before departure. All inclusive: coach, walking part, boat, Prague Castle and lunch. Live guide.', NULL, NULL, 'Vyber nástupní zastávku při rezervaci. A – Staroměstské nám.: roh Pařížská 1 u kostela sv. Mikuláše (Staré Město), metro A „Staroměstská\". B – nám. Republiky 3 naproti Obecnímu domu, metro B „Náměstí Republiky\".', 'Choose your boarding stop when booking. A – Old Town Square: corner of Pařížská 1 by St. Nicholas Church (Old Town), metro A \"Staroměstská\". B – náměstí Republiky 3 opposite the Municipal House, metro B \"Náměstí Republiky\".', 'Stop A – Old Town Square||Old Town Square (corner of Pařížská 1, beside St. Nicholas Church), Praha 1\r\nStop B – náměstí Republiky||náměstí Republiky 3 (in front of the Hybernia Palace), Praha 1', NULL, 0, NULL, NULL, '[\"en\",\"de\",\"fr\",\"es\",\"it\",\"ru\"]', NULL),
(46, 4, NULL, NULL, 'Lunch River Cruise', 'Lunch River Cruise', NULL, 'products/46_9c47371b.jpg', NULL, NULL, NULL, NULL, '26 languages (audio); live guide EN', NULL, NULL, NULL, NULL, 0, 150, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Staroměstské náměstí, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Sraz na zvoleném místě (A/B) 10 min před odjezdem. Oběd formou bufetu v ceně, nápoje zvlášť.', 'Meet at your chosen stop (A/B) 10 min before departure. Buffet lunch included, drinks separate.', NULL, NULL, 'Vyber nástupní zastávku při rezervaci. A – Staroměstské nám.: roh Pařížská 1 u kostela sv. Mikuláše (Staré Město), metro A „Staroměstská\". B – nám. Republiky 3 naproti Obecnímu domu, metro B „Náměstí Republiky\".', 'Choose your boarding stop when booking. A – Old Town Square: corner of Pařížská 1 by St. Nicholas Church (Old Town), metro A \"Staroměstská\". B – náměstí Republiky 3 opposite the Municipal House, metro B \"Náměstí Republiky\".', 'Stop A – Old Town Square||Old Town Square (corner of Pařížská 1, beside St. Nicholas Church), Praha 1\r\nStop B – náměstí Republiky||náměstí Republiky 3 (in front of the Hybernia Palace), Praha 1', NULL, 0, NULL, NULL, NULL, NULL),
(47, 4, NULL, NULL, 'Evening River Cruise with Dinner', 'Evening River Cruise with Dinner', NULL, 'products/47_4f72d0bf.jpg', NULL, NULL, NULL, NULL, '26 languages (audio); live guide EN', NULL, NULL, NULL, NULL, 0, 210, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Staroměstské náměstí, Praha 1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Voucher vyměň za vstupenku v kiosku Pařížská 1 (Staroměstské nám.) DO 16:00. Welcome drink + bufet večeře (nápoje zvlášť). Konec cca 22:00.', 'Exchange the voucher for a ticket at the kiosk at Pařížská 1 (Old Town Square) BY 16:00. Welcome drink + buffet dinner (drinks separate). Ends around 22:00.', NULL, NULL, 'Vyber nástupní zastávku při rezervaci. A – Staroměstské nám.: roh Pařížská 1 u kostela sv. Mikuláše (Staré Město), metro A „Staroměstská\". B – nám. Republiky 3 naproti Obecnímu domu, metro B „Náměstí Republiky\".', 'Choose your boarding stop when booking. A – Old Town Square: corner of Pařížská 1 by St. Nicholas Church (Old Town), metro A \"Staroměstská\". B – náměstí Republiky 3 opposite the Municipal House, metro B \"Náměstí Republiky\".', 'Stop A – Old Town Square||Old Town Square (corner of Pařížská 1, beside St. Nicholas Church), Praha 1\r\nStop B – náměstí Republiky||náměstí Republiky 3 (in front of the Hybernia Palace), Praha 1', NULL, 0, NULL, NULL, NULL, NULL);
INSERT INTO `products` (`id`, `agency_id`, `commission_pct`, `seller_bonus_pct`, `name_cs`, `name_en`, `name_de`, `image_path`, `variant_diagram_path`, `description_cs`, `description_en`, `description_de`, `languages`, `languages_en`, `order_instructions`, `order_instructions_en`, `booking_url`, `has_contingent`, `duration_minutes`, `schedule_type`, `voucher_redemption_type`, `ticket_type`, `pickup_available`, `pickup_required`, `pickup_free`, `pickup_window_minutes`, `pickup_confirmation`, `status`, `is_featured`, `created_at`, `updated_at`, `deposit_fixed_czk`, `deposit_fixed_eur`, `meeting_point_address`, `meeting_point_address_en`, `map_url`, `included`, `included_en`, `excluded`, `excluded_en`, `what_to_bring`, `what_to_bring_en`, `important_info`, `important_info_en`, `cancellation_policy`, `cancellation_policy_en`, `meeting_point_note`, `meeting_point_note_en`, `meeting_options`, `meeting_options_en`, `seating`, `addons`, `seat_map_svg`, `language_options`, `attributes`) VALUES
(48, 5, NULL, NULL, 'Swan Lake Ballet', NULL, NULL, 'products/48_43929c18.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 150, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 15:56:14', NULL, NULL, 'Broadway Theatre, Na Příkopě 31, Praha 1', NULL, NULL, 'Show admission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Broadway passage (entrance from Na Příkopě 31 or Celetná 38). Show your voucher at the box office.', NULL, NULL, NULL, 1, NULL, '<svg viewBox=\"0 0 340 380\" width=\"100%\" xmlns=\"http://www.w3.org/2000/svg\" font-family=\"sans-serif\"><rect x=\"40\" y=\"8\" width=\"260\" height=\"24\" rx=\"4\" fill=\"#222222\"/><text x=\"170\" y=\"24\" fill=\"#ffffff\" font-size=\"12\" text-anchor=\"middle\">JEVIŠTĚ</text><rect x=\"40\" y=\"40\" width=\"260\" height=\"32\" rx=\"5\" fill=\"#2C6FB5\"/><text x=\"170\" y=\"60\" fill=\"#ffffff\" font-size=\"12.5\" text-anchor=\"middle\">KAT. A · řada 1–4</text><rect x=\"40\" y=\"76\" width=\"260\" height=\"32\" rx=\"5\" fill=\"#C9A227\"/><text x=\"170\" y=\"96\" fill=\"#1a1a2e\" font-size=\"12.5\" text-anchor=\"middle\">VIP · řada 5–10</text><rect x=\"40\" y=\"112\" width=\"260\" height=\"32\" rx=\"5\" fill=\"#2C6FB5\"/><text x=\"170\" y=\"132\" fill=\"#ffffff\" font-size=\"12.5\" text-anchor=\"middle\">KAT. A · řada 11–15</text><rect x=\"40\" y=\"148\" width=\"260\" height=\"32\" rx=\"5\" fill=\"#3E9B6E\"/><text x=\"170\" y=\"168\" fill=\"#ffffff\" font-size=\"12.5\" text-anchor=\"middle\">KAT. B · řada 16–20</text><rect x=\"40\" y=\"184\" width=\"260\" height=\"32\" rx=\"5\" fill=\"#8A8F98\"/><text x=\"170\" y=\"204\" fill=\"#ffffff\" font-size=\"12.5\" text-anchor=\"middle\">KAT. C · řada 21–26</text><text x=\"170\" y=\"232\" fill=\"#555555\" font-size=\"11\" text-anchor=\"middle\">— BALKÓN —</text><rect x=\"40\" y=\"240\" width=\"260\" height=\"32\" rx=\"5\" fill=\"#3E9B6E\"/><text x=\"170\" y=\"260\" fill=\"#ffffff\" font-size=\"12.5\" text-anchor=\"middle\">KAT. B · balkón řada 1–7</text><rect x=\"40\" y=\"292\" width=\"14\" height=\"14\" rx=\"3\" fill=\"#C9A227\"/><text x=\"62\" y=\"304\" fill=\"#1a1a2e\" font-size=\"11.5\">VIP — 1450 Kč</text><rect x=\"40\" y=\"312\" width=\"14\" height=\"14\" rx=\"3\" fill=\"#2C6FB5\"/><text x=\"62\" y=\"324\" fill=\"#1a1a2e\" font-size=\"11.5\">Kategorie A — 1250 Kč</text><rect x=\"40\" y=\"332\" width=\"14\" height=\"14\" rx=\"3\" fill=\"#3E9B6E\"/><text x=\"62\" y=\"344\" fill=\"#1a1a2e\" font-size=\"11.5\">Kategorie B — 1050 Kč</text><rect x=\"40\" y=\"352\" width=\"14\" height=\"14\" rx=\"3\" fill=\"#8A8F98\"/><text x=\"62\" y=\"364\" fill=\"#1a1a2e\" font-size=\"11.5\">Kategorie C — 850 Kč</text></svg>', NULL, NULL),
(49, 5, NULL, NULL, 'Best of Czech and World Classical Music', NULL, NULL, 'products/49_a15bfd3f.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'weekly_pattern', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 10:31:06', NULL, NULL, 'Church of St. Martin in the Wall, Martinská 8, Praha 1', NULL, NULL, 'Concert admission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the concert; non-refundable afterwards.', NULL, 'Please arrive 20 minutes before the concert; show this voucher at the box office.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(50, 5, NULL, NULL, 'Concert @ Hybernia (TBD program)', NULL, NULL, 'products/50_3a0c5684.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'specific_dates', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'archived', 0, '2026-06-01 06:52:56', '2026-06-06 10:34:41', NULL, NULL, NULL, NULL, NULL, 'Concert admission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the concert; non-refundable afterwards.', NULL, 'Please arrive 20 minutes before the concert and show this voucher at the box office.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(51, 5, NULL, NULL, 'Concert @ Smetana Hall (TBD program)', NULL, NULL, 'products/51_6eb38c54.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'specific_dates', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'archived', 0, '2026-06-01 06:52:56', '2026-06-06 10:35:36', NULL, NULL, NULL, NULL, NULL, 'Concert admission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the concert; non-refundable afterwards.', NULL, 'Please arrive 20 minutes before the concert and show this voucher at the box office.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(52, 5, NULL, NULL, 'Concert @ Klementinum Mirror Chapel', NULL, NULL, 'products/52_7c77ec67.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'specific_dates', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'archived', 0, '2026-06-01 06:52:56', '2026-06-06 10:32:50', NULL, NULL, NULL, NULL, NULL, 'Concert admission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the concert; non-refundable afterwards.', NULL, 'Please arrive 20 minutes before the concert and show this voucher at the box office.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(53, 5, NULL, NULL, 'Concert @ St. George\'s Basilica', NULL, NULL, 'products/53_141821c0.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'specific_dates', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'archived', 0, '2026-06-01 06:52:56', '2026-06-06 10:42:53', NULL, NULL, NULL, NULL, NULL, 'Concert admission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the concert; non-refundable afterwards.', NULL, 'Please arrive 20 minutes before the concert and show this voucher at the box office.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(54, 5, NULL, NULL, 'Concert @ St. Cajetan', NULL, NULL, 'products/54_950cd27d.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'specific_dates', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'archived', 0, '2026-06-01 06:52:56', '2026-06-06 10:38:55', NULL, NULL, NULL, NULL, NULL, 'Concert admission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the concert; non-refundable afterwards.', NULL, 'Please arrive 20 minutes before the concert and show this voucher at the box office.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(55, 5, NULL, NULL, 'Christmas Concerts @ Martin', NULL, NULL, 'products/55_4d1e792d.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'seasonal', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'archived', 0, '2026-06-01 06:52:56', '2026-06-06 10:32:11', NULL, NULL, 'Church of St. Martin in the Wall, Martinská 8, Praha 1', NULL, NULL, 'Concert admission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the concert; non-refundable afterwards.', NULL, 'Please arrive 20 minutes before the concert and show this voucher at the box office.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(56, 5, NULL, NULL, 'Easter Concerts', NULL, NULL, 'placeholders/ag-5.svg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'seasonal', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'archived', 0, '2026-06-01 06:52:56', '2026-06-02 13:03:39', NULL, NULL, NULL, NULL, NULL, 'Concert admission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the concert; non-refundable afterwards.', NULL, 'Please arrive 20 minutes before the concert and show this voucher at the box office.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(57, 6, NULL, NULL, 'Concert @ Rudolfinum Suk Hall', NULL, NULL, 'products/57_baea52bc.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'specific_dates', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 09:45:58', NULL, NULL, 'Rudolfinum – Suk Hall, Alšovo nábřeží 12, Praha 1', NULL, NULL, 'Concert admission', NULL, NULL, NULL, NULL, NULL, 'Student price requires a valid ISIC card. Please arrive 20 minutes before the concert.', NULL, 'Free cancellation up to 24 hours before the concert; non-refundable afterwards.', NULL, 'Please arrive 20 minutes before the concert and show this voucher at the box office.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(58, 6, NULL, NULL, 'Concert @ Lichtenštejnský palác', NULL, NULL, 'products/58_a7d385f2.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'specific_dates', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 09:43:47', NULL, NULL, 'Lichtenstein Palace – B. Martinů Hall, Malostranské náměstí 13, Praha 1', NULL, NULL, 'Concert admission', NULL, NULL, NULL, NULL, NULL, 'Student price requires a valid ISIC card. Please arrive 20 minutes before the concert.', NULL, 'Free cancellation up to 24 hours before the concert; non-refundable afterwards.', NULL, 'Please arrive 20 minutes before the concert and show this voucher at the box office.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(59, 7, NULL, NULL, 'Mozart Dinner', 'Mozart Dinner', NULL, 'products/59_c3e186c6.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 180, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-05 15:50:55', NULL, NULL, 'Grand Hotel Bohemia – Boccaccio Ballroom, Králodvorská 4 (side entrance), Praha 1', NULL, NULL, '3-course dinner (Czech & Austrian cuisine)\r\nLive Mozart concert (arias, duets, instrumental)', NULL, 'Drinks\r\nGratuities', NULL, NULL, NULL, 'Smart-casual dress. Non-smoking inside the hall.', NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Please arrive 15 minutes before the start. Seating is by arrival time.', NULL, NULL, NULL, 1, '[{\"label\":\"Champagne welcome upgrade\",\"czk\":280,\"eur\":11},{\"label\":\"Transfer z hotelu (Mozart partner)\",\"czk\":290,\"eur\":12},{\"label\":\"Kytice na stůl (k narozeninám \\/ výročí)\",\"czk\":450,\"eur\":18},{\"label\":\"Foto z koncertu (digitální + tisk)\",\"czk\":350,\"eur\":14}]', NULL, NULL, NULL),
(60, 7, NULL, NULL, 'Mozart Dinner (welcome drink)', 'Mozart Dinner (welcome drink)', NULL, 'products/60_4ba834d4.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 180, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'inactive', 0, '2026-06-01 06:52:56', '2026-06-06 10:20:17', NULL, NULL, 'Grand Hotel Bohemia – Boccaccio Ballroom, Králodvorská 4 (side entrance), Praha 1', NULL, NULL, '3-course dinner (Czech & Austrian cuisine)\r\nLive Mozart concert (arias, duets, instrumental)', NULL, 'Drinks\r\nGratuities', NULL, NULL, NULL, 'Smart-casual dress. Non-smoking inside the hall.', NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Please arrive 15 minutes before the start. Seating is by arrival time.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(61, 7, NULL, NULL, 'Mozart Gold Dinner (4-course)', 'Mozart Gold Dinner (4-course)', NULL, 'products/61_9451d421.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 180, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'inactive', 0, '2026-06-01 06:52:56', '2026-06-06 10:20:28', NULL, NULL, 'Grand Hotel Bohemia – Boccaccio Ballroom, Králodvorská 4 (side entrance), Praha 1', NULL, NULL, '3-course dinner (Czech & Austrian cuisine)\r\nLive Mozart concert (arias, duets, instrumental)', NULL, 'Drinks\r\nGratuities', NULL, NULL, NULL, 'Smart-casual dress. Non-smoking inside the hall.', NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Please arrive 15 minutes before the start. Seating is by arrival time.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(62, 7, NULL, NULL, 'Mozart Concert (no dinner)', 'Mozart Concert (no dinner)', NULL, 'products/62_a5d50899.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 90, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'inactive', 0, '2026-06-01 06:52:56', '2026-06-06 10:20:10', NULL, NULL, 'Grand Hotel Bohemia – Boccaccio Ballroom, Králodvorská 4 (side entrance), Praha 1', NULL, NULL, '3-course dinner (Czech & Austrian cuisine)\r\nLive Mozart concert (arias, duets, instrumental)', NULL, 'Drinks\r\nGratuities', NULL, NULL, NULL, 'Smart-casual dress. Non-smoking inside the hall.', NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Please arrive 15 minutes before the start. Seating is by arrival time.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(63, 7, NULL, NULL, 'Christmas Dinner', NULL, NULL, 'products/63_ef042cb2.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 180, 'specific_dates', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'inactive', 0, '2026-06-01 06:52:56', '2026-06-06 10:20:03', NULL, NULL, 'Grand Hotel Bohemia – Boccaccio Ballroom, Králodvorská 4 (side entrance), Praha 1', NULL, NULL, '3-course dinner (Czech & Austrian cuisine)\r\nLive Mozart concert (arias, duets, instrumental)', NULL, 'Drinks\r\nGratuities', NULL, NULL, NULL, 'Smart-casual dress. Non-smoking inside the hall.', NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Please arrive 15 minutes before the start. Seating is by arrival time.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(64, 7, NULL, NULL, 'NYE Gala', NULL, NULL, 'products/64_5f3f1159.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 240, 'specific_dates', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'inactive', 0, '2026-06-01 06:52:56', '2026-06-06 10:20:34', NULL, NULL, 'Grand Hotel Bohemia – Boccaccio Ballroom, Králodvorská 4 (side entrance), Praha 1', NULL, NULL, '3-course dinner (Czech & Austrian cuisine)\r\nLive Mozart concert (arias, duets, instrumental)', NULL, 'Drinks\r\nGratuities', NULL, NULL, NULL, 'Smart-casual dress. Non-smoking inside the hall.', NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Please arrive 15 minutes before the start. Seating is by arrival time.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(65, 8, NULL, NULL, 'Alchemy & Mysteries of Prague Castle', 'Alchemy & Mysteries of Prague Castle', NULL, 'products/65_6a0f8ec2.jpg', NULL, NULL, NULL, NULL, 'EN, DE', NULL, 'Min. 2 osoby na rezervaci. Sraz: Týnská 627/7, Praha 1 (před č. 7). Přijít 10 min předem. Večerní prohlídka ~3 h. Jazyk EN/DE dle vybraného času.', 'Min. 2 people per booking. Meeting point: Týnská 627/7, Prague 1 (in front of no. 7). Arrive 10 min early. Evening tour ~3 h. Language EN/DE depending on the selected time.', NULL, 0, 180, 'weekly_pattern', 'direct_entry', 'date_required', 1, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Týnská 627/7, 110 00 Praha 1 (před budovou č. 7)', NULL, NULL, 'Professional guide\r\nHotel pickup and drop-off\r\nGratuities\r\nTour in EN or DE (per selected option)\r\nSmall-group walking tour', NULL, 'Tram ticket\r\nEntries/interiors (unless stated)', NULL, 'Pohodlná obuv.', 'Comfortable shoes.', 'Evening tour. Exterior only (no interiors). Min. 2 pax. Tram ticket not included. Not wheelchair/stroller accessible. Comfortable shoes recommended. Dostupné v EN i DE — jazyk zvol podle vybraného času.', 'Evening tour. Exterior only (no interiors). Min. 2 pax. Tram ticket not included. Not wheelchair/stroller accessible. Comfortable shoes recommended. Available in EN and DE — choose the language by the selected time.', 'Min. 2 osoby na rezervaci. Při nenaplnění může být zájezd po potvrzení zrušen – nabídnut náhradní termín nebo plná refundace.', 'Min. 2 people per booking. If the minimum is not reached, the tour may be cancelled after confirmation — an alternative date or a full refund will be offered.', 'Starting point in front of the building at Týnská 7.', NULL, NULL, NULL, 0, NULL, NULL, NULL, '[\"walking\",\"guide\",\"family\",\"ghost\",\"history\",\"night\"]'),
(66, 8, NULL, NULL, 'Ghosts & Legends of Old Town', 'Ghosts & Legends of Old Town', NULL, 'products/66_51cecb42.jpg', NULL, NULL, NULL, NULL, 'EN, DE', NULL, 'Min. 2 osoby na rezervaci. Sraz: Týnská 627/7, Praha 1 (před č. 7). Přijít 10 min předem. ~1,5 h, nenáročné. Jazyk EN/DE dle vybraného času.', 'Min. 2 people per booking. Meeting point: Týnská 627/7, Prague 1 (in front of no. 7). Arrive 10 min early. ~1.5 h, easy. Language EN/DE depending on the selected time.', NULL, 0, 90, 'weekly_pattern', 'direct_entry', 'date_required', 1, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Týnská 627/7, 110 00 Praha 1 (před budovou č. 7)', NULL, NULL, 'Professional guide\r\nHotel pickup and drop-off\r\nGratuities\r\nTour in EN or DE (per selected option)', NULL, 'Tram ticket\r\nEntries/interiors (unless stated)', NULL, 'Pohodlná obuv.', 'Comfortable shoes.', 'Evening tour. Min. 2 pax. Arrive 10 min early. Not wheelchair accessible. Price per person; set schedule. Dostupné v EN i DE — jazyk zvol podle vybraného času.', 'Evening tour. Min. 2 pax. Arrive 10 min early. Not wheelchair accessible. Price per person, set schedule. Available in EN and DE — choose the language by the selected time.', 'Min. 2 osoby na rezervaci. Při nenaplnění může být zájezd po potvrzení zrušen – nabídnut náhradní termín nebo plná refundace.', 'Min. 2 people per booking. If the minimum is not reached, the tour may be cancelled after confirmation — an alternative date or a full refund will be offered.', 'Starting point in front of the building at Týnská 7.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(67, 8, NULL, NULL, 'Psychiatric Hospital & Abandoned Cemetery', 'Psychiatric Hospital & Abandoned Cemetery', NULL, 'products/67_19ac5171.jpg', NULL, NULL, NULL, NULL, 'EN', NULL, 'Min. 2 osoby. SRAZ: před branou Psychiatrické nemocnice Bohnice, Ústavní 91, Praha 8 (NE Týnská!). Přijít 10 min předem. ~3 h. Není vhodné pro malé děti.', 'Min. 2 people. MEETING POINT: in front of the gate of Bohnice Psychiatric Hospital, Ústavní 91, Prague 8 (NOT Týnská!). Arrive 10 min early. ~3 h. Not suitable for small children.', NULL, 0, 180, 'weekly_pattern', 'direct_entry', 'date_required', 1, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Psychiatrická nemocnice Bohnice, Ústavní 91, 181 00 Praha 8 (před branou)', NULL, NULL, 'Professional guide\r\nHotel pickup and drop-off\r\nGratuities\r\nInterior visit of the hospital buildings', NULL, 'Tram ticket\r\nEntries/interiors (unless stated)', NULL, 'Pohodlná obuv.', 'Comfortable shoes.', 'Dark history of psychiatry – not recommended for small children. Min. 2 pax. Not wheelchair/stroller accessible. Comfortable shoes; bottle of water.', NULL, 'Min. 2 osoby na rezervaci. Při nenaplnění může být zájezd po potvrzení zrušen – nabídnut náhradní termín nebo plná refundace.', 'Min. 2 people per booking. If the minimum is not reached, the tour may be cancelled after confirmation — an alternative date or a full refund will be offered.', 'Starting point in front of the building at Týnská 7.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(68, 8, NULL, NULL, 'Prague Castle Tour & Canal River Cruise', 'Prague Castle Tour & Canal River Cruise', NULL, 'products/68_8c51776b.jpg', NULL, NULL, NULL, NULL, 'EN', NULL, 'Min. 2 osoby. Sraz: Týnská 627/7, Praha 1. Přijít 10 min předem. ~3 h. Pouze EN.', 'Min. 2 people. Meeting point: Týnská 627/7, Prague 1. Arrive 10 min early. ~3 h. English only.', NULL, 0, 180, 'weekly_pattern', 'direct_entry', 'date_required', 1, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Týnská 627/7, 110 00 Praha 1 (před budovou č. 7)', NULL, NULL, 'Professional guide\r\nHotel pickup and drop-off\r\nGratuities\r\nRiver cruise with refreshments & on-board commentary', NULL, 'Tram ticket\r\nEntries/interiors (unless stated)', NULL, 'Pohodlná obuv.', 'Comfortable shoes.', 'English only (private DE on request). Does NOT enter Prague Castle interior. Tram ticket not included. Min. 2 pax. Not wheelchair/stroller accessible.', NULL, 'Min. 2 osoby na rezervaci. Při nenaplnění může být zájezd po potvrzení zrušen – nabídnut náhradní termín nebo plná refundace.', 'Min. 2 people per booking. If the minimum is not reached, the tour may be cancelled after confirmation — an alternative date or a full refund will be offered.', 'Starting point in front of the building at Týnská 7.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(69, 8, NULL, NULL, 'World War 2 & Operation Anthropoid', 'World War 2 & Operation Anthropoid', NULL, 'products/69_6fa042cf.jpg', NULL, NULL, NULL, NULL, 'EN', NULL, 'Min. 2 osoby. Sraz: Týnská 627/7, Praha 1. Přijít 10 min předem. ~3 h. Pouze EN. Není vhodné pro malé děti.', 'Min. 2 people. Meeting point: Týnská 627/7, Prague 1. Arrive 10 min early. ~3 h. English only. Not suitable for small children.', NULL, 0, 180, 'weekly_pattern', 'direct_entry', 'date_required', 1, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Týnská 627/7, 110 00 Praha 1 (před budovou č. 7)', NULL, NULL, 'Knowledgeable guide\r\nVisit to Church of St Cyril and Methodius\r\nHotel pickup and drop-off\r\nGratuities', NULL, 'Tram ticket\r\nEntries/interiors (unless stated)', NULL, 'Pohodlná obuv.', 'Comfortable shoes.', 'WW2 themes – not recommended for small children (children must be accompanied; free of charge). Min. 2 pax. Not wheelchair/stroller accessible. Bottle of water.', NULL, 'Min. 2 osoby na rezervaci. Při nenaplnění může být zájezd po potvrzení zrušen – nabídnut náhradní termín nebo plná refundace.', 'Min. 2 people per booking. If the minimum is not reached, the tour may be cancelled after confirmation — an alternative date or a full refund will be offered.', 'Starting point in front of the building at Týnská 7.', NULL, NULL, NULL, 0, NULL, NULL, NULL, '[\"walking\",\"guide\",\"history\"]'),
(70, 8, NULL, NULL, 'Prague Full-Day City Tour with Cruise & Lunch', 'Prague Full-Day City Tour with Cruise & Lunch', NULL, 'products/70_acd433a5.jpg', NULL, NULL, NULL, NULL, 'EN', NULL, 'Min. 2 osoby. Sraz: Týnská 627/7, Praha 1. Přijít 10 min předem. ~6 h. Pouze EN. Nedoporučeno dětem do 10 let.', 'Min. 2 people. Meeting point: Týnská 627/7, Prague 1. Arrive 10 min early. ~6 h. English only. Not recommended for children under 10.', NULL, 0, 360, 'weekly_pattern', 'direct_entry', 'date_required', 1, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Týnská 627/7, 110 00 Praha 1 (před budovou č. 7)', NULL, NULL, 'Knowledgeable guide\r\nTraditional Czech lunch\r\nRiver cruise with refreshments & on-board commentary\r\nHotel pickup and drop-off\r\nGratuities', NULL, 'Tram ticket\r\nEntries/interiors (unless stated)', NULL, 'Pohodlná obuv.', 'Comfortable shoes.', 'English only (private DE on request). Not recommended for children under 10. Tram ticket not included. Min. 2 pax. Not wheelchair/stroller accessible.', NULL, 'Min. 2 osoby na rezervaci. Při nenaplnění může být zájezd po potvrzení zrušen – nabídnut náhradní termín nebo plná refundace.', 'Min. 2 people per booking. If the minimum is not reached, the tour may be cancelled after confirmation — an alternative date or a full refund will be offered.', 'Starting point in front of the building at Týnská 7.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(71, 8, NULL, NULL, 'Highlights of Prague Old Town & Jewish Ghetto', 'Highlights of Prague Old Town & Jewish Ghetto', NULL, 'products/71_9cb3a988.jpg', NULL, NULL, NULL, NULL, 'EN', NULL, 'Min. 2 osoby. Sraz: Týnská 627/7, Praha 1. Přijít 10 min předem. ~2 h, nenáročné. Pouze EN.', 'Min. 2 people. Meeting point: Týnská 627/7, Prague 1. Arrive 10 min early. ~2 h, easy. English only.', NULL, 0, 120, 'weekly_pattern', 'direct_entry', 'date_required', 1, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Týnská 627/7, 110 00 Praha 1 (před budovou č. 7)', NULL, NULL, 'Professional guide\r\nHotel pickup and drop-off\r\nGratuities\r\nBottle of water', NULL, 'Tram ticket\r\nEntries/interiors (unless stated)', NULL, 'Pohodlná obuv.', 'Comfortable shoes.', 'English only (private DE on request). Min. 2 pax. Arrive 10 min early. Not wheelchair accessible. Price per person; set schedule.', NULL, 'Min. 2 osoby na rezervaci. Při nenaplnění může být zájezd po potvrzení zrušen – nabídnut náhradní termín nebo plná refundace.', 'Min. 2 people per booking. If the minimum is not reached, the tour may be cancelled after confirmation — an alternative date or a full refund will be offered.', 'Starting point in front of the building at Týnská 7.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(72, 9, NULL, NULL, 'Hodinová plavba po VltavěSightseeing Cruise (50 min)', 'One Hour Cruise - Sightseeing Cruise (50 min)', NULL, 'products/72_49eef77d.jpg', NULL, 'Hodinová okružní plavba prosklenou lodí historickým centrem Prahy – jedna z nejoblíbenějších plaveb. Z paluby i ze salonu uvidíte nejznámější památky na obou březích Vltavy. Odplutí od Čechova mostu, pár minut od Staroměstského náměstí.', 'A one-hour sightseeing cruise on a glass-sided boat through the historic centre of Prague — one of the most popular trips. From the deck and the saloon you will see the best-known landmarks on both banks of the Vltava. Departs from Čech Bridge, a few minutes from the Old Town Square.', NULL, '16 languages (audio/printed guide)', NULL, 'Nástup: molo 3B u Čechova mostu (Dvořákovo nábřeží), Praha 1. 50 min. Děti 3–11 dětská cena, do 3 let zdarma. Kancelář otevřena denně 9:00–21:00.', 'Boarding: pier 3B by Čech Bridge (Dvořákovo nábřeží), Prague 1. 50 min. Children 3–11 child fare, under 3 free. Office open daily 9:00–21:00.', NULL, 0, 50, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 1, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Dvořákovo nábřeží, molo 3B (u Čechova mostu), Praha 1', NULL, NULL, '50 min sightseeing on the Vltava\r\nOnline GPS guide (audio/text/photos, 30+ sights)\r\nPrinted guide in 16 languages\r\nFree Wi-Fi on board', NULL, 'Food and drinks\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nA light jacket for the open deck', NULL, 'Boarding: Čechův most, molo 3B. Children 3–11; under 3 free. Latest check-in 10 min before departure.', NULL, 'Free cancellation up to 24 hours before departure; non-refundable afterwards.', NULL, 'The boat departs from Čech Bridge (Prague Boats pier). Please arrive 15 minutes before departure.', NULL, NULL, NULL, 0, NULL, NULL, NULL, '[\"boat\",\"audio\",\"accessible\",\"family\"]'),
(73, 9, NULL, NULL, 'Prague Grand River Cruise (2h)', 'Prague Grand River Cruise (2h)', NULL, 'products/73_b2f87304.jpg', NULL, 'Dvouhodinová klidná okružní plavba pro ty, kdo si chtějí Prahu užít beze spěchu a v pohodlí. Z prosklené lodi se otevírá výhled na Pražský hrad, proplouvá se pod Karlovým mostem a kolem Rudolfina a Národního divadla. Odplutí od Čechova mostu.', 'A relaxed two-hour cruise for those who want to enjoy Prague without rushing. From the glass-sided boat you take in Prague Castle, glide beneath Charles Bridge and pass the Rudolfinum and the National Theatre. Departs from Čech Bridge.', NULL, '16 languages (audio/printed guide)', NULL, 'Nástup: molo 3B u Čechova mostu, Praha 1. 2 h. Děti 3–11; do 3 let zdarma. Trasu může ovlivnit provoz/plavební komory, délku ne. Konkrétní loď není garantována.', 'Boarding: pier 3B by Čech Bridge, Prague 1. 2 h. Children 3–11, under 3 free. The route may be affected by traffic/locks, the duration is not. A specific boat is not guaranteed.', NULL, 0, 120, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Dvořákovo nábřeží, molo 3B (u Čechova mostu), Praha 1', NULL, NULL, '2h sightseeing on the Vltava\r\nOnline GPS guide (30+ sights)\r\nPrinted guide in 16 languages\r\nFree Wi-Fi on board', NULL, 'Food and drinks\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nA light jacket for the open deck', NULL, 'Boarding: Čechův most, molo 3B. Children 3–11; under 3 free. Latest check-in 10 min before departure.', NULL, 'Free cancellation up to 24 hours before departure; non-refundable afterwards.', NULL, 'The boat departs from Čech Bridge (Prague Boats pier). Please arrive 15 minutes before departure.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(74, 9, NULL, NULL, 'Evening Sightseeing Cruise (50 min)', 'Evening Sightseeing Cruise (50 min)', NULL, 'products/74_3fd1cbf3.jpg', NULL, 'Hodinová večerní okružní plavba prosklenou lodí – Praha v nasvícené kráse z paluby i ze salonu. Cestou míjíte nejznámější památky podél Vltavy. Odplutí od Čechova mostu.', 'A one-hour evening sightseeing cruise on a glass-sided boat — Prague at its illuminated best, seen from the deck and the saloon. The route passes the most famous landmarks along the Vltava. Departs from Čech Bridge.', NULL, '16 languages (audio/printed guide)', NULL, 'Nástup: molo 3B u Čechova mostu, Praha 1. Večerní 50min plavba. Děti 3–11; do 3 let zdarma.', 'Boarding: pier 3B by Čech Bridge, Prague 1. Evening 50-min cruise. Children 3–11, under 3 free.', NULL, 0, 50, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Dvořákovo nábřeží, molo 3B (u Čechova mostu), Praha 1', NULL, NULL, '50 min sightseeing on the Vltava\r\nOnline GPS guide (audio/text/photos, 30+ sights)\r\nPrinted guide in 16 languages\r\nFree Wi-Fi on board', NULL, 'Food and drinks\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nA light jacket for the open deck', NULL, 'Boarding: Čechův most, molo 3B. Children 3–11; under 3 free. Latest check-in 10 min before departure. Evening departures.', NULL, 'Free cancellation up to 24 hours before departure; non-refundable afterwards.', NULL, 'The boat departs from Čech Bridge (Prague Boats pier). Please arrive 15 minutes before departure.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(75, 9, NULL, NULL, 'Evening Eco-cruise with a Glass of Prosecco', 'Evening Eco-cruise with a Glass of Prosecco', NULL, 'products/75_053ea969.jpg', NULL, 'Hodinová večerní plavba na plně elektrické lodi (Marie d\'Bohemia nebo Bella Bohemia) – tiše a ekologicky. V ceně sklenka prosecca (nebo džus) a malé občerstvení; výhled z otevřené horní paluby i prosklených stěn, wi-fi zdarma a tištěný průvodce v 16 jazycích. Cestou Pražský hrad a Karlův most.', 'A one-hour evening cruise on a fully electric boat (Marie d\'Bohemia or Bella Bohemia) — quiet and eco-friendly. Includes a glass of Prosecco (or juice) and a light snack, views from the open top deck and the glass walls, free Wi-Fi and a printed guide in 16 languages. You pass Prague Castle and Charles Bridge.', NULL, '16 languages (audio/printed guide)', NULL, 'Nástup: molo 3B u Čechova mostu, Praha 1. 50 min, sklenice prosecca/džusu v ceně. Děti 3–11; do 3 let zdarma.', 'Boarding: pier 3B by Čech Bridge, Prague 1. 50 min, a glass of prosecco/juice included. Children 3–11, under 3 free.', NULL, 0, 50, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Dvořákovo nábřeží, molo 3B (u Čechova mostu), Praha 1', NULL, NULL, '50 min evening eco-cruise\r\nGlass of prosecco or juice\r\nLight refreshments\r\nPrinted guide in 16 languages\r\nFree Wi-Fi on board', NULL, 'Additional drinks\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nA light jacket for the open deck', NULL, 'Boarding: Čechův most, molo 3B. Children 3–11; under 3 free. Latest check-in 10 min before departure. Departures from 20:00.', NULL, 'Free cancellation up to 24 hours before departure; non-refundable afterwards.', NULL, 'The boat departs from Čech Bridge (Prague Boats pier). Please arrive 15 minutes before departure.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(76, 9, NULL, NULL, 'Beer Story Tour & Prague River Cruise', 'Beer Story Tour & Prague River Cruise', NULL, 'products/76_9a8f7de0.jpg', NULL, 'Kombinovaná vstupenka spojující dva zážitky za cenu jednoho: návštěvu Pilsner Urquell: The Original Beer Experience (60 minut s ochutnávkou) a 50minutovou okružní plavbu na elektrické lodi kolem nejkrásnějších pražských památek. Kombinovanou vstupenku lze koupit pouze na pokladně na molu 3B.', 'A combined ticket pairing two experiences for the price of one: a visit to Pilsner Urquell: The Original Beer Experience (60 minutes, with a tasting) and a 50-minute sightseeing cruise on an electric boat past Prague\'s most beautiful landmarks. The combined ticket can only be purchased at the platform 3B ticket office.', NULL, '16 languages (audio/printed guide)', NULL, 'Nástup: molo 3B u Čechova mostu, Praha 1. Děti 3–11; do 3 let zdarma.', 'Boarding: pier 3B by Čech Bridge, Prague 1. Children 3–11, under 3 free.', NULL, 0, 150, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Dvořákovo nábřeží, molo 3B (u Čechova mostu), Praha 1', NULL, NULL, 'Prague river cruise\r\nBeer story / tasting element\r\nOnline GPS guide\r\nFree Wi-Fi on board', NULL, 'Additional drinks and food\r\nGratuities', NULL, 'This voucher (print or mobile)', NULL, 'Boarding: Čechův most, molo 3B. Children 3–11; under 3 free. Latest check-in 10 min before departure.', NULL, 'Free cancellation up to 24 hours before departure; non-refundable afterwards.', NULL, 'The boat departs from Čech Bridge (Prague Boats pier). Please arrive 15 minutes before departure.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(77, 9, NULL, NULL, 'Cruise to Devil\'s Channel (Čertovka)', 'Cruise to Devil\'s Channel (Čertovka)', NULL, 'products/77_767d4279.jpg', NULL, 'Plavba malým člunem úzkým ramenem Vltavy zvaným Čertovka mezi ostrovem Kampa a Malou Stranou – zákoutí přezdívanému „pražské Benátky\" hned u Karlova mostu, s historickým mlýnským kolem. Komorní pohled na město z míst, kam velké lodě nedoplují.', 'A small-boat cruise along Čertovka, the narrow arm of the Vltava between Kampa Island and the Lesser Town — the corner nicknamed \"Prague\'s Venice\" right by Charles Bridge, with its historic mill wheel. An intimate view of the city from places the larger boats cannot reach.', NULL, '16 languages (audio/printed guide)', NULL, 'Nástup: molo 3B u Čechova mostu, Praha 1. Děti 3–11; do 3 let zdarma.', 'Boarding: pier 3B by Čech Bridge, Prague 1. Children 3–11, under 3 free.', NULL, 0, 50, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Dvořákovo nábřeží, molo 3B (u Čechova mostu), Praha 1', NULL, NULL, '50 min sightseeing on the Vltava\r\nOnline GPS guide (audio/text/photos, 30+ sights)\r\nPrinted guide in 16 languages\r\nFree Wi-Fi on board', NULL, 'Food and drinks\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nA light jacket for the open deck', NULL, 'Boarding: Čechův most, molo 3B. Children 3–11; under 3 free. Latest check-in 10 min before departure.', NULL, 'Free cancellation up to 24 hours before departure; non-refundable afterwards.', NULL, 'The boat departs from Čech Bridge (Prague Boats pier). Please arrive 15 minutes before departure.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(78, 9, NULL, NULL, 'Lunch Cruise on a Glass Boat (2h)', 'Lunch Cruise on a Glass Boat (2h)', NULL, 'products/78_866745de.jpg', 'diagrams/prague-boats-2cat.svg', 'Dvouhodinová obědová plavba prosklenou lodí centrem Prahy. V ceně uvítací drink a teplý i studený raut – obědváte v klidu přímo na Vltavě, zatímco kolem oken plyne panorama města a hraje živá hudba. Po jídle se dá vyjít na otevřenou horní palubu za výhledy a fotkami. Odplutí ve 12:00 od Čechova mostu; trasa míjí Karlův most, Pražský hrad, Národní divadlo, Tančící dům a Vyšehrad. Dvě kategorie sezení – centrální salon a prémiová místa u oken.', 'A two-hour lunch cruise through the centre of Prague on a glass-sided boat. The ticket includes a welcome drink and a hot and cold buffet — a relaxed lunch right on the Vltava with the city panorama passing the windows and live music in the background. After the meal you can head up to the open top deck for views and photos. Departs at 12:00 from Čech Bridge, passing Charles Bridge, Prague Castle, the National Theatre, the Dancing House and Vyšehrad. Two seating categories: central saloon and premium seats by the windows.', NULL, '16 languages', NULL, 'Nástup: molo 3B u Čechova mostu, Praha 1. Check-in 10 min před odplutím, nástup končí 5 min předem. Essential lze pro 1 os., Exclusive od 2 os. Zvířata nejsou povolena. Konkrétní loď není garantována.', 'Boarding: pier 3B by Čech Bridge, Prague 1. Check-in 10 min before departure, boarding closes 5 min before. Essential available for 1 person, Exclusive from 2 people. Animals not permitted. A specific boat is not guaranteed.', 'https://www.prague-boats.cz/prague-lunch-cruise/', 0, 120, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 1, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Dvořákovo nábřeží, molo 3B (u Čechova mostu), Praha 1', NULL, NULL, '2h cruise on a glass boat\r\nWelcome drink\r\nBuffet lunch (all you can eat)\r\nLive music\r\nFree Wi-Fi', NULL, 'Drinks other than the welcome drink\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nA light jacket for the open deck', NULL, 'Boarding: Čechův most, molo 3B. Children 3–11; under 3 free. Latest check-in 10 min before departure. Daily 12:00. Exclusive: min. 2 osoby. Animals not permitted.', NULL, 'Free cancellation up to 24 hours before departure; non-refundable afterwards.', NULL, 'The boat departs from Čech Bridge (Prague Boats pier). Please arrive 15 minutes before departure.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(79, 9, NULL, NULL, 'Crystal Dinner Cruise (3h)', 'Crystal Dinner Cruise (3h)', NULL, 'products/79_0f34683c.jpg', 'diagrams/prague-boats-3cat.svg', 'Tříhodinová večerní plavba po Vltavě na prosklené lodi s posuvnou střechou – za příznivého počasí pod hvězdami, jinak za panoramatem skrz skleněné stěny. V ceně uvítací drink se sýrovou plnou a pečivem, bohatý teplý i studený raut formou all-you-can-eat a živá hudba. Odplutí ve 19:00 od Čechova mostu (5 minut od Staroměstského náměstí); cestou nasvícený Karlův most, Pražský hrad, Národní divadlo, Tančící dům a Vyšehrad. Místo si vybíráte podle kategorie sezení.', 'A three-hour evening cruise on the Vltava aboard a glass-sided boat with a sliding roof — under the stars in fair weather, or behind the glass walls when it is not. The ticket includes a welcome drink with a cheese platter and bread, a generous all-you-can-eat hot and cold buffet and live music. Departs at 19:00 from Čech Bridge, a five-minute walk from the Old Town Square, passing the illuminated Charles Bridge, Prague Castle, the National Theatre, the Dancing House and Vyšehrad. Choose your seat by category at booking.', NULL, '16 languages', NULL, 'Před prodejem ověř volné místo a potvrď rezervaci telefonicky (datum, čas, počet osob a kategorie sezení).', 'Before selling, check availability and confirm the reservation by phone (date, time, number of people and seating category).', 'https://www.prague-boats.cz/crystal-dinner/', 0, 180, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 1, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Dvořákovo nábřeží, molo 3B (u Čechova mostu), Praha 1', NULL, NULL, '3h evening cruise (glass boat, sliding roof)\r\nWelcome drink with cheese platter\r\nGenerous buffet (all you can eat)\r\nLive music\r\nFree Wi-Fi', NULL, 'Drinks other than the welcome drink\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nA light jacket for the open deck', NULL, 'Boarding: Čechův most, molo 3B. Children 3–11; under 3 free. Latest check-in 10 min before departure. Departure 19:00. De Luxe: min. 2 osoby.', NULL, 'Free cancellation up to 24 hours before departure; non-refundable afterwards.', NULL, 'The boat departs from Čech Bridge (Prague Boats pier). Please arrive 15 minutes before departure.', NULL, NULL, NULL, 0, NULL, NULL, NULL, '[\"night\",\"food\",\"dinner\"]'),
(80, 9, NULL, NULL, 'Dinner Cruise – Prague by Night (3h)', 'Dinner Cruise – Prague by Night (3h)', NULL, 'products/80_1ebe802f.jpg', 'diagrams/prague-boats-2cat.svg', 'Tříhodinová večerní plavba s rautovou večeří – ideální na romantický večer ve dvou, sešlost s přáteli, rodinnou oslavu i firemní setkání v netradičních kulisách. Pro nejlepší výhled na nasvícené město lze rezervovat garantované místo u okna. Odplutí ve 19:00 od Čechova mostu; večerní trasa míjí rozzářený Karlův most, Pražský hrad, Národní divadlo, Tančící dům a Vyšehrad. Dvě kategorie sezení.', 'A three-hour evening cruise with a buffet dinner — ideal for a romantic dinner for two, a get-together with friends, a family celebration or a business meeting against an unusual backdrop. For the best view of the illuminated city you can reserve a guaranteed window seat. Departs at 19:00 from Čech Bridge, the night-time route taking in the glowing Charles Bridge, Prague Castle, the National Theatre, the Dancing House and Vyšehrad. Two seating categories.', NULL, '16 languages', NULL, 'Nástup: molo 3B u Čechova mostu, Praha 1. Check-in 10 min před odplutím, nástup končí 5 min předem. Garantované místo u okna za příplatek. Konkrétní loď není garantována.', 'Boarding: pier 3B by Čech Bridge, Prague 1. Check-in 10 min before departure, boarding closes 5 min before. Guaranteed window seat for a surcharge. A specific boat is not guaranteed.', 'https://www.prague-boats.cz/prague-by-night-prague-dinner-cruise/', 0, 180, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Dvořákovo nábřeží, molo 3B (u Čechova mostu), Praha 1', NULL, NULL, '3h evening cruise through central Prague\r\nWelcome drink\r\nBuffet dinner (all you can eat)\r\nLive music\r\nFree Wi-Fi', NULL, 'Drinks other than the welcome drink\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nA light jacket for the open deck', NULL, 'Boarding: Čechův most, molo 3B. Children 3–11; under 3 free. Latest check-in 10 min before departure. Departure 19:00. Essential: min. 2 osoby. Guaranteed window seat for extra charge.', NULL, 'Free cancellation up to 24 hours before departure; non-refundable afterwards.', NULL, 'The boat departs from Čech Bridge (Prague Boats pier). Please arrive 15 minutes before departure.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(81, 10, NULL, NULL, 'Čertovka 45min Cruise (Prague Venice)', 'Čertovka 45min Cruise (Prague Venice)', NULL, 'products/81_5e504edd.jpg', NULL, NULL, NULL, NULL, '19 languages (audio guide)', NULL, NULL, NULL, NULL, 0, 45, 'continuous', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-05 13:43:02', NULL, NULL, 'Křižovnické náměstí 3, 110 00 Praha 1 (molo Judita pod Karlovým mostem)', NULL, 'https://www.google.com/maps/place/Prague+Venice+Boat+Trip/@50.0864114,14.4134753,20z/data=!4m6!3m5!1s0x470b94e5e58eb59f:0xaa4b2e0331376e12!8m2!3d50.0864117!4d14.4137573!16s%2Fg%2F11ggdth0px?authuser=0&entry=ttu&g_ep=EgoyMDI2MDYwMS4wIKXMDSoASAFQAw%3D%3D', '45-min cruise around Charles Bridge & the Čertovka canal\r\nFree admission to the Charles Bridge Museum\r\nFree Czech craft beer Krakonoš + refreshments\r\nAudio guide in 19 languages + disposable headphones', NULL, NULL, NULL, NULL, NULL, 'Departs every 10 minutes from the medieval Judith wharf beneath Charles Bridge; the boat leaves even with one passenger. Open 365 days. Hours: Oct–Apr 10:30–17:00; May–Jun 10:30–19:00; Jul–Aug 10:30–20:00; Sep- 10:30 - 19:00. Child fare 2–15 years.', NULL, 'Free cancellation up to 24 hours before the cruise.', NULL, 'Departures from Křižovnické náměstí. First visit the Charles Bridge Museum to exchange your voucher for a boat ticket and free museum entry, then continue through the museum to the boarding point on the channel under Charles Bridge.', NULL, NULL, NULL, 0, NULL, NULL, NULL, '[\"boat\",\"audio\",\"drink\"]'),
(82, 11, NULL, NULL, 'Afternoon Show (3-course)', 'Afternoon Show (3-course)', NULL, 'products/82_531902a3.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 120, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 12:12:56', NULL, NULL, 'Celetná 17, Praha 1', NULL, NULL, 'Live historic music\r\nDances with fire\r\nMedieval fencers\r\nWelcome Czech honey wine\r\nUnlimited drinks (beer, wine, soft drinks)\r\n3-course menu', NULL, NULL, NULL, NULL, NULL, 'Menu in 9 languages. Vegetarian / vegan menu at no extra charge.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, '[\"family\",\"drink\",\"dinner\"]'),
(83, 11, NULL, NULL, 'Evening Show (5-course)', 'Evening Show (5-course)', NULL, 'products/83_f4a13171.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 150, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-05 14:43:48', NULL, NULL, 'Celetná 17, Praha 1', NULL, NULL, 'Live historic music\r\nDances with fire\r\nMedieval fencers\r\nWelcome Czech honey wine\r\nUnlimited drinks (beer, wine, soft drinks)\r\n5-course menu (choice per course)', NULL, NULL, NULL, NULL, NULL, 'Menu in 9 languages. Vegetarian / vegan menu at no extra charge.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(84, 12, 30.00, NULL, 'HALLELUJAH', NULL, NULL, 'products/84_56b118db.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 60, 'weekly_pattern', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 10:27:26', NULL, NULL, 'Spanish Synagogue, Vězeňská 1, Praha 1 – Josefov', NULL, NULL, 'Concert admission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the concert; non-refundable afterwards.', NULL, 'Please arrive 20 minutes before the concert; show this voucher at the box office.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(85, 12, 30.00, NULL, 'CARMINA BURANA / BOLERO', NULL, NULL, 'products/85_1226eddf.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 60, 'weekly_pattern', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 10:27:35', NULL, NULL, 'Spanish Synagogue, Vězeňská 1, Praha 1 – Josefov', NULL, NULL, 'Concert admission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the concert; non-refundable afterwards.', NULL, 'Please arrive 20 minutes before the concert; show this voucher at the box office.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(86, 12, 30.00, NULL, 'MUSICALS in concert', NULL, NULL, 'products/86_bb463c36.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 60, 'specific_dates', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 10:28:09', NULL, NULL, 'Spanish Synagogue, Vězeňská 1, Praha 1 – Josefov', NULL, NULL, 'Concert admission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the concert; non-refundable afterwards.', NULL, 'Please arrive 20 minutes before the concert; show this voucher at the box office.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(87, 12, 30.00, NULL, 'Best of Czech and world music', NULL, NULL, 'products/87_7541613c.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 60, 'weekly_pattern', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 10:27:40', NULL, NULL, 'Spanish Synagogue, Vězeňská 1, Praha 1 – Josefov', NULL, NULL, 'Concert admission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the concert; non-refundable afterwards.', NULL, 'Please arrive 20 minutes before the concert; show this voucher at the box office.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL);
INSERT INTO `products` (`id`, `agency_id`, `commission_pct`, `seller_bonus_pct`, `name_cs`, `name_en`, `name_de`, `image_path`, `variant_diagram_path`, `description_cs`, `description_en`, `description_de`, `languages`, `languages_en`, `order_instructions`, `order_instructions_en`, `booking_url`, `has_contingent`, `duration_minutes`, `schedule_type`, `voucher_redemption_type`, `ticket_type`, `pickup_available`, `pickup_required`, `pickup_free`, `pickup_window_minutes`, `pickup_confirmation`, `status`, `is_featured`, `created_at`, `updated_at`, `deposit_fixed_czk`, `deposit_fixed_eur`, `meeting_point_address`, `meeting_point_address_en`, `map_url`, `included`, `included_en`, `excluded`, `excluded_en`, `what_to_bring`, `what_to_bring_en`, `important_info`, `important_info_en`, `cancellation_policy`, `cancellation_policy_en`, `meeting_point_note`, `meeting_point_note_en`, `meeting_options`, `meeting_options_en`, `seating`, `addons`, `seat_map_svg`, `language_options`, `attributes`) VALUES
(88, 13, NULL, NULL, 'Folklore Dinner Show', NULL, NULL, 'products/88_3508488c.jpg', NULL, NULL, NULL, NULL, 'Non-verbal', NULL, 'Rezervace nutná: dostupnost zkontroluj v kalendáři na webu folkloregarden.cz a rezervuj telefonicky na +420 724 334 340. Počet hostů není omezen.', 'Reservation required: check availability in the calendar at folkloregarden.cz and book by phone at +420 724 334 340. No limit on the number of guests.', 'https://www.folkloregarden.cz', 0, 180, 'fixed_daily', 'direct_entry', 'date_required', 1, 1, 0, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 19:16:39', NULL, NULL, 'Na Zlíchově 18, Praha 5 – Hlubočepy', NULL, NULL, 'Return transfer (hotel pickup)\r\n4-course dinner\r\nWelcome drink (mead)\r\nLive folklore show', NULL, 'Extra drinks\r\nGratuities', NULL, NULL, NULL, 'No minimum or maximum group size. The performance is non-verbal — traditional folk dance, a multi-course dinner and live music, so there is no language barrier.', NULL, NULL, NULL, 'Pickup z hotelové recepce 18:40–19:00 vlastním minibusem; show 19:00–22:00, drop-off zpět na hotel po 22:00.', 'Hotel reception pickup 18:40–19:00 by their own minibus, show 19:00–22:00, drop-off back at the hotel after 22:00.', NULL, NULL, 0, '[{\"label\":\"Special main course (upgrade)\",\"czk\":75,\"eur\":3},{\"label\":\"Hotel transfer (return minibus)\",\"czk\":300,\"eur\":12}]', NULL, NULL, NULL),
(89, 14, NULL, NULL, 'Range Shooting', NULL, NULL, 'products/89_a22faae7.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 09:15:02', NULL, NULL, 'IC Mostecká 53/4, Praha 1', NULL, NULL, 'English-speaking instructor\r\nBriefing (safety, gun handling, shooting techniques)\r\nRange fee (indoor or outdoor range)\r\nGuns rental (1-13 guns by package)\r\nGear (ammo, targets, eye & ear protection)\r\nRefreshment (mineral water)\r\nPick-up & drop-off + both-way transfer (AC minibus)', NULL, 'Gratuities\r\nPersonal expenses', NULL, 'This voucher (print or mobile)\r\nComfortable clothing and closed shoes', NULL, 'Exact pick-up time is confirmed by the agency. Minimum age, weight or health restrictions may apply — please check when booking. Weather-dependent activities may be rescheduled.', NULL, 'Free cancellation up to 24 hours before the activity.', NULL, 'We pick you up — at your hotel or at IC Mostecká 53/4, Praha 1. The agency confirms the exact time.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(90, 14, NULL, NULL, 'Tandem Skydiving', NULL, NULL, 'products/90_d3acc808.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 240, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 09:14:57', NULL, NULL, 'IC Mostecká 53/4, Praha 1', NULL, NULL, 'English-speaking tandem skydiver\r\nBriefing & tandem jump simulation training\r\nEquipment (skydive suit, goggles)\r\n20-minute sightseeing flight\r\nTandem jump from 4,200 m, 1-minute free fall at 200 km/h\r\nTransfers (AC minibus from/to our office)', NULL, 'Gratuities\r\nPersonal expenses', NULL, 'This voucher (print or mobile)\r\nComfortable clothing and closed shoes', NULL, 'Exact pick-up time is confirmed by the agency. Minimum age, weight or health restrictions may apply — please check when booking. Weather-dependent activities may be rescheduled.', NULL, 'Free cancellation up to 24 hours before the activity.', NULL, 'We pick you up — at your hotel or at IC Mostecká 53/4, Praha 1. The agency confirms the exact time.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(91, 14, NULL, NULL, 'Horse Riding', NULL, NULL, 'products/91_5582b407.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 120, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 09:11:22', NULL, NULL, 'IC Mostecká 53/4, Praha 1', NULL, NULL, 'Pick-up & drop-off + both-way transfer (AC minibus)\r\nEnglish-speaking instructor\r\nBriefing (safety)\r\nEquipment (helmet)\r\n40-minute riding session\r\nRefreshment (mineral water)', NULL, 'Gratuities\r\nPersonal expenses', NULL, 'This voucher (print or mobile)\r\nComfortable clothing and closed shoes', NULL, 'Exact pick-up time is confirmed by the agency. Minimum age, weight or health restrictions may apply — please check when booking. Weather-dependent activities may be rescheduled.', NULL, 'Free cancellation up to 24 hours before the activity.', NULL, 'We pick you up — at your hotel or at IC Mostecká 53/4, Praha 1. The agency confirms the exact time.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(92, 14, NULL, NULL, 'Bungee Jumping', NULL, NULL, 'products/92_6ce13648.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 180, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-03 20:52:05', NULL, NULL, 'IC Mostecká 53/4, Praha 1', NULL, NULL, 'Pick-up & drop-off + both-way transfer\r\nEnglish-speaking professional instructors\r\nBriefing (safety)\r\nBungee jump (62 m bridge or 36 m TV tower by package)\r\nWeight limit 40-160 kg', NULL, 'Gratuities\r\nPersonal expenses', NULL, 'This voucher (print or mobile)\r\nComfortable clothing and closed shoes', NULL, 'Exact pick-up time is confirmed by the agency. Minimum age, weight or health restrictions may apply — please check when booking. Weather-dependent activities may be rescheduled.', NULL, 'Free cancellation up to 24 hours before the activity.', NULL, 'We pick you up — at your hotel or at IC Mostecká 53/4, Praha 1. The agency confirms the exact time.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(93, 14, NULL, NULL, 'Go-Karting', NULL, NULL, 'products/93_023d73e2.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 90, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 09:11:56', NULL, NULL, 'IC Mostecká 53/4, Praha 1', NULL, NULL, 'Pick-up & drop-off + both-way transfer\r\nEnglish-speaking instructor\r\nBriefing (safety)\r\nEquipment (go-karts, petrol, helmet, gloves)\r\n2 or 3 ten-minute rides by package\r\nRacing results printed after each ride', NULL, 'Gratuities\r\nPersonal expenses', NULL, 'This voucher (print or mobile)\r\nComfortable clothing and closed shoes', NULL, 'Exact pick-up time is confirmed by the agency. Minimum age, weight or health restrictions may apply — please check when booking. Weather-dependent activities may be rescheduled.', NULL, 'Free cancellation up to 24 hours before the activity.', NULL, 'We pick you up — at your hotel or at IC Mostecká 53/4, Praha 1. The agency confirms the exact time.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(94, 14, NULL, NULL, 'Bobsleigh Track', NULL, NULL, 'products/94_ad0b3f12.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 60, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-03 20:51:29', NULL, NULL, 'IC Mostecká 53/4, Praha 1', NULL, NULL, 'Pick-up & drop-off + both-way transfer\r\nEnglish-speaking instructor\r\nBriefing (safety)\r\n5 rides on the bobsleigh track\r\nRefreshment (beer, wine or soft drink)', NULL, 'Gratuities\r\nPersonal expenses', NULL, 'This voucher (print or mobile)\r\nComfortable clothing and closed shoes', NULL, 'Exact pick-up time is confirmed by the agency. Minimum age, weight or health restrictions may apply — please check when booking. Weather-dependent activities may be rescheduled.', NULL, 'Free cancellation up to 24 hours before the activity.', NULL, 'We pick you up — at your hotel or at IC Mostecká 53/4, Praha 1. The agency confirms the exact time.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(95, 14, NULL, NULL, 'White Water Rafting', NULL, NULL, 'products/95_17e2dbe7.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 180, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 09:14:32', NULL, NULL, 'IC Mostecká 53/4, Praha 1', NULL, NULL, 'Pick-up & drop-off + both-way transfer\r\nEnglish-speaking instructor\r\nBriefing (safety)\r\nEquipment (paddles, lifejacket, wetsuit, neoprene shoes, helmet, changing room, showers)\r\n6 rides on the world-class wildwater canal\r\nRefreshment (mineral water)', NULL, 'Gratuities\r\nPersonal expenses', NULL, 'This voucher (print or mobile)\r\nComfortable clothing and closed shoes', NULL, 'Exact pick-up time is confirmed by the agency. Minimum age, weight or health restrictions may apply — please check when booking. Weather-dependent activities may be rescheduled.', NULL, 'Free cancellation up to 24 hours before the activity.', NULL, 'We pick you up — at your hotel or at IC Mostecká 53/4, Praha 1. The agency confirms the exact time.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(96, 14, NULL, NULL, 'Hot Air Ballooning', NULL, NULL, 'products/96_49a01535.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 180, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-03 20:53:14', NULL, NULL, 'IC Mostecká 53/4, Praha 1', NULL, NULL, 'Pick-up & drop-off + both-way transfer\r\nEnglish-speaking pilot\r\nBriefing (safety)\r\nOne-hour hot air balloon flight\r\nRefreshment (mineral water + champagne toast)', NULL, 'Gratuities\r\nPersonal expenses', NULL, 'This voucher (print or mobile)\r\nComfortable clothing and closed shoes', NULL, 'Exact pick-up time is confirmed by the agency. Minimum age, weight or health restrictions may apply — please check when booking. Weather-dependent activities may be rescheduled.', NULL, 'Free cancellation up to 24 hours before the activity.', NULL, 'We pick you up — at your hotel or at IC Mostecká 53/4, Praha 1. The agency confirms the exact time.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(97, 14, NULL, NULL, 'Indoor Skydiving', NULL, NULL, 'products/97_a3c91e37.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 90, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 09:14:26', NULL, NULL, 'IC Mostecká 53/4, Praha 1', NULL, NULL, 'Pick-up & drop-off + both-way transfer\r\nEnglish-speaking instructor\r\nBriefing (video projection + flight simulation)\r\nEquipment (suit, helmet, goggles, gloves)\r\n4-minute flight (two 2-minute flights)', NULL, 'Gratuities\r\nPersonal expenses', NULL, 'This voucher (print or mobile)\r\nComfortable clothing and closed shoes', NULL, 'Exact pick-up time is confirmed by the agency. Minimum age, weight or health restrictions may apply — please check when booking. Weather-dependent activities may be rescheduled.', NULL, 'Free cancellation up to 24 hours before the activity.', NULL, 'We pick you up — at your hotel or at IC Mostecká 53/4, Praha 1. The agency confirms the exact time.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(98, 14, NULL, NULL, 'Clay Pigeons Shooting', NULL, NULL, 'products/98_a2c4f250.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 120, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-03 20:52:32', NULL, NULL, 'IC Mostecká 53/4, Praha 1', NULL, NULL, 'Pick-up & drop-off + both-way transfer\r\nEnglish-speaking instructor\r\nBriefing (safety, shotgun handling)\r\nEquipment (shotgun, ammunition, clay targets, eye & ear protection)\r\n10 clay targets & 20 shots\r\nRefreshment (mineral water)', NULL, 'Gratuities\r\nPersonal expenses', NULL, 'This voucher (print or mobile)\r\nComfortable clothing and closed shoes', NULL, 'Exact pick-up time is confirmed by the agency. Minimum age, weight or health restrictions may apply — please check when booking. Weather-dependent activities may be rescheduled.', NULL, 'Free cancellation up to 24 hours before the activity.', NULL, 'We pick you up — at your hotel or at IC Mostecká 53/4, Praha 1. The agency confirms the exact time.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(99, 14, NULL, NULL, 'Paintball', NULL, NULL, 'products/99_6f70e48d.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 120, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 09:12:53', NULL, NULL, 'IC Mostecká 53/4, Praha 1', NULL, NULL, 'Equipment (overall, face mask, gloves, paintball gun, ammo)\r\nEnglish-speaking instructor\r\nBriefing (safety, gun handling)\r\nPaintball game up to 4 hours\r\n100 / 200 / 300 bullets by package', NULL, 'Gratuities\r\nPersonal expenses', NULL, 'This voucher (print or mobile)\r\nComfortable clothing and closed shoes', NULL, 'Exact pick-up time is confirmed by the agency. Minimum age, weight or health restrictions may apply — please check when booking. Weather-dependent activities may be rescheduled.', NULL, 'Free cancellation up to 24 hours before the activity.', NULL, 'We pick you up — at your hotel or at IC Mostecká 53/4, Praha 1. The agency confirms the exact time.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(100, 14, NULL, NULL, 'High Roping', NULL, NULL, 'products/100_df01264e.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 120, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 09:12:02', NULL, NULL, 'IC Mostecká 53/4, Praha 1', NULL, NULL, 'Pick-up & drop-off + both-way transfer\r\nEnglish-speaking instructor\r\nBriefing (safety)\r\nEquipment\r\nTwo hours of high roping\r\nRefreshment (mineral water)', NULL, 'Gratuities\r\nPersonal expenses', NULL, 'This voucher (print or mobile)\r\nComfortable clothing and closed shoes', NULL, 'Exact pick-up time is confirmed by the agency. Minimum age, weight or health restrictions may apply — please check when booking. Weather-dependent activities may be rescheduled.', NULL, 'Free cancellation up to 24 hours before the activity.', NULL, 'We pick you up — at your hotel or at IC Mostecká 53/4, Praha 1. The agency confirms the exact time.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(101, 14, NULL, NULL, 'Flyboarding', NULL, NULL, 'products/101_663db338.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 90, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 09:12:46', NULL, NULL, 'IC Mostecká 53/4, Praha 1', NULL, NULL, 'Pick-up & drop-off + both-way transfer\r\nEnglish-speaking instructor\r\nBriefing (safety)\r\nEquipment (wetsuit, lifejacket, helmet, shower facilities)\r\n15-minute flyboarding\r\nRefreshment (mineral water)', NULL, 'Gratuities\r\nPersonal expenses', NULL, 'This voucher (print or mobile)\r\nComfortable clothing and closed shoes', NULL, 'Minimum age 12; weight limit 30 kg. Exact pick-up time is confirmed by the agency. Minimum age, weight or health restrictions may apply — please check when booking. Weather-dependent activities may be rescheduled.', NULL, 'Free cancellation up to 24 hours before the activity.', NULL, 'We pick you up — at your hotel or at IC Mostecká 53/4, Praha 1. The agency confirms the exact time.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(102, 14, NULL, NULL, 'Quad Biking', NULL, NULL, 'products/102_1ac71db5.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 120, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, 'tbc_agency', 'active', 0, '2026-06-01 06:52:56', '2026-06-06 09:15:46', NULL, NULL, 'IC Mostecká 53/4, Praha 1', NULL, NULL, 'Pick-up & drop-off + both-way transfer\r\nEnglish-speaking instructor\r\nBriefing (safety)\r\nEquipment (quad bike, helmet, gloves)\r\n30 / 45 / 60-minute ride by package', NULL, 'Gratuities\r\nPersonal expenses', NULL, 'This voucher (print or mobile)\r\nComfortable clothing and closed shoes', NULL, 'Exact pick-up time is confirmed by the agency. Minimum age, weight or health restrictions may apply — please check when booking. Weather-dependent activities may be rescheduled.', NULL, 'Free cancellation up to 24 hours before the activity.', NULL, 'We pick you up — at your hotel or at IC Mostecká 53/4, Praha 1. The agency confirms the exact time.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(103, 15, NULL, NULL, 'Castle Side Food Tour', NULL, NULL, 'products/103_00257e34.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 180, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-05 15:38:37', NULL, NULL, 'Mostecká 4/53, Praha 1 (kancelář PragueWay)', NULL, NULL, 'Local English-speaking guide\r\nFood and/or drink tastings as per the itinerary', NULL, 'Additional food and drinks beyond the tastings\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes (cobblestones)\r\nCome hungry', NULL, 'Small group. Please share any dietary requirements when booking.', NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at Mostecká 53/4 (information centre). Please arrive 10 minutes early.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(104, 15, NULL, NULL, 'Castle Side Beer Tour', NULL, NULL, 'products/104_39015d9f.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 210, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 14:48:14', NULL, NULL, 'Mostecká 4/53, Praha 1 (kancelář PragueWay)', NULL, NULL, 'Local English-speaking guide\r\nFood and/or drink tastings as per the itinerary', NULL, 'Additional food and drinks beyond the tastings\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes (cobblestones)\r\nCome hungry', NULL, 'Small group. Please share any dietary requirements when booking.', NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at Mostecká 53/4 (information centre). Please arrive 10 minutes early.', NULL, NULL, NULL, 0, NULL, NULL, NULL, '[\"walking\",\"guide\",\"smallgroup\",\"history\",\"beer\",\"drink\"]'),
(105, 15, NULL, NULL, 'One Prague Tour Castle Side', NULL, NULL, 'products/105_5c3a4c8d.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 180, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-05 15:35:05', NULL, NULL, 'Mostecká 4/53, Praha 1 (kancelář PragueWay)', NULL, NULL, 'Local English-speaking guide', NULL, 'Admission fees where applicable\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes (cobblestones)', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at Mostecká 53/4 (information centre). Please arrive 10 minutes early.', NULL, NULL, NULL, 0, NULL, NULL, NULL, '[\"walking\",\"guide\",\"smallgroup\",\"food\",\"beer\",\"drink\"]'),
(106, 15, NULL, NULL, 'One Prague Tour Old Town Road', NULL, NULL, 'products/106_7fee83a7.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 180, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-05 15:40:33', NULL, NULL, 'Mostecká 4/53, Praha 1 (kancelář PragueWay)', NULL, NULL, 'Local English-speaking guide\r\nFood and/or drink tastings as per the itinerary', NULL, 'Additional food and drinks beyond the tastings\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes (cobblestones)\r\nCome hungry', NULL, 'Small group. Please share any dietary requirements when booking.', NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at Mostecká 53/4 (information centre). Please arrive 10 minutes early.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(107, 15, NULL, NULL, 'Old Town & Jewish Quarter', NULL, NULL, 'products/107_fce0f4f5.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 120, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 15:38:18', NULL, NULL, 'Mostecká 4/53, Praha 1 (kancelář PragueWay)', NULL, NULL, 'Local English-speaking guide', NULL, 'Admission fees where applicable\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes (cobblestones)', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at Mostecká 53/4 (information centre). Please arrive 10 minutes early.', NULL, NULL, NULL, 0, NULL, NULL, NULL, '[\"walking\",\"guide\",\"smallgroup\",\"history\"]'),
(108, 15, NULL, NULL, 'Charles Bridge River Cruise', NULL, NULL, 'products/108_37434997.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 90, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 15:37:34', NULL, NULL, 'Mostecká 4/53, Praha 1 (kancelář PragueWay)', NULL, NULL, 'Scenic river cruise\r\nLocal commentary', NULL, 'Admission fees where applicable\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes (cobblestones)', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at Mostecká 53/4 (information centre). Please arrive 10 minutes early.', NULL, NULL, NULL, 0, NULL, NULL, NULL, '[\"walking\",\"boat\",\"audio\",\"guide\",\"smallgroup\"]'),
(109, 15, NULL, NULL, 'Vyšehrad Castle & Fort', NULL, NULL, 'products/109_0ba96e05.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 150, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 15:39:13', NULL, NULL, 'Charles IV Statue, Křížovnické náměstí, Praha 1', NULL, NULL, 'Local English-speaking guide', NULL, 'Admission fees where applicable\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes (cobblestones)', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at the Charles IV statue on Křižovnické náměstí, Praha 1.', NULL, NULL, NULL, 0, NULL, NULL, NULL, '[\"walking\",\"guide\",\"smallgroup\",\"history\"]'),
(110, 15, NULL, NULL, 'E-Scooter Grand City Tour', NULL, NULL, 'products/110_677e75f3.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 180, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 15:56:52', NULL, NULL, 'Mostecká 4/53, Praha 1 (kancelář PragueWay)', NULL, NULL, 'E-scooter and helmet\r\nLocal guide\r\nSafety briefing', NULL, 'Gratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes', NULL, 'Minimum height 150 cm.', NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at Mostecká 53/4 (information centre). Please arrive 10 minutes early.', NULL, NULL, NULL, 0, NULL, NULL, NULL, '[\"escooter\",\"audio\",\"guide\",\"smallgroup\"]'),
(111, 15, NULL, NULL, 'Old Town & Medieval Underground', NULL, NULL, 'products/111_cb0e727b.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 180, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-05 15:33:21', NULL, NULL, 'Mostecká 4/53, Praha 1 (kancelář PragueWay)', NULL, NULL, 'Local English-speaking guide', NULL, 'Admission fees where applicable\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes (cobblestones)', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at Mostecká 53/4 (information centre). Please arrive 10 minutes early.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(112, 15, NULL, NULL, 'Prague Castle Highlights', NULL, NULL, 'products/112_77d02231.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 120, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 16:25:39', NULL, NULL, 'Mostecká 4/53, Praha 1 (kancelář PragueWay)', NULL, NULL, 'Local English-speaking guide', NULL, 'Admission fees where applicable\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes (cobblestones)', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at Mostecká 53/4 (information centre). Please arrive 10 minutes early.', NULL, NULL, NULL, 0, NULL, NULL, NULL, '[\"walking\",\"guide\",\"smallgroup\"]'),
(113, 15, NULL, NULL, 'One-Day See It All', NULL, NULL, 'products/113_a40fcadc.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 420, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 16:26:20', NULL, NULL, 'Mostecká 4/53, Praha 1 (kancelář PragueWay)', NULL, NULL, 'Local English-speaking guide', NULL, 'Admission fees where applicable\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes (cobblestones)', NULL, NULL, NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at Mostecká 53/4 (information centre). Please arrive 10 minutes early.', NULL, NULL, NULL, 0, NULL, NULL, NULL, '[\"walking\",\"boat\",\"audio\",\"guide\",\"smallgroup\",\"history\"]'),
(114, 15, NULL, NULL, 'E-Scooter Panoramic Tour', NULL, NULL, 'products/114_3118967f.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 120, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 16:07:18', NULL, NULL, 'Mostecká 4/53, Praha 1 (kancelář PragueWay)', NULL, NULL, 'E-scooter and helmet\r\nLocal guide\r\nSafety briefing', NULL, 'Gratuities', NULL, 'This voucher (print or mobile)\r\nComfortable shoes', NULL, 'Minimum height 150 cm.', NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Meet at Mostecká 53/4 (information centre). Please arrive 10 minutes early.', NULL, NULL, NULL, 0, NULL, NULL, NULL, '[\"escooter\",\"audio\",\"guide\",\"smallgroup\"]'),
(115, 16, NULL, NULL, 'Image Black Light Theatre', 'Image Black Light Theatre', NULL, 'products/115_06163e7b.jpg', NULL, NULL, NULL, NULL, 'Non-verbal', NULL, NULL, NULL, NULL, 0, 80, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 09:42:44', NULL, NULL, 'Národní 25, 110 00 Praha 1', NULL, NULL, 'Non-verbal black-light theatre performance (75–85 min, no intermission)', NULL, NULL, NULL, NULL, NULL, 'Daily at 20:00. All performances are non-verbal (no language barrier). Box office opens 16:00 on the day; hall opens 30 min before start. Wheelchair accessible. Reservation by phone required (+420 732 156 343 / +420 222 314 448). The specific show follows the monthly programme.', NULL, 'Reservation by phone required; cancellation terms per the theatre.', NULL, 'Show your voucher at the Image Theatre box office.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(116, 17, NULL, NULL, 'Antologia (Srnec Black Light Theatre)', 'Antologia (Srnec Black Light Theatre)', NULL, 'products/116_5bda6e7c.jpg', NULL, NULL, NULL, NULL, 'Non-verbal', NULL, NULL, NULL, NULL, 0, 90, 'fixed_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 12:15:40', NULL, NULL, 'Národní 20, 110 00 Praha 1 (Reduta Jazz Club)', NULL, NULL, 'Non-verbal black-light theatre performance (90 min, with intermission)', NULL, NULL, NULL, NULL, NULL, 'Show at 20:00 per the monthly programme. The original / oldest black-light theatre in the world. Venue: Reduta Jazz Club, Národní 20. NOTE: the full (adult) price varies by date per the monthly programme — on some dates it is 550 CZK instead of 650; apply a discount on those dates. Reservation by phone (+420 774 574 475).', NULL, 'Reservation by phone required; cancellation terms per the theatre.', NULL, 'Show your voucher at the Srnec Theatre box office (inside the Reduta Jazz Club building).', NULL, NULL, NULL, 1, NULL, NULL, NULL, '[\"family\",\"art\",\"night\",\"ticket\"]'),
(117, 18, NULL, NULL, 'WOW Show – 4D Interactive Black Light', 'WOW Show – 4D Interactive Black Light', NULL, 'products/117_15c4d55c.jpg', NULL, NULL, NULL, NULL, 'Non-verbal', NULL, NULL, NULL, NULL, 0, 65, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-01 06:52:56', '2026-06-06 08:41:39', NULL, NULL, 'Divadlo Broadway, Na Příkopě 31, 110 00 Praha 1 (pasáž Broadway; vstup i z Celetné 38)', NULL, NULL, 'Non-verbal 4D & interactive black-light show (65 min, no intermission)', NULL, NULL, NULL, NULL, NULL, 'Non-verbal 4D & interactive show for all ages, 65 min, no intermission, no language barrier. Free seating – choose your seat on arrival (booster seats for small children). Show at 20:00 or 21:30 per the monthly programme. Reservation by phone (+420 777 061 623 / +420 225 113 194), Mon–Sun from 12:00 until showtime.', NULL, 'Reservation by phone required; cancellation terms per the theatre.', NULL, 'Broadway passage (entrance from Na Příkopě 31 or Celetná 38). Show your voucher at the box office.', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL),
(118, 1, 25.00, NULL, 'Big Bus Hop-on Hop-off', 'Big Bus Hop-on Hop-off', NULL, 'products/118_90e93da6.jpg', NULL, 'Vyhlídkové autobusy hop-on hop-off s otevřenou střechou a audio průvodcem v 11 jazycích. Nastupujete a vystupujete, kde chcete; autobusy jezdí zhruba každých 15 minut. Variantu si vyberte podle délky platnosti a počtu tras – některé balíčky zahrnují i plavbu po Vltavě. Storno zdarma 24 h předem.', 'Hop-on hop-off sightseeing buses with an open top and audio commentary in 11 languages. Get on and off wherever you like; buses run roughly every 15 minutes. Choose the variant by validity and number of routes — some packages also include a Vltava river cruise. Free cancellation up to 24 hours in advance.', NULL, 'audio průvodce ve 24  jazycích', 'audio commentary in 24 languages', 'Je třeba rovnou objednat\r\nV případě problémů volat 602405701', 'Order right away.\nIf there are any problems, call 602405701.', NULL, 1, NULL, 'continuous', 'bus_activation', 'open', 0, 0, 0, NULL, NULL, 'active', 1, '2026-06-01 13:46:16', '2026-06-06 19:16:39', NULL, NULL, 'různá místa nástupu', NULL, NULL, 'Unlimited hop-on hop-off on both routes (Red and Green) for your ticket validity\r\nMultilingual audio commentary (24 languages) with earphones\r\nOn-board staff\r\nVltava river cruise (where included in your ticket)', NULL, 'Food and drinks\r\nGratuities', NULL, 'This voucher (print or mobile)\r\nSun protection in summer', NULL, 'Board at any of the 18 stops — look for the red Big Bus. Audio guide via the earphones provided.', NULL, 'Free cancellation up to 24 hours before start; non-refundable afterwards.', NULL, 'Použijte QR kód na voucheru pro získání lokaci nejbližší zastávky', 'Use the QR code on the voucher to get the location of the nearest stop.', NULL, NULL, 0, NULL, NULL, NULL, '[\"bus\",\"audio\",\"family\",\"history\"]'),
(119, 5, NULL, NULL, 'Pilsner Urquell Experience – vstupenka', 'Pilsner Urquell Experience – ticket', NULL, 'products/119_5ee6437b.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'on_demand', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'inactive', 0, '2026-06-02 13:01:57', '2026-06-06 10:45:35', NULL, NULL, 'Pilsner Urquell Experience, 28. října 377/13, Praha 1', NULL, NULL, 'Admission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Show your voucher at the entrance.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(120, 5, NULL, NULL, 'Story of Prague – interaktivní muzeum', 'Story of Prague – interactive museum', NULL, 'products/120_ef882b0e.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 'on_demand', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'inactive', 0, '2026-06-02 13:01:57', '2026-06-06 10:45:41', NULL, NULL, 'Story of Prague, Křižovnické náměstí, Praha 1', NULL, NULL, 'Museum admission\r\nApp audio guide (7 languages)', NULL, NULL, NULL, NULL, NULL, 'Interactive AR museum — 160 exhibits across 19 rooms / 3 floors. Open daily 10:00–20:00.', NULL, NULL, NULL, 'Enter from inside the passage at Křižovnické náměstí. Show your voucher at the entrance.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(121, 15, NULL, NULL, 'The Little Quarter Walk: Prague Beyond the Crowds', 'The Little Quarter Walk: Prague Beyond the Crowds', NULL, 'products/121_edb285ca.jpg', NULL, NULL, NULL, NULL, 'EN', NULL, NULL, NULL, NULL, 0, 150, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 16:26:33', NULL, NULL, 'West side of Charles Bridge, Praha 1', NULL, NULL, 'Local expert guide\r\nSmall-group experience\r\nOne café drink (beer, wine or non-alcoholic)\r\nSeasonal admission: Vrtba Garden (Mar–Oct) / St. Nicholas Church interior (winter)', NULL, NULL, NULL, NULL, NULL, 'Daily 9:30 & 15:30. Small group (max 11–12). Minimum 2 participants — if you are a solo traveler, contact us before booking.', NULL, 'Free cancellation up to 24 hours before the tour.', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, '[\"walking\",\"guide\",\"smallgroup\",\"history\"]'),
(122, 15, NULL, NULL, 'Czech Highlights in 2 Days: Prague & Bohemian Switzerland', 'Czech Highlights in 2 Days: Prague & Bohemian Switzerland', NULL, 'products/122_3b1be755.jpg', NULL, NULL, NULL, NULL, 'EN', NULL, NULL, NULL, NULL, 0, 1020, 'fixed_daily', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-05 15:37:28', NULL, NULL, 'Day 1: Mostecká 53/4, Praha 1 (West side of Charles Bridge)', NULL, NULL, 'Day 1 (Prague): local expert guide, boat cruise (free drink & snack), tram ticket to the castle\r\nDay 2 (National Park): hotel pickup & drop-off, expert guides, lunch & snacks (veg options), all entries & transport\r\nSmall-group comfort', NULL, NULL, NULL, NULL, NULL, 'Two consecutive days (Day 1 Prague, Day 2 Bohemian/Saxon Switzerland). Bring EU ID or passport — the national-park day crosses into Germany. Difficulty easy/moderate (8–10 km hike). Operated jointly by PragueWay (Day 1) and Bohemia Adventures (Day 2).', NULL, 'Free cancellation up to 24 hours before; one day can be cancelled independently.', NULL, 'Day 1 Prague: meet at Mostecká 53/4 at 10:00. Day 2 National Park: hotel pickup 7:30–8:00, drop-off ~18:30.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(123, 21, NULL, NULL, 'Top Highlights of Bohemian & Saxon Switzerland (with Boat Ride)', 'Top Highlights of Bohemian & Saxon Switzerland (with Boat Ride)', NULL, 'products/123_8df72f04.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 600, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 12:19:34', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, '[\"bus\",\"walking\",\"boat\",\"transfer\",\"guide\",\"smallgroup\",\"family\",\"nature\",\"hotelpickup\"]'),
(124, 21, NULL, NULL, 'Easy Walking Tour: Romantic Boat Ride & Bastei Bridge', 'Easy Walking Tour: Romantic Boat Ride & Bastei Bridge', NULL, 'products/124_8af503f3.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 540, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 09:19:24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(125, 21, NULL, NULL, 'Best Viewpoint Hikes: Tisa Rocks, Pravčická Gate & Bastei Bridge', 'Best Viewpoint Hikes: Tisa Rocks, Pravčická Gate & Bastei Bridge', NULL, 'products/125_f6d8ee2e.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 600, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 09:18:42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(126, 21, NULL, NULL, 'Easy Walking Tour: Tisa Rocks & Bastei Bridge', 'Easy Walking Tour: Tisa Rocks & Bastei Bridge', NULL, 'products/126_85522eb6.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 540, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 09:20:24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(127, 21, NULL, NULL, 'Karlovy Vary All-Inclusive Escape: Springs, Views & Culture', 'Karlovy Vary All-Inclusive Escape: Springs, Views & Culture', NULL, 'products/127_698c9d78.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 600, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 09:23:16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(128, 21, NULL, NULL, 'Dresden City Tour from Prague & Bastei Bridge', 'Dresden City Tour from Prague & Bastei Bridge', NULL, 'products/128_694f39a6.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 600, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 09:23:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(129, 21, NULL, NULL, 'Terezín & the Best of Bohemian and Saxon Switzerland', 'Terezín & the Best of Bohemian and Saxon Switzerland', NULL, 'products/129_95d98c0f.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 600, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 09:24:37', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(130, 21, NULL, NULL, 'Discover Bohemia: Tisa Rocks, Bastei Bridge & Brewery with Beer Tasting', 'Discover Bohemia: Tisa Rocks, Bastei Bridge & Brewery with Beer Tasting', NULL, 'products/130_68b4e1a2.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 600, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 09:25:42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(131, 21, NULL, NULL, 'Unlimited Thermal Spa & Top Highlights of Saxon Switzerland', 'Unlimited Thermal Spa & Top Highlights of Saxon Switzerland', NULL, 'products/131_d1060a09.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 600, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 09:25:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(132, 21, NULL, NULL, 'Dresden Christmas Market Special Tour with Mulled Wine', 'Dresden Christmas Market Special Tour with Mulled Wine', NULL, 'products/132_aae9e75c.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 600, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 09:24:18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(133, 21, NULL, NULL, 'Horseback Riding Tour in Bohemian Switzerland', 'Horseback Riding Tour in Bohemian Switzerland', NULL, 'products/133_8565348e.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 480, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 09:21:31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(134, 21, NULL, NULL, 'Mountain Bike Adventure Tour from Prague', 'Mountain Bike Adventure Tour from Prague', NULL, 'products/134_95ccf7c7.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 480, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 09:21:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(135, 21, NULL, NULL, 'Rafting & Canoeing Adventure Tour to Bohemian Switzerland', 'Rafting & Canoeing Adventure Tour to Bohemian Switzerland', NULL, 'products/135_b2bd7823.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 480, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 09:22:32', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(136, 21, NULL, NULL, 'Rock Climbing & Via Ferrata Tour in Bohemian Switzerland', 'Rock Climbing & Via Ferrata Tour in Bohemian Switzerland', NULL, 'products/136_bb45d06b.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 480, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 12:18:31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, '[\"bus\",\"walking\",\"transfer\",\"guide\",\"smallgroup\",\"nature\",\"hotelpickup\"]'),
(137, 21, NULL, NULL, 'Winter Fairy Tale: Winter Hiking in Bohemian & Saxon Switzerland', 'Winter Fairy Tale: Winter Hiking in Bohemian & Saxon Switzerland', NULL, 'products/137_835942e5.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 600, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 09:27:52', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(138, 21, NULL, NULL, 'Cross-Country Skiing Guided Tour from Prague', 'Cross-Country Skiing Guided Tour from Prague', NULL, 'products/138_6c844595.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 480, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 09:28:43', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(139, 21, NULL, NULL, 'Downhill Skiing & Snowboarding Tour', 'Downhill Skiing & Snowboarding Tour', NULL, 'products/139_834e2bcc.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 480, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 09:28:49', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(140, 21, NULL, NULL, 'Private Day Trip of Bohemian & Saxon Switzerland (up to 16)', 'Private Day Trip of Bohemian & Saxon Switzerland (up to 16)', NULL, 'products/140_f80520dc.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 600, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 09:27:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Private group price (up to 16 people). Fully customizable itinerary.', NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(141, 21, NULL, NULL, 'Overnight Bohemian Switzerland Tour with Wellness Stay', 'Overnight Bohemian Switzerland Tour with Wellness Stay', NULL, 'products/141_623175c1.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1440, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 09:26:35', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Overnight tour with wellness stay at Bohemian Homes (1–12 guests).', NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(142, 21, NULL, NULL, 'Luxury Wood Cabin Stay with Private Tour of Bohemian Switzerland', 'Luxury Wood Cabin Stay with Private Tour of Bohemian Switzerland', NULL, 'products/142_b33d584e.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1440, 'on_demand', 'direct_entry', 'date_required', 1, 1, 1, NULL, NULL, 'active', 0, '2026-06-02 13:11:36', '2026-06-06 09:26:23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Private tour with luxury wood-cabin accommodation and wellness.', NULL, 'Free cancellation up to 24 hours before the tour.', NULL, 'Hotel pickup in Prague included; exact time confirmed by the agency.', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL);
INSERT INTO `products` (`id`, `agency_id`, `commission_pct`, `seller_bonus_pct`, `name_cs`, `name_en`, `name_de`, `image_path`, `variant_diagram_path`, `description_cs`, `description_en`, `description_de`, `languages`, `languages_en`, `order_instructions`, `order_instructions_en`, `booking_url`, `has_contingent`, `duration_minutes`, `schedule_type`, `voucher_redemption_type`, `ticket_type`, `pickup_available`, `pickup_required`, `pickup_free`, `pickup_window_minutes`, `pickup_confirmation`, `status`, `is_featured`, `created_at`, `updated_at`, `deposit_fixed_czk`, `deposit_fixed_eur`, `meeting_point_address`, `meeting_point_address_en`, `map_url`, `included`, `included_en`, `excluded`, `excluded_en`, `what_to_bring`, `what_to_bring_en`, `important_info`, `important_info_en`, `cancellation_policy`, `cancellation_policy_en`, `meeting_point_note`, `meeting_point_note_en`, `meeting_options`, `meeting_options_en`, `seating`, `addons`, `seat_map_svg`, `language_options`, `attributes`) VALUES
(143, 5, NULL, NULL, 'Nutcracker Ballet', NULL, NULL, 'products/48_43929c18.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 150, 'multiple_daily', 'direct_entry', 'date_required', 0, 0, 1, NULL, NULL, 'active', 0, '2026-06-06 15:56:14', '2026-06-06 15:56:14', NULL, NULL, 'Broadway Theatre, Na Příkopě 31, Praha 1', NULL, NULL, 'Show admission', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Broadway passage (entrance from Na Příkopě 31 or Celetná 38). Show your voucher at the box office.', NULL, NULL, NULL, 1, NULL, '<svg viewBox=\"0 0 340 380\" width=\"100%\" xmlns=\"http://www.w3.org/2000/svg\" font-family=\"sans-serif\"><rect x=\"40\" y=\"8\" width=\"260\" height=\"24\" rx=\"4\" fill=\"#222222\"/><text x=\"170\" y=\"24\" fill=\"#ffffff\" font-size=\"12\" text-anchor=\"middle\">JEVIŠTĚ</text><rect x=\"40\" y=\"40\" width=\"260\" height=\"32\" rx=\"5\" fill=\"#2C6FB5\"/><text x=\"170\" y=\"60\" fill=\"#ffffff\" font-size=\"12.5\" text-anchor=\"middle\">KAT. A · řada 1–4</text><rect x=\"40\" y=\"76\" width=\"260\" height=\"32\" rx=\"5\" fill=\"#C9A227\"/><text x=\"170\" y=\"96\" fill=\"#1a1a2e\" font-size=\"12.5\" text-anchor=\"middle\">VIP · řada 5–10</text><rect x=\"40\" y=\"112\" width=\"260\" height=\"32\" rx=\"5\" fill=\"#2C6FB5\"/><text x=\"170\" y=\"132\" fill=\"#ffffff\" font-size=\"12.5\" text-anchor=\"middle\">KAT. A · řada 11–15</text><rect x=\"40\" y=\"148\" width=\"260\" height=\"32\" rx=\"5\" fill=\"#3E9B6E\"/><text x=\"170\" y=\"168\" fill=\"#ffffff\" font-size=\"12.5\" text-anchor=\"middle\">KAT. B · řada 16–20</text><rect x=\"40\" y=\"184\" width=\"260\" height=\"32\" rx=\"5\" fill=\"#8A8F98\"/><text x=\"170\" y=\"204\" fill=\"#ffffff\" font-size=\"12.5\" text-anchor=\"middle\">KAT. C · řada 21–26</text><text x=\"170\" y=\"232\" fill=\"#555555\" font-size=\"11\" text-anchor=\"middle\">— BALKÓN —</text><rect x=\"40\" y=\"240\" width=\"260\" height=\"32\" rx=\"5\" fill=\"#3E9B6E\"/><text x=\"170\" y=\"260\" fill=\"#ffffff\" font-size=\"12.5\" text-anchor=\"middle\">KAT. B · balkón řada 1–7</text><rect x=\"40\" y=\"292\" width=\"14\" height=\"14\" rx=\"3\" fill=\"#C9A227\"/><text x=\"62\" y=\"304\" fill=\"#1a1a2e\" font-size=\"11.5\">VIP — 1450 Kč</text><rect x=\"40\" y=\"312\" width=\"14\" height=\"14\" rx=\"3\" fill=\"#2C6FB5\"/><text x=\"62\" y=\"324\" fill=\"#1a1a2e\" font-size=\"11.5\">Kategorie A — 1250 Kč</text><rect x=\"40\" y=\"332\" width=\"14\" height=\"14\" rx=\"3\" fill=\"#3E9B6E\"/><text x=\"62\" y=\"344\" fill=\"#1a1a2e\" font-size=\"11.5\">Kategorie B — 1050 Kč</text><rect x=\"40\" y=\"352\" width=\"14\" height=\"14\" rx=\"3\" fill=\"#8A8F98\"/><text x=\"62\" y=\"364\" fill=\"#1a1a2e\" font-size=\"11.5\">Kategorie C — 850 Kč</text></svg>', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabulky `product_categories`
--

DROP TABLE IF EXISTS `product_categories`;
CREATE TABLE `product_categories` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `product_categories`
--

INSERT INTO `product_categories` (`product_id`, `category_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 7),
(9, 7),
(10, 7),
(11, 7),
(12, 7),
(13, 7),
(14, 7),
(15, 7),
(16, 7),
(17, 7),
(18, 7),
(19, 7),
(20, 7),
(21, 7),
(22, 7),
(23, 7),
(24, 1),
(25, 7),
(26, 7),
(27, 7),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 7),
(35, 7),
(36, 7),
(37, 7),
(38, 7),
(39, 1),
(40, 1),
(41, 3),
(42, 7),
(43, 7),
(44, 7),
(45, 7),
(46, 1),
(47, 7),
(48, 4),
(49, 4),
(50, 4),
(51, 4),
(52, 4),
(53, 4),
(54, 4),
(55, 4),
(56, 4),
(57, 4),
(58, 4),
(59, 6),
(60, 6),
(61, 6),
(62, 6),
(63, 6),
(64, 6),
(65, 2),
(65, 8),
(66, 8),
(67, 8),
(68, 2),
(69, 2),
(70, 2),
(71, 2),
(72, 3),
(73, 3),
(74, 3),
(75, 3),
(76, 3),
(77, 3),
(78, 6),
(79, 3),
(79, 6),
(80, 6),
(81, 3),
(82, 6),
(83, 6),
(84, 4),
(85, 4),
(86, 4),
(87, 4),
(88, 6),
(89, 9),
(90, 9),
(91, 9),
(92, 9),
(93, 9),
(94, 9),
(95, 9),
(96, 9),
(97, 9),
(98, 9),
(99, 9),
(100, 9),
(101, 9),
(102, 9),
(103, 2),
(104, 2),
(105, 2),
(106, 2),
(107, 2),
(108, 2),
(108, 3),
(109, 2),
(110, 1),
(110, 9),
(111, 2),
(112, 2),
(113, 2),
(114, 1),
(114, 9),
(115, 5),
(116, 5),
(117, 5),
(118, 1),
(123, 7),
(123, 9),
(136, 7),
(136, 9),
(143, 4);

-- --------------------------------------------------------

--
-- Struktura tabulky `product_pins`
--

DROP TABLE IF EXISTS `product_pins`;
CREATE TABLE `product_pins` (
  `id` int(10) UNSIGNED NOT NULL,
  `context_type` varchar(16) NOT NULL,
  `context_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `sort_weight` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Vypisuji data pro tabulku `product_pins`
--

INSERT INTO `product_pins` (`id`, `context_type`, `context_id`, `product_id`, `sort_weight`, `created_at`) VALUES
(1, 'category', 3, 77, 10, '2026-06-03 16:43:49'),
(2, 'category', 3, 72, 1, '2026-06-03 16:43:49'),
(3, 'category', 3, 81, 2, '2026-06-03 16:43:49'),
(4, 'category', 1, 118, 1, '2026-06-03 20:17:53'),
(5, 'category', 1, 5, 2, '2026-06-03 20:17:53'),
(6, 'category', 8, 65, 2, '2026-06-03 20:21:13'),
(7, 'category', 8, 66, 1, '2026-06-03 20:21:13'),
(8, 'category', 8, 67, 3, '2026-06-03 20:21:13'),
(9, 'category', 9, 92, 5, '2026-06-03 20:47:22'),
(10, 'category', 9, 110, 4, '2026-06-03 20:47:22'),
(11, 'category', 9, 114, 3, '2026-06-03 20:47:22'),
(12, 'category', 9, 99, 6, '2026-06-03 20:47:22'),
(13, 'category', 9, 89, 1, '2026-06-03 20:47:22'),
(14, 'category', 9, 90, 2, '2026-06-03 20:47:22');

-- --------------------------------------------------------

--
-- Struktura tabulky `product_schedules`
--

DROP TABLE IF EXISTS `product_schedules`;
CREATE TABLE `product_schedules` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `season_from` date DEFAULT NULL,
  `season_to` date DEFAULT NULL,
  `days_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`days_json`)),
  `times_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`times_json`)),
  `open_start` time DEFAULT NULL,
  `open_end` time DEFAULT NULL,
  `frequency_min` int(10) UNSIGNED DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `product_schedules`
--

INSERT INTO `product_schedules` (`id`, `product_id`, `season_from`, `season_to`, `days_json`, `times_json`, `open_start`, `open_end`, `frequency_min`, `sort_order`, `status`) VALUES
(1, 78, NULL, NULL, NULL, '[\"12:00\"]', NULL, NULL, NULL, 0, 'active'),
(2, 81, NULL, NULL, NULL, NULL, '10:00:00', '20:00:00', 15, 0, 'active'),
(5, 9, NULL, NULL, '[1,3,5,7]', '[\"08:45\"]', NULL, NULL, NULL, 0, 'active'),
(6, 49, NULL, NULL, '[6]', '[\"17:00\"]', NULL, NULL, NULL, 0, 'active'),
(9, 73, NULL, NULL, NULL, '[\"12:00\", \"15:00\"]', NULL, NULL, NULL, 0, 'active'),
(10, 79, NULL, NULL, NULL, '[\"19:00\"]', NULL, NULL, NULL, 0, 'active'),
(11, 84, NULL, NULL, '[1, 4]', '[\"20:00\"]', NULL, NULL, NULL, 0, 'active'),
(12, 85, NULL, NULL, '[2, 7]', '[\"20:00\"]', NULL, NULL, NULL, 0, 'active'),
(13, 87, NULL, NULL, '[3]', '[\"20:00\"]', NULL, NULL, NULL, 0, 'active'),
(14, 103, NULL, NULL, NULL, '[\"15:00\"]', NULL, NULL, NULL, 0, 'active'),
(15, 104, NULL, NULL, NULL, '[\"18:00\"]', NULL, NULL, NULL, 0, 'active'),
(16, 105, NULL, NULL, NULL, '[\"10:30\", \"15:30\"]', NULL, NULL, NULL, 0, 'active'),
(17, 106, NULL, NULL, NULL, '[\"10:30\", \"15:30\"]', NULL, NULL, NULL, 0, 'active'),
(18, 107, NULL, NULL, NULL, '[\"10:00\", \"17:00\"]', NULL, NULL, NULL, 0, 'active'),
(19, 108, NULL, NULL, NULL, '[\"13:30\"]', NULL, NULL, NULL, 0, 'active'),
(20, 110, NULL, NULL, NULL, '[\"10:00\", \"17:00\"]', NULL, NULL, NULL, 0, 'active'),
(21, 111, NULL, NULL, NULL, '[\"10:00\", \"17:00\"]', NULL, NULL, NULL, 0, 'active'),
(22, 112, NULL, NULL, NULL, '[\"15:00\"]', NULL, NULL, NULL, 0, 'active'),
(23, 113, NULL, NULL, NULL, '[\"10:00\"]', NULL, NULL, NULL, 0, 'active'),
(24, 114, NULL, NULL, NULL, '[\"10:00\", \"17:00\"]', NULL, NULL, NULL, 0, 'active'),
(25, 115, NULL, NULL, NULL, '[\"20:00\"]', NULL, NULL, NULL, 0, 'active'),
(26, 116, NULL, NULL, NULL, '[\"20:00\"]', NULL, NULL, NULL, 0, 'active'),
(27, 32, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"Bus Stop A 10:30 / Bus Stop B 10:45\",\"Bus Stop A 11:30 / Bus Stop B 11:45\",\"Bus Stop A 13:45 / Bus Stop B 14:00\",\"Bus Stop A 16:00 / Bus Stop B 16:15\"]', NULL, NULL, NULL, 0, 'active'),
(28, 42, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"Bus Stop A 10:30 / Bus Stop B 10:45\",\"Bus Stop A 11:30 / Bus Stop B 11:45\",\"Bus Stop A 13:45 / Bus Stop B 14:00\",\"Bus Stop A 16:00 / Bus Stop B 16:15\"]', NULL, NULL, NULL, 0, 'active'),
(29, 43, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"Bus Stop A 12:45 / Bus Stop B 13:00\",\"Bus Stop A 14:30 / Bus Stop B 14:45\",\"Bus Stop A 16:00 / Bus Stop B 16:15\"]', NULL, NULL, NULL, 0, 'active'),
(30, 44, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"Bus Stop A 12:45 / Bus Stop B 13:00\",\"Bus Stop A 14:30 / Bus Stop B 14:45\",\"Bus Stop A 16:00 / Bus Stop B 16:15\"]', NULL, NULL, NULL, 0, 'active'),
(31, 45, NULL, NULL, '[3,5]', '[\"Bus Stop A 10:45 / Bus Stop B 10:30\"]', NULL, NULL, NULL, 0, 'active'),
(32, 39, NULL, NULL, '[4,6]', '[\"Bus Stop A 10:45 / Bus Stop B 10:30\"]', NULL, NULL, NULL, 0, 'active'),
(33, 33, NULL, NULL, '[5]', '[\"Bus Stop A 10:45 / Bus Stop B 10:30\"]', NULL, NULL, NULL, 0, 'active'),
(34, 41, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"Bus Stop A 13:45 / Bus Stop B 13:30\",\"Bus Stop A 15:45 / Bus Stop B 15:30\"]', NULL, NULL, NULL, 0, 'active'),
(35, 46, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"11:30\"]', NULL, NULL, NULL, 0, 'active'),
(36, 47, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"18:30\"]', NULL, NULL, NULL, 0, 'active'),
(37, 36, NULL, NULL, '[3,5]', '[\"Bus Stop A 09:45 / Bus Stop B 09:30\"]', NULL, NULL, NULL, 0, 'active'),
(38, 35, '2026-04-01', '2026-10-31', '[7]', '[\"Bus Stop A 10:00 / Bus Stop B 09:45\"]', NULL, NULL, NULL, 0, 'active'),
(39, 37, NULL, NULL, '[2,4,6]', '[\"Bus Stop A 12:30 / Bus Stop B 12:45\"]', NULL, NULL, NULL, 0, 'active'),
(40, 34, NULL, NULL, '[2,4,6]', '[\"Bus Stop A 09:15 / Bus Stop B 09:00\"]', NULL, NULL, NULL, 0, 'active'),
(41, 38, NULL, NULL, '[1,3,5,7]', '[\"Bus Stop A 12:00 / Bus Stop B 12:15\"]', NULL, NULL, NULL, 0, 'active'),
(51, 72, NULL, NULL, NULL, '[\"11:30\",\"12:00\",\"12:30\",\"13:00\",\"13:30\",\"14:00\",\"14:30\",\"15:00\",\"15:30\",\"16:00\",\"16:30\",\"17:00\",\"17:30\",\"18:00\",\"18:30\",\"19:00\",\"19:30\",\"20:00\",\"20:30\",\"21:00\",\"21:30\",\"22:00\"]', NULL, NULL, NULL, 0, 'active'),
(53, 75, NULL, NULL, NULL, '[\"20:00\",\"21:00\",\"22:00\"]', NULL, NULL, NULL, 0, 'active'),
(54, 80, NULL, NULL, NULL, '[\"19:00\"]', NULL, NULL, NULL, 0, 'active'),
(55, 65, '2000-06-01', '2000-08-31', '[2,4,6,7]', '[\"19:00 (EN)\"]', NULL, NULL, NULL, 0, 'active'),
(56, 65, '2000-09-01', '2000-05-31', '[2,4,6,7]', '[\"18:00 (EN)\"]', NULL, NULL, NULL, 1, 'active'),
(57, 65, '2000-06-01', '2000-08-31', '[4,6]', '[\"19:00 (DE)\"]', NULL, NULL, NULL, 2, 'active'),
(58, 65, '2000-09-01', '2000-05-31', '[4,6]', '[\"18:00 (DE)\"]', NULL, NULL, NULL, 3, 'active'),
(59, 66, '2000-05-01', '2000-09-30', '[1,2,3,4,5,6,7]', '[\"20:30 (EN)\"]', NULL, NULL, NULL, 0, 'active'),
(60, 66, '2000-10-01', '2000-04-30', '[1,2,3,4,5,6,7]', '[\"19:30 (EN)\"]', NULL, NULL, NULL, 1, 'active'),
(61, 66, NULL, NULL, '[3,6]', '[\"20:00 (DE)\"]', NULL, NULL, NULL, 2, 'active'),
(62, 67, NULL, NULL, '[3,7]', '[\"14:00\"]', NULL, NULL, NULL, 0, 'active'),
(63, 68, NULL, NULL, '[2,4,6,7]', '[\"13:30\"]', NULL, NULL, NULL, 0, 'active'),
(64, 69, NULL, NULL, '[2,4,6,7]', '[\"14:00\"]', NULL, NULL, NULL, 0, 'active'),
(65, 70, NULL, NULL, '[2,4,6,7]', '[\"10:30\"]', NULL, NULL, NULL, 0, 'active'),
(66, 71, NULL, NULL, '[2,4,6,7]', '[\"10:30\"]', NULL, NULL, NULL, 0, 'active'),
(67, 18, NULL, NULL, '[2,4,6]', '[\"09:30\"]', NULL, NULL, NULL, 0, 'active'),
(68, 19, NULL, NULL, '[2,4,6,7]', '[\"09:30\"]', NULL, NULL, NULL, 0, 'active'),
(69, 20, NULL, NULL, '[1,3,5,7]', '[\"09:30\"]', NULL, NULL, NULL, 0, 'active'),
(70, 21, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"12:30\"]', NULL, NULL, NULL, 0, 'active'),
(71, 22, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"09:30\"]', NULL, NULL, NULL, 0, 'active'),
(72, 23, NULL, NULL, '[2,4,6,7]', '[\"09:30\"]', NULL, NULL, NULL, 0, 'active'),
(73, 24, NULL, NULL, '[2,4,6,7]', '[\"09:30\"]', NULL, NULL, NULL, 0, 'active'),
(74, 25, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"10:30\"]', NULL, NULL, NULL, 0, 'active'),
(75, 26, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"19:00\"]', NULL, NULL, NULL, 0, 'active'),
(76, 27, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"18:00\"]', NULL, NULL, NULL, 0, 'active'),
(77, 28, NULL, NULL, '[1,2,3,4,5,7]', '[\"10:30\"]', NULL, NULL, NULL, 0, 'active'),
(78, 5, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"10:00\",\"14:00\"]', NULL, NULL, NULL, 0, 'active'),
(79, 6, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"10:15\",\"14:15\"]', NULL, NULL, NULL, 0, 'active'),
(80, 7, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"14:30\"]', NULL, NULL, NULL, 0, 'active'),
(81, 8, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"11:00\"]', NULL, NULL, NULL, 0, 'active'),
(82, 10, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"18:30 (nástup, odjezd 18:50)\"]', NULL, NULL, NULL, 0, 'active'),
(83, 11, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"08:45\"]', NULL, NULL, NULL, 0, 'active'),
(84, 12, NULL, NULL, '[1,3,5,7]', '[\"08:45\"]', NULL, NULL, NULL, 0, 'active'),
(85, 13, NULL, NULL, '[1,3,5,7]', '[\"08:45\"]', NULL, NULL, NULL, 0, 'active'),
(86, 14, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"08:45\"]', NULL, NULL, NULL, 0, 'active'),
(87, 15, NULL, NULL, '[1,3,6]', '[\"08:45\"]', NULL, NULL, NULL, 0, 'active'),
(88, 16, NULL, NULL, '[1,3,6]', '[\"08:45\"]', NULL, NULL, NULL, 0, 'active'),
(89, 48, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"17:00\",\"19:00\"]', NULL, NULL, NULL, 0, 'active'),
(90, 57, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"20:00\"]', NULL, NULL, NULL, 0, 'active'),
(91, 58, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"20:00\"]', NULL, NULL, NULL, 0, 'active'),
(92, 86, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"20:00\"]', NULL, NULL, NULL, 0, 'active'),
(93, 82, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"16:30\"]', NULL, NULL, NULL, 0, 'active'),
(94, 83, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"20:00\"]', NULL, NULL, NULL, 0, 'active'),
(95, 59, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"19:00\"]', NULL, NULL, NULL, 0, 'active'),
(96, 88, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"19:00\"]', NULL, NULL, NULL, 0, 'active'),
(97, 121, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"09:30\",\"15:30\"]', NULL, NULL, NULL, 0, 'active'),
(98, 109, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"15:00\"]', NULL, NULL, NULL, 0, 'active'),
(99, 122, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"10:00\"]', NULL, NULL, NULL, 0, 'active'),
(100, 117, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"20:00\",\"21:30\"]', NULL, NULL, NULL, 0, 'active'),
(101, 76, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"10:00\",\"10:30\",\"11:00\",\"11:30\",\"12:00\",\"12:30\",\"13:00\",\"13:30\",\"14:00\",\"14:30\",\"15:00\",\"15:30\",\"16:00\",\"16:30\",\"17:00\",\"17:30\",\"18:00\",\"18:30\",\"19:00\",\"19:20\",\"19:40\",\"20:20\",\"20:40\",\"21:00\",\"21:20\",\"21:40\",\"22:00\"]', NULL, NULL, NULL, 0, 'active'),
(102, 77, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"10:15\",\"11:15\",\"12:15\",\"13:15\",\"14:15\",\"15:15\",\"16:15\",\"17:15\",\"18:15\",\"19:15\",\"20:15\"]', NULL, NULL, NULL, 0, 'active'),
(103, 74, NULL, NULL, '[1,2,3,4,5,6,7]', '[\"17:30\",\"18:00\",\"19:30\",\"20:00\",\"20:30\",\"21:00\",\"21:30\",\"22:00\"]', NULL, NULL, NULL, 0, 'active');

-- --------------------------------------------------------

--
-- Struktura tabulky `refunds`
--

DROP TABLE IF EXISTS `refunds`;
CREATE TABLE `refunds` (
  `id` int(10) UNSIGNED NOT NULL,
  `sale_id` int(10) UNSIGNED NOT NULL,
  `actor_type` enum('seller','admin','system') NOT NULL,
  `actor_id` int(10) UNSIGNED DEFAULT NULL,
  `approved_by_admin_id` int(10) UNSIGNED DEFAULT NULL,
  `kind` enum('partial','full') NOT NULL DEFAULT 'partial',
  `amount_czk` decimal(10,2) NOT NULL,
  `amount_eur` decimal(10,2) DEFAULT NULL,
  `commission_reversed_czk` decimal(10,2) DEFAULT NULL,
  `reason` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `sales`
--

DROP TABLE IF EXISTS `sales`;
CREATE TABLE `sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `tenant_id` int(10) UNSIGNED NOT NULL,
  `station_id` int(10) UNSIGNED DEFAULT NULL,
  `seller_id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED DEFAULT NULL,
  `voucher_number` varchar(24) DEFAULT NULL,
  `status` enum('draft','paid','cancelled','refunded') NOT NULL DEFAULT 'draft',
  `total_czk` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_eur` decimal(10,2) DEFAULT NULL,
  `payment_method` enum('cash','card') DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_deposit` tinyint(1) NOT NULL DEFAULT 0,
  `paid_czk` decimal(10,2) DEFAULT NULL,
  `paid_eur` decimal(10,2) DEFAULT NULL,
  `balance_czk` decimal(10,2) DEFAULT NULL,
  `balance_eur` decimal(10,2) DEFAULT NULL,
  `pin` varchar(8) DEFAULT NULL,
  `refunded_czk` decimal(10,2) NOT NULL DEFAULT 0.00,
  `refunded_eur` decimal(10,2) DEFAULT NULL,
  `cancelled_at` datetime DEFAULT NULL,
  `cancel_reason` varchar(255) DEFAULT NULL,
  `reservation_done_at` datetime DEFAULT NULL,
  `reservation_ref` varchar(120) DEFAULT NULL,
  `public_token` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `sales`
--

INSERT INTO `sales` (`id`, `tenant_id`, `station_id`, `seller_id`, `customer_id`, `voucher_number`, `status`, `total_czk`, `total_eur`, `payment_method`, `note`, `paid_at`, `created_at`, `updated_at`, `is_deposit`, `paid_czk`, `paid_eur`, `balance_czk`, `balance_eur`, `pin`, `refunded_czk`, `refunded_eur`, `cancelled_at`, `cancel_reason`, `reservation_done_at`, `reservation_ref`, `public_token`) VALUES
(1, 1, NULL, 1, NULL, 'PTI-2026-000001', 'paid', 1300.00, 52.00, 'cash', NULL, '2026-06-01 17:45:37', '2026-06-01 17:45:37', '2026-06-01 17:45:37', 0, NULL, NULL, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 1, NULL, 1, 1, 'PTI-2026-000002', 'paid', 780.00, 31.00, 'card', NULL, '2026-06-01 17:54:43', '2026-06-01 17:54:43', '2026-06-01 17:54:43', 0, 780.00, 31.00, 0.00, 0.00, NULL, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 1, NULL, 1, 2, 'PTI-2026-000003', 'paid', 780.00, 31.00, 'cash', NULL, '2026-06-01 17:57:20', '2026-06-01 17:57:20', '2026-06-01 17:57:20', 0, 780.00, 31.00, 0.00, 0.00, NULL, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 1, NULL, 1, 3, 'PTI-2026-000004', 'paid', 1300.00, 52.00, 'card', NULL, '2026-06-01 19:54:32', '2026-06-01 19:54:32', '2026-06-01 19:54:32', 0, 1300.00, 52.00, 0.00, 0.00, NULL, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 1, NULL, 1, 4, 'PTI-2026-000005', 'paid', 900.00, 36.00, 'cash', NULL, '2026-06-01 20:00:51', '2026-06-01 20:00:51', '2026-06-01 20:00:51', 0, 900.00, 36.00, 0.00, 0.00, NULL, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 1, NULL, 1, NULL, 'PTI-2026-000006', 'paid', 1600.00, 64.00, 'card', NULL, '2026-06-01 20:04:25', '2026-06-01 20:04:25', '2026-06-01 20:04:25', 0, 1600.00, 64.00, 0.00, 0.00, NULL, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 1, NULL, 1, 5, 'PTI-2026-000007', 'paid', 3960.00, 158.00, 'cash', NULL, '2026-06-01 20:06:40', '2026-06-01 20:06:40', '2026-06-01 20:06:40', 0, 3960.00, 158.00, 0.00, 0.00, NULL, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 1, NULL, 1, 6, 'PTI-2026-000008', 'paid', 7380.00, 294.00, 'card', NULL, '2026-06-01 21:12:52', '2026-06-01 21:12:52', '2026-06-01 21:12:52', 0, 7380.00, 294.00, 0.00, 0.00, NULL, 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 1, NULL, 1, 7, 'PTI-2026-000009', 'paid', 1400.00, 56.00, 'card', NULL, '2026-06-02 13:20:12', '2026-06-02 13:20:12', '2026-06-02 13:20:12', 0, 1400.00, 56.00, 0.00, 0.00, '5629', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 1, NULL, 1, 8, 'PTI-2026-000010', 'paid', 3000.00, 120.00, 'card', NULL, '2026-06-02 15:13:28', '2026-06-02 15:13:28', '2026-06-02 15:13:28', 0, 3000.00, 120.00, 0.00, 0.00, '0091', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 1, NULL, 1, 9, 'PTI-2026-000011', 'paid', 900.00, 36.00, 'card', NULL, '2026-06-02 16:15:54', '2026-06-02 16:15:54', '2026-06-02 16:15:54', 0, 900.00, 36.00, 0.00, 0.00, '3235', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 1, NULL, 1, 10, 'PTI-2026-000012', 'paid', 3425.00, 137.00, 'cash', NULL, '2026-06-02 17:17:12', '2026-06-02 17:17:12', '2026-06-02 17:17:12', 0, 3425.00, 137.00, 0.00, 0.00, '8699', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 1, NULL, 1, 11, 'PTI-2026-000013', 'cancelled', 6460.00, 258.00, 'cash', NULL, '2026-06-02 17:21:50', '2026-06-02 17:21:50', '2026-06-02 17:22:04', 0, 6460.00, 258.00, 0.00, 0.00, '6621', 0.00, NULL, '2026-06-02 17:22:04', 'Debil', NULL, NULL, NULL),
(14, 1, NULL, 1, NULL, 'PTI-2026-000014', 'paid', 3120.00, 124.00, 'card', NULL, '2026-06-02 17:24:56', '2026-06-02 17:24:56', '2026-06-02 17:24:56', 0, 3120.00, 124.00, 0.00, 0.00, '3824', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(15, 1, NULL, 1, 12, 'PTI-2026-000015', 'paid', 11700.00, 468.00, 'card', NULL, '2026-06-02 17:26:06', '2026-06-02 17:26:06', '2026-06-02 17:26:06', 0, 11700.00, 468.00, 0.00, 0.00, '7772', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(16, 1, NULL, 1, 13, 'PTI-2026-000016', 'paid', 2800.00, 112.00, 'card', NULL, '2026-06-02 17:27:35', '2026-06-02 17:27:35', '2026-06-02 17:27:35', 0, 2800.00, 112.00, 0.00, 0.00, '3690', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(17, 1, NULL, 1, 14, 'PTI-2026-000017', 'paid', 2350.00, 94.00, 'cash', NULL, '2026-06-02 18:15:50', '2026-06-02 18:15:50', '2026-06-02 18:15:50', 0, 2350.00, 94.00, 0.00, 0.00, '4036', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(18, 1, NULL, 1, 15, 'PTI-2026-000018', 'paid', 1980.00, 79.00, 'card', NULL, '2026-06-02 18:35:21', '2026-06-02 18:35:21', '2026-06-02 18:35:21', 0, 1980.00, 79.00, 0.00, 0.00, '0516', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 1, NULL, 1, 16, 'PTI-2026-000019', 'paid', 1560.00, 62.00, 'cash', NULL, '2026-06-02 18:45:54', '2026-06-02 18:45:54', '2026-06-02 18:45:54', 0, 1560.00, 62.00, 0.00, 0.00, '9618', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 1, NULL, 1, 17, 'PTI-2026-000020', 'paid', 3800.00, 150.00, 'card', NULL, '2026-06-02 18:58:07', '2026-06-02 18:58:07', '2026-06-02 18:58:07', 0, 3800.00, 150.00, 0.00, 0.00, '9260', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(21, 1, NULL, 1, 18, 'PTI-2026-000021', 'paid', 3060.00, 122.40, 'card', NULL, '2026-06-02 19:02:32', '2026-06-02 19:02:32', '2026-06-02 19:02:32', 0, 3060.00, 122.40, 0.00, 0.00, '4852', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(22, 1, NULL, 1, 19, 'PTI-2026-000022', 'paid', 1950.00, 78.00, 'card', NULL, '2026-06-02 19:06:27', '2026-06-02 19:06:27', '2026-06-02 19:06:27', 0, 1950.00, 78.00, 0.00, 0.00, '4392', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(23, 1, NULL, 1, 20, 'PTI-2026-000023', 'paid', 900.00, 36.00, 'card', NULL, '2026-06-02 20:04:29', '2026-06-02 20:04:29', '2026-06-02 20:04:29', 0, 900.00, 36.00, 0.00, 0.00, '7655', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(24, 1, NULL, 1, 21, 'PTI-2026-000024', 'paid', 1700.00, 68.00, 'card', NULL, '2026-06-03 11:58:04', '2026-06-03 11:58:04', '2026-06-03 11:58:04', 1, 600.00, 24.00, 1100.00, 44.00, '3584', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(25, 1, NULL, 1, 22, 'PTI-2026-000025', 'paid', 9180.00, 368.00, 'card', NULL, '2026-06-03 14:14:49', '2026-06-03 14:14:49', '2026-06-03 14:14:49', 0, 9180.00, 368.00, 0.00, 0.00, '9309', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(26, 1, NULL, 1, 23, 'PTI-2026-000026', 'paid', 13860.00, 553.00, 'card', NULL, '2026-06-03 14:16:34', '2026-06-03 14:16:34', '2026-06-03 14:16:34', 0, 13860.00, 553.00, 0.00, 0.00, '6722', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(27, 1, NULL, 1, 24, 'PTI-2026-000027', 'paid', 2340.00, 93.00, 'card', NULL, '2026-06-03 14:41:46', '2026-06-03 14:41:46', '2026-06-03 14:41:46', 0, 2340.00, 93.00, 0.00, 0.00, '0270', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(28, 1, NULL, 1, 25, 'PTI-2026-000028', 'paid', 1800.00, 72.00, 'cash', NULL, '2026-06-03 14:43:16', '2026-06-03 14:43:16', '2026-06-03 14:43:16', 0, 1800.00, 72.00, 0.00, 0.00, '6660', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(29, 1, NULL, 1, 26, 'PTI-2026-000029', 'paid', 9360.00, 372.00, 'card', NULL, '2026-06-03 15:33:39', '2026-06-03 15:33:39', '2026-06-03 15:33:39', 0, 9360.00, 372.00, 0.00, 0.00, '5425', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(30, 1, NULL, 1, 27, 'PTI-2026-000030', 'paid', 32300.00, 1290.00, 'card', NULL, '2026-06-03 15:35:51', '2026-06-03 15:35:51', '2026-06-03 15:35:51', 0, 32300.00, 1290.00, 0.00, 0.00, '5801', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(31, 1, NULL, 1, 28, 'PTI-2026-000031', 'paid', 1950.00, 78.00, 'card', NULL, '2026-06-03 17:08:04', '2026-06-03 17:08:04', '2026-06-03 17:08:04', 0, 1950.00, 78.00, 0.00, 0.00, '3838', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(32, 1, NULL, 1, 29, 'PTI-2026-000032', 'paid', 5925.00, 237.00, 'card', NULL, '2026-06-03 17:26:47', '2026-06-03 17:26:47', '2026-06-03 17:26:47', 0, 5925.00, 237.00, 0.00, 0.00, '9484', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(33, 1, NULL, 1, 30, 'PTI-2026-000033', 'paid', 6500.00, 260.00, 'cash', NULL, '2026-06-03 20:01:12', '2026-06-03 20:01:12', '2026-06-03 20:01:12', 0, 6500.00, 260.00, 0.00, 0.00, '2186', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(34, 1, NULL, 1, 31, 'PTI-2026-000034', 'paid', 3600.00, 144.00, 'card', NULL, '2026-06-03 20:08:31', '2026-06-03 20:08:31', '2026-06-03 20:08:31', 0, 3600.00, 144.00, 0.00, 0.00, '6704', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(35, 1, NULL, 1, 32, 'PTI-2026-000035', 'paid', 12250.00, 490.00, 'cash', NULL, '2026-06-03 21:00:02', '2026-06-03 21:00:02', '2026-06-03 21:00:02', 0, 12250.00, 490.00, 0.00, 0.00, '0697', 0.00, NULL, NULL, NULL, NULL, NULL, NULL),
(39, 1, NULL, 1, 36, 'PTI-2026-000036', 'paid', 4200.00, 168.00, 'cash', NULL, '2026-06-04 07:15:42', '2026-06-04 07:15:42', '2026-06-04 09:51:54', 0, 4200.00, 168.00, 0.00, 0.00, '4803', 0.00, NULL, NULL, NULL, '2026-06-04 09:51:54', NULL, NULL),
(40, 1, NULL, 1, 37, 'PTI-2026-000037', 'paid', 3800.00, 152.00, 'card', NULL, '2026-06-04 09:03:43', '2026-06-04 09:03:43', '2026-06-04 09:52:05', 0, 3800.00, 152.00, 0.00, 0.00, '4967', 0.00, NULL, NULL, NULL, '2026-06-04 09:52:05', NULL, NULL),
(41, 1, NULL, 1, 38, 'PTI-2026-000038', 'paid', 700.00, 28.00, 'card', NULL, '2026-06-04 09:25:05', '2026-06-04 09:25:05', '2026-06-04 10:25:04', 0, 700.00, 28.00, 0.00, 0.00, '4273', 0.00, NULL, NULL, NULL, '2026-06-04 10:25:04', NULL, NULL),
(42, 1, NULL, 1, 39, 'PTI-2026-000039', 'paid', 2600.00, 104.00, 'card', NULL, '2026-06-04 10:18:13', '2026-06-04 10:18:13', '2026-06-04 10:25:11', 0, 2600.00, 104.00, 0.00, 0.00, '9186', 0.00, NULL, NULL, NULL, '2026-06-04 10:25:11', NULL, NULL),
(43, 1, NULL, 1, 40, 'PTI-2026-000040', 'paid', 3900.00, 156.00, 'card', NULL, '2026-06-04 10:19:05', '2026-06-04 10:19:05', '2026-06-04 14:59:00', 0, 3900.00, 156.00, 0.00, 0.00, '1475', 0.00, NULL, NULL, NULL, '2026-06-04 14:59:00', NULL, '9bac55850a8bec1394a3947780379dd8'),
(44, 1, NULL, 1, 41, 'PTI-2026-000041', 'paid', 29400.00, 1176.00, 'cash', NULL, '2026-06-04 10:47:19', '2026-06-04 10:47:19', '2026-06-04 14:59:01', 0, 29400.00, 1176.00, 0.00, 0.00, '4436', 0.00, NULL, NULL, NULL, '2026-06-04 14:59:01', NULL, 'c237258b41359bd2e30615ca73a209c8'),
(45, 1, NULL, 1, 42, 'PTI-2026-000042', 'paid', 6460.00, 258.00, 'card', NULL, '2026-06-04 12:26:36', '2026-06-04 12:26:36', '2026-06-04 14:59:03', 0, 6460.00, 258.00, 0.00, 0.00, '5838', 0.00, NULL, NULL, NULL, '2026-06-04 14:59:03', NULL, 'fb14c3d0700ac929a328d6814f1dde21'),
(46, 1, NULL, 1, 43, 'PTI-2026-000043', 'paid', 11000.00, 440.00, 'card', NULL, '2026-06-04 15:01:51', '2026-06-04 15:01:51', '2026-06-04 15:01:52', 0, 11000.00, 440.00, 0.00, 0.00, '8300', 0.00, NULL, NULL, NULL, NULL, NULL, 'b98dcfdd1aab54c47087f8e38040b97f'),
(47, 1, NULL, 1, NULL, 'PTI-2026-000044', 'paid', 3060.00, 123.00, 'card', NULL, '2026-06-04 17:31:48', '2026-06-04 17:31:48', '2026-06-04 17:31:48', 0, 3060.00, 123.00, 0.00, 0.00, '4191', 0.00, NULL, NULL, NULL, NULL, NULL, '98b344c9a4bef48cb02cf79e748aa9a6'),
(48, 1, NULL, 1, 44, 'PTI-2026-000045', 'paid', 3900.00, 156.00, 'card', NULL, '2026-06-04 18:08:27', '2026-06-04 18:08:27', '2026-06-04 18:08:28', 0, 3900.00, 156.00, 0.00, 0.00, '9126', 0.00, NULL, NULL, NULL, NULL, NULL, 'bcd40ac2842b13a44db366d0ba874aa6'),
(49, 1, NULL, 1, 45, 'PTI-2026-000046', 'paid', 1800.00, 72.00, 'cash', NULL, '2026-06-05 10:33:10', '2026-06-05 10:33:10', '2026-06-05 10:33:10', 0, 1800.00, 72.00, 0.00, 0.00, '9881', 0.00, NULL, NULL, NULL, NULL, NULL, 'd68d9a7d20b0e5ac25b2da820719510a'),
(50, 1, NULL, 1, 46, 'PTI-2026-000047', 'paid', 4960.00, 198.00, 'card', NULL, '2026-06-05 10:34:02', '2026-06-05 10:34:02', '2026-06-05 10:34:03', 0, 4960.00, 198.00, 0.00, 0.00, '6001', 0.00, NULL, NULL, NULL, NULL, NULL, 'df754b71d0ec254975ffcc88c85e154a'),
(51, 1, NULL, 1, 47, 'PTI-2026-000048', 'paid', 900.00, 40.00, 'card', NULL, '2026-06-05 10:35:11', '2026-06-05 10:35:11', '2026-06-05 10:35:12', 0, 900.00, 40.00, 0.00, 0.00, '9913', 0.00, NULL, NULL, NULL, NULL, NULL, '4aa61e502ba2bbf05fefa1bad99e42cd'),
(52, 1, NULL, 1, 48, 'PTI-2026-000049', 'paid', 1800.00, 72.00, 'cash', NULL, '2026-06-05 10:35:40', '2026-06-05 10:35:40', '2026-06-05 10:35:41', 0, 1800.00, 72.00, 0.00, 0.00, '6967', 0.00, NULL, NULL, NULL, NULL, NULL, 'f7559cd47b40315fcca2b61918e5428a'),
(53, 1, NULL, 1, 49, 'PTI-2026-000050', 'paid', 6200.00, 258.00, 'cash', NULL, '2026-06-05 10:38:59', '2026-06-05 10:38:59', '2026-06-05 10:39:00', 0, 6200.00, 258.00, 0.00, 0.00, '0689', 0.00, NULL, NULL, NULL, NULL, NULL, '59caa3ce6bc76d034c36dae349e6fb00'),
(54, 1, NULL, 1, 50, 'PTI-2026-000051', 'paid', 3900.00, 156.00, 'cash', NULL, '2026-06-05 10:39:56', '2026-06-05 10:39:56', '2026-06-05 10:39:56', 0, 3900.00, 156.00, 0.00, 0.00, '8671', 0.00, NULL, NULL, NULL, NULL, NULL, 'd0707ba1bfedf3bbd18c0d7d05ec5555'),
(55, 1, NULL, 1, 51, 'PTI-2026-000052', 'paid', 3900.00, 156.00, 'card', NULL, '2026-06-05 10:40:47', '2026-06-05 10:40:47', '2026-06-05 10:40:47', 0, 3900.00, 156.00, 0.00, 0.00, '3266', 0.00, NULL, NULL, NULL, NULL, NULL, 'dc2e78a0fbe46427a1558c045ac9e525'),
(56, 1, NULL, 1, 52, 'PTI-2026-000053', 'paid', 1800.00, 72.00, 'cash', NULL, '2026-06-05 10:44:53', '2026-06-05 10:44:53', '2026-06-05 10:44:54', 0, 1800.00, 72.00, 0.00, 0.00, '6155', 0.00, NULL, NULL, NULL, NULL, NULL, '9c3d3c5581db353e69112cfac71f4792'),
(57, 1, NULL, 1, 53, 'PTI-2026-000054', 'paid', 2200.00, 88.00, 'card', NULL, '2026-06-05 10:45:18', '2026-06-05 10:45:18', '2026-06-05 10:45:18', 0, 2200.00, 88.00, 0.00, 0.00, '3199', 0.00, NULL, NULL, NULL, NULL, NULL, '7ea93648adb24fbbe516206c91a379ec'),
(58, 1, NULL, 1, 54, 'PTI-2026-000055', 'paid', 4460.00, 178.00, 'card', NULL, '2026-06-05 10:45:49', '2026-06-05 10:45:49', '2026-06-05 14:46:29', 0, 4460.00, 178.00, 0.00, 0.00, '0084', 0.00, NULL, NULL, NULL, '2026-06-05 14:46:29', NULL, '844e42213b898fc4cff71e8fe6dfdcbd'),
(59, 1, NULL, 1, 55, 'PTI-2026-000056', 'paid', 3600.00, 144.00, 'card', NULL, '2026-06-05 10:46:10', '2026-06-05 10:46:10', '2026-06-05 10:46:11', 0, 3600.00, 144.00, 0.00, 0.00, '8754', 0.00, NULL, NULL, NULL, NULL, NULL, '58f6b367c9be55cc5b7fd150fb5e397a'),
(60, 1, NULL, 1, 56, 'PTI-2026-000057', 'paid', 11220.00, 451.00, 'cash', NULL, '2026-06-05 16:00:22', '2026-06-05 16:00:22', '2026-06-05 16:00:22', 0, 11220.00, 451.00, 0.00, 0.00, '3516', 0.00, NULL, NULL, NULL, NULL, NULL, 'dd311188ea6eac19fe621e7abd344604'),
(61, 1, NULL, 1, 57, 'PTI-2026-000058', 'paid', 780.00, 31.00, 'cash', NULL, '2026-06-06 16:49:04', '2026-06-06 16:49:04', '2026-06-06 16:49:04', 0, 780.00, 31.00, 0.00, 0.00, '1457', 0.00, NULL, NULL, NULL, NULL, NULL, '5e08a74c59b66c3a6232f0a82620f549'),
(62, 1, NULL, 1, 58, 'PTI-2026-000059', 'paid', 4975.00, 199.00, 'card', NULL, '2026-06-06 17:11:08', '2026-06-06 17:11:08', '2026-06-06 17:11:08', 0, 4975.00, 199.00, 0.00, 0.00, '7044', 0.00, NULL, NULL, NULL, NULL, NULL, '6a94725e71dad0b007fa6b625a7c53db'),
(63, 1, NULL, 1, 59, 'PTI-2026-000060', 'paid', 8100.00, 323.00, 'card', NULL, '2026-06-06 18:37:11', '2026-06-06 18:37:11', '2026-06-06 18:37:11', 0, 8100.00, 323.00, 0.00, 0.00, '0650', 0.00, NULL, NULL, NULL, NULL, NULL, '02fc884b259cc83127ed4057287bcd44'),
(64, 1, NULL, 1, 60, 'PTI-2026-000061', 'paid', 900.00, 36.00, 'card', NULL, '2026-06-06 20:03:56', '2026-06-06 20:03:56', '2026-06-06 20:03:56', 0, 900.00, 36.00, 0.00, 0.00, '6112', 0.00, NULL, NULL, NULL, NULL, NULL, '42a58480733511ad5116c2c6002a745b'),
(65, 1, NULL, 1, 61, 'PTI-2026-000062', 'paid', 1020.00, 41.00, 'card', NULL, '2026-06-06 20:10:09', '2026-06-06 20:10:09', '2026-06-06 20:10:09', 0, 1020.00, 41.00, 0.00, 0.00, '0683', 0.00, NULL, NULL, NULL, NULL, NULL, 'fce529bfc253cbb289d6cd28d7162565'),
(66, 1, NULL, 1, 62, 'PTI-2026-000063', 'paid', 1180.00, 48.00, 'card', NULL, '2026-06-06 20:49:58', '2026-06-06 20:49:58', '2026-06-06 20:49:59', 0, 1180.00, 48.00, 0.00, 0.00, '3321', 0.00, NULL, NULL, NULL, NULL, NULL, 'c6066cec3b56f8e44dfa133be8d14b54'),
(67, 1, NULL, 1, 63, 'PTI-2026-000064', 'paid', 2600.00, 104.00, 'card', NULL, '2026-06-06 20:53:31', '2026-06-06 20:53:31', '2026-06-06 20:53:31', 0, 2600.00, 104.00, 0.00, 0.00, '2216', 0.00, NULL, NULL, NULL, NULL, NULL, '29d5e16189f98ec03af2f89fbb87c5f9'),
(68, 1, NULL, 1, 64, 'PTI-2026-000065', 'paid', 1950.00, 78.00, 'cash', NULL, '2026-06-07 04:46:02', '2026-06-07 04:46:02', '2026-06-07 04:46:03', 0, 1950.00, 78.00, 0.00, 0.00, '0183', 0.00, NULL, NULL, NULL, NULL, NULL, 'b8c39377adb3958fdb044b7bff916f36');

-- --------------------------------------------------------

--
-- Struktura tabulky `sale_items`
--

DROP TABLE IF EXISTS `sale_items`;
CREATE TABLE `sale_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `sale_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `pricing_version_id` int(10) UNSIGNED DEFAULT NULL,
  `cell_key` varchar(255) DEFAULT NULL,
  `snapshot_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`snapshot_json`)),
  `qty` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `unit_price_czk` decimal(10,2) NOT NULL,
  `unit_price_eur` decimal(10,2) DEFAULT NULL,
  `discount_pct` decimal(5,2) NOT NULL DEFAULT 0.00,
  `line_total_czk` decimal(10,2) NOT NULL,
  `line_total_eur` decimal(10,2) DEFAULT NULL,
  `commission_pct` decimal(5,2) DEFAULT NULL,
  `commission_czk` decimal(10,2) DEFAULT NULL,
  `agency_cost_czk` decimal(10,2) DEFAULT NULL,
  `agency_cost_eur` decimal(10,2) DEFAULT NULL,
  `seller_bonus_pct` decimal(5,2) DEFAULT NULL,
  `seller_bonus_czk` decimal(10,2) DEFAULT NULL,
  `ticket_date` date DEFAULT NULL,
  `ticket_time` time DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `sale_items`
--

INSERT INTO `sale_items` (`id`, `sale_id`, `product_id`, `pricing_version_id`, `cell_key`, `snapshot_json`, `qty`, `unit_price_czk`, `unit_price_eur`, `discount_pct`, `line_total_czk`, `line_total_eur`, `commission_pct`, `commission_czk`, `agency_cost_czk`, `agency_cost_eur`, `seller_bonus_pct`, `seller_bonus_czk`, `ticket_date`, `ticket_time`, `created_at`) VALUES
(1, 1, 104, 95, '[]', '{\"lid\":\"a919a17dcf1d\",\"product_id\":104,\"version_id\":95,\"cell_key\":\"[]\",\"product_name\":\"Castle Side Beer Tour\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"PragueWay\",\"agency_id\":15,\"image_path\":\"placeholders\\/ag-15.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"chosen\":[],\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1300,\"retail_eur\":52,\"ticket_date\":\"2026-06-01\",\"ticket_time\":\"18:00\",\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1300,\"retail_eur\":52,\"customer_czk\":1300,\"customer_eur\":52,\"agency_czk\":1040,\"agency_eur\":41.6,\"margin_czk\":260,\"margin_eur\":10.4,\"bonus_czk\":26,\"bonus_eur\":1.04}}', 1, 1300.00, 52.00, 0.00, 1300.00, 52.00, 20.00, 260.00, NULL, NULL, NULL, NULL, '2026-06-01', '18:00:00', '2026-06-01 17:45:37'),
(2, 2, 118, 121, '{\"101\":\"Discover\",\"102\":\"Adult\"}', '{\"lid\":\"227290a66d88\",\"product_id\":118,\"version_id\":121,\"cell_key\":\"{\\\"101\\\":\\\"Discover\\\",\\\"102\\\":\\\"Adult\\\"}\",\"product_name\":\"Big Bus Hop-on Hop-off\",\"product_name_en\":\"Big Bus Hop-on Hop-off\",\"product_name_de\":null,\"agency\":\"Big Bus Tours\",\"agency_id\":1,\"image_path\":\"placeholders\\/ag-1.svg\",\"redemption_type\":\"bus_activation\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Varianta\",\"value\":\"Discover\"},{\"label\":\"Typ pasažéra\",\"value\":\"Adult\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":780,\"retail_eur\":31,\"ticket_date\":null,\"ticket_time\":null,\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":780,\"retail_eur\":31,\"customer_czk\":780,\"customer_eur\":31,\"agency_czk\":624,\"agency_eur\":24.8,\"margin_czk\":156,\"margin_eur\":6.2,\"bonus_czk\":15.6,\"bonus_eur\":0.62}}', 1, 780.00, 31.00, 0.00, 780.00, 31.00, 20.00, 156.00, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-01 17:54:43'),
(3, 3, 118, 121, '{\"101\":\"Discover\",\"102\":\"Adult\"}', '{\"lid\":\"37a9e8da5d1f\",\"product_id\":118,\"version_id\":121,\"cell_key\":\"{\\\"101\\\":\\\"Discover\\\",\\\"102\\\":\\\"Adult\\\"}\",\"product_name\":\"Big Bus Hop-on Hop-off\",\"product_name_en\":\"Big Bus Hop-on Hop-off\",\"product_name_de\":null,\"agency\":\"Big Bus Tours\",\"agency_id\":1,\"image_path\":\"placeholders\\/ag-1.svg\",\"redemption_type\":\"bus_activation\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Varianta\",\"value\":\"Discover\"},{\"label\":\"Typ pasažéra\",\"value\":\"Adult\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":780,\"retail_eur\":31,\"ticket_date\":null,\"ticket_time\":null,\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":780,\"retail_eur\":31,\"customer_czk\":780,\"customer_eur\":31,\"agency_czk\":624,\"agency_eur\":24.8,\"margin_czk\":156,\"margin_eur\":6.2,\"bonus_czk\":15.6,\"bonus_eur\":0.62}}', 1, 780.00, 31.00, 0.00, 780.00, 31.00, 20.00, 156.00, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-01 17:57:20'),
(4, 4, 104, 95, '[]', '{\"lid\":\"68d2bf2a949f\",\"product_id\":104,\"version_id\":95,\"cell_key\":\"[]\",\"product_name\":\"Castle Side Beer Tour\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"PragueWay\",\"agency_id\":15,\"image_path\":\"placeholders\\/ag-15.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":1,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[],\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1300,\"retail_eur\":52,\"ticket_date\":\"2026-06-02\",\"ticket_time\":\"18:00\",\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1300,\"retail_eur\":52,\"customer_czk\":1300,\"customer_eur\":52,\"agency_czk\":1040,\"agency_eur\":41.6,\"margin_czk\":260,\"margin_eur\":10.4,\"bonus_czk\":26,\"bonus_eur\":1.04}}', 1, 1300.00, 52.00, 0.00, 1300.00, 52.00, 20.00, 260.00, NULL, NULL, NULL, NULL, '2026-06-02', '18:00:00', '2026-06-01 19:54:32'),
(5, 5, 72, 71, '{\"73\":\"Dospělý\"}', '{\"lid\":\"47164c990ef5\",\"product_id\":72,\"version_id\":71,\"cell_key\":\"{\\\"73\\\":\\\"Dospělý\\\"}\",\"product_name\":\"Sightseeing Cruise\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"Prague Boats\",\"agency_id\":9,\"image_path\":\"placeholders\\/ag-9.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Typ pasažéra\",\"value\":\"Dospělý\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":450,\"retail_eur\":18,\"ticket_date\":null,\"ticket_time\":null,\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":450,\"retail_eur\":18,\"customer_czk\":900,\"customer_eur\":36,\"agency_czk\":720,\"agency_eur\":28.8,\"margin_czk\":180,\"margin_eur\":7.2,\"bonus_czk\":18,\"bonus_eur\":0.72}}', 2, 450.00, 18.00, 0.00, 900.00, 36.00, 20.00, 180.00, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-01 20:00:51'),
(6, 6, 49, 9, '{\"12\":\"A (orchestr\\/front rows)\"}', '{\"lid\":\"e2068936e31c\",\"product_id\":49,\"version_id\":9,\"cell_key\":\"{\\\"12\\\":\\\"A (orchestr\\\\\\/front rows)\\\"}\",\"product_name\":\"Best of Czech and World Classical Music\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"Agency Artistic Intl (AAI)\",\"agency_id\":5,\"image_path\":\"placeholders\\/ag-5.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Zóna\",\"value\":\"A (orchestr\\/front rows)\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":800,\"retail_eur\":32,\"ticket_date\":\"2026-06-06\",\"ticket_time\":\"17:00\",\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":800,\"retail_eur\":32,\"customer_czk\":1600,\"customer_eur\":64,\"agency_czk\":1280,\"agency_eur\":51.2,\"margin_czk\":320,\"margin_eur\":12.8,\"bonus_czk\":32,\"bonus_eur\":1.28}}', 2, 800.00, 32.00, 0.00, 1600.00, 64.00, 20.00, 320.00, NULL, NULL, NULL, NULL, '2026-06-06', '17:00:00', '2026-06-01 20:04:25'),
(7, 7, 79, 14, '{\"18\":\"Essential\",\"19\":\"Adult\"}', '{\"lid\":\"11d33b4192e8\",\"product_id\":79,\"version_id\":14,\"cell_key\":\"{\\\"18\\\":\\\"Essential\\\",\\\"19\\\":\\\"Adult\\\"}\",\"product_name\":\"Crystal Dinner\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"Prague Boats\",\"agency_id\":9,\"image_path\":\"placeholders\\/ag-9.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Balíček\",\"value\":\"Essential\"},{\"label\":\"Typ návštěvníka\",\"value\":\"Adult\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1980,\"retail_eur\":79,\"ticket_date\":\"2026-06-03\",\"ticket_time\":\"19:00\",\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1980,\"retail_eur\":79,\"customer_czk\":3960,\"customer_eur\":158,\"agency_czk\":3168,\"agency_eur\":126.4,\"margin_czk\":792,\"margin_eur\":31.6,\"bonus_czk\":79.2,\"bonus_eur\":3.16}}', 2, 1980.00, 79.00, 0.00, 3960.00, 158.00, 20.00, 792.00, NULL, NULL, NULL, NULL, '2026-06-03', '19:00:00', '2026-06-01 20:06:40'),
(8, 8, 78, 110, '{\"87\":\"Essential\",\"88\":\"Adult\"}', '{\"lid\":\"60b52afcca7e\",\"product_id\":78,\"version_id\":110,\"cell_key\":\"{\\\"87\\\":\\\"Essential\\\",\\\"88\\\":\\\"Adult\\\"}\",\"product_name\":\"Lunch Cruise (glass boat)\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"Prague Boats\",\"agency_id\":9,\"image_path\":\"placeholders\\/ag-9.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Sezení\",\"value\":\"Essential\"},{\"label\":\"Typ návštěvníka\",\"value\":\"Adult\"}],\"qty\":6,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1230,\"retail_eur\":49,\"ticket_date\":\"2026-06-03\",\"ticket_time\":\"12:00\",\"q\":{\"qty\":6,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1230,\"retail_eur\":49,\"customer_czk\":7380,\"customer_eur\":294,\"agency_czk\":5904,\"agency_eur\":235.2,\"margin_czk\":1476,\"margin_eur\":58.8,\"bonus_czk\":147.6,\"bonus_eur\":5.88}}', 6, 1230.00, 49.00, 0.00, 7380.00, 294.00, 20.00, 1476.00, NULL, NULL, NULL, NULL, '2026-06-03', '12:00:00', '2026-06-01 21:12:52'),
(9, 9, 103, 149, '{\"138\":\"Per person\"}', '{\"lid\":\"681e637a2eec\",\"product_id\":103,\"version_id\":149,\"cell_key\":\"{\\\"138\\\":\\\"Per person\\\"}\",\"product_name\":\"Castle Side Food Tour\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"PragueWay\",\"agency_id\":15,\"image_path\":\"placeholders\\/ag-15.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":1,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Per person\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1400,\"retail_eur\":56,\"ticket_date\":\"2026-06-02\",\"ticket_time\":\"15:00\",\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1400,\"retail_eur\":56,\"customer_czk\":1400,\"customer_eur\":56,\"agency_czk\":1120,\"agency_eur\":44.8,\"margin_czk\":280,\"margin_eur\":11.2,\"bonus_czk\":28,\"bonus_eur\":1.12},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 1, 1400.00, 56.00, 0.00, 1400.00, 56.00, 20.00, 280.00, NULL, NULL, NULL, NULL, '2026-06-02', '15:00:00', '2026-06-02 13:20:12'),
(10, 10, 108, 154, '{\"143\":\"Per person\"}', '{\"lid\":\"c0fd726fc706\",\"product_id\":108,\"version_id\":154,\"cell_key\":\"{\\\"143\\\":\\\"Per person\\\"}\",\"product_name\":\"Charles Bridge River Cruise\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"PragueWay\",\"agency_id\":15,\"image_path\":\"placeholders\\/ag-15.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":1,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Per person\"}],\"qty\":3,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1000,\"retail_eur\":40,\"ticket_date\":\"2026-06-02\",\"ticket_time\":\"13:30\",\"q\":{\"qty\":3,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1000,\"retail_eur\":40,\"customer_czk\":3000,\"customer_eur\":120,\"agency_czk\":2400,\"agency_eur\":96,\"margin_czk\":600,\"margin_eur\":24,\"bonus_czk\":60,\"bonus_eur\":2.4},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 3, 1000.00, 40.00, 0.00, 3000.00, 120.00, 20.00, 600.00, NULL, NULL, NULL, NULL, '2026-06-02', '13:30:00', '2026-06-02 15:13:28'),
(11, 11, 72, 233, '{\"222\":\"Adult\"}', '{\"lid\":\"9402f812f9c5\",\"product_id\":72,\"version_id\":233,\"cell_key\":\"{\\\"222\\\":\\\"Adult\\\"}\",\"product_name\":\"Sightseeing Cruise (50 min)\",\"product_name_en\":\"Sightseeing Cruise (50 min)\",\"product_name_de\":null,\"agency\":\"Prague Boats\",\"agency_id\":9,\"image_path\":\"placeholders\\/ag-9.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":450,\"retail_eur\":18,\"ticket_date\":\"2026-06-02\",\"ticket_time\":null,\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":450,\"retail_eur\":18,\"customer_czk\":900,\"customer_eur\":36,\"agency_czk\":720,\"agency_eur\":28.8,\"margin_czk\":180,\"margin_eur\":7.2,\"bonus_czk\":18,\"bonus_eur\":0.72},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 2, 450.00, 18.00, 0.00, 900.00, 36.00, 20.00, 180.00, NULL, NULL, NULL, NULL, '2026-06-02', NULL, '2026-06-02 16:15:54'),
(12, 12, 88, 135, '{\"123\":\"Adult\"}', '{\"lid\":\"7b79bb105b38\",\"product_id\":88,\"version_id\":135,\"cell_key\":\"{\\\"123\\\":\\\"Adult\\\"}\",\"product_name\":\"Folklore Dinner Show\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"Folklore Garden\",\"agency_id\":13,\"image_path\":\"placeholders\\/ag-13.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":1,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1300,\"retail_eur\":52,\"ticket_date\":\"2026-06-10\",\"ticket_time\":null,\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1300,\"retail_eur\":52,\"customer_czk\":2600,\"customer_eur\":104,\"agency_czk\":2080,\"agency_eur\":83.2,\"margin_czk\":520,\"margin_eur\":20.8,\"bonus_czk\":52,\"bonus_eur\":2.08},\"meeting_label\":\"Místo srazu\",\"meeting_address\":\"Na Zlíchově 18, Praha 5 – Hlubočepy\",\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 2, 1300.00, 52.00, 0.00, 2600.00, 104.00, 20.00, 520.00, NULL, NULL, NULL, NULL, '2026-06-10', NULL, '2026-06-02 17:17:12'),
(13, 12, 88, 135, '{\"123\":\"Child 3-12\"}', '{\"lid\":\"22cb1752e4da\",\"product_id\":88,\"version_id\":135,\"cell_key\":\"{\\\"123\\\":\\\"Child 3-12\\\"}\",\"product_name\":\"Folklore Dinner Show\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"Folklore Garden\",\"agency_id\":13,\"image_path\":\"placeholders\\/ag-13.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":1,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Child 3-12\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":825,\"retail_eur\":33,\"ticket_date\":\"2026-06-10\",\"ticket_time\":null,\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":825,\"retail_eur\":33,\"customer_czk\":825,\"customer_eur\":33,\"agency_czk\":660,\"agency_eur\":26.4,\"margin_czk\":165,\"margin_eur\":6.6,\"bonus_czk\":16.5,\"bonus_eur\":0.66},\"meeting_label\":\"Místo srazu\",\"meeting_address\":\"Na Zlíchově 18, Praha 5 – Hlubočepy\",\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 1, 825.00, 33.00, 0.00, 825.00, 33.00, 20.00, 165.00, NULL, NULL, NULL, NULL, '2026-06-10', NULL, '2026-06-02 17:17:12'),
(14, 13, 79, 240, '{\"230\":\"De Luxe\",\"231\":\"Adult\"}', '{\"lid\":\"66b6e5b22fb7\",\"product_id\":79,\"version_id\":240,\"cell_key\":\"{\\\"230\\\":\\\"De Luxe\\\",\\\"231\\\":\\\"Adult\\\"}\",\"product_name\":\"Crystal Dinner Cruise (3h)\",\"product_name_en\":\"Crystal Dinner Cruise (3h)\",\"product_name_de\":null,\"agency\":\"Prague Boats\",\"agency_id\":9,\"image_path\":\"placeholders\\/ag-9.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Třída\",\"value\":\"De Luxe\"},{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":3230,\"retail_eur\":129,\"ticket_date\":\"2026-06-02\",\"ticket_time\":\"19:00\",\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":3230,\"retail_eur\":129,\"customer_czk\":6460,\"customer_eur\":258,\"agency_czk\":5168,\"agency_eur\":206.4,\"margin_czk\":1292,\"margin_eur\":51.6,\"bonus_czk\":129.2,\"bonus_eur\":5.16},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 2, 3230.00, 129.00, 0.00, 6460.00, 258.00, 20.00, 1292.00, NULL, NULL, NULL, NULL, '2026-06-02', '19:00:00', '2026-06-02 17:21:50'),
(15, 14, 118, 121, '{\"101\":\"Discover\",\"102\":\"Adult\"}', '{\"lid\":\"5cf357991094\",\"product_id\":118,\"version_id\":121,\"cell_key\":\"{\\\"101\\\":\\\"Discover\\\",\\\"102\\\":\\\"Adult\\\"}\",\"product_name\":\"Big Bus Hop-on Hop-off\",\"product_name_en\":\"Big Bus Hop-on Hop-off\",\"product_name_de\":null,\"agency\":\"Big Bus Tours\",\"agency_id\":1,\"image_path\":\"placeholders\\/ag-1.svg\",\"redemption_type\":\"bus_activation\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Varianta\",\"value\":\"Discover\"},{\"label\":\"Typ pasažéra\",\"value\":\"Adult\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":780,\"retail_eur\":31,\"ticket_date\":null,\"ticket_time\":null,\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":780,\"retail_eur\":31,\"customer_czk\":1560,\"customer_eur\":62,\"agency_czk\":1248,\"agency_eur\":49.6,\"margin_czk\":312,\"margin_eur\":12.4,\"bonus_czk\":31.2,\"bonus_eur\":1.24},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 2, 780.00, 31.00, 0.00, 1560.00, 62.00, 20.00, 312.00, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-02 17:24:56'),
(16, 14, 118, 121, '{\"101\":\"Discover\",\"102\":\"Adult\"}', '{\"lid\":\"786f42ad7b84\",\"product_id\":118,\"version_id\":121,\"cell_key\":\"{\\\"101\\\":\\\"Discover\\\",\\\"102\\\":\\\"Adult\\\"}\",\"product_name\":\"Big Bus Hop-on Hop-off\",\"product_name_en\":\"Big Bus Hop-on Hop-off\",\"product_name_de\":null,\"agency\":\"Big Bus Tours\",\"agency_id\":1,\"image_path\":\"placeholders\\/ag-1.svg\",\"redemption_type\":\"bus_activation\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Varianta\",\"value\":\"Discover\"},{\"label\":\"Typ pasažéra\",\"value\":\"Adult\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":780,\"retail_eur\":31,\"ticket_date\":null,\"ticket_time\":null,\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":780,\"retail_eur\":31,\"customer_czk\":1560,\"customer_eur\":62,\"agency_czk\":1248,\"agency_eur\":49.6,\"margin_czk\":312,\"margin_eur\":12.4,\"bonus_czk\":31.2,\"bonus_eur\":1.24},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 2, 780.00, 31.00, 0.00, 1560.00, 62.00, 20.00, 312.00, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-02 17:24:56'),
(17, 15, 105, 151, '{\"140\":\"Per person\"}', '{\"lid\":\"73e7821ea8dc\",\"product_id\":105,\"version_id\":151,\"cell_key\":\"{\\\"140\\\":\\\"Per person\\\"}\",\"product_name\":\"One Prague Tour Castle Side\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"PragueWay\",\"agency_id\":15,\"image_path\":\"placeholders\\/ag-15.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":1,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Per person\"}],\"qty\":9,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1300,\"retail_eur\":52,\"ticket_date\":\"2026-06-02\",\"ticket_time\":\"10:30\",\"q\":{\"qty\":9,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1300,\"retail_eur\":52,\"customer_czk\":11700,\"customer_eur\":468,\"agency_czk\":9360,\"agency_eur\":374.4,\"margin_czk\":2340,\"margin_eur\":93.6,\"bonus_czk\":234,\"bonus_eur\":9.36},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 9, 1300.00, 52.00, 0.00, 11700.00, 468.00, 20.00, 2340.00, NULL, NULL, NULL, NULL, '2026-06-02', '10:30:00', '2026-06-02 17:26:06'),
(18, 16, 111, 157, '{\"146\":\"Per person\"}', '{\"lid\":\"d108066985eb\",\"product_id\":111,\"version_id\":157,\"cell_key\":\"{\\\"146\\\":\\\"Per person\\\"}\",\"product_name\":\"Old Town & Medieval Underground\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"PragueWay\",\"agency_id\":15,\"image_path\":\"placeholders\\/ag-15.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":1,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Per person\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1400,\"retail_eur\":56,\"ticket_date\":\"2026-06-02\",\"ticket_time\":\"10:00\",\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1400,\"retail_eur\":56,\"customer_czk\":2800,\"customer_eur\":112,\"agency_czk\":2240,\"agency_eur\":89.6,\"margin_czk\":560,\"margin_eur\":22.4,\"bonus_czk\":56,\"bonus_eur\":2.24},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 2, 1400.00, 56.00, 0.00, 2800.00, 112.00, 20.00, 560.00, NULL, NULL, NULL, NULL, '2026-06-02', '10:00:00', '2026-06-02 17:27:35'),
(19, 17, 81, 242, '{\"234\":\"Adult\"}', '{\"lid\":\"0f4b02fffa19\",\"product_id\":81,\"version_id\":242,\"cell_key\":\"{\\\"234\\\":\\\"Adult\\\"}\",\"product_name\":\"Čertovka 45min Cruise (Prague Venice)\",\"product_name_en\":\"Čertovka 45min Cruise (Prague Venice)\",\"product_name_de\":null,\"agency\":\"Prague Venice\",\"agency_id\":10,\"image_path\":\"placeholders\\/ag-10.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":3,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":550,\"retail_eur\":22,\"ticket_date\":\"2026-06-02\",\"ticket_time\":null,\"q\":{\"qty\":3,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":550,\"retail_eur\":22,\"customer_czk\":1650,\"customer_eur\":66,\"agency_czk\":1320,\"agency_eur\":52.8,\"margin_czk\":330,\"margin_eur\":13.2,\"bonus_czk\":33,\"bonus_eur\":1.32},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 3, 550.00, 22.00, 0.00, 1650.00, 66.00, 20.00, 330.00, NULL, NULL, NULL, NULL, '2026-06-02', NULL, '2026-06-02 18:15:50'),
(20, 17, 81, 242, '{\"234\":\"Child 2-12\"}', '{\"lid\":\"dcc49cbd135d\",\"product_id\":81,\"version_id\":242,\"cell_key\":\"{\\\"234\\\":\\\"Child 2-12\\\"}\",\"product_name\":\"Čertovka 45min Cruise (Prague Venice)\",\"product_name_en\":\"Čertovka 45min Cruise (Prague Venice)\",\"product_name_de\":null,\"agency\":\"Prague Venice\",\"agency_id\":10,\"image_path\":\"placeholders\\/ag-10.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Child 2-12\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":350,\"retail_eur\":14,\"ticket_date\":\"2026-06-02\",\"ticket_time\":null,\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":350,\"retail_eur\":14,\"customer_czk\":700,\"customer_eur\":28,\"agency_czk\":560,\"agency_eur\":22.4,\"margin_czk\":140,\"margin_eur\":5.6,\"bonus_czk\":14,\"bonus_eur\":0.56},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 2, 350.00, 14.00, 0.00, 700.00, 28.00, 20.00, 140.00, NULL, NULL, NULL, NULL, '2026-06-02', NULL, '2026-06-02 18:15:50'),
(21, 18, 79, 240, '{\"230\":\"Essential\",\"231\":\"Adult\"}', '{\"lid\":\"942789e9bef2\",\"product_id\":79,\"version_id\":240,\"cell_key\":\"{\\\"230\\\":\\\"Essential\\\",\\\"231\\\":\\\"Adult\\\"}\",\"product_name\":\"Crystal Dinner Cruise (3h)\",\"product_name_en\":\"Crystal Dinner Cruise (3h)\",\"product_name_de\":null,\"agency\":\"Prague Boats\",\"agency_id\":9,\"image_path\":\"placeholders\\/ag-9.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Třída\",\"value\":\"Essential\"},{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1980,\"retail_eur\":79,\"ticket_date\":\"2026-06-02\",\"ticket_time\":\"19:00\",\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1980,\"retail_eur\":79,\"customer_czk\":1980,\"customer_eur\":79,\"agency_czk\":1584,\"agency_eur\":63.2,\"margin_czk\":396,\"margin_eur\":15.8,\"bonus_czk\":39.6,\"bonus_eur\":1.58},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 1, 1980.00, 79.00, 0.00, 1980.00, 79.00, 20.00, 396.00, NULL, NULL, NULL, NULL, '2026-06-02', '19:00:00', '2026-06-02 18:35:21'),
(22, 19, 118, 121, '{\"101\":\"Discover\",\"102\":\"Adult\"}', '{\"lid\":\"c24270528f33\",\"product_id\":118,\"version_id\":121,\"cell_key\":\"{\\\"101\\\":\\\"Discover\\\",\\\"102\\\":\\\"Adult\\\"}\",\"product_name\":\"Big Bus Hop-on Hop-off\",\"product_name_en\":\"Big Bus Hop-on Hop-off\",\"product_name_de\":null,\"agency\":\"Big Bus Tours\",\"agency_id\":1,\"image_path\":\"placeholders\\/ag-1.svg\",\"redemption_type\":\"bus_activation\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Varianta\",\"value\":\"Discover\"},{\"label\":\"Typ pasažéra\",\"value\":\"Adult\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":780,\"retail_eur\":31,\"ticket_date\":null,\"ticket_time\":null,\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":780,\"retail_eur\":31,\"customer_czk\":1560,\"customer_eur\":62,\"agency_czk\":1248,\"agency_eur\":49.6,\"margin_czk\":312,\"margin_eur\":12.4,\"bonus_czk\":31.2,\"bonus_eur\":1.24},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 2, 780.00, 31.00, 0.00, 1560.00, 62.00, 20.00, 312.00, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-02 18:45:54'),
(23, 20, 92, 138, '{\"126\":\"Chomutov (62 m bridge)\"}', '{\"lid\":\"2437bb65ce6a\",\"product_id\":92,\"version_id\":138,\"cell_key\":\"{\\\"126\\\":\\\"Chomutov (62 m bridge)\\\"}\",\"product_name\":\"Bungee Jumping\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"Magical Prague\",\"agency_id\":14,\"image_path\":\"placeholders\\/ag-14.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":1,\"agency_deposit\":1,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Lokalita\",\"value\":\"Chomutov (62 m bridge)\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":3800,\"retail_eur\":150,\"ticket_date\":\"2026-06-02\",\"ticket_time\":null,\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":3800,\"retail_eur\":150,\"customer_czk\":3800,\"customer_eur\":150,\"agency_czk\":3040,\"agency_eur\":120,\"margin_czk\":760,\"margin_eur\":30,\"bonus_czk\":76,\"bonus_eur\":3},\"meeting_label\":\"Hotel pickup\",\"meeting_address\":\"Brix\",\"is_pickup\":1,\"pickup_addr\":\"Brix\",\"pickup_time\":\"8:15\",\"seating\":0,\"seats_note\":null}', 1, 3800.00, 150.00, 0.00, 3800.00, 150.00, 20.00, 760.00, NULL, NULL, NULL, NULL, '2026-06-02', NULL, '2026-06-02 18:58:07'),
(24, 21, 110, 156, '{\"145\":\"Per person\"}', '{\"lid\":\"63a687be5f36\",\"product_id\":110,\"version_id\":156,\"cell_key\":\"{\\\"145\\\":\\\"Per person\\\"}\",\"product_name\":\"E-Scooter Grand City Tour\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"PragueWay\",\"agency_id\":15,\"image_path\":\"placeholders\\/ag-15.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":1,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Per person\"}],\"qty\":2,\"discount_pct\":10,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1700,\"retail_eur\":68,\"ticket_date\":\"2026-06-02\",\"ticket_time\":\"17:00\",\"q\":{\"qty\":2,\"discount_pct\":10,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1700,\"retail_eur\":68,\"customer_czk\":3060,\"customer_eur\":122.4,\"agency_czk\":2720,\"agency_eur\":108.8,\"margin_czk\":340,\"margin_eur\":13.6,\"bonus_czk\":34,\"bonus_eur\":1.36},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 2, 1700.00, 68.00, 10.00, 3060.00, 122.40, 20.00, 340.00, NULL, NULL, NULL, NULL, '2026-06-02', '17:00:00', '2026-06-02 19:02:32'),
(25, 22, 11, 169, '{\"158\":\"Adult\"}', '{\"lid\":\"1cab2bec76d5\",\"product_id\":11,\"version_id\":169,\"cell_key\":\"{\\\"158\\\":\\\"Adult\\\"}\",\"product_name\":\"Český Krumlov – UNESCO\",\"product_name_en\":\"Český Krumlov – UNESCO\",\"product_name_de\":null,\"agency\":\"Premiant\",\"agency_id\":2,\"image_path\":\"placeholders\\/ag-2.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1950,\"retail_eur\":78,\"ticket_date\":\"2026-06-02\",\"ticket_time\":null,\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1950,\"retail_eur\":78,\"customer_czk\":1950,\"customer_eur\":78,\"agency_czk\":1560,\"agency_eur\":62.4,\"margin_czk\":390,\"margin_eur\":15.6,\"bonus_czk\":39,\"bonus_eur\":1.56},\"meeting_label\":\"Hotel pickup\",\"meeting_address\":\"Hotel Avion\",\"is_pickup\":1,\"pickup_addr\":\"Hotel Avion\",\"pickup_time\":\"8:00\",\"seating\":0,\"seats_note\":null}', 1, 1950.00, 78.00, 0.00, 1950.00, 78.00, 20.00, 390.00, NULL, NULL, NULL, NULL, '2026-06-02', NULL, '2026-06-02 19:06:27'),
(26, 23, 118, 121, '{\"101\":\"Essential\",\"102\":\"Adult\"}', '{\"lid\":\"c66eb243b918\",\"product_id\":118,\"version_id\":121,\"cell_key\":\"{\\\"101\\\":\\\"Essential\\\",\\\"102\\\":\\\"Adult\\\"}\",\"product_name\":\"Big Bus Hop-on Hop-off\",\"product_name_en\":\"Big Bus Hop-on Hop-off\",\"product_name_de\":null,\"agency\":\"Big Bus Tours\",\"agency_id\":1,\"image_path\":\"placeholders\\/ag-1.svg\",\"redemption_type\":\"bus_activation\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Varianta\",\"value\":\"Essential\"},{\"label\":\"Typ pasažéra\",\"value\":\"Adult\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":900,\"retail_eur\":36,\"ticket_date\":null,\"ticket_time\":null,\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":900,\"retail_eur\":36,\"customer_czk\":900,\"customer_eur\":36,\"agency_czk\":720,\"agency_eur\":28.8,\"margin_czk\":180,\"margin_eur\":7.2,\"bonus_czk\":18,\"bonus_eur\":0.72},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 1, 900.00, 36.00, 0.00, 900.00, 36.00, 20.00, 180.00, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-02 20:04:29'),
(27, 24, 110, 156, '{\"145\":\"Per person\"}', '{\"lid\":\"f45d4a26bc92\",\"product_id\":110,\"version_id\":156,\"cell_key\":\"{\\\"145\\\":\\\"Per person\\\"}\",\"product_name\":\"E-Scooter Grand City Tour\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"PragueWay\",\"agency_id\":15,\"image_path\":\"placeholders\\/ag-15.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":1,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Per person\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1700,\"retail_eur\":68,\"ticket_date\":\"2026-06-04\",\"ticket_time\":\"10:00\",\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1700,\"retail_eur\":68,\"customer_czk\":1700,\"customer_eur\":68,\"agency_czk\":1360,\"agency_eur\":54.4,\"margin_czk\":340,\"margin_eur\":13.6,\"bonus_czk\":34,\"bonus_eur\":1.36},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 1, 1700.00, 68.00, 0.00, 1700.00, 68.00, 20.00, 340.00, NULL, NULL, NULL, NULL, '2026-06-04', '10:00:00', '2026-06-03 11:58:04'),
(28, 25, 118, 121, '{\"101\":\"Essential\",\"102\":\"Adult\"}', '{\"lid\":\"98faa75c9a05\",\"product_id\":118,\"version_id\":121,\"cell_key\":\"{\\\"101\\\":\\\"Essential\\\",\\\"102\\\":\\\"Adult\\\"}\",\"product_name\":\"Big Bus Hop-on Hop-off\",\"product_name_en\":\"Big Bus Hop-on Hop-off\",\"product_name_de\":null,\"agency\":\"Big Bus Tours\",\"agency_id\":1,\"image_path\":\"products\\/118_4aaf86ac.jpg\",\"redemption_type\":\"bus_activation\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Varianta\",\"value\":\"Essential\"},{\"label\":\"Typ pasažéra\",\"value\":\"Adult\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":900,\"retail_eur\":36,\"ticket_date\":null,\"ticket_time\":null,\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":900,\"retail_eur\":36,\"customer_czk\":900,\"customer_eur\":36,\"agency_czk\":720,\"agency_eur\":28.8,\"margin_czk\":180,\"margin_eur\":7.2,\"bonus_czk\":18,\"bonus_eur\":0.72},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 1, 900.00, 36.00, 0.00, 900.00, 36.00, 20.00, 180.00, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-03 14:14:49'),
(29, 25, 118, 121, '{\"101\":\"Essential\",\"102\":\"Family (2A+3C 5-15)\"}', '{\"lid\":\"b47d8e73c1e5\",\"product_id\":118,\"version_id\":121,\"cell_key\":\"{\\\"101\\\":\\\"Essential\\\",\\\"102\\\":\\\"Family (2A+3C 5-15)\\\"}\",\"product_name\":\"Big Bus Hop-on Hop-off\",\"product_name_en\":\"Big Bus Hop-on Hop-off\",\"product_name_de\":null,\"agency\":\"Big Bus Tours\",\"agency_id\":1,\"image_path\":\"products\\/118_4aaf86ac.jpg\",\"redemption_type\":\"bus_activation\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Varianta\",\"value\":\"Essential\"},{\"label\":\"Typ pasažéra\",\"value\":\"Family (2A+3C 5-15)\"}],\"qty\":4,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":2070,\"retail_eur\":83,\"ticket_date\":null,\"ticket_time\":null,\"q\":{\"qty\":4,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":2070,\"retail_eur\":83,\"customer_czk\":8280,\"customer_eur\":332,\"agency_czk\":6624,\"agency_eur\":265.6,\"margin_czk\":1656,\"margin_eur\":66.4,\"bonus_czk\":165.6,\"bonus_eur\":6.64},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 4, 2070.00, 83.00, 0.00, 8280.00, 332.00, 20.00, 1656.00, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-03 14:14:49'),
(30, 26, 79, 240, '{\"230\":\"Essential\",\"231\":\"Adult\"}', '{\"lid\":\"28d19fbed620\",\"product_id\":79,\"version_id\":240,\"cell_key\":\"{\\\"230\\\":\\\"Essential\\\",\\\"231\\\":\\\"Adult\\\"}\",\"product_name\":\"Crystal Dinner Cruise (3h)\",\"product_name_en\":\"Crystal Dinner Cruise (3h)\",\"product_name_de\":null,\"agency\":\"Prague Boats\",\"agency_id\":9,\"image_path\":\"placeholders\\/ag-9.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Třída\",\"value\":\"Essential\"},{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":7,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1980,\"retail_eur\":79,\"ticket_date\":\"2026-06-03\",\"ticket_time\":\"19:00\",\"q\":{\"qty\":7,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1980,\"retail_eur\":79,\"customer_czk\":13860,\"customer_eur\":553,\"agency_czk\":11088,\"agency_eur\":442.4,\"margin_czk\":2772,\"margin_eur\":110.6,\"bonus_czk\":277.2,\"bonus_eur\":11.06},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 7, 1980.00, 79.00, 0.00, 13860.00, 553.00, 20.00, 2772.00, NULL, NULL, NULL, NULL, '2026-06-03', '19:00:00', '2026-06-03 14:16:34'),
(31, 27, 118, 121, '{\"101\":\"Discover\",\"102\":\"Adult\"}', '{\"lid\":\"1ad51e105104\",\"product_id\":118,\"version_id\":121,\"cell_key\":\"{\\\"101\\\":\\\"Discover\\\",\\\"102\\\":\\\"Adult\\\"}\",\"product_name\":\"Big Bus Hop-on Hop-off\",\"product_name_en\":\"Big Bus Hop-on Hop-off\",\"product_name_de\":null,\"agency\":\"Big Bus Tours\",\"agency_id\":1,\"image_path\":\"products\\/118_4aaf86ac.jpg\",\"redemption_type\":\"bus_activation\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Varianta\",\"value\":\"Discover\"},{\"label\":\"Typ pasažéra\",\"value\":\"Adult\"}],\"qty\":3,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":780,\"retail_eur\":31,\"ticket_date\":null,\"ticket_time\":null,\"q\":{\"qty\":3,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":780,\"retail_eur\":31,\"customer_czk\":2340,\"customer_eur\":93,\"agency_czk\":1872,\"agency_eur\":74.4,\"margin_czk\":468,\"margin_eur\":18.6,\"bonus_czk\":46.8,\"bonus_eur\":1.86},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 3, 780.00, 31.00, 0.00, 2340.00, 93.00, 20.00, 468.00, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-03 14:41:46'),
(32, 28, 81, 242, '{\"234\":\"Adult\"}', '{\"lid\":\"0031f853e29f\",\"product_id\":81,\"version_id\":242,\"cell_key\":\"{\\\"234\\\":\\\"Adult\\\"}\",\"product_name\":\"Čertovka 45min Cruise (Prague Venice)\",\"product_name_en\":\"Čertovka 45min Cruise (Prague Venice)\",\"product_name_de\":null,\"agency\":\"Prague Venice\",\"agency_id\":10,\"image_path\":\"placeholders\\/ag-10.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":550,\"retail_eur\":22,\"ticket_date\":\"2026-06-03\",\"ticket_time\":null,\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":550,\"retail_eur\":22,\"customer_czk\":1100,\"customer_eur\":44,\"agency_czk\":880,\"agency_eur\":35.2,\"margin_czk\":220,\"margin_eur\":8.8,\"bonus_czk\":22,\"bonus_eur\":0.88},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 2, 550.00, 22.00, 0.00, 1100.00, 44.00, 20.00, 220.00, NULL, NULL, NULL, NULL, '2026-06-03', NULL, '2026-06-03 14:43:16'),
(33, 28, 81, 242, '{\"234\":\"Child 2-12\"}', '{\"lid\":\"3af60a6e550c\",\"product_id\":81,\"version_id\":242,\"cell_key\":\"{\\\"234\\\":\\\"Child 2-12\\\"}\",\"product_name\":\"Čertovka 45min Cruise (Prague Venice)\",\"product_name_en\":\"Čertovka 45min Cruise (Prague Venice)\",\"product_name_de\":null,\"agency\":\"Prague Venice\",\"agency_id\":10,\"image_path\":\"placeholders\\/ag-10.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Child 2-12\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":350,\"retail_eur\":14,\"ticket_date\":\"2026-06-03\",\"ticket_time\":null,\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":350,\"retail_eur\":14,\"customer_czk\":700,\"customer_eur\":28,\"agency_czk\":560,\"agency_eur\":22.4,\"margin_czk\":140,\"margin_eur\":5.6,\"bonus_czk\":14,\"bonus_eur\":0.56},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null}', 2, 350.00, 14.00, 0.00, 700.00, 28.00, 20.00, 140.00, NULL, NULL, NULL, NULL, '2026-06-03', NULL, '2026-06-03 14:43:16'),
(34, 29, 118, 121, '{\"101\":\"Discover\",\"102\":\"Adult\"}', '{\"lid\":\"9b1ed0cdc6f4\",\"product_id\":118,\"version_id\":121,\"cell_key\":\"{\\\"101\\\":\\\"Discover\\\",\\\"102\\\":\\\"Adult\\\"}\",\"product_name\":\"Big Bus Hop-on Hop-off\",\"product_name_en\":\"Big Bus Hop-on Hop-off\",\"product_name_de\":null,\"agency\":\"Big Bus Tours\",\"agency_id\":1,\"image_path\":\"products\\/118_4aaf86ac.jpg\",\"redemption_type\":\"bus_activation\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Varianta\",\"value\":\"Discover\"},{\"label\":\"Typ pasažéra\",\"value\":\"Adult\"}],\"qty\":12,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":780,\"retail_eur\":31,\"ticket_date\":null,\"ticket_time\":null,\"q\":{\"qty\":12,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":780,\"retail_eur\":31,\"customer_czk\":9360,\"customer_eur\":372,\"agency_czk\":7488,\"agency_eur\":297.6,\"margin_czk\":1872,\"margin_eur\":74.4,\"bonus_czk\":187.2,\"bonus_eur\":7.44},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 12, 780.00, 31.00, 0.00, 9360.00, 372.00, 20.00, 1872.00, 7488.00, 297.60, 10.00, 187.20, NULL, NULL, '2026-06-03 15:33:39'),
(35, 30, 79, 240, '{\"230\":\"De Luxe\",\"231\":\"Adult\"}', '{\"lid\":\"e61a72ef68ed\",\"product_id\":79,\"version_id\":240,\"cell_key\":\"{\\\"230\\\":\\\"De Luxe\\\",\\\"231\\\":\\\"Adult\\\"}\",\"product_name\":\"Crystal Dinner Cruise (3h)\",\"product_name_en\":\"Crystal Dinner Cruise (3h)\",\"product_name_de\":null,\"agency\":\"Prague Boats\",\"agency_id\":9,\"image_path\":\"placeholders\\/ag-9.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Třída\",\"value\":\"De Luxe\"},{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":10,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":3230,\"retail_eur\":129,\"ticket_date\":\"2026-06-03\",\"ticket_time\":\"19:00\",\"q\":{\"qty\":10,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":3230,\"retail_eur\":129,\"customer_czk\":32300,\"customer_eur\":1290,\"agency_czk\":25840,\"agency_eur\":1032,\"margin_czk\":6460,\"margin_eur\":258,\"bonus_czk\":646,\"bonus_eur\":25.8},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 10, 3230.00, 129.00, 0.00, 32300.00, 1290.00, 20.00, 6460.00, 25840.00, 1032.00, 10.00, 646.00, '2026-06-03', '19:00:00', '2026-06-03 15:35:51'),
(36, 31, 11, 169, '{\"158\":\"Adult\"}', '{\"lid\":\"6ea7b9059af1\",\"product_id\":11,\"version_id\":169,\"cell_key\":\"{\\\"158\\\":\\\"Adult\\\"}\",\"product_name\":\"Český Krumlov – UNESCO\",\"product_name_en\":\"Český Krumlov – UNESCO\",\"product_name_de\":null,\"agency\":\"Premiant\",\"agency_id\":2,\"image_path\":\"products\\/11_a093f527.webp\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1950,\"retail_eur\":78,\"ticket_date\":\"2026-06-03\",\"ticket_time\":\"08:45\",\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1950,\"retail_eur\":78,\"customer_czk\":1950,\"customer_eur\":78,\"agency_czk\":1560,\"agency_eur\":62.4,\"margin_czk\":390,\"margin_eur\":15.6,\"bonus_czk\":39,\"bonus_eur\":1.56},\"meeting_label\":\"Místo srazu\",\"meeting_address\":\"Premiant Point — Na Příkopě 23, Praha 1\",\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":\"en\",\"tour_lang_cs\":\"Angličtina\",\"tour_lang_en\":\"English\"}', 1, 1950.00, 78.00, 0.00, 1950.00, 78.00, 20.00, 390.00, 1560.00, 62.40, 10.00, 39.00, '2026-06-03', '08:45:00', '2026-06-03 17:08:04'),
(37, 32, 88, 135, '{\"123\":\"Adult\"}', '{\"lid\":\"56ed4b8942ba\",\"product_id\":88,\"version_id\":135,\"cell_key\":\"{\\\"123\\\":\\\"Adult\\\"}\",\"product_name\":\"Folklore Dinner Show\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"Folklore Garden\",\"agency_id\":13,\"image_path\":\"placeholders\\/ag-13.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":1,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":3,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1300,\"retail_eur\":52,\"ticket_date\":\"2026-06-03\",\"ticket_time\":\"19:00\",\"q\":{\"qty\":3,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1300,\"retail_eur\":52,\"customer_czk\":3900,\"customer_eur\":156,\"agency_czk\":3120,\"agency_eur\":124.8,\"margin_czk\":780,\"margin_eur\":31.2,\"bonus_czk\":78,\"bonus_eur\":3.12},\"meeting_label\":\"Hotel pickup\",\"meeting_address\":\"Domus Balthasar\",\"is_pickup\":1,\"pickup_addr\":\"Domus Balthasar\",\"pickup_time\":\"8:15\",\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 3, 1300.00, 52.00, 0.00, 3900.00, 156.00, 20.00, 780.00, 3120.00, 124.80, 10.00, 78.00, '2026-06-03', '19:00:00', '2026-06-03 17:26:47'),
(38, 32, 88, 135, '{\"123\":\"Child 3-12\"}', '{\"lid\":\"31031e863539\",\"product_id\":88,\"version_id\":135,\"cell_key\":\"{\\\"123\\\":\\\"Child 3-12\\\"}\",\"product_name\":\"Folklore Dinner Show\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"Folklore Garden\",\"agency_id\":13,\"image_path\":\"placeholders\\/ag-13.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":1,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Child 3-12\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":825,\"retail_eur\":33,\"ticket_date\":\"2026-06-03\",\"ticket_time\":\"19:00\",\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":825,\"retail_eur\":33,\"customer_czk\":1650,\"customer_eur\":66,\"agency_czk\":1320,\"agency_eur\":52.8,\"margin_czk\":330,\"margin_eur\":13.2,\"bonus_czk\":33,\"bonus_eur\":1.32},\"meeting_label\":\"Hotel pickup\",\"meeting_address\":\"Domus Balthasar\",\"is_pickup\":1,\"pickup_addr\":\"Domus Balthasar\",\"pickup_time\":\"8:15\",\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 2, 825.00, 33.00, 0.00, 1650.00, 66.00, 20.00, 330.00, 1320.00, 52.80, 10.00, 33.00, '2026-06-03', '19:00:00', '2026-06-03 17:26:47');
INSERT INTO `sale_items` (`id`, `sale_id`, `product_id`, `pricing_version_id`, `cell_key`, `snapshot_json`, `qty`, `unit_price_czk`, `unit_price_eur`, `discount_pct`, `line_total_czk`, `line_total_eur`, `commission_pct`, `commission_czk`, `agency_cost_czk`, `agency_cost_eur`, `seller_bonus_pct`, `seller_bonus_czk`, `ticket_date`, `ticket_time`, `created_at`) VALUES
(39, 32, 88, 135, 'addon', '{\"lid\":\"55c9ce952232\",\"product_id\":88,\"version_id\":135,\"cell_key\":\"addon\",\"product_name\":\"Folklore Dinner Show\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"Folklore Garden\",\"agency_id\":13,\"image_path\":\"placeholders\\/ag-13.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Doplněk\",\"value\":\"Special main course (upgrade)\"}],\"qty\":5,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":75,\"retail_eur\":3,\"ticket_date\":\"2026-06-03\",\"ticket_time\":\"19:00\",\"q\":{\"qty\":5,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":75,\"retail_eur\":3,\"customer_czk\":375,\"customer_eur\":15,\"agency_czk\":300,\"agency_eur\":12,\"margin_czk\":75,\"margin_eur\":3,\"bonus_czk\":7.5,\"bonus_eur\":0.3},\"is_addon\":1,\"addon_label\":\"Special main course (upgrade)\",\"is_pickup\":0}', 5, 75.00, 3.00, 0.00, 375.00, 15.00, 20.00, 75.00, 300.00, 12.00, 10.00, 7.50, '2026-06-03', '19:00:00', '2026-06-03 17:26:47'),
(40, 33, 116, 244, '{\"237\":\"Adult\"}', '{\"lid\":\"28412e49e8aa\",\"product_id\":116,\"version_id\":244,\"cell_key\":\"{\\\"237\\\":\\\"Adult\\\"}\",\"product_name\":\"Antologia (Srnec Black Light Theatre)\",\"product_name_en\":\"Antologia (Srnec Black Light Theatre)\",\"product_name_de\":null,\"agency\":\"Srnec Theatre\",\"agency_id\":17,\"image_path\":\"placeholders\\/ag-17.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Vstupenka\",\"value\":\"Adult\"}],\"qty\":10,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":650,\"retail_eur\":26,\"ticket_date\":\"2026-06-03\",\"ticket_time\":\"20:00\",\"q\":{\"qty\":10,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":650,\"retail_eur\":26,\"customer_czk\":6500,\"customer_eur\":260,\"agency_czk\":5200,\"agency_eur\":208,\"margin_czk\":1300,\"margin_eur\":52,\"bonus_czk\":130,\"bonus_eur\":5.2},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":1,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 10, 650.00, 26.00, 0.00, 6500.00, 260.00, 20.00, 1300.00, 5200.00, 208.00, 10.00, 130.00, '2026-06-03', '20:00:00', '2026-06-03 20:01:12'),
(41, 34, 118, 121, '{\"101\":\"Essential\",\"102\":\"Adult\"}', '{\"lid\":\"6c7048217ee7\",\"product_id\":118,\"version_id\":121,\"cell_key\":\"{\\\"101\\\":\\\"Essential\\\",\\\"102\\\":\\\"Adult\\\"}\",\"product_name\":\"Big Bus Hop-on Hop-off\",\"product_name_en\":\"Big Bus Hop-on Hop-off\",\"product_name_de\":null,\"agency\":\"Big Bus Tours\",\"agency_id\":1,\"image_path\":\"products\\/118_90e93da6.jpg\",\"redemption_type\":\"bus_activation\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Varianta\",\"value\":\"Essential\"},{\"label\":\"Typ pasažéra\",\"value\":\"Adult\"}],\"qty\":4,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":900,\"retail_eur\":36,\"ticket_date\":null,\"ticket_time\":null,\"q\":{\"qty\":4,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":900,\"retail_eur\":36,\"customer_czk\":3600,\"customer_eur\":144,\"agency_czk\":2880,\"agency_eur\":115.2,\"margin_czk\":720,\"margin_eur\":28.8,\"bonus_czk\":72,\"bonus_eur\":2.88},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 4, 900.00, 36.00, 0.00, 3600.00, 144.00, 20.00, 720.00, 2880.00, 115.20, 10.00, 72.00, NULL, NULL, '2026-06-03 20:08:31'),
(42, 35, 81, 242, '{\"234\":\"Adult\"}', '{\"lid\":\"4379e6a3bde4\",\"product_id\":81,\"version_id\":242,\"cell_key\":\"{\\\"234\\\":\\\"Adult\\\"}\",\"product_name\":\"Čertovka 45min Cruise (Prague Venice)\",\"product_name_en\":\"Čertovka 45min Cruise (Prague Venice)\",\"product_name_de\":null,\"agency\":\"Prague Venice\",\"agency_id\":10,\"image_path\":\"placeholders\\/ag-10.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":14,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":550,\"retail_eur\":22,\"ticket_date\":\"2026-06-03\",\"ticket_time\":null,\"q\":{\"qty\":14,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":550,\"retail_eur\":22,\"customer_czk\":7700,\"customer_eur\":308,\"agency_czk\":6160,\"agency_eur\":246.4,\"margin_czk\":1540,\"margin_eur\":61.6,\"bonus_czk\":154,\"bonus_eur\":6.16},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 14, 550.00, 22.00, 0.00, 7700.00, 308.00, 20.00, 1540.00, 6160.00, 246.40, 10.00, 154.00, '2026-06-03', NULL, '2026-06-03 21:00:02'),
(43, 35, 81, 242, '{\"234\":\"Child 2-12\"}', '{\"lid\":\"8695cada4da6\",\"product_id\":81,\"version_id\":242,\"cell_key\":\"{\\\"234\\\":\\\"Child 2-12\\\"}\",\"product_name\":\"Čertovka 45min Cruise (Prague Venice)\",\"product_name_en\":\"Čertovka 45min Cruise (Prague Venice)\",\"product_name_de\":null,\"agency\":\"Prague Venice\",\"agency_id\":10,\"image_path\":\"placeholders\\/ag-10.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Child 2-12\"}],\"qty\":13,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":350,\"retail_eur\":14,\"ticket_date\":\"2026-06-03\",\"ticket_time\":null,\"q\":{\"qty\":13,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":350,\"retail_eur\":14,\"customer_czk\":4550,\"customer_eur\":182,\"agency_czk\":3640,\"agency_eur\":145.6,\"margin_czk\":910,\"margin_eur\":36.4,\"bonus_czk\":91,\"bonus_eur\":3.64},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 13, 350.00, 14.00, 0.00, 4550.00, 182.00, 20.00, 910.00, 3640.00, 145.60, 10.00, 91.00, '2026-06-03', NULL, '2026-06-03 21:00:02'),
(44, 39, 112, 158, '{\"147\":\"Per person\"}', '{\"lid\":\"650f1d52db58\",\"product_id\":112,\"version_id\":158,\"cell_key\":\"{\\\"147\\\":\\\"Per person\\\"}\",\"product_name\":\"Prague Castle Highlights\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"PragueWay\",\"agency_id\":15,\"image_path\":\"placeholders\\/ag-15.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":1,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Per person\"}],\"qty\":6,\"discount_pct\":0,\"commission_pct\":25,\"bonus_pct\":10,\"retail_czk\":700,\"retail_eur\":28,\"ticket_date\":\"2026-06-04\",\"ticket_time\":\"15:00\",\"q\":{\"qty\":6,\"discount_pct\":0,\"commission_pct\":25,\"bonus_pct\":10,\"retail_czk\":700,\"retail_eur\":28,\"customer_czk\":4200,\"customer_eur\":168,\"agency_czk\":3150,\"agency_eur\":126,\"margin_czk\":1050,\"margin_eur\":42,\"bonus_czk\":105,\"bonus_eur\":4.2},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 6, 700.00, 28.00, 0.00, 4200.00, 168.00, 25.00, 1050.00, 3150.00, 126.00, 10.00, 105.00, '2026-06-04', '15:00:00', '2026-06-04 07:15:42'),
(45, 40, 11, 169, '{\"158\":\"Adult\"}', '{\"lid\":\"cd419071730d\",\"product_id\":11,\"version_id\":169,\"cell_key\":\"{\\\"158\\\":\\\"Adult\\\"}\",\"product_name\":\"Český Krumlov – UNESCO\",\"product_name_en\":\"Český Krumlov – UNESCO\",\"product_name_de\":null,\"agency\":\"Premiant\",\"agency_id\":2,\"image_path\":\"products\\/11_a093f527.webp\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1950,\"retail_eur\":78,\"ticket_date\":\"2026-06-05\",\"ticket_time\":\"08:45\",\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1950,\"retail_eur\":78,\"customer_czk\":1950,\"customer_eur\":78,\"agency_czk\":1560,\"agency_eur\":62.4,\"margin_czk\":390,\"margin_eur\":15.6,\"bonus_czk\":39,\"bonus_eur\":1.56},\"meeting_label\":\"Místo srazu\",\"meeting_address\":\"Premiant Point — Na Příkopě 23, Praha 1\",\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":\"es\",\"tour_lang_cs\":\"Španělština\",\"tour_lang_en\":\"Spanish\"}', 1, 1950.00, 78.00, 0.00, 1950.00, 78.00, 20.00, 390.00, 1560.00, 62.40, 10.00, 39.00, '2026-06-05', '08:45:00', '2026-06-04 09:03:43'),
(46, 40, 11, 169, '{\"158\":\"Student\"}', '{\"lid\":\"20ec3716ec6d\",\"product_id\":11,\"version_id\":169,\"cell_key\":\"{\\\"158\\\":\\\"Student\\\"}\",\"product_name\":\"Český Krumlov – UNESCO\",\"product_name_en\":\"Český Krumlov – UNESCO\",\"product_name_de\":null,\"agency\":\"Premiant\",\"agency_id\":2,\"image_path\":\"products\\/11_a093f527.webp\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Student\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1850,\"retail_eur\":74,\"ticket_date\":\"2026-06-05\",\"ticket_time\":\"08:45\",\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1850,\"retail_eur\":74,\"customer_czk\":1850,\"customer_eur\":74,\"agency_czk\":1480,\"agency_eur\":59.2,\"margin_czk\":370,\"margin_eur\":14.8,\"bonus_czk\":37,\"bonus_eur\":1.48},\"meeting_label\":\"Místo srazu\",\"meeting_address\":\"Premiant Point — Na Příkopě 23, Praha 1\",\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":\"es\",\"tour_lang_cs\":\"Španělština\",\"tour_lang_en\":\"Spanish\"}', 1, 1850.00, 74.00, 0.00, 1850.00, 74.00, 20.00, 370.00, 1480.00, 59.20, 10.00, 37.00, '2026-06-05', '08:45:00', '2026-06-04 09:03:43'),
(47, 41, 65, 226, '{\"215\":\"Německy\"}', '{\"lid\":\"f0803b96ab26\",\"product_id\":65,\"version_id\":226,\"cell_key\":\"{\\\"215\\\":\\\"Německy\\\"}\",\"product_name\":\"Alchemy & Mysteries of Prague Castle\",\"product_name_en\":\"Alchemy & Mysteries of Prague Castle\",\"product_name_de\":null,\"agency\":\"McGee\'s Trips & Tickets\",\"agency_id\":8,\"image_path\":\"placeholders\\/ag-8.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":0,\"agency_deposit\":1,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Jazyk\",\"value\":\"Německy\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":30,\"bonus_pct\":10,\"retail_czk\":700,\"retail_eur\":28,\"ticket_date\":\"2026-06-04\",\"ticket_time\":\"19:00 (DE)\",\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":30,\"bonus_pct\":10,\"retail_czk\":700,\"retail_eur\":28,\"customer_czk\":700,\"customer_eur\":28,\"agency_czk\":490,\"agency_eur\":19.6,\"margin_czk\":210,\"margin_eur\":8.4,\"bonus_czk\":21,\"bonus_eur\":0.84},\"meeting_label\":\"Místo srazu\",\"meeting_address\":\"Týnská 627\\/7, 110 00 Praha 1 (před budovou č. 7)\",\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 1, 700.00, 28.00, 0.00, 700.00, 28.00, 30.00, 210.00, 490.00, 19.60, 10.00, 21.00, '2026-06-04', '19:00:00', '2026-06-04 09:25:05'),
(48, 42, 105, 151, '{\"140\":\"Per person\"}', '{\"lid\":\"84caf2ee583e\",\"product_id\":105,\"version_id\":151,\"cell_key\":\"{\\\"140\\\":\\\"Per person\\\"}\",\"product_name\":\"One Prague Tour Castle Side\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"PragueWay\",\"agency_id\":15,\"image_path\":\"placeholders\\/ag-15.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":1,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Per person\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":25,\"bonus_pct\":10,\"retail_czk\":1300,\"retail_eur\":52,\"ticket_date\":\"2026-06-04\",\"ticket_time\":\"10:30\",\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":25,\"bonus_pct\":10,\"retail_czk\":1300,\"retail_eur\":52,\"customer_czk\":2600,\"customer_eur\":104,\"agency_czk\":1950,\"agency_eur\":78,\"margin_czk\":650,\"margin_eur\":26,\"bonus_czk\":65,\"bonus_eur\":2.6},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 2, 1300.00, 52.00, 0.00, 2600.00, 104.00, 25.00, 650.00, 1950.00, 78.00, 10.00, 65.00, '2026-06-04', '10:30:00', '2026-06-04 10:18:13'),
(49, 43, 105, 151, '{\"140\":\"Per person\"}', '{\"lid\":\"69843eb9e84f\",\"product_id\":105,\"version_id\":151,\"cell_key\":\"{\\\"140\\\":\\\"Per person\\\"}\",\"product_name\":\"One Prague Tour Castle Side\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"PragueWay\",\"agency_id\":15,\"image_path\":\"placeholders\\/ag-15.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":1,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Per person\"}],\"qty\":3,\"discount_pct\":0,\"commission_pct\":25,\"bonus_pct\":10,\"retail_czk\":1300,\"retail_eur\":52,\"ticket_date\":\"2026-06-04\",\"ticket_time\":\"10:30\",\"q\":{\"qty\":3,\"discount_pct\":0,\"commission_pct\":25,\"bonus_pct\":10,\"retail_czk\":1300,\"retail_eur\":52,\"customer_czk\":3900,\"customer_eur\":156,\"agency_czk\":2925,\"agency_eur\":117,\"margin_czk\":975,\"margin_eur\":39,\"bonus_czk\":97.5,\"bonus_eur\":3.9},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 3, 1300.00, 52.00, 0.00, 3900.00, 156.00, 25.00, 975.00, 2925.00, 117.00, 10.00, 97.50, '2026-06-04', '10:30:00', '2026-06-04 10:19:05'),
(50, 44, 11, 169, '{\"158\":\"Adult\"}', '{\"lid\":\"f62483151b9c\",\"product_id\":11,\"version_id\":169,\"cell_key\":\"{\\\"158\\\":\\\"Adult\\\"}\",\"product_name\":\"Český Krumlov – UNESCO\",\"product_name_en\":\"Český Krumlov – UNESCO\",\"product_name_de\":null,\"agency\":\"Premiant\",\"agency_id\":2,\"image_path\":\"products\\/11_a093f527.webp\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":8,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1950,\"retail_eur\":78,\"ticket_date\":\"2026-06-06\",\"ticket_time\":\"08:45\",\"q\":{\"qty\":8,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1950,\"retail_eur\":78,\"customer_czk\":15600,\"customer_eur\":624,\"agency_czk\":12480,\"agency_eur\":499.2,\"margin_czk\":3120,\"margin_eur\":124.8,\"bonus_czk\":312,\"bonus_eur\":12.48},\"meeting_label\":\"Hotel pickup\",\"meeting_address\":\"u šuterů\",\"is_pickup\":1,\"pickup_addr\":\"u šuterů\",\"pickup_time\":\"7:30\",\"seating\":0,\"seats_note\":null,\"tour_lang\":\"it\",\"tour_lang_cs\":\"Italština\",\"tour_lang_en\":\"Italian\"}', 8, 1950.00, 78.00, 0.00, 15600.00, 624.00, 20.00, 3120.00, 12480.00, 499.20, 10.00, 312.00, '2026-06-06', '08:45:00', '2026-06-04 10:47:19'),
(51, 44, 11, 169, '{\"158\":\"Student\"}', '{\"lid\":\"688fbeb1b0a0\",\"product_id\":11,\"version_id\":169,\"cell_key\":\"{\\\"158\\\":\\\"Student\\\"}\",\"product_name\":\"Český Krumlov – UNESCO\",\"product_name_en\":\"Český Krumlov – UNESCO\",\"product_name_de\":null,\"agency\":\"Premiant\",\"agency_id\":2,\"image_path\":\"products\\/11_a093f527.webp\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Student\"}],\"qty\":3,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1850,\"retail_eur\":74,\"ticket_date\":\"2026-06-06\",\"ticket_time\":\"08:45\",\"q\":{\"qty\":3,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1850,\"retail_eur\":74,\"customer_czk\":5550,\"customer_eur\":222,\"agency_czk\":4440,\"agency_eur\":177.6,\"margin_czk\":1110,\"margin_eur\":44.4,\"bonus_czk\":111,\"bonus_eur\":4.44},\"meeting_label\":\"Hotel pickup\",\"meeting_address\":\"u šuterů\",\"is_pickup\":1,\"pickup_addr\":\"u šuterů\",\"pickup_time\":\"7:30\",\"seating\":0,\"seats_note\":null,\"tour_lang\":\"it\",\"tour_lang_cs\":\"Italština\",\"tour_lang_en\":\"Italian\"}', 3, 1850.00, 74.00, 0.00, 5550.00, 222.00, 20.00, 1110.00, 4440.00, 177.60, 10.00, 111.00, '2026-06-06', '08:45:00', '2026-06-04 10:47:19'),
(52, 44, 11, 169, '{\"158\":\"Child 5-15\"}', '{\"lid\":\"2c27d8e49004\",\"product_id\":11,\"version_id\":169,\"cell_key\":\"{\\\"158\\\":\\\"Child 5-15\\\"}\",\"product_name\":\"Český Krumlov – UNESCO\",\"product_name_en\":\"Český Krumlov – UNESCO\",\"product_name_de\":null,\"agency\":\"Premiant\",\"agency_id\":2,\"image_path\":\"products\\/11_a093f527.webp\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Child 5-15\"}],\"qty\":5,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1650,\"retail_eur\":66,\"ticket_date\":\"2026-06-06\",\"ticket_time\":\"08:45\",\"q\":{\"qty\":5,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1650,\"retail_eur\":66,\"customer_czk\":8250,\"customer_eur\":330,\"agency_czk\":6600,\"agency_eur\":264,\"margin_czk\":1650,\"margin_eur\":66,\"bonus_czk\":165,\"bonus_eur\":6.6},\"meeting_label\":\"Hotel pickup\",\"meeting_address\":\"u šuterů\",\"is_pickup\":1,\"pickup_addr\":\"u šuterů\",\"pickup_time\":\"7:30\",\"seating\":0,\"seats_note\":null,\"tour_lang\":\"it\",\"tour_lang_cs\":\"Italština\",\"tour_lang_en\":\"Italian\"}', 5, 1650.00, 66.00, 0.00, 8250.00, 330.00, 20.00, 1650.00, 6600.00, 264.00, 10.00, 165.00, '2026-06-06', '08:45:00', '2026-06-04 10:47:19'),
(53, 45, 79, 240, '{\"230\":\"De Luxe\",\"231\":\"Adult\"}', '{\"lid\":\"a69b98ad5c9a\",\"product_id\":79,\"version_id\":240,\"cell_key\":\"{\\\"230\\\":\\\"De Luxe\\\",\\\"231\\\":\\\"Adult\\\"}\",\"product_name\":\"Crystal Dinner Cruise (3h)\",\"product_name_en\":\"Crystal Dinner Cruise (3h)\",\"product_name_de\":null,\"agency\":\"Prague Boats\",\"agency_id\":9,\"image_path\":\"placeholders\\/ag-9.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Třída\",\"value\":\"De Luxe\"},{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":3230,\"retail_eur\":129,\"ticket_date\":\"2026-06-04\",\"ticket_time\":\"19:00\",\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":3230,\"retail_eur\":129,\"customer_czk\":6460,\"customer_eur\":258,\"agency_czk\":5168,\"agency_eur\":206.4,\"margin_czk\":1292,\"margin_eur\":51.6,\"bonus_czk\":129.2,\"bonus_eur\":5.16},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 2, 3230.00, 129.00, 0.00, 6460.00, 258.00, 20.00, 1292.00, 5168.00, 206.40, 10.00, 129.20, '2026-06-04', '19:00:00', '2026-06-04 12:26:36'),
(54, 46, 11, 169, '{\"158\":\"Adult\"}', '{\"lid\":\"c31828729bde\",\"product_id\":11,\"version_id\":169,\"cell_key\":\"{\\\"158\\\":\\\"Adult\\\"}\",\"product_name\":\"Český Krumlov – UNESCO\",\"product_name_en\":\"Český Krumlov – UNESCO\",\"product_name_de\":null,\"agency\":\"Premiant\",\"agency_id\":2,\"image_path\":\"products\\/11_a093f527.webp\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":3,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1950,\"retail_eur\":78,\"ticket_date\":\"2026-06-05\",\"ticket_time\":\"08:45\",\"q\":{\"qty\":3,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1950,\"retail_eur\":78,\"customer_czk\":5850,\"customer_eur\":234,\"agency_czk\":4680,\"agency_eur\":187.2,\"margin_czk\":1170,\"margin_eur\":46.8,\"bonus_czk\":117,\"bonus_eur\":4.68},\"meeting_label\":\"Hotel pickup\",\"meeting_address\":\"Domus Balthasar\",\"is_pickup\":1,\"pickup_addr\":\"Domus Balthasar\",\"pickup_time\":\"8:00\",\"seating\":0,\"seats_note\":null,\"tour_lang\":\"en\",\"tour_lang_cs\":\"Angličtina\",\"tour_lang_en\":\"English\"}', 3, 1950.00, 78.00, 0.00, 5850.00, 234.00, 20.00, 1170.00, 4680.00, 187.20, 10.00, 117.00, '2026-06-05', '08:45:00', '2026-06-04 15:01:51'),
(55, 46, 11, 169, '{\"158\":\"Student\"}', '{\"lid\":\"afba2690de70\",\"product_id\":11,\"version_id\":169,\"cell_key\":\"{\\\"158\\\":\\\"Student\\\"}\",\"product_name\":\"Český Krumlov – UNESCO\",\"product_name_en\":\"Český Krumlov – UNESCO\",\"product_name_de\":null,\"agency\":\"Premiant\",\"agency_id\":2,\"image_path\":\"products\\/11_a093f527.webp\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Student\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1850,\"retail_eur\":74,\"ticket_date\":\"2026-06-05\",\"ticket_time\":\"08:45\",\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1850,\"retail_eur\":74,\"customer_czk\":1850,\"customer_eur\":74,\"agency_czk\":1480,\"agency_eur\":59.2,\"margin_czk\":370,\"margin_eur\":14.8,\"bonus_czk\":37,\"bonus_eur\":1.48},\"meeting_label\":\"Hotel pickup\",\"meeting_address\":\"Domus Balthasar\",\"is_pickup\":1,\"pickup_addr\":\"Domus Balthasar\",\"pickup_time\":\"8:00\",\"seating\":0,\"seats_note\":null,\"tour_lang\":\"en\",\"tour_lang_cs\":\"Angličtina\",\"tour_lang_en\":\"English\"}', 1, 1850.00, 74.00, 0.00, 1850.00, 74.00, 20.00, 370.00, 1480.00, 59.20, 10.00, 37.00, '2026-06-05', '08:45:00', '2026-06-04 15:01:51'),
(56, 46, 11, 169, '{\"158\":\"Child 5-15\"}', '{\"lid\":\"25b6a52a7ca4\",\"product_id\":11,\"version_id\":169,\"cell_key\":\"{\\\"158\\\":\\\"Child 5-15\\\"}\",\"product_name\":\"Český Krumlov – UNESCO\",\"product_name_en\":\"Český Krumlov – UNESCO\",\"product_name_de\":null,\"agency\":\"Premiant\",\"agency_id\":2,\"image_path\":\"products\\/11_a093f527.webp\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Child 5-15\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1650,\"retail_eur\":66,\"ticket_date\":\"2026-06-05\",\"ticket_time\":\"08:45\",\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1650,\"retail_eur\":66,\"customer_czk\":3300,\"customer_eur\":132,\"agency_czk\":2640,\"agency_eur\":105.6,\"margin_czk\":660,\"margin_eur\":26.4,\"bonus_czk\":66,\"bonus_eur\":2.64},\"meeting_label\":\"Hotel pickup\",\"meeting_address\":\"Domus Balthasar\",\"is_pickup\":1,\"pickup_addr\":\"Domus Balthasar\",\"pickup_time\":\"8:00\",\"seating\":0,\"seats_note\":null,\"tour_lang\":\"en\",\"tour_lang_cs\":\"Angličtina\",\"tour_lang_en\":\"English\"}', 2, 1650.00, 66.00, 0.00, 3300.00, 132.00, 20.00, 660.00, 2640.00, 105.60, 10.00, 66.00, '2026-06-05', '08:45:00', '2026-06-04 15:01:51'),
(57, 47, 118, 121, '{\"101\":\"Explore\",\"102\":\"Adult\"}', '{\"lid\":\"e2c8f5afd683\",\"product_id\":118,\"version_id\":121,\"cell_key\":\"{\\\"101\\\":\\\"Explore\\\",\\\"102\\\":\\\"Adult\\\"}\",\"product_name\":\"Big Bus Hop-on Hop-off\",\"product_name_en\":\"Big Bus Hop-on Hop-off\",\"product_name_de\":null,\"agency\":\"Big Bus Tours\",\"agency_id\":1,\"image_path\":\"products\\/118_90e93da6.jpg\",\"redemption_type\":\"bus_activation\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Varianta\",\"value\":\"Explore\"},{\"label\":\"Typ pasažéra\",\"value\":\"Adult\"}],\"qty\":3,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1020,\"retail_eur\":41,\"ticket_date\":null,\"ticket_time\":null,\"q\":{\"qty\":3,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1020,\"retail_eur\":41,\"customer_czk\":3060,\"customer_eur\":123,\"agency_czk\":2448,\"agency_eur\":98.4,\"margin_czk\":612,\"margin_eur\":24.6,\"bonus_czk\":61.2,\"bonus_eur\":2.46},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 3, 1020.00, 41.00, 0.00, 3060.00, 123.00, 20.00, 612.00, 2448.00, 98.40, 10.00, 61.20, NULL, NULL, '2026-06-04 17:31:48'),
(58, 48, 11, 169, '{\"158\":\"Adult\"}', '{\"lid\":\"24eb3edd1e88\",\"product_id\":11,\"version_id\":169,\"cell_key\":\"{\\\"158\\\":\\\"Adult\\\"}\",\"product_name\":\"Český Krumlov – UNESCO\",\"product_name_en\":\"Český Krumlov – UNESCO\",\"product_name_de\":null,\"agency\":\"Premiant\",\"agency_id\":2,\"image_path\":\"products\\/11_a093f527.webp\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1950,\"retail_eur\":78,\"ticket_date\":\"2026-06-04\",\"ticket_time\":\"08:45\",\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1950,\"retail_eur\":78,\"customer_czk\":3900,\"customer_eur\":156,\"agency_czk\":3120,\"agency_eur\":124.8,\"margin_czk\":780,\"margin_eur\":31.2,\"bonus_czk\":78,\"bonus_eur\":3.12},\"meeting_label\":\"Místo srazu\",\"meeting_address\":\"Premiant Point — Na Příkopě 23, Praha 1\",\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":\"en\",\"tour_lang_cs\":\"Angličtina\",\"tour_lang_en\":\"English\"}', 2, 1950.00, 78.00, 0.00, 3900.00, 156.00, 20.00, 780.00, 3120.00, 124.80, 10.00, 78.00, '2026-06-04', '08:45:00', '2026-06-04 18:08:27'),
(59, 49, 118, 121, '{\"101\":\"Essential\",\"102\":\"Adult\"}', '{\"lid\":\"2b3790a4b864\",\"product_id\":118,\"version_id\":121,\"cell_key\":\"{\\\"101\\\":\\\"Essential\\\",\\\"102\\\":\\\"Adult\\\"}\",\"product_name\":\"Big Bus Hop-on Hop-off\",\"product_name_en\":\"Big Bus Hop-on Hop-off\",\"product_name_de\":null,\"agency\":\"Big Bus Tours\",\"agency_id\":1,\"image_path\":\"products\\/118_90e93da6.jpg\",\"redemption_type\":\"bus_activation\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Varianta\",\"value\":\"Essential\"},{\"label\":\"Typ pasažéra\",\"value\":\"Adult\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":900,\"retail_eur\":36,\"ticket_date\":null,\"ticket_time\":null,\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":900,\"retail_eur\":36,\"customer_czk\":1800,\"customer_eur\":72,\"agency_czk\":1440,\"agency_eur\":57.6,\"margin_czk\":360,\"margin_eur\":14.4,\"bonus_czk\":36,\"bonus_eur\":1.44},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 2, 900.00, 36.00, 0.00, 1800.00, 72.00, 20.00, 360.00, 1440.00, 57.60, 10.00, 36.00, NULL, NULL, '2026-06-05 10:33:10'),
(60, 50, 79, 240, '{\"230\":\"Exclusive\",\"231\":\"Adult\"}', '{\"lid\":\"d815a700e642\",\"product_id\":79,\"version_id\":240,\"cell_key\":\"{\\\"230\\\":\\\"Exclusive\\\",\\\"231\\\":\\\"Adult\\\"}\",\"product_name\":\"Crystal Dinner Cruise (3h)\",\"product_name_en\":\"Crystal Dinner Cruise (3h)\",\"product_name_de\":null,\"agency\":\"Prague Boats\",\"agency_id\":9,\"image_path\":\"placeholders\\/ag-9.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Třída\",\"value\":\"Exclusive\"},{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":2480,\"retail_eur\":99,\"ticket_date\":\"2026-06-05\",\"ticket_time\":\"19:00\",\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":2480,\"retail_eur\":99,\"customer_czk\":4960,\"customer_eur\":198,\"agency_czk\":3968,\"agency_eur\":158.4,\"margin_czk\":992,\"margin_eur\":39.6,\"bonus_czk\":99.2,\"bonus_eur\":3.96},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 2, 2480.00, 99.00, 0.00, 4960.00, 198.00, 20.00, 992.00, 3968.00, 158.40, 10.00, 99.20, '2026-06-05', '19:00:00', '2026-06-05 10:34:02'),
(61, 51, 66, 227, '{\"216\":\"Anglicky\"}', '{\"lid\":\"4156752e1079\",\"product_id\":66,\"version_id\":227,\"cell_key\":\"{\\\"216\\\":\\\"Anglicky\\\"}\",\"product_name\":\"Ghosts & Legends of Old Town\",\"product_name_en\":\"Ghosts & Legends of Old Town\",\"product_name_de\":null,\"agency\":\"McGee\'s Trips & Tickets\",\"agency_id\":8,\"image_path\":\"placeholders\\/ag-8.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":0,\"agency_deposit\":1,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Jazyk\",\"value\":\"Anglicky\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":30,\"bonus_pct\":10,\"retail_czk\":450,\"retail_eur\":20,\"ticket_date\":\"2026-06-05\",\"ticket_time\":\"20:30 (EN)\",\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":30,\"bonus_pct\":10,\"retail_czk\":450,\"retail_eur\":20,\"customer_czk\":900,\"customer_eur\":40,\"agency_czk\":630,\"agency_eur\":28,\"margin_czk\":270,\"margin_eur\":12,\"bonus_czk\":27,\"bonus_eur\":1.2},\"meeting_label\":\"Místo srazu\",\"meeting_address\":\"Týnská 627\\/7, 110 00 Praha 1 (před budovou č. 7)\",\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 2, 450.00, 20.00, 0.00, 900.00, 40.00, 30.00, 270.00, 630.00, 28.00, 10.00, 27.00, '2026-06-05', '20:30:00', '2026-06-05 10:35:11'),
(62, 52, 72, 233, '{\"222\":\"Adult\"}', '{\"lid\":\"236653ad21bc\",\"product_id\":72,\"version_id\":233,\"cell_key\":\"{\\\"222\\\":\\\"Adult\\\"}\",\"product_name\":\"Sightseeing Cruise (50 min)\",\"product_name_en\":\"Sightseeing Cruise (50 min)\",\"product_name_de\":null,\"agency\":\"Prague Boats\",\"agency_id\":9,\"image_path\":\"placeholders\\/ag-9.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":4,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":450,\"retail_eur\":18,\"ticket_date\":\"2026-06-05\",\"ticket_time\":\"11:30\",\"q\":{\"qty\":4,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":450,\"retail_eur\":18,\"customer_czk\":1800,\"customer_eur\":72,\"agency_czk\":1440,\"agency_eur\":57.6,\"margin_czk\":360,\"margin_eur\":14.4,\"bonus_czk\":36,\"bonus_eur\":1.44},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 4, 450.00, 18.00, 0.00, 1800.00, 72.00, 20.00, 360.00, 1440.00, 57.60, 10.00, 36.00, '2026-06-05', '11:30:00', '2026-06-05 10:35:40'),
(63, 53, 90, 136, '{\"124\":\"Tandem Skydiving\"}', '{\"lid\":\"f1515bf673df\",\"product_id\":90,\"version_id\":136,\"cell_key\":\"{\\\"124\\\":\\\"Tandem Skydiving\\\"}\",\"product_name\":\"Tandem Skydiving\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"Magical Prague\",\"agency_id\":14,\"image_path\":\"placeholders\\/ag-14.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":1,\"agency_deposit\":1,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Balíček\",\"value\":\"Tandem Skydiving\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":6200,\"retail_eur\":258,\"ticket_date\":\"2026-06-05\",\"ticket_time\":null,\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":6200,\"retail_eur\":258,\"customer_czk\":6200,\"customer_eur\":258,\"agency_czk\":4960,\"agency_eur\":206.4,\"margin_czk\":1240,\"margin_eur\":51.6,\"bonus_czk\":124,\"bonus_eur\":5.16},\"meeting_label\":\"Místo srazu\",\"meeting_address\":\"IC Mostecká 53\\/4, Praha 1\",\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 1, 6200.00, 258.00, 0.00, 6200.00, 258.00, 20.00, 1240.00, 4960.00, 206.40, 10.00, 124.00, '2026-06-05', NULL, '2026-06-05 10:38:59'),
(64, 54, 11, 169, '{\"158\":\"Adult\"}', '{\"lid\":\"ba4ab29934d1\",\"product_id\":11,\"version_id\":169,\"cell_key\":\"{\\\"158\\\":\\\"Adult\\\"}\",\"product_name\":\"Český Krumlov – UNESCO\",\"product_name_en\":\"Český Krumlov – UNESCO\",\"product_name_de\":null,\"agency\":\"Premiant\",\"agency_id\":2,\"image_path\":\"products\\/11_a093f527.webp\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1950,\"retail_eur\":78,\"ticket_date\":\"2026-06-05\",\"ticket_time\":\"08:45\",\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1950,\"retail_eur\":78,\"customer_czk\":3900,\"customer_eur\":156,\"agency_czk\":3120,\"agency_eur\":124.8,\"margin_czk\":780,\"margin_eur\":31.2,\"bonus_czk\":78,\"bonus_eur\":3.12},\"meeting_label\":\"Místo srazu\",\"meeting_address\":\"Premiant Point — Na Příkopě 23, Praha 1\",\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":\"en\",\"tour_lang_cs\":\"Angličtina\",\"tour_lang_en\":\"English\"}', 2, 1950.00, 78.00, 0.00, 3900.00, 156.00, 20.00, 780.00, 3120.00, 124.80, 10.00, 78.00, '2026-06-05', '08:45:00', '2026-06-05 10:39:56'),
(65, 55, 11, 169, '{\"158\":\"Adult\"}', '{\"lid\":\"8a280f39f70a\",\"product_id\":11,\"version_id\":169,\"cell_key\":\"{\\\"158\\\":\\\"Adult\\\"}\",\"product_name\":\"Český Krumlov – UNESCO\",\"product_name_en\":\"Český Krumlov – UNESCO\",\"product_name_de\":null,\"agency\":\"Premiant\",\"agency_id\":2,\"image_path\":\"products\\/11_a093f527.webp\",\"redemption_type\":\"direct_entry\",\"pickup_available\":1,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1950,\"retail_eur\":78,\"ticket_date\":\"2026-06-05\",\"ticket_time\":\"08:45\",\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1950,\"retail_eur\":78,\"customer_czk\":3900,\"customer_eur\":156,\"agency_czk\":3120,\"agency_eur\":124.8,\"margin_czk\":780,\"margin_eur\":31.2,\"bonus_czk\":78,\"bonus_eur\":3.12},\"meeting_label\":\"Místo srazu\",\"meeting_address\":\"Premiant Point — Na Příkopě 23, Praha 1\",\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":\"en\",\"tour_lang_cs\":\"Angličtina\",\"tour_lang_en\":\"English\"}', 2, 1950.00, 78.00, 0.00, 3900.00, 156.00, 20.00, 780.00, 3120.00, 124.80, 10.00, 78.00, '2026-06-05', '08:45:00', '2026-06-05 10:40:47'),
(66, 56, 72, 233, '{\"222\":\"Adult\"}', '{\"lid\":\"73102440f3ee\",\"product_id\":72,\"version_id\":233,\"cell_key\":\"{\\\"222\\\":\\\"Adult\\\"}\",\"product_name\":\"Sightseeing Cruise (50 min)\",\"product_name_en\":\"Sightseeing Cruise (50 min)\",\"product_name_de\":null,\"agency\":\"Prague Boats\",\"agency_id\":9,\"image_path\":\"placeholders\\/ag-9.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":4,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":450,\"retail_eur\":18,\"ticket_date\":\"2026-06-05\",\"ticket_time\":\"11:30\",\"q\":{\"qty\":4,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":450,\"retail_eur\":18,\"customer_czk\":1800,\"customer_eur\":72,\"agency_czk\":1440,\"agency_eur\":57.6,\"margin_czk\":360,\"margin_eur\":14.4,\"bonus_czk\":36,\"bonus_eur\":1.44},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 4, 450.00, 18.00, 0.00, 1800.00, 72.00, 20.00, 360.00, 1440.00, 57.60, 10.00, 36.00, '2026-06-05', '11:30:00', '2026-06-05 10:44:53'),
(67, 57, 81, 242, '{\"234\":\"Adult\"}', '{\"lid\":\"e60fc277db4b\",\"product_id\":81,\"version_id\":242,\"cell_key\":\"{\\\"234\\\":\\\"Adult\\\"}\",\"product_name\":\"Čertovka 45min Cruise (Prague Venice)\",\"product_name_en\":\"Čertovka 45min Cruise (Prague Venice)\",\"product_name_de\":null,\"agency\":\"Prague Venice\",\"agency_id\":10,\"image_path\":\"placeholders\\/ag-10.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":4,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":550,\"retail_eur\":22,\"ticket_date\":\"2026-06-05\",\"ticket_time\":null,\"q\":{\"qty\":4,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":550,\"retail_eur\":22,\"customer_czk\":2200,\"customer_eur\":88,\"agency_czk\":1760,\"agency_eur\":70.4,\"margin_czk\":440,\"margin_eur\":17.6,\"bonus_czk\":44,\"bonus_eur\":1.76},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 4, 550.00, 22.00, 0.00, 2200.00, 88.00, 20.00, 440.00, 1760.00, 70.40, 10.00, 44.00, '2026-06-05', NULL, '2026-06-05 10:45:18'),
(68, 58, 80, 241, '{\"232\":\"Exclusive\",\"233\":\"Adult\"}', '{\"lid\":\"0b2297407502\",\"product_id\":80,\"version_id\":241,\"cell_key\":\"{\\\"232\\\":\\\"Exclusive\\\",\\\"233\\\":\\\"Adult\\\"}\",\"product_name\":\"Dinner Cruise – Prague by Night (3h)\",\"product_name_en\":\"Dinner Cruise – Prague by Night (3h)\",\"product_name_de\":null,\"agency\":\"Prague Boats\",\"agency_id\":9,\"image_path\":\"placeholders\\/ag-9.svg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Třída\",\"value\":\"Exclusive\"},{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":2230,\"retail_eur\":89,\"ticket_date\":\"2026-06-05\",\"ticket_time\":\"19:00\",\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":2230,\"retail_eur\":89,\"customer_czk\":4460,\"customer_eur\":178,\"agency_czk\":3568,\"agency_eur\":142.4,\"margin_czk\":892,\"margin_eur\":35.6,\"bonus_czk\":89.2,\"bonus_eur\":3.56},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 2, 2230.00, 89.00, 0.00, 4460.00, 178.00, 20.00, 892.00, 3568.00, 142.40, 10.00, 89.20, '2026-06-05', '19:00:00', '2026-06-05 10:45:49'),
(69, 59, 118, 121, '{\"101\":\"Essential\",\"102\":\"Adult\"}', '{\"lid\":\"d9bf47059d0e\",\"product_id\":118,\"version_id\":121,\"cell_key\":\"{\\\"101\\\":\\\"Essential\\\",\\\"102\\\":\\\"Adult\\\"}\",\"product_name\":\"Big Bus Hop-on Hop-off\",\"product_name_en\":\"Big Bus Hop-on Hop-off\",\"product_name_de\":null,\"agency\":\"Big Bus Tours\",\"agency_id\":1,\"image_path\":\"products\\/118_90e93da6.jpg\",\"redemption_type\":\"bus_activation\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Varianta\",\"value\":\"Essential\"},{\"label\":\"Typ pasažéra\",\"value\":\"Adult\"}],\"qty\":4,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":900,\"retail_eur\":36,\"ticket_date\":null,\"ticket_time\":null,\"q\":{\"qty\":4,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":900,\"retail_eur\":36,\"customer_czk\":3600,\"customer_eur\":144,\"agency_czk\":2880,\"agency_eur\":115.2,\"margin_czk\":720,\"margin_eur\":28.8,\"bonus_czk\":72,\"bonus_eur\":2.88},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 4, 900.00, 36.00, 0.00, 3600.00, 144.00, 20.00, 720.00, 2880.00, 115.20, 10.00, 72.00, NULL, NULL, '2026-06-05 10:46:10'),
(70, 60, 118, 121, '{\"101\":\"Explore\",\"102\":\"Adult\"}', '{\"lid\":\"f0cde93a19ad\",\"product_id\":118,\"version_id\":121,\"cell_key\":\"{\\\"101\\\":\\\"Explore\\\",\\\"102\\\":\\\"Adult\\\"}\",\"product_name\":\"Big Bus Hop-on Hop-off\",\"product_name_en\":\"Big Bus Hop-on Hop-off\",\"product_name_de\":null,\"agency\":\"Big Bus Tours\",\"agency_id\":1,\"image_path\":\"products\\/118_90e93da6.jpg\",\"redemption_type\":\"bus_activation\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Varianta\",\"value\":\"Explore\"},{\"label\":\"Typ pasažéra\",\"value\":\"Adult\"}],\"qty\":11,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1020,\"retail_eur\":41,\"ticket_date\":null,\"ticket_time\":null,\"q\":{\"qty\":11,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1020,\"retail_eur\":41,\"customer_czk\":11220,\"customer_eur\":451,\"agency_czk\":8976,\"agency_eur\":360.8,\"margin_czk\":2244,\"margin_eur\":90.2,\"bonus_czk\":224.4,\"bonus_eur\":9.02},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 11, 1020.00, 41.00, 0.00, 11220.00, 451.00, 20.00, 2244.00, 8976.00, 360.80, 10.00, 224.40, NULL, NULL, '2026-06-05 16:00:22'),
(71, 61, 118, 121, '{\"101\":\"Discover\",\"102\":\"Adult\"}', '{\"lid\":\"a76e49753b8b\",\"product_id\":118,\"version_id\":121,\"cell_key\":\"{\\\"101\\\":\\\"Discover\\\",\\\"102\\\":\\\"Adult\\\"}\",\"product_name\":\"Big Bus Hop-on Hop-off\",\"product_name_en\":\"Big Bus Hop-on Hop-off\",\"product_name_de\":null,\"agency\":\"Big Bus Tours\",\"agency_id\":1,\"image_path\":\"products\\/118_90e93da6.jpg\",\"redemption_type\":\"bus_activation\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Varianta\",\"value\":\"Discover\"},{\"label\":\"Typ pasažéra\",\"value\":\"Adult\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":25,\"bonus_pct\":10,\"retail_czk\":780,\"retail_eur\":31,\"ticket_date\":null,\"ticket_time\":null,\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":25,\"bonus_pct\":10,\"retail_czk\":780,\"retail_eur\":31,\"customer_czk\":780,\"customer_eur\":31,\"agency_czk\":585,\"agency_eur\":23.25,\"margin_czk\":195,\"margin_eur\":7.75,\"bonus_czk\":19.5,\"bonus_eur\":0.78},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 1, 780.00, 31.00, 0.00, 780.00, 31.00, 25.00, 195.00, 585.00, 23.25, 10.00, 19.50, NULL, NULL, '2026-06-06 16:49:04'),
(72, 62, 143, 257, '{\"256\":\"VIP\",\"257\":\"Dospělý\"}', '{\"lid\":\"23d7423aafb5\",\"product_id\":143,\"version_id\":257,\"cell_key\":\"{\\\"256\\\":\\\"VIP\\\",\\\"257\\\":\\\"Dospělý\\\"}\",\"product_name\":\"Nutcracker Ballet\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"Agency Artistic Intl (AAI)\",\"agency_id\":5,\"image_path\":\"products\\/48_43929c18.webp\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Zóna\",\"value\":\"VIP\"},{\"label\":\"Návštěvník\",\"value\":\"Dospělý\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1450,\"retail_eur\":58,\"ticket_date\":\"2026-06-06\",\"ticket_time\":null,\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1450,\"retail_eur\":58,\"customer_czk\":2900,\"customer_eur\":116,\"agency_czk\":2320,\"agency_eur\":92.8,\"margin_czk\":580,\"margin_eur\":23.2,\"bonus_czk\":58,\"bonus_eur\":2.32},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":1,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 2, 1450.00, 58.00, 0.00, 2900.00, 116.00, 20.00, 580.00, 2320.00, 92.80, 10.00, 58.00, '2026-06-06', NULL, '2026-06-06 17:11:08'),
(73, 62, 143, 257, '{\"256\":\"VIP\",\"257\":\"Student a senior 64+\"}', '{\"lid\":\"2e83eab05e68\",\"product_id\":143,\"version_id\":257,\"cell_key\":\"{\\\"256\\\":\\\"VIP\\\",\\\"257\\\":\\\"Student a senior 64+\\\"}\",\"product_name\":\"Nutcracker Ballet\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"Agency Artistic Intl (AAI)\",\"agency_id\":5,\"image_path\":\"products\\/48_43929c18.webp\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Zóna\",\"value\":\"VIP\"},{\"label\":\"Návštěvník\",\"value\":\"Student a senior 64+\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1350,\"retail_eur\":54,\"ticket_date\":\"2026-06-06\",\"ticket_time\":null,\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1350,\"retail_eur\":54,\"customer_czk\":1350,\"customer_eur\":54,\"agency_czk\":1080,\"agency_eur\":43.2,\"margin_czk\":270,\"margin_eur\":10.8,\"bonus_czk\":27,\"bonus_eur\":1.08},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":1,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 1, 1350.00, 54.00, 0.00, 1350.00, 54.00, 20.00, 270.00, 1080.00, 43.20, 10.00, 27.00, '2026-06-06', NULL, '2026-06-06 17:11:08');
INSERT INTO `sale_items` (`id`, `sale_id`, `product_id`, `pricing_version_id`, `cell_key`, `snapshot_json`, `qty`, `unit_price_czk`, `unit_price_eur`, `discount_pct`, `line_total_czk`, `line_total_eur`, `commission_pct`, `commission_czk`, `agency_cost_czk`, `agency_cost_eur`, `seller_bonus_pct`, `seller_bonus_czk`, `ticket_date`, `ticket_time`, `created_at`) VALUES
(74, 62, 143, 257, '{\"256\":\"VIP\",\"257\":\"Dítě do 12 let\"}', '{\"lid\":\"02368910c362\",\"product_id\":143,\"version_id\":257,\"cell_key\":\"{\\\"256\\\":\\\"VIP\\\",\\\"257\\\":\\\"Dítě do 12 let\\\"}\",\"product_name\":\"Nutcracker Ballet\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"Agency Artistic Intl (AAI)\",\"agency_id\":5,\"image_path\":\"products\\/48_43929c18.webp\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Zóna\",\"value\":\"VIP\"},{\"label\":\"Návštěvník\",\"value\":\"Dítě do 12 let\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":725,\"retail_eur\":29,\"ticket_date\":\"2026-06-06\",\"ticket_time\":null,\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":725,\"retail_eur\":29,\"customer_czk\":725,\"customer_eur\":29,\"agency_czk\":580,\"agency_eur\":23.2,\"margin_czk\":145,\"margin_eur\":5.8,\"bonus_czk\":14.5,\"bonus_eur\":0.58},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":1,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 1, 725.00, 29.00, 0.00, 725.00, 29.00, 20.00, 145.00, 580.00, 23.20, 10.00, 14.50, '2026-06-06', NULL, '2026-06-06 17:11:08'),
(75, 63, 79, 240, '{\"230\":\"Essential\",\"231\":\"Adult\"}', '{\"lid\":\"514364b89318\",\"product_id\":79,\"version_id\":240,\"cell_key\":\"{\\\"230\\\":\\\"Essential\\\",\\\"231\\\":\\\"Adult\\\"}\",\"product_name\":\"Crystal Dinner Cruise (3h)\",\"product_name_en\":\"Crystal Dinner Cruise (3h)\",\"product_name_de\":null,\"agency\":\"Prague Boats\",\"agency_id\":9,\"image_path\":\"products\\/79_0f34683c.jpg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Třída\",\"value\":\"Essential\"},{\"label\":\"Návštěvník\",\"value\":\"Adult\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1980,\"retail_eur\":79,\"ticket_date\":\"2026-06-06\",\"ticket_time\":\"19:00\",\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1980,\"retail_eur\":79,\"customer_czk\":3960,\"customer_eur\":158,\"agency_czk\":3168,\"agency_eur\":126.4,\"margin_czk\":792,\"margin_eur\":31.6,\"bonus_czk\":79.2,\"bonus_eur\":3.16},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 2, 1980.00, 79.00, 0.00, 3960.00, 158.00, 20.00, 792.00, 3168.00, 126.40, 10.00, 79.20, '2026-06-06', '19:00:00', '2026-06-06 18:37:11'),
(76, 63, 79, 240, '{\"230\":\"Essential\",\"231\":\"Child 3-11\"}', '{\"lid\":\"aed04fccb048\",\"product_id\":79,\"version_id\":240,\"cell_key\":\"{\\\"230\\\":\\\"Essential\\\",\\\"231\\\":\\\"Child 3-11\\\"}\",\"product_name\":\"Crystal Dinner Cruise (3h)\",\"product_name_en\":\"Crystal Dinner Cruise (3h)\",\"product_name_de\":null,\"agency\":\"Prague Boats\",\"agency_id\":9,\"image_path\":\"products\\/79_0f34683c.jpg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Třída\",\"value\":\"Essential\"},{\"label\":\"Návštěvník\",\"value\":\"Child 3-11\"}],\"qty\":3,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1380,\"retail_eur\":55,\"ticket_date\":\"2026-06-06\",\"ticket_time\":\"19:00\",\"q\":{\"qty\":3,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":1380,\"retail_eur\":55,\"customer_czk\":4140,\"customer_eur\":165,\"agency_czk\":3312,\"agency_eur\":132,\"margin_czk\":828,\"margin_eur\":33,\"bonus_czk\":82.8,\"bonus_eur\":3.3},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 3, 1380.00, 55.00, 0.00, 4140.00, 165.00, 20.00, 828.00, 3312.00, 132.00, 10.00, 82.80, '2026-06-06', '19:00:00', '2026-06-06 18:37:11'),
(77, 64, 72, 233, '{\"222\":\"Adult\"}', '{\"lid\":\"7bad2756c7e5\",\"product_id\":72,\"version_id\":233,\"cell_key\":\"{\\\"222\\\":\\\"Adult\\\"}\",\"product_name\":\"Hodinová plavba po VltavěSightseeing Cruise (50 min)\",\"product_name_en\":\"One Hour Cruise - Sightseeing Cruise (50 min)\",\"product_name_de\":null,\"agency\":\"Prague Boats\",\"agency_id\":9,\"image_path\":\"products\\/72_49eef77d.jpg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Visitor\",\"value\":\"Adult\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":450,\"retail_eur\":18,\"ticket_date\":\"2026-06-06\",\"ticket_time\":\"11:30\",\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":450,\"retail_eur\":18,\"customer_czk\":900,\"customer_eur\":36,\"agency_czk\":720,\"agency_eur\":28.8,\"margin_czk\":180,\"margin_eur\":7.2,\"bonus_czk\":18,\"bonus_eur\":0.72},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 2, 450.00, 18.00, 0.00, 900.00, 36.00, 20.00, 180.00, 720.00, 28.80, 10.00, 18.00, '2026-06-06', '11:30:00', '2026-06-06 20:03:56'),
(78, 65, 118, 121, '{\"101\":\"Explore\",\"102\":\"Adult\"}', '{\"lid\":\"7045dc582d0a\",\"product_id\":118,\"version_id\":121,\"cell_key\":\"{\\\"101\\\":\\\"Explore\\\",\\\"102\\\":\\\"Adult\\\"}\",\"product_name\":\"Big Bus Hop-on Hop-off\",\"product_name_en\":\"Big Bus Hop-on Hop-off\",\"product_name_de\":null,\"agency\":\"Big Bus Tours\",\"agency_id\":1,\"image_path\":\"products\\/118_90e93da6.jpg\",\"redemption_type\":\"bus_activation\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Variant\",\"value\":\"Explore\"},{\"label\":\"Passenger type\",\"value\":\"Adult\"}],\"qty\":1,\"discount_pct\":0,\"commission_pct\":25,\"bonus_pct\":10,\"retail_czk\":1020,\"retail_eur\":41,\"ticket_date\":null,\"ticket_time\":null,\"q\":{\"qty\":1,\"discount_pct\":0,\"commission_pct\":25,\"bonus_pct\":10,\"retail_czk\":1020,\"retail_eur\":41,\"customer_czk\":1020,\"customer_eur\":41,\"agency_czk\":765,\"agency_eur\":30.75,\"margin_czk\":255,\"margin_eur\":10.25,\"bonus_czk\":25.5,\"bonus_eur\":1.03},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 1, 1020.00, 41.00, 0.00, 1020.00, 41.00, 25.00, 255.00, 765.00, 30.75, 10.00, 25.50, NULL, NULL, '2026-06-06 20:10:09'),
(79, 66, 115, 243, '{\"235\":\"Abrakadabra\",\"236\":\"Adult 15+\"}', '{\"lid\":\"904ff0ccba68\",\"product_id\":115,\"version_id\":243,\"cell_key\":\"{\\\"235\\\":\\\"Abrakadabra\\\",\\\"236\\\":\\\"Adult 15+\\\"}\",\"product_name\":\"Image Black Light Theatre\",\"product_name_en\":\"Image Black Light Theatre\",\"product_name_de\":null,\"agency\":\"Image Black Light Theatre\",\"agency_id\":16,\"image_path\":\"products\\/115_06163e7b.jpg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Show\",\"value\":\"Abrakadabra\"},{\"label\":\"Ticket\",\"value\":\"Adult 15+\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":590,\"retail_eur\":24,\"ticket_date\":\"2026-06-06\",\"ticket_time\":\"20:00\",\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":590,\"retail_eur\":24,\"customer_czk\":1180,\"customer_eur\":48,\"agency_czk\":944,\"agency_eur\":38.4,\"margin_czk\":236,\"margin_eur\":9.6,\"bonus_czk\":23.6,\"bonus_eur\":0.96},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":1,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 2, 590.00, 24.00, 0.00, 1180.00, 48.00, 20.00, 236.00, 944.00, 38.40, 10.00, 23.60, '2026-06-06', '20:00:00', '2026-06-06 20:49:58'),
(80, 67, 105, 151, '{\"140\":\"Per person\"}', '{\"lid\":\"feece3cb90dc\",\"product_id\":105,\"version_id\":151,\"cell_key\":\"{\\\"140\\\":\\\"Per person\\\"}\",\"product_name\":\"One Prague Tour Castle Side\",\"product_name_en\":null,\"product_name_de\":null,\"agency\":\"PragueWay\",\"agency_id\":15,\"image_path\":\"products\\/105_5c3a4c8d.jpg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":1,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Visitor\",\"value\":\"Per person\"}],\"qty\":2,\"discount_pct\":0,\"commission_pct\":25,\"bonus_pct\":10,\"retail_czk\":1300,\"retail_eur\":52,\"ticket_date\":\"2026-06-06\",\"ticket_time\":\"10:30\",\"q\":{\"qty\":2,\"discount_pct\":0,\"commission_pct\":25,\"bonus_pct\":10,\"retail_czk\":1300,\"retail_eur\":52,\"customer_czk\":2600,\"customer_eur\":104,\"agency_czk\":1950,\"agency_eur\":78,\"margin_czk\":650,\"margin_eur\":26,\"bonus_czk\":65,\"bonus_eur\":2.6},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":0,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 2, 1300.00, 52.00, 0.00, 2600.00, 104.00, 25.00, 650.00, 1950.00, 78.00, 10.00, 65.00, '2026-06-06', '10:30:00', '2026-06-06 20:53:31'),
(81, 68, 117, 245, '{\"238\":\"Adult\"}', '{\"lid\":\"ccf8a381c136\",\"product_id\":117,\"version_id\":245,\"cell_key\":\"{\\\"238\\\":\\\"Adult\\\"}\",\"product_name\":\"WOW Show – 4D Interactive Black Light\",\"product_name_en\":\"WOW Show – 4D Interactive Black Light\",\"product_name_de\":null,\"agency\":\"WOW Show\",\"agency_id\":18,\"image_path\":\"products\\/117_15c4d55c.jpg\",\"redemption_type\":\"direct_entry\",\"pickup_available\":0,\"pickup_required\":0,\"agency_deposit\":0,\"deposit_fixed_czk\":null,\"deposit_fixed_eur\":null,\"chosen\":[{\"label\":\"Ticket\",\"value\":\"Adult\"}],\"qty\":3,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":650,\"retail_eur\":26,\"ticket_date\":\"2026-06-06\",\"ticket_time\":\"20:00\",\"q\":{\"qty\":3,\"discount_pct\":0,\"commission_pct\":20,\"bonus_pct\":10,\"retail_czk\":650,\"retail_eur\":26,\"customer_czk\":1950,\"customer_eur\":78,\"agency_czk\":1560,\"agency_eur\":62.4,\"margin_czk\":390,\"margin_eur\":15.6,\"bonus_czk\":39,\"bonus_eur\":1.56},\"meeting_label\":null,\"meeting_address\":null,\"is_pickup\":0,\"pickup_addr\":null,\"pickup_time\":null,\"seating\":1,\"seats_note\":null,\"tour_lang\":null,\"tour_lang_cs\":null,\"tour_lang_en\":null}', 3, 650.00, 26.00, 0.00, 1950.00, 78.00, 20.00, 390.00, 1560.00, 62.40, 10.00, 39.00, '2026-06-06', '20:00:00', '2026-06-07 04:46:02');

-- --------------------------------------------------------

--
-- Struktura tabulky `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
CREATE TABLE `schema_migrations` (
  `version` varchar(20) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `applied_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`, `filename`, `applied_at`) VALUES
('001', '001_core_schema.sql', '2026-05-31 16:40:47'),
('002', '002_seed_min.sql', '2026-05-31 16:40:47'),
('003', '003_pricing_schema.sql', '2026-06-01 06:07:44'),
('004', '004_seed_agencies.sql', '2026-06-01 06:07:44'),
('005', '005_seed_products.sql', '2026-06-01 06:52:56'),
('006', '006_product_image.sql', '2026-06-01 07:00:31'),
('007', '007_sales_schema.sql', '2026-06-01 08:08:02'),
('008', '008_commission_bonus.sql', '2026-06-01 08:37:00'),
('009', '009_agency_commission_default.sql', '2026-06-01 08:37:00'),
('010', '010_open_tickets.sql', '2026-06-01 09:07:04'),
('011', '011_variant_cards.sql', '2026-06-01 10:11:45'),
('012', '012_crystal_diagram_features.sql', '2026-06-01 10:57:04'),
('013', '013_prague_boats_descriptions.sql', '2026-06-01 13:46:16'),
('014', '014_bigbus_merge.sql', '2026-06-01 13:46:16'),
('015', '015_prague_boats_seating.sql', '2026-06-01 13:46:16'),
('016', '016_magical_prague_packages.sql', '2026-06-01 13:46:16'),
('017', '017_bigbus_panoramic_fix.sql', '2026-06-01 13:46:16'),
('018', '018_order_instructions.sql', '2026-06-01 14:47:34'),
('020', '020_schedules.sql', '2026-06-01 15:52:23'),
('021', '021_placeholder_images.sql', '2026-06-01 15:52:23'),
('023', '023_catalog_schedules.sql', '2026-06-01 16:10:45'),
('026', '026_product_languages.sql', '2026-06-01 16:46:18'),
('027', '027_featured.sql', '2026-06-01 16:46:18'),
('028', '028_deposit.sql', '2026-06-01 17:53:37'),
('029', '029_meeting_point.sql', '2026-06-01 17:53:37'),
('030', '030_voucher_content.sql', '2026-06-02 12:53:59'),
('031', '031_voucher_content_seed.sql', '2026-06-02 12:55:19'),
('032', '032_meeting_points.sql', '2026-06-02 12:55:47'),
('033', '033_meeting_points_fix.sql', '2026-06-02 13:01:36'),
('034', '034_pricing_aai_cleanup.sql', '2026-06-02 13:01:57'),
('035', '035_aai_prices.sql', '2026-06-02 13:02:20'),
('036', '036_meeting_variants.sql', '2026-06-02 13:02:44'),
('037', '037_seating.sql', '2026-06-02 13:03:39'),
('038', '038_pricing_mozart_magical_folklore.sql', '2026-06-02 13:05:51'),
('039', '039_pricing_magical_prague.sql', '2026-06-02 13:06:52'),
('040', '040_addons.sql', '2026-06-02 13:07:19'),
('041', '041_folklore_details.sql', '2026-06-02 13:08:23'),
('042', '042_prices_pragueway_upavouka_premiant_besttour.sql', '2026-06-02 13:08:48'),
('043', '043_prices_martin_tour.sql', '2026-06-02 13:11:36'),
('044', '044_pragueway_new_and_bohemia_adventures.sql', '2026-06-02 13:11:36'),
('045', '045_prices_mcgees.sql', '2026-06-02 13:11:36'),
('046', '046_prices_prague_boats.sql', '2026-06-02 13:11:36'),
('047', '047_prices_prague_venice.sql', '2026-06-02 13:11:36'),
('048', '048_prices_image_srnec.sql', '2026-06-02 13:11:36'),
('049', '049_prices_wow.sql', '2026-06-02 13:11:36'),
('050', '050_postsale_ops.sql', '2026-06-02 15:10:01'),
('051', '051_bigbus_no_reservation.sql', '2026-06-02 18:08:01'),
('052', '052_deactivate_unpriced.sql', '2026-06-02 18:08:01'),
('053', '053_mozart_merge.sql', '2026-06-03 10:39:26'),
('054', '054_concert_pricing_repair.sql', '2026-06-03 10:39:26'),
('055', '055_martin_tour_schedules.sql', '2026-06-03 10:39:26'),
('056', '056_mcgees_pragueboats_schedules.sql', '2026-06-03 10:39:26'),
('057', '057_mcgees_seasonal.sql', '2026-06-03 10:39:26'),
('058', '058_remaining_schedules.sql', '2026-06-03 10:39:26'),
('059', '059_pragueboats_beerstory_devilschannel.sql', '2026-06-03 10:39:26'),
('061', '061_enrich_and_fix74.sql', '2026-06-03 10:39:26'),
('062', '062_enrich_mcgees.sql', '2026-06-03 10:39:26'),
('063', '063_enrich_pragueboats_premiant.sql', '2026-06-03 11:45:18'),
('064', '064_mozart_addons.sql', '2026-06-03 11:45:18'),
('065', '065_aai_concert_legend.sql', '2026-06-03 11:45:18'),
('067', '067_mcgees_language_variant.sql', '2026-06-03 11:45:18'),
('068', '068_seat_map.sql', '2026-06-03 12:39:19'),
('069', '069_martin_tour_busstop_labels.sql', '2026-06-03 12:39:19'),
('070', '070_martin_tour_meeting_detail.sql', '2026-06-03 14:07:38'),
('071', '071_bonus_payouts.sql', '2026-06-03 14:07:38'),
('072', '072_language_options.sql', '2026-06-03 15:32:32'),
('073', '073_product_pins.sql', '2026-06-04 09:34:55'),
('074', '074_product_attributes.sql', '2026-06-04 09:14:31'),
('075', '075_sale_reservation.sql', '2026-06-04 09:24:27'),
('076', '076_sale_public_token.sql', '2026-06-04 10:18:24'),
('077', '077_aai_visitor_discounts.sql', '2026-06-06 15:54:43'),
('078', '078_nutcracker_product.sql', '2026-06-06 15:56:14'),
('079', '079_product_content_en.sql', '2026-06-06 18:50:18'),
('080', '080_product_content_en_translations.sql', '2026-06-06 19:16:39'),
('081', '081_pricing_dimensions_en.sql', '2026-06-06 19:23:51'),
('082', '082_dimension_value_meta_en.sql', '2026-06-06 19:34:03'),
('083', '083_value_meta_en_rest.sql', '2026-06-06 19:37:34');

-- --------------------------------------------------------

--
-- Struktura tabulky `sellers`
--

DROP TABLE IF EXISTS `sellers`;
CREATE TABLE `sellers` (
  `id` int(10) UNSIGNED NOT NULL,
  `tenant_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `pin_hash` varchar(255) NOT NULL,
  `role` enum('seller','partner_seller') NOT NULL DEFAULT 'seller',
  `status` enum('active','inactive','archived') NOT NULL DEFAULT 'active',
  `last_login_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `sellers`
--

INSERT INTO `sellers` (`id`, `tenant_id`, `name`, `pin_hash`, `role`, `status`, `last_login_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'Karel', '$2y$12$AWnzMV1GM0yKkCwPn3G4g.8C3qJKyy6J3BlAoqXa9m10AtD6gfCnS', 'seller', 'active', '2026-06-03 14:40:11', '2026-05-31 17:09:35', '2026-06-03 14:40:11');

-- --------------------------------------------------------

--
-- Struktura tabulky `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` varchar(128) NOT NULL,
  `actor_type` enum('seller','admin') DEFAULT NULL,
  `actor_id` int(10) UNSIGNED DEFAULT NULL,
  `tenant_id` int(10) UNSIGNED DEFAULT NULL,
  `station_id` int(10) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `payload` mediumtext NOT NULL,
  `last_activity` int(10) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `sessions`
--

INSERT INTO `sessions` (`id`, `actor_type`, `actor_id`, `tenant_id`, `station_id`, `ip_address`, `user_agent`, `payload`, `last_activity`, `created_at`) VALUES
('053ca0a91d3305b1437bcf844b994cfe', NULL, NULL, NULL, NULL, '90.180.55.48', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/30.0 Chrome/143.0.0.0 Mobile Safari/537.36', '_csrf|s:64:\"9bc6a08e336eeb8fd7c891bf7bd0768d4758cf0b03144f2f5940189a0c671efb\";actor|a:7:{s:4:\"type\";s:7:\"station\";s:2:\"id\";N;s:4:\"name\";s:3:\"PTI\";s:4:\"role\";s:7:\"station\";s:9:\"tenant_id\";i:1;s:10:\"station_id\";N;s:8:\"login_at\";i:1780779607;}', 1780807680, '2026-06-06 21:00:07'),
('0813f392c3e7fe75fdca1e8319f35f30', NULL, NULL, NULL, NULL, '90.180.55.48', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '_csrf|s:64:\"1968458549d3a85e4df9238fee45ee3fbbf90d7c3eef012718f115f70c0f3bb1\";actor|a:7:{s:4:\"type\";s:7:\"station\";s:2:\"id\";N;s:4:\"name\";s:3:\"PTI\";s:4:\"role\";s:7:\"station\";s:9:\"tenant_id\";i:1;s:10:\"station_id\";N;s:8:\"login_at\";i:1780777602;}', 1780777609, '2026-06-06 20:26:42'),
('0f50792fdcf774c70aa15d24ca50204e', NULL, NULL, NULL, NULL, '37.188.236.163', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/30.0 Chrome/143.0.0.0 Mobile Safari/537.36', '_csrf|s:64:\"77d817e92213b60fbe2024570d3e86828bc00897d8733477241c9bd96f85014f\";actor|a:7:{s:4:\"type\";s:7:\"station\";s:2:\"id\";N;s:4:\"name\";s:3:\"PTI\";s:4:\"role\";s:7:\"station\";s:9:\"tenant_id\";i:1;s:10:\"station_id\";N;s:8:\"login_at\";i:1780569887;}', 1780578217, '2026-06-04 10:44:47'),
('19388385c9f362f54d0c997a3aa18a58', NULL, NULL, NULL, NULL, '90.180.55.48', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/30.0 Chrome/143.0.0.0 Mobile Safari/537.36', '_csrf|s:64:\"98b1a750e48abf37a21b15aa01bdba83ec8692f845d4827a1c7c343dce4c2f07\";actor|a:7:{s:4:\"type\";s:7:\"station\";s:2:\"id\";N;s:4:\"name\";s:3:\"PTI\";s:4:\"role\";s:7:\"station\";s:9:\"tenant_id\";i:1;s:10:\"station_id\";N;s:8:\"login_at\";i:1780755744;}', 1780779571, '2026-06-06 14:22:24'),
('2bad2c8fd548f288079ee8c1b4d29854', NULL, NULL, NULL, NULL, '90.180.55.48', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/30.0 Chrome/143.0.0.0 Mobile Safari/537.36', '_csrf|s:64:\"6bdcede8383e8c61f474e70cb3dae225105606ae6bef3faf0ab3e8ef0bbe730b\";actor|a:7:{s:4:\"type\";s:7:\"station\";s:2:\"id\";N;s:4:\"name\";s:3:\"PTI\";s:4:\"role\";s:7:\"station\";s:9:\"tenant_id\";i:1;s:10:\"station_id\";N;s:8:\"login_at\";i:1780522952;}', 1780549607, '2026-06-03 21:42:32'),
('31df6e7852fcb2b447a2c0de68d85bf9', NULL, NULL, NULL, NULL, '90.180.55.48', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/30.0 Chrome/143.0.0.0 Mobile Safari/537.36', '_csrf|s:64:\"61151c5bb8085163df7bd60a6cade9cea8135da83b1b0ee755cb49737378e98a\";actor|a:7:{s:4:\"type\";s:5:\"admin\";s:2:\"id\";i:1;s:4:\"name\";s:6:\"Michal\";s:5:\"email\";s:25:\"michal@prague-tourism.com\";s:4:\"role\";s:5:\"owner\";s:9:\"tenant_id\";N;s:8:\"login_at\";i:1780657126;}', 1780657289, '2026-06-05 10:58:46'),
('326972477a47af7b4b8a593fce702d2b', NULL, NULL, NULL, NULL, '90.180.55.48', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', '_csrf|s:64:\"f14b314d848cadb09389bcee11878bf50015870e6998c532a762d80e2a7d992d\";actor|a:7:{s:4:\"type\";s:7:\"station\";s:2:\"id\";N;s:4:\"name\";s:3:\"PTI\";s:4:\"role\";s:7:\"station\";s:9:\"tenant_id\";i:1;s:10:\"station_id\";N;s:8:\"login_at\";i:1780563778;}', 1780594033, '2026-06-04 09:02:58'),
('7f8ac615d17a6bd941b4d51de4653d01', NULL, NULL, NULL, NULL, '185.249.112.67', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0', '_csrf|s:64:\"1c16a0af5af35e14d42f712cb5692aa1f398347eab6cf2c201681118ce542a1f\";actor|a:7:{s:4:\"type\";s:7:\"station\";s:2:\"id\";N;s:4:\"name\";s:3:\"PTI\";s:4:\"role\";s:7:\"station\";s:9:\"tenant_id\";i:1;s:10:\"station_id\";N;s:8:\"login_at\";i:1780674306;}cart|a:1:{i:0;a:36:{s:3:\"lid\";s:12:\"6d76158021c4\";s:10:\"product_id\";i:111;s:10:\"version_id\";i:157;s:8:\"cell_key\";s:20:\"{\"146\":\"Per person\"}\";s:12:\"product_name\";s:31:\"Old Town & Medieval Underground\";s:15:\"product_name_en\";N;s:15:\"product_name_de\";N;s:6:\"agency\";s:9:\"PragueWay\";s:9:\"agency_id\";i:15;s:10:\"image_path\";s:25:\"products/111_cb0e727b.jpg\";s:15:\"redemption_type\";s:12:\"direct_entry\";s:16:\"pickup_available\";i:0;s:15:\"pickup_required\";i:0;s:14:\"agency_deposit\";i:1;s:17:\"deposit_fixed_czk\";N;s:17:\"deposit_fixed_eur\";N;s:6:\"chosen\";a:1:{i:0;a:2:{s:5:\"label\";s:14:\"Návštěvník\";s:5:\"value\";s:10:\"Per person\";}}s:3:\"qty\";i:2;s:12:\"discount_pct\";d:0;s:14:\"commission_pct\";d:25;s:9:\"bonus_pct\";d:10;s:10:\"retail_czk\";d:1400;s:10:\"retail_eur\";d:56;s:11:\"ticket_date\";s:10:\"2026-06-05\";s:11:\"ticket_time\";s:5:\"10:00\";s:1:\"q\";a:14:{s:3:\"qty\";i:2;s:12:\"discount_pct\";d:0;s:14:\"commission_pct\";d:25;s:9:\"bonus_pct\";d:10;s:10:\"retail_czk\";d:1400;s:10:\"retail_eur\";d:56;s:12:\"customer_czk\";d:2800;s:12:\"customer_eur\";d:112;s:10:\"agency_czk\";d:2100;s:10:\"agency_eur\";d:84;s:10:\"margin_czk\";d:700;s:10:\"margin_eur\";d:28;s:9:\"bonus_czk\";d:70;s:9:\"bonus_eur\";d:2.8;}s:13:\"meeting_label\";N;s:15:\"meeting_address\";N;s:9:\"is_pickup\";i:0;s:11:\"pickup_addr\";N;s:11:\"pickup_time\";N;s:7:\"seating\";i:0;s:10:\"seats_note\";N;s:9:\"tour_lang\";N;s:12:\"tour_lang_cs\";N;s:12:\"tour_lang_en\";N;}}', 1780675007, '2026-06-05 15:45:06'),
('8285966aac2bbee524b9de78978b9749', NULL, NULL, NULL, NULL, '185.249.112.67', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0', '_csrf|s:64:\"06391290bb87d0d2ef808490a8661c221240ca39be7b28f55786fdf5eddaaa70\";actor|a:7:{s:4:\"type\";s:7:\"station\";s:2:\"id\";N;s:4:\"name\";s:3:\"PTI\";s:4:\"role\";s:7:\"station\";s:9:\"tenant_id\";i:1;s:10:\"station_id\";N;s:8:\"login_at\";i:1780659441;}', 1780659442, '2026-06-05 11:37:21'),
('93addc39f15ee800913f9f633cdfe378', NULL, NULL, NULL, NULL, '185.249.112.67', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0', '_csrf|s:64:\"cf679f4dd6e867b1f478587e6319d81693198a303ff8e1d4b4b99b04a2a70ef2\";actor|a:7:{s:4:\"type\";s:7:\"station\";s:2:\"id\";N;s:4:\"name\";s:3:\"PTI\";s:4:\"role\";s:7:\"station\";s:9:\"tenant_id\";i:1;s:10:\"station_id\";N;s:8:\"login_at\";i:1780753965;}', 1780763228, '2026-06-06 13:52:45'),
('9bd34f6461a594b65d8c4dca42af22fc', NULL, NULL, NULL, NULL, '185.249.112.67', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0', '_csrf|s:64:\"1e323a6a0fa27cedf9abd9f0217bc9dbad938baf707137d4dee7cc9d7eb8d692\";actor|a:7:{s:4:\"type\";s:7:\"station\";s:2:\"id\";N;s:4:\"name\";s:3:\"PTI\";s:4:\"role\";s:7:\"station\";s:9:\"tenant_id\";i:1;s:10:\"station_id\";N;s:8:\"login_at\";i:1780667183;}', 1780667512, '2026-06-05 13:46:23'),
('a6fa18a2e32f2f4071a564e4d1cb5fa6', NULL, NULL, NULL, NULL, '90.180.55.48', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/30.0 Chrome/143.0.0.0 Mobile Safari/537.36', '_csrf|s:64:\"c04e414a53b4cb817f538a08bef54f1ae586b323f0e3156a59a0d57442e37c71\";actor|a:7:{s:4:\"type\";s:5:\"admin\";s:2:\"id\";i:1;s:4:\"name\";s:6:\"Michal\";s:5:\"email\";s:25:\"michal@prague-tourism.com\";s:4:\"role\";s:5:\"owner\";s:9:\"tenant_id\";N;s:8:\"login_at\";i:1780752893;}', 1780753354, '2026-06-06 13:34:53'),
('a8138fade54c25a6c17a33faad4d5268', NULL, NULL, NULL, NULL, '90.180.55.48', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', '_csrf|s:64:\"190168216ac437ce5f23f35aac77e1cb1dd01c87da31db11dbbc03c513adab7a\";actor|a:7:{s:4:\"type\";s:7:\"station\";s:2:\"id\";N;s:4:\"name\";s:3:\"PTI\";s:4:\"role\";s:7:\"station\";s:9:\"tenant_id\";i:1;s:10:\"station_id\";N;s:8:\"login_at\";i:1780774240;}', 1780779211, '2026-06-06 19:30:40'),
('a9daafe050fd3d0e0eebadba1a994b1d', NULL, NULL, NULL, NULL, '185.249.112.67', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0', '_csrf|s:64:\"9303ad64b8278f94a068ed7bb27a6faf2994fea548fdacc4737e84cbe1cd9668\";actor|a:7:{s:4:\"type\";s:7:\"station\";s:2:\"id\";N;s:4:\"name\";s:3:\"PTI\";s:4:\"role\";s:7:\"station\";s:9:\"tenant_id\";i:1;s:10:\"station_id\";N;s:8:\"login_at\";i:1780735428;}', 1780753365, '2026-06-06 08:43:48'),
('af272591bd82f8074dcc1e0f845d954f', NULL, NULL, NULL, NULL, '185.249.112.67', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0', '_csrf|s:64:\"8ac4ef2a1c03176830b4df7ada88d796c1eee011227dfc38f82182193323adfa\";actor|a:7:{s:4:\"type\";s:7:\"station\";s:2:\"id\";N;s:4:\"name\";s:3:\"PTI\";s:4:\"role\";s:7:\"station\";s:9:\"tenant_id\";i:1;s:10:\"station_id\";N;s:8:\"login_at\";i:1780672635;}', 1780672840, '2026-06-05 15:17:15'),
('afff3469a4e4b138977d24b209f1f10a', NULL, NULL, NULL, NULL, '185.249.112.67', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '_csrf|s:64:\"523943f575a2869e665edbd5bfdb4c16b75c596a5561d471e7776d094a2ba85b\";actor|a:7:{s:4:\"type\";s:5:\"admin\";s:2:\"id\";i:5;s:4:\"name\";s:5:\"Bahri\";s:5:\"email\";s:26:\"bahriberk.kayali@gmail.com\";s:4:\"role\";s:7:\"manager\";s:9:\"tenant_id\";N;s:8:\"login_at\";i:1780753922;}', 1780763193, '2026-06-06 13:52:02'),
('b30487d831f2a5ec3feb3e3e481c6953', NULL, NULL, NULL, NULL, '185.249.112.67', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '_csrf|s:64:\"4b2cbcf1d76a8fcc8bea789a14d96bcbdb640112cc72218c10c6da2635989b9d\";actor|a:7:{s:4:\"type\";s:5:\"admin\";s:2:\"id\";i:4;s:4:\"name\";s:5:\"Jarry\";s:5:\"email\";s:17:\"heligon@gmail.com\";s:4:\"role\";s:5:\"owner\";s:9:\"tenant_id\";N;s:8:\"login_at\";i:1780745769;}', 1780750463, '2026-06-06 11:36:09'),
('dc823d445ac3089a0f1d9d743019dda3', NULL, NULL, NULL, NULL, '185.249.114.234', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0', '_csrf|s:64:\"7a01d76120c880ab33f43b3e5c2b6ae5c43599e868ee54f4e47706fc648b985b\";actor|a:7:{s:4:\"type\";s:7:\"station\";s:2:\"id\";N;s:4:\"name\";s:3:\"PTI\";s:4:\"role\";s:7:\"station\";s:9:\"tenant_id\";i:1;s:10:\"station_id\";N;s:8:\"login_at\";i:1780577793;}', 1780578511, '2026-06-04 12:56:33'),
('e13eaa37ad7208dc1f22915da5319740', NULL, NULL, NULL, NULL, '37.188.163.165', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/30.0 Chrome/143.0.0.0 Mobile Safari/537.36', '_csrf|s:64:\"1e9b9091a9c952c276ef1a9f0cfb464dfed9d52c281371aba8565f747a5674b2\";actor|a:7:{s:4:\"type\";s:7:\"station\";s:2:\"id\";N;s:4:\"name\";s:3:\"PTI\";s:4:\"role\";s:7:\"station\";s:9:\"tenant_id\";i:1;s:10:\"station_id\";N;s:8:\"login_at\";i:1780722530;}', 1780722552, '2026-06-06 05:08:50'),
('fc882cd87daaefe08d4fcef45601393c', NULL, NULL, NULL, NULL, '185.249.112.67', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:151.0) Gecko/20100101 Firefox/151.0', '_csrf|s:64:\"02eb6cdac76ce3026aa747d2843b35b074d2e74c3068965769f1ed6666f4f1a5\";actor|a:7:{s:4:\"type\";s:7:\"station\";s:2:\"id\";N;s:4:\"name\";s:3:\"PTI\";s:4:\"role\";s:7:\"station\";s:9:\"tenant_id\";i:1;s:10:\"station_id\";N;s:8:\"login_at\";i:1780670364;}cart|a:1:{i:0;a:36:{s:3:\"lid\";s:12:\"3a6e42ec674f\";s:10:\"product_id\";i:118;s:10:\"version_id\";i:121;s:8:\"cell_key\";s:31:\"{\"101\":\"Explore\",\"102\":\"Adult\"}\";s:12:\"product_name\";s:22:\"Big Bus Hop-on Hop-off\";s:15:\"product_name_en\";s:22:\"Big Bus Hop-on Hop-off\";s:15:\"product_name_de\";N;s:6:\"agency\";s:13:\"Big Bus Tours\";s:9:\"agency_id\";i:1;s:10:\"image_path\";s:25:\"products/118_90e93da6.jpg\";s:15:\"redemption_type\";s:14:\"bus_activation\";s:16:\"pickup_available\";i:0;s:15:\"pickup_required\";i:0;s:14:\"agency_deposit\";i:0;s:17:\"deposit_fixed_czk\";N;s:17:\"deposit_fixed_eur\";N;s:6:\"chosen\";a:2:{i:0;a:2:{s:5:\"label\";s:8:\"Varianta\";s:5:\"value\";s:7:\"Explore\";}i:1;a:2:{s:5:\"label\";s:14:\"Typ pasažéra\";s:5:\"value\";s:5:\"Adult\";}}s:3:\"qty\";i:2;s:12:\"discount_pct\";d:0;s:14:\"commission_pct\";d:20;s:9:\"bonus_pct\";d:10;s:10:\"retail_czk\";d:1020;s:10:\"retail_eur\";d:41;s:11:\"ticket_date\";N;s:11:\"ticket_time\";N;s:1:\"q\";a:14:{s:3:\"qty\";i:2;s:12:\"discount_pct\";d:0;s:14:\"commission_pct\";d:20;s:9:\"bonus_pct\";d:10;s:10:\"retail_czk\";d:1020;s:10:\"retail_eur\";d:41;s:12:\"customer_czk\";d:2040;s:12:\"customer_eur\";d:82;s:10:\"agency_czk\";d:1632;s:10:\"agency_eur\";d:65.6;s:10:\"margin_czk\";d:408;s:10:\"margin_eur\";d:16.4;s:9:\"bonus_czk\";d:40.8;s:9:\"bonus_eur\";d:1.64;}s:13:\"meeting_label\";N;s:15:\"meeting_address\";N;s:9:\"is_pickup\";i:0;s:11:\"pickup_addr\";N;s:11:\"pickup_time\";N;s:7:\"seating\";i:0;s:10:\"seats_note\";N;s:9:\"tour_lang\";N;s:12:\"tour_lang_cs\";N;s:12:\"tour_lang_en\";N;}}', 1780670836, '2026-06-05 14:39:24'),
('fcf48fe0c1596dd091a8cda70636fba1', NULL, NULL, NULL, NULL, '90.180.55.48', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', '_csrf|s:64:\"8b1aa6c33a90ff5f0ba9da1c9f11e44539fa94ff53e5a5e2b85a3d5a0b2ae09e\";actor|a:7:{s:4:\"type\";s:7:\"station\";s:2:\"id\";N;s:4:\"name\";s:3:\"PTI\";s:4:\"role\";s:7:\"station\";s:9:\"tenant_id\";i:1;s:10:\"station_id\";N;s:8:\"login_at\";i:1780550661;}', 1780550773, '2026-06-04 05:24:21');

-- --------------------------------------------------------

--
-- Struktura tabulky `stations`
--

DROP TABLE IF EXISTS `stations`;
CREATE TABLE `stations` (
  `id` int(10) UNSIGNED NOT NULL,
  `tenant_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(40) DEFAULT NULL,
  `hours` varchar(190) DEFAULT NULL,
  `status` enum('active','inactive','archived') NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktura tabulky `tenants`
--

DROP TABLE IF EXISTS `tenants`;
CREATE TABLE `tenants` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `login_email` varchar(190) NOT NULL,
  `voucher_footer` varchar(255) DEFAULT NULL,
  `default_station_id` int(10) UNSIGNED DEFAULT NULL,
  `status` enum('active','inactive','archived') NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `tenants`
--

INSERT INTO `tenants` (`id`, `name`, `login_email`, `voucher_footer`, `default_station_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'PTI', 'info@prague-tourism.com', 'YOUR SALE: PTI', NULL, 'active', '2026-05-31 16:40:47', '2026-05-31 16:40:47'),
(2, 'Hotel U Šuterů', 'hotel@usuteru.com', 'YOUR SALE: Hotel U Šuterů', NULL, 'active', '2026-05-31 16:40:47', '2026-05-31 16:40:47');

-- --------------------------------------------------------

--
-- Struktura tabulky `vouchers`
--

DROP TABLE IF EXISTS `vouchers`;
CREATE TABLE `vouchers` (
  `id` int(10) UNSIGNED NOT NULL,
  `sale_id` int(10) UNSIGNED NOT NULL,
  `language` enum('cs','en','de') NOT NULL DEFAULT 'en',
  `language_secondary` enum('cs','en','de') DEFAULT NULL,
  `page_count` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `pdf_path` varchar(255) DEFAULT NULL,
  `status` enum('issued','voided','reissued') NOT NULL DEFAULT 'issued',
  `reissue_of` int(10) UNSIGNED DEFAULT NULL,
  `generated_at` timestamp NULL DEFAULT NULL,
  `printed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `vouchers`
--

INSERT INTO `vouchers` (`id`, `sale_id`, `language`, `language_secondary`, `page_count`, `pdf_path`, `status`, `reissue_of`, `generated_at`, `printed_at`, `created_at`) VALUES
(1, 1, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-01 17:45:37', NULL, '2026-06-01 17:45:37'),
(2, 2, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-01 17:54:43', NULL, '2026-06-01 17:54:43'),
(3, 3, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-01 17:57:20', NULL, '2026-06-01 17:57:20'),
(4, 4, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-01 19:54:32', NULL, '2026-06-01 19:54:32'),
(5, 5, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-01 20:00:51', NULL, '2026-06-01 20:00:51'),
(6, 6, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-01 20:04:25', NULL, '2026-06-01 20:04:25'),
(7, 7, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-01 20:06:40', NULL, '2026-06-01 20:06:40'),
(8, 8, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-01 21:12:52', NULL, '2026-06-01 21:12:52'),
(9, 9, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-02 13:20:12', NULL, '2026-06-02 13:20:12'),
(10, 10, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-02 15:13:28', NULL, '2026-06-02 15:13:28'),
(11, 11, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-02 16:15:54', NULL, '2026-06-02 16:15:54'),
(12, 12, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-02 17:17:12', NULL, '2026-06-02 17:17:12'),
(13, 13, 'en', NULL, 1, NULL, 'voided', NULL, '2026-06-02 17:21:50', NULL, '2026-06-02 17:21:50'),
(14, 14, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-02 17:24:56', NULL, '2026-06-02 17:24:56'),
(15, 15, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-02 17:26:06', NULL, '2026-06-02 17:26:06'),
(16, 16, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-02 17:27:35', NULL, '2026-06-02 17:27:35'),
(17, 17, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-02 18:15:50', NULL, '2026-06-02 18:15:50'),
(18, 18, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-02 18:35:21', NULL, '2026-06-02 18:35:21'),
(19, 19, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-02 18:45:54', NULL, '2026-06-02 18:45:54'),
(20, 20, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-02 18:58:07', NULL, '2026-06-02 18:58:07'),
(21, 21, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-02 19:02:32', NULL, '2026-06-02 19:02:32'),
(22, 22, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-02 19:06:27', NULL, '2026-06-02 19:06:27'),
(23, 23, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-02 20:04:29', NULL, '2026-06-02 20:04:29'),
(24, 24, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-03 11:58:04', NULL, '2026-06-03 11:58:04'),
(25, 25, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-03 14:14:49', NULL, '2026-06-03 14:14:49'),
(26, 26, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-03 14:16:34', NULL, '2026-06-03 14:16:34'),
(27, 27, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-03 14:41:46', NULL, '2026-06-03 14:41:46'),
(28, 28, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-03 14:43:16', NULL, '2026-06-03 14:43:16'),
(29, 29, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-03 15:33:39', NULL, '2026-06-03 15:33:39'),
(30, 30, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-03 15:35:51', NULL, '2026-06-03 15:35:51'),
(31, 31, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-03 17:08:04', NULL, '2026-06-03 17:08:04'),
(32, 32, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-03 17:26:47', NULL, '2026-06-03 17:26:47'),
(33, 33, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-03 20:01:12', NULL, '2026-06-03 20:01:12'),
(34, 34, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-03 20:08:31', NULL, '2026-06-03 20:08:31'),
(35, 35, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-03 21:00:02', NULL, '2026-06-03 21:00:02'),
(36, 39, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-04 07:15:42', NULL, '2026-06-04 07:15:42'),
(37, 40, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-04 09:03:43', NULL, '2026-06-04 09:03:43'),
(38, 41, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-04 09:25:05', NULL, '2026-06-04 09:25:05'),
(39, 42, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-04 10:18:13', NULL, '2026-06-04 10:18:13'),
(40, 43, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-04 10:19:05', NULL, '2026-06-04 10:19:05'),
(41, 44, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-04 10:47:19', NULL, '2026-06-04 10:47:19'),
(42, 45, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-04 12:26:36', NULL, '2026-06-04 12:26:36'),
(43, 46, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-04 15:01:51', NULL, '2026-06-04 15:01:51'),
(44, 47, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-04 17:31:48', NULL, '2026-06-04 17:31:48'),
(45, 48, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-04 18:08:27', NULL, '2026-06-04 18:08:27'),
(46, 49, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-05 10:33:10', NULL, '2026-06-05 10:33:10'),
(47, 50, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-05 10:34:02', NULL, '2026-06-05 10:34:02'),
(48, 51, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-05 10:35:11', NULL, '2026-06-05 10:35:11'),
(49, 52, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-05 10:35:40', NULL, '2026-06-05 10:35:40'),
(50, 53, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-05 10:38:59', NULL, '2026-06-05 10:38:59'),
(51, 54, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-05 10:39:56', NULL, '2026-06-05 10:39:56'),
(52, 55, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-05 10:40:47', NULL, '2026-06-05 10:40:47'),
(53, 56, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-05 10:44:53', NULL, '2026-06-05 10:44:53'),
(54, 57, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-05 10:45:18', NULL, '2026-06-05 10:45:18'),
(55, 58, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-05 10:45:49', NULL, '2026-06-05 10:45:49'),
(56, 59, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-05 10:46:10', NULL, '2026-06-05 10:46:10'),
(57, 60, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-05 16:00:22', NULL, '2026-06-05 16:00:22'),
(58, 61, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-06 16:49:04', NULL, '2026-06-06 16:49:04'),
(59, 62, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-06 17:11:08', NULL, '2026-06-06 17:11:08'),
(60, 63, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-06 18:37:11', NULL, '2026-06-06 18:37:11'),
(61, 64, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-06 20:03:56', NULL, '2026-06-06 20:03:56'),
(62, 65, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-06 20:10:09', NULL, '2026-06-06 20:10:09'),
(63, 66, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-06 20:49:58', NULL, '2026-06-06 20:49:58'),
(64, 67, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-06 20:53:31', NULL, '2026-06-06 20:53:31'),
(65, 68, 'en', NULL, 1, NULL, 'issued', NULL, '2026-06-07 04:46:02', NULL, '2026-06-07 04:46:02');

-- --------------------------------------------------------

--
-- Struktura tabulky `voucher_counters`
--

DROP TABLE IF EXISTS `voucher_counters`;
CREATE TABLE `voucher_counters` (
  `tenant_id` int(10) UNSIGNED NOT NULL,
  `year` smallint(5) UNSIGNED NOT NULL,
  `last_seq` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Vypisuji data pro tabulku `voucher_counters`
--

INSERT INTO `voucher_counters` (`tenant_id`, `year`, `last_seq`) VALUES
(0, 2026, 65);

--
-- Indexy pro exportované tabulky
--

--
-- Indexy pro tabulku `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_admins_email` (`email`),
  ADD KEY `idx_admins_home_tenant` (`home_tenant_id`);

--
-- Indexy pro tabulku `admin_recovery_codes`
--
ALTER TABLE `admin_recovery_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_recovery_admin` (`admin_id`);

--
-- Indexy pro tabulku `agencies`
--
ALTER TABLE `agencies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_agencies_status` (`status`);

--
-- Indexy pro tabulku `audit_log`
--
ALTER TABLE `audit_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_audit_actor` (`actor_type`,`actor_id`),
  ADD KEY `idx_audit_target` (`target_type`,`target_id`),
  ADD KEY `idx_audit_created` (`created_at`);

--
-- Indexy pro tabulku `bonus_payouts`
--
ALTER TABLE `bonus_payouts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_seller_day` (`tenant_id`,`seller_id`,`payout_day`),
  ADD KEY `k_day` (`payout_day`);

--
-- Indexy pro tabulku `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_categories_name_cs` (`name_cs`),
  ADD KEY `idx_categories_sort` (`sort_order`);

--
-- Indexy pro tabulku `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pro tabulku `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_attempts_lookup` (`scope`,`identifier`,`attempted_at`);

--
-- Indexy pro tabulku `pickups`
--
ALTER TABLE `pickups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `k_item` (`sale_item_id`);

--
-- Indexy pro tabulku `prices`
--
ALTER TABLE `prices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_price_cell` (`pricing_version_id`,`cell_key`);

--
-- Indexy pro tabulku `pricing_dimensions`
--
ALTER TABLE `pricing_dimensions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pd_product` (`product_id`);

--
-- Indexy pro tabulku `pricing_versions`
--
ALTER TABLE `pricing_versions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pv_product` (`product_id`),
  ADD KEY `idx_pv_status` (`status`);

--
-- Indexy pro tabulku `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_products_agency` (`agency_id`),
  ADD KEY `idx_products_status` (`status`);

--
-- Indexy pro tabulku `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`product_id`,`category_id`),
  ADD KEY `idx_pc_category` (`category_id`);

--
-- Indexy pro tabulku `product_pins`
--
ALTER TABLE `product_pins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_pin` (`context_type`,`context_id`,`product_id`),
  ADD KEY `idx_ctx` (`context_type`,`context_id`);

--
-- Indexy pro tabulku `product_schedules`
--
ALTER TABLE `product_schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `k_ps_product` (`product_id`);

--
-- Indexy pro tabulku `refunds`
--
ALTER TABLE `refunds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `k_sale` (`sale_id`);

--
-- Indexy pro tabulku `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_voucher_number` (`voucher_number`),
  ADD UNIQUE KEY `uq_sales_public_token` (`public_token`),
  ADD KEY `k_tenant` (`tenant_id`),
  ADD KEY `k_seller` (`seller_id`),
  ADD KEY `k_status` (`status`);

--
-- Indexy pro tabulku `sale_items`
--
ALTER TABLE `sale_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `k_sale` (`sale_id`);

--
-- Indexy pro tabulku `schema_migrations`
--
ALTER TABLE `schema_migrations`
  ADD PRIMARY KEY (`version`);

--
-- Indexy pro tabulku `sellers`
--
ALTER TABLE `sellers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_sellers_tenant` (`tenant_id`),
  ADD KEY `idx_sellers_status` (`status`);

--
-- Indexy pro tabulku `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_sessions_last_activity` (`last_activity`),
  ADD KEY `idx_sessions_actor` (`actor_type`,`actor_id`);

--
-- Indexy pro tabulku `stations`
--
ALTER TABLE `stations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_stations_tenant` (`tenant_id`);

--
-- Indexy pro tabulku `tenants`
--
ALTER TABLE `tenants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_tenants_login_email` (`login_email`);

--
-- Indexy pro tabulku `vouchers`
--
ALTER TABLE `vouchers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `k_sale` (`sale_id`);

--
-- Indexy pro tabulku `voucher_counters`
--
ALTER TABLE `voucher_counters`
  ADD PRIMARY KEY (`tenant_id`,`year`);

--
-- AUTO_INCREMENT pro tabulky
--

--
-- AUTO_INCREMENT pro tabulku `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pro tabulku `admin_recovery_codes`
--
ALTER TABLE `admin_recovery_codes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pro tabulku `agencies`
--
ALTER TABLE `agencies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT pro tabulku `audit_log`
--
ALTER TABLE `audit_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=209;

--
-- AUTO_INCREMENT pro tabulku `bonus_payouts`
--
ALTER TABLE `bonus_payouts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pro tabulku `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pro tabulku `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT pro tabulku `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=222;

--
-- AUTO_INCREMENT pro tabulku `pickups`
--
ALTER TABLE `pickups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pro tabulku `prices`
--
ALTER TABLE `prices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=850;

--
-- AUTO_INCREMENT pro tabulku `pricing_dimensions`
--
ALTER TABLE `pricing_dimensions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=258;

--
-- AUTO_INCREMENT pro tabulku `pricing_versions`
--
ALTER TABLE `pricing_versions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=258;

--
-- AUTO_INCREMENT pro tabulku `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;

--
-- AUTO_INCREMENT pro tabulku `product_pins`
--
ALTER TABLE `product_pins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pro tabulku `product_schedules`
--
ALTER TABLE `product_schedules`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT pro tabulku `refunds`
--
ALTER TABLE `refunds`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pro tabulku `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT pro tabulku `sale_items`
--
ALTER TABLE `sale_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT pro tabulku `sellers`
--
ALTER TABLE `sellers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pro tabulku `stations`
--
ALTER TABLE `stations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pro tabulku `tenants`
--
ALTER TABLE `tenants`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pro tabulku `vouchers`
--
ALTER TABLE `vouchers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `fk_admins_home_tenant` FOREIGN KEY (`home_tenant_id`) REFERENCES `tenants` (`id`);

--
-- Omezení pro tabulku `admin_recovery_codes`
--
ALTER TABLE `admin_recovery_codes`
  ADD CONSTRAINT `fk_recovery_admin` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`);

--
-- Omezení pro tabulku `prices`
--
ALTER TABLE `prices`
  ADD CONSTRAINT `fk_price_version` FOREIGN KEY (`pricing_version_id`) REFERENCES `pricing_versions` (`id`);

--
-- Omezení pro tabulku `pricing_dimensions`
--
ALTER TABLE `pricing_dimensions`
  ADD CONSTRAINT `fk_pd_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Omezení pro tabulku `pricing_versions`
--
ALTER TABLE `pricing_versions`
  ADD CONSTRAINT `fk_pv_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Omezení pro tabulku `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_agency` FOREIGN KEY (`agency_id`) REFERENCES `agencies` (`id`);

--
-- Omezení pro tabulku `product_categories`
--
ALTER TABLE `product_categories`
  ADD CONSTRAINT `fk_pc_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `fk_pc_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Omezení pro tabulku `sellers`
--
ALTER TABLE `sellers`
  ADD CONSTRAINT `fk_sellers_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);

--
-- Omezení pro tabulku `stations`
--
ALTER TABLE `stations`
  ADD CONSTRAINT `fk_stations_tenant` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`);
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
