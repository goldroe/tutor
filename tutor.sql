-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 06, 2023 at 02:54 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tutor`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `account_id` int(11) NOT NULL,
  `email` varchar(128) NOT NULL,
  `account_type` enum('admin','student','tutor') NOT NULL,
  `password` varchar(65) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `avatar` varchar(256) DEFAULT 'default.jpg',
  `about_me` text NOT NULL,
  `create_time` datetime NOT NULL,
  `tutoring_minutes` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `country` varchar(40) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `street` varchar(45) DEFAULT NULL,
  `province` varchar(45) DEFAULT NULL,
  `postal_code` varchar(45) DEFAULT NULL,
  `suite_number` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`account_id`, `email`, `account_type`, `password`, `first_name`, `last_name`, `gender`, `phone_number`, `avatar`, `about_me`, `create_time`, `tutoring_minutes`, `country`, `state`, `city`, `street`, `province`, `postal_code`, `suite_number`) VALUES
(14, 'car190000@utdallas.edu', 'student', '$2b$10$07m.jFJKajNbDccq3CiO2e7pmdbnW3/rXuRKXgbzX5WtonmiL.SmW', 'Carlos', 'Rivera', 'M', NULL, 'pic-4.jpg', 'CS student at UTD', '0000-00-00 00:00:00', 240, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, 'janedoe@hotmail.com', 'tutor', '$2b$10$VgiEXeQ6PXfSMpqDhw/6O.FC4UpFFsbHWS0VV0D93RLVmTaqokdsa', 'Jane', 'Doe', 'M', NULL, 'pic-5.jpg', 'teacher about me', '0000-00-00 00:00:00', 180, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, 'johndoe@hotmail.com', 'tutor', '$2b$10$/jeunZxndzLnL606KTN11OnHLfpUGjdmYW.pZA3CmzaaoUO0cGEdS', 'John', 'Doe', 'M', NULL, 'pic-1.jpg', 'This is John Doe. I teach for fun!', '0000-00-00 00:00:00', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, 'oscarshelton@utdallas.edu', 'tutor', '$2b$10$731oZrE6YjF6q0PC0P.LaODcAaV6jKFfbigy5dMWe4sEnHE4uvUii', 'Oscar', 'Shelton', 'M', NULL, 'pic-9.jpg', 'This is Oscar Shelton! I teach students topics surrounding full-stack development!', '0000-00-00 00:00:00', 120, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(28, 'carlos@email.org', 'student', '$2b$10$Kl1CqbnECCJm0hJoX/PpCuki99jBBbB9VQD4ZON72QkRiHX.fYwFi', 'Carlos', 'Rivera', 'M', NULL, 'pic-1.jpg', 'This is me!', '0000-00-00 00:00:00', 60, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(29, 'tom@email.org', 'tutor', '$2b$10$sNiXRiOYoOD1xHTsc34vGOp/3w8Z485CK.3Tilq0JaNuFZDcPr9/O', 'Tom', 'Hill', 'M', NULL, 'pic-9.jpg', 'About me!', '0000-00-00 00:00:00', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `appointment_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `tutor_id` int(11) NOT NULL,
  `time_begin` datetime NOT NULL,
  `time_end` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`appointment_id`, `subject_id`, `student_id`, `tutor_id`, `time_begin`, `time_end`) VALUES
