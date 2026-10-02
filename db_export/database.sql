-- IT0049 - Technical Formative Assessment 3
-- Database: it0049_pos
-- POS Foundations: From Arrays to a Real Database (Philippine Localization)

CREATE DATABASE IF NOT EXISTS `it0049_pos` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `it0049_pos`;

-- --------------------------------------------------------
-- Table structure for table `customers`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `full_name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `phone` VARCHAR(20),
    `created_at` DATETIME NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Seed data for table `customers` (6 sample records - Philippines)
-- --------------------------------------------------------

INSERT INTO `customers` (`id`, `full_name`, `email`, `phone`, `created_at`) VALUES
(1, 'Juan Dela Cruz', 'juan.delacruz@example.ph', '+63 917 123 4567', '2026-09-01 08:30:00'),
(2, 'Maria Clara Santos', 'maria.santos@example.ph', '+63 918 234 5678', '2026-09-02 09:15:00'),
(3, 'Gabriel Mendoza', 'gabriel.mendoza@example.ph', '+63 922 345 6789', '2026-09-03 10:45:00'),
(4, 'Angelica Reyes', 'angelica.reyes@example.ph', '+63 919 456 7890', '2026-09-04 11:20:00'),
(5, 'Patricia Bautista', 'patricia.bautista@example.ph', '+63 2 8923 4567', '2026-09-05 14:00:00'),
(6, 'Mateo Dimaculangan', 'mateo.dimaculangan@example.ph', '+63 908 567 8901', '2026-09-06 16:30:00');

-- --------------------------------------------------------
-- Table structure for table `users`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `full_name` VARCHAR(100) NOT NULL,
    `avatar` VARCHAR(255) NULL,
    `created_at` DATETIME NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Seed data for table `users` (6 sample records - Philippines)
-- --------------------------------------------------------

INSERT INTO `users` (`id`, `username`, `full_name`, `avatar`, `created_at`) VALUES
(1, 'maria.santos', 'Maria Clara Santos', NULL, '2026-08-15 08:00:00'),
(2, 'juan.delacruz', 'Juan Dela Cruz', NULL, '2026-08-16 09:00:00'),
(3, 'angelica.reyes', 'Angelica Reyes', NULL, '2026-08-17 10:00:00'),
(4, 'gabriel.mendoza', 'Gabriel Mendoza', NULL, '2026-08-18 11:00:00'),
(5, 'patricia.bautista', 'Patricia Bautista', NULL, '2026-08-19 13:00:00'),
(6, 'mateo.dimaculangan', 'Mateo Dimaculangan', NULL, '2026-08-20 15:00:00');
