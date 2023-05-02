-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 02, 2023 at 09:34 PM
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
(2, 'johndoe@hotmail.com', 'tutor', 'pass123', 'John', 'Doe', 'M', '123-456-6789', 'pic-3.jpg', 'teacher1 description.', '2023-04-26 23:40:33', 155, 'USA', 'Texas', 'Dallas', '123 Street Road', NULL, '123456', NULL),
(3, 'fnorris@outlook.com', 'tutor', 'password123', 'Faye', 'Norris', 'F', '123-123-4564', 'pic-7.jpg', 'teacher2 description.', '2023-04-27 02:20:16', 180, 'USA', 'Nebraska', 'Omaha', '298 Road Avenue', NULL, '45687', NULL),
(11, 'tomblow@outlook.com', 'tutor', 'tom123', 'Tom', 'Blow', 'M', NULL, 'pic-9.jpg', 'This is Tom Blow. A professional Web Dev, teaching full stsack development.', '0000-00-00 00:00:00', 60, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 'foobar@gmail.com', 'tutor', 'Foo@2001', 'foo', 'bar', 'M', NULL, 'pic-5.jpg', 'Sample foo bar', '0000-00-00 00:00:00', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, 'car190000@utdallas.edu', 'student', '$2b$10$07m.jFJKajNbDccq3CiO2e7pmdbnW3/rXuRKXgbzX5WtonmiL.SmW', 'Carlos', 'Rivera', 'M', NULL, 'pic-4.jpg', 'CS student at UTD', '0000-00-00 00:00:00', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
(1, 2, '16:00:00', '18:30:00'),
(2, 3, '15:00:00', '18:00:00'),
(3, 11, '12:00:00', '14:00:00');

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
(19, 14, 3, 5),
(20, 14, 11, 1),
(21, 14, 2, 6),
(22, 14, 2, 8),
(23, 14, 11, 3);

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
(1, 'HTML', 'Introduction to HTML'),
(2, 'CSS', 'Introduction to CSS'),
(3, 'Javascript', 'Introduction to Javascript'),
(4, 'React', 'Introduction to React'),
(5, 'Calculus', 'Calculus is the mathematical study of change.'),
(6, 'Algebra', 'Algebra is one of the main branches of mathematics, covering the study of structure, relation and quantity. '),
(7, 'English Literature', 'English literature is literature written in the English language from the United Kingdom, the Republic of Ireland, and the United States.'),
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
(1, 2, 1),
(2, 3, 2),
(3, 2, 6),
(4, 2, 8),
(5, 3, 5),
(6, 3, 4),
(10, 11, 1),
(11, 11, 2),
(12, 11, 3),
(13, 11, 4);

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
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `availabilities`
--
ALTER TABLE `availabilities`
  MODIFY `availabilities_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `favorite_list`
--
ALTER TABLE `favorite_list`
  MODIFY `favorite_list_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `subject`
--
ALTER TABLE `subject`
  MODIFY `subject_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `subject_list`
--
ALTER TABLE `subject_list`
  MODIFY `subject_list_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

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