(14, 5, 14, 16, '2023-05-01 12:00:00', '2023-05-01 13:00:00'),
(16, 4, 14, 18, '2023-05-01 08:00:00', '2023-05-01 10:00:00'),
(18, 5, 28, 16, '2023-05-31 12:00:00', '2023-05-31 13:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `availabilities`
--

CREATE TABLE `availabilities` (
  `availabilities_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `window_start` time NOT NULL,
  `window_end` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `availabilities`
--

INSERT INTO `availabilities` (`availabilities_id`, `account_id`, `window_start`, `window_end`) VALUES
(4, 16, '12:00:00', '13:00:00'),
(5, 17, '17:00:00', '18:00:00'),
(6, 18, '08:00:00', '10:00:00'),
(9, 29, '20:00:00', '22:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `favorite_list`
--

CREATE TABLE `favorite_list` (
  `favorite_list_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `tutor_id` int(11) NOT NULL,
  `on_subject_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `favorite_list`
--

INSERT INTO `favorite_list` (`favorite_list_id`, `student_id`, `tutor_id`, `on_subject_id`) VALUES
(27, 14, 16, 5),
(28, 14, 17, 4),
(29, 14, 18, 3),
(31, 14, 17, 6);

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `subject_id` int(11) NOT NULL,
  `subject_name` varchar(45) NOT NULL,
  `subject_description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subject`
--

INSERT INTO `subject` (`subject_id`, `subject_name`, `subject_description`) VALUES
(1, 'HTML', 'Introduction to HTML for front-end development'),
(2, 'CSS', 'Introduction to CSS for front-end development'),
(3, 'Javascript', 'Introduction to Javascript for front-end development'),
(4, 'React', 'Introduction to React for front-end development'),
(5, 'Calculus', 'Calculus is the mathematical study of change.'),
(6, 'Algebra', 'Algebra is a branch of mathematics, study of structure, relation and quantity. '),
(7, 'English Literature', 'English literature is literature written in the English language from the United Kingdom, and the United States.'),
(8, 'Chemistry', 'Chemistry is the scientific study of the properties and behavior of matter.');

-- --------------------------------------------------------

--
-- Table structure for table `subject_list`
--

CREATE TABLE `subject_list` (
  `subject_list_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subject_list`
--

INSERT INTO `subject_list` (`subject_list_id`, `account_id`, `subject_id`) VALUES
(14, 16, 5),
(15, 16, 6),
(16, 16, 7),
(17, 16, 8),
(18, 17, 3),
(19, 17, 4),
(20, 17, 6),
(21, 18, 1),
(22, 18, 2),
(23, 18, 3),
(24, 18, 4),
(30, 29, 5),
(31, 29, 6),
(32, 29, 7),
(33, 29, 8);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`account_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `fk_appointment_account1` (`student_id`),
  ADD KEY `fk_appointment_subject` (`subject_id`),
  ADD KEY `fk_appointment_account2` (`tutor_id`);

--
-- Indexes for table `availabilities`
--
ALTER TABLE `availabilities`
  ADD PRIMARY KEY (`availabilities_id`),
  ADD KEY `fk_availabilities_account` (`account_id`);

--
-- Indexes for table `favorite_list`
--
ALTER TABLE `favorite_list`
  ADD PRIMARY KEY (`favorite_list_id`),
  ADD KEY `fk_favoritelist_account1` (`student_id`),
  ADD KEY `fk_favoritelist_subject` (`on_subject_id`),
  ADD KEY `fk_favoritelist_account2` (`tutor_id`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`subject_id`);

--
-- Indexes for table `subject_list`
--
ALTER TABLE `subject_list`
  ADD PRIMARY KEY (`subject_list_id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `availabilities`
--
ALTER TABLE `availabilities`
  MODIFY `availabilities_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `favorite_list`
--
ALTER TABLE `favorite_list`
  MODIFY `favorite_list_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `subject`
--
ALTER TABLE `subject`
  MODIFY `subject_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `subject_list`
--
ALTER TABLE `subject_list`
  MODIFY `subject_list_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointment`
--
ALTER TABLE `appointment`
  ADD CONSTRAINT `fk_appointment_account1` FOREIGN KEY (`student_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_appointment_account2` FOREIGN KEY (`tutor_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_appointment_subject` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `availabilities`
--
ALTER TABLE `availabilities`
  ADD CONSTRAINT `fk_availabilities_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `favorite_list`
--
ALTER TABLE `favorite_list`
  ADD CONSTRAINT `fk_favoritelist_account1` FOREIGN KEY (`student_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_favoritelist_account2` FOREIGN KEY (`tutor_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_favoritelist_subject` FOREIGN KEY (`on_subject_id`) REFERENCES `subject` (`subject_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `subject_list`
--
ALTER TABLE `subject_list`
  ADD CONSTRAINT `subject_list_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `subject_list_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
