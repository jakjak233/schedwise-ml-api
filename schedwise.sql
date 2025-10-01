-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 23, 2025 at 12:10 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `schedwise`
--

-- --------------------------------------------------------

--
-- Table structure for table `classschedules`
--

CREATE TABLE `classschedules` (
  `schedule_id` int(11) NOT NULL,
  `faculty_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `time_start` time DEFAULT NULL,
  `time_end` time DEFAULT NULL,
  `days` varchar(10) DEFAULT NULL,
  `equivalent_units` decimal(4,2) DEFAULT NULL,
  `delivery_mode` enum('Face-to-face','Online','Hybrid') DEFAULT 'Face-to-face'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `classschedules`
--

INSERT INTO `classschedules` (`schedule_id`, `faculty_id`, `course_id`, `section_id`, `room_id`, `time_start`, `time_end`, `days`, `equivalent_units`, `delivery_mode`) VALUES
(9293, 64, 131, 76, 31, '07:30:00', '09:00:00', 'W', 3.00, 'Face-to-face'),
(9294, 64, 131, 76, 50, '07:30:00', '09:00:00', 'M', 3.00, 'Online'),
(9295, 63, 131, 77, 33, '07:30:00', '09:00:00', 'TH', 3.00, 'Face-to-face'),
(9296, 63, 131, 77, 50, '07:30:00', '09:00:00', 'T', 3.00, 'Online'),
(9297, 64, 131, 78, 32, '07:30:00', '09:00:00', 'F', 3.00, 'Face-to-face'),
(9298, 64, 131, 78, 50, '09:00:00', '10:30:00', 'W', 3.00, 'Online'),
(9299, 63, 131, 79, 31, '07:30:00', '09:00:00', 'M', 3.00, 'Face-to-face'),
(9300, 63, 131, 79, 50, '09:00:00', '10:30:00', 'TH', 3.00, 'Online'),
(9301, 61, 132, 76, 33, '09:00:00', '10:30:00', 'TH', 3.00, 'Face-to-face'),
(9302, 61, 132, 76, 50, '07:30:00', '09:00:00', 'T', 3.00, 'Online'),
(9303, 61, 132, 77, 32, '09:00:00', '10:30:00', 'F', 3.00, 'Face-to-face'),
(9304, 61, 132, 77, 50, '07:30:00', '09:00:00', 'W', 3.00, 'Online'),
(9305, 61, 132, 78, 31, '09:00:00', '10:30:00', 'M', 3.00, 'Face-to-face'),
(9306, 61, 132, 78, 50, '07:30:00', '09:00:00', 'TH', 3.00, 'Online'),
(9307, 61, 132, 79, 33, '09:00:00', '10:30:00', 'T', 3.00, 'Face-to-face'),
(9308, 61, 132, 79, 50, '07:30:00', '09:00:00', 'F', 3.00, 'Online'),
(9309, 65, 133, 76, 32, '10:30:00', '12:00:00', 'F', 3.00, 'Face-to-face'),
(9310, 65, 133, 76, 50, '09:00:00', '10:30:00', 'W', 3.00, 'Online'),
(9311, 65, 133, 77, 31, '10:30:00', '12:00:00', 'M', 3.00, 'Face-to-face'),
(9312, 65, 133, 77, 50, '09:00:00', '10:30:00', 'TH', 3.00, 'Online'),
(9313, 65, 133, 78, 33, '07:30:00', '09:00:00', 'T', 3.00, 'Face-to-face'),
(9314, 65, 133, 78, 50, '09:00:00', '10:30:00', 'F', 3.00, 'Online'),
(9315, 64, 133, 79, 32, '10:30:00', '12:00:00', 'W', 3.00, 'Face-to-face'),
(9316, 64, 133, 79, 50, '09:00:00', '10:30:00', 'M', 3.00, 'Online'),
(9317, 61, 134, 76, 31, '13:30:00', '15:00:00', 'M', 3.00, 'Face-to-face'),
(9318, 61, 134, 76, 50, '10:30:00', '12:00:00', 'TH', 3.00, 'Online'),
(9319, 61, 134, 77, 33, '10:30:00', '12:00:00', 'T', 3.00, 'Face-to-face'),
(9320, 61, 134, 77, 50, '10:30:00', '12:00:00', 'F', 3.00, 'Online'),
(9321, 61, 134, 78, 32, '13:30:00', '15:00:00', 'W', 3.00, 'Face-to-face'),
(9322, 61, 134, 78, 50, '07:30:00', '09:00:00', 'M', 3.00, 'Online'),
(9323, 61, 134, 79, 31, '13:30:00', '15:00:00', 'TH', 3.00, 'Face-to-face'),
(9324, 61, 134, 79, 50, '13:30:00', '15:00:00', 'T', 3.00, 'Online'),
(9325, 69, 135, 76, 33, '13:30:00', '15:00:00', 'T', 3.00, 'Face-to-face'),
(9326, 69, 135, 76, 50, '07:30:00', '09:00:00', 'F', 3.00, 'Online'),
(9327, 66, 135, 77, 32, '09:00:00', '10:30:00', 'W', 3.00, 'Face-to-face'),
(9328, 66, 135, 77, 50, '07:30:00', '09:00:00', 'M', 3.00, 'Online'),
(9329, 69, 135, 78, 31, '09:00:00', '10:30:00', 'TH', 3.00, 'Face-to-face'),
(9330, 69, 135, 78, 50, '09:00:00', '10:30:00', 'T', 3.00, 'Online'),
(9331, 66, 135, 79, 33, '09:00:00', '10:30:00', 'F', 3.00, 'Face-to-face'),
(9332, 66, 135, 79, 50, '07:30:00', '09:00:00', 'W', 3.00, 'Online'),
(9333, 65, 138, 80, 32, '07:30:00', '09:00:00', 'TH', 3.00, 'Face-to-face'),
(9334, 65, 138, 80, 50, '09:00:00', '10:30:00', 'T', 3.00, 'Online'),
(9335, 64, 138, 81, 31, '09:00:00', '10:30:00', 'F', 3.00, 'Face-to-face'),
(9336, 64, 138, 81, 50, '13:30:00', '15:00:00', 'W', 3.00, 'Online'),
(9337, 65, 138, 82, 33, '07:30:00', '09:00:00', 'M', 3.00, 'Face-to-face'),
(9338, 65, 138, 82, 50, '10:30:00', '12:00:00', 'TH', 3.00, 'Online'),
(9339, 58, 140, 80, 32, '07:30:00', '09:00:00', 'M', 3.00, 'Face-to-face'),
(9340, 58, 140, 80, 50, '09:00:00', '10:30:00', 'TH', 3.00, 'Online'),
(9341, 58, 140, 81, 31, '07:30:00', '09:00:00', 'T', 3.00, 'Face-to-face'),
(9342, 58, 140, 81, 50, '07:30:00', '09:00:00', 'F', 3.00, 'Online'),
(9343, 58, 140, 82, 33, '07:30:00', '09:00:00', 'W', 3.00, 'Face-to-face'),
(9344, 58, 140, 82, 50, '09:00:00', '10:30:00', 'M', 3.00, 'Online'),
(9345, 58, 141, 80, 32, '10:30:00', '12:00:00', 'T', 3.00, 'Face-to-face'),
(9346, 58, 141, 80, 50, '09:00:00', '10:30:00', 'F', 3.00, 'Online'),
(9347, 58, 141, 81, 31, '09:00:00', '10:30:00', 'W', 3.00, 'Face-to-face'),
(9348, 58, 141, 81, 50, '10:30:00', '12:00:00', 'M', 3.00, 'Online'),
(9349, 58, 141, 82, 33, '13:30:00', '15:00:00', 'TH', 3.00, 'Face-to-face'),
(9350, 58, 141, 82, 50, '09:00:00', '10:30:00', 'T', 3.00, 'Online'),
(9351, 59, 139, 80, 32, '13:30:00', '15:00:00', 'F', 3.00, 'Face-to-face'),
(9352, 59, 139, 80, 50, '07:30:00', '09:00:00', 'W', 3.00, 'Online'),
(9353, 59, 139, 81, 31, '15:00:00', '16:30:00', 'M', 3.00, 'Face-to-face'),
(9354, 59, 139, 81, 50, '07:30:00', '09:00:00', 'TH', 3.00, 'Online'),
(9355, 59, 139, 82, 33, '15:00:00', '16:30:00', 'T', 3.00, 'Face-to-face'),
(9356, 59, 139, 82, 50, '07:30:00', '09:00:00', 'F', 3.00, 'Online'),
(9357, 62, 142, 80, 32, '15:00:00', '16:30:00', 'W', 6.00, 'Face-to-face'),
(9358, 62, 142, 80, 50, '09:00:00', '10:30:00', 'M', 6.00, 'Online'),
(9359, 62, 142, 81, 31, '10:30:00', '12:00:00', 'TH', 6.00, 'Face-to-face'),
(9360, 62, 142, 81, 50, '09:00:00', '10:30:00', 'T', 6.00, 'Online'),
(9361, 62, 142, 82, 33, '10:30:00', '12:00:00', 'F', 6.00, 'Face-to-face'),
(9362, 62, 142, 82, 50, '09:00:00', '10:30:00', 'W', 6.00, 'Online'),
(9363, 60, 143, 83, 32, '07:30:00', '09:00:00', 'T', 3.00, 'Face-to-face'),
(9364, 60, 143, 83, 50, '07:30:00', '09:00:00', 'F', 3.00, 'Online'),
(9365, 60, 143, 84, 31, '10:30:00', '12:00:00', 'W', 3.00, 'Face-to-face'),
(9366, 60, 143, 84, 50, '07:30:00', '09:00:00', 'M', 3.00, 'Online'),
(9367, 60, 143, 85, 33, '10:30:00', '12:00:00', 'TH', 3.00, 'Face-to-face'),
(9368, 60, 143, 85, 50, '09:00:00', '10:30:00', 'T', 3.00, 'Online'),
(9369, 60, 144, 83, 32, '07:30:00', '09:00:00', 'W', 3.00, 'Face-to-face'),
(9370, 60, 144, 83, 50, '09:00:00', '10:30:00', 'M', 3.00, 'Online'),
(9371, 60, 144, 84, 31, '07:30:00', '09:00:00', 'TH', 3.00, 'Face-to-face'),
(9372, 60, 144, 84, 50, '10:30:00', '12:00:00', 'T', 3.00, 'Online'),
(9373, 60, 144, 85, 33, '13:30:00', '15:00:00', 'F', 3.00, 'Face-to-face'),
(9374, 60, 144, 85, 50, '09:00:00', '10:30:00', 'W', 3.00, 'Online'),
(9375, 62, 145, 83, 32, '09:00:00', '10:30:00', 'TH', 3.00, 'Face-to-face'),
(9376, 62, 145, 83, 50, '10:30:00', '12:00:00', 'T', 3.00, 'Online'),
(9377, 62, 145, 84, 31, '07:30:00', '09:00:00', 'F', 3.00, 'Face-to-face'),
(9378, 62, 145, 84, 50, '07:30:00', '09:00:00', 'W', 3.00, 'Online'),
(9379, 62, 145, 85, 33, '10:30:00', '12:00:00', 'M', 3.00, 'Face-to-face'),
(9380, 62, 145, 85, 50, '07:30:00', '09:00:00', 'TH', 3.00, 'Online'),
(9381, 61, 146, 83, 32, '15:00:00', '16:30:00', 'F', 3.00, 'Face-to-face'),
(9382, 61, 146, 83, 50, '09:00:00', '10:30:00', 'W', 3.00, 'Online'),
(9383, 61, 146, 84, 31, '15:00:00', '16:30:00', 'T', 3.00, 'Face-to-face'),
(9384, 61, 146, 84, 50, '15:00:00', '16:30:00', 'TH', 3.00, 'Online'),
(9385, 56, 147, 83, 33, '13:30:00', '15:00:00', 'M', 3.00, 'Face-to-face'),
(9386, 56, 147, 83, 50, '07:30:00', '09:00:00', 'TH', 3.00, 'Online'),
(9387, 56, 147, 84, 32, '09:00:00', '10:30:00', 'T', 3.00, 'Face-to-face'),
(9388, 56, 147, 84, 50, '09:00:00', '10:30:00', 'F', 3.00, 'Online'),
(9389, 56, 147, 85, 31, '13:30:00', '15:00:00', 'W', 3.00, 'Face-to-face'),
(9390, 56, 147, 85, 50, '07:30:00', '09:00:00', 'M', 3.00, 'Online'),
(9391, 59, 148, 83, 33, '10:30:00', '12:00:00', 'W', 3.00, 'Face-to-face'),
(9392, 59, 148, 83, 50, '09:00:00', '10:30:00', 'F', 3.00, 'Online'),
(9393, 59, 148, 84, 32, '10:30:00', '12:00:00', 'TH', 3.00, 'Face-to-face'),
(9394, 59, 148, 84, 50, '09:00:00', '10:30:00', 'M', 3.00, 'Online'),
(9395, 59, 148, 85, 31, '15:00:00', '16:30:00', 'TH', 3.00, 'Face-to-face'),
(9396, 59, 148, 85, 50, '07:30:00', '09:00:00', 'T', 3.00, 'Online'),
(9397, 58, 149, 83, 33, '13:30:00', '15:00:00', 'W', 3.00, 'Face-to-face'),
(9398, 58, 149, 83, 50, '15:00:00', '16:30:00', 'M', 3.00, 'Online'),
(9399, 58, 149, 84, 32, '13:30:00', '15:00:00', 'M', 3.00, 'Face-to-face'),
(9400, 58, 149, 84, 50, '13:30:00', '15:00:00', 'T', 3.00, 'Online'),
(9401, 58, 149, 85, 31, '10:30:00', '12:00:00', 'F', 3.00, 'Face-to-face'),
(9402, 58, 149, 85, 50, '10:30:00', '12:00:00', 'W', 3.00, 'Online'),
(9403, 62, 151, 86, 33, '15:00:00', '16:30:00', 'TH', 6.00, 'Face-to-face'),
(9404, 62, 151, 86, 50, '07:30:00', '09:00:00', 'M', 6.00, 'Online'),
(9405, 68, 153, 76, 46, '09:00:00', '10:30:00', 'F', 3.00, 'Face-to-face'),
(9406, 68, 153, 76, 50, '10:30:00', '12:00:00', 'W', 3.00, 'Online'),
(9407, 68, 153, 77, 47, '09:00:00', '10:30:00', 'M', 3.00, 'Face-to-face'),
(9408, 68, 153, 77, 50, '10:30:00', '12:00:00', 'TH', 3.00, 'Online'),
(9409, 68, 153, 78, 35, '10:30:00', '12:00:00', 'T', 3.00, 'Face-to-face'),
(9410, 68, 153, 78, 50, '10:30:00', '12:00:00', 'F', 3.00, 'Online'),
(9411, 68, 153, 79, 46, '09:00:00', '10:30:00', 'W', 3.00, 'Face-to-face'),
(9412, 68, 153, 79, 50, '10:30:00', '12:00:00', 'M', 3.00, 'Online'),
(9413, 72, 136, 76, 47, '13:30:00', '15:00:00', 'W', 3.00, 'Face-to-face'),
(9414, 72, 136, 76, 50, '09:00:00', '10:30:00', 'M', 3.00, 'Online'),
(9415, 72, 136, 77, 35, '13:30:00', '15:00:00', 'TH', 3.00, 'Face-to-face'),
(9416, 72, 136, 77, 50, '09:00:00', '10:30:00', 'T', 3.00, 'Online'),
(9417, 72, 136, 78, 46, '13:30:00', '15:00:00', 'F', 3.00, 'Face-to-face'),
(9418, 72, 136, 78, 50, '07:30:00', '09:00:00', 'W', 3.00, 'Online'),
(9419, 72, 136, 79, 47, '13:30:00', '15:00:00', 'M', 3.00, 'Face-to-face'),
(9420, 72, 136, 79, 50, '07:30:00', '09:00:00', 'TH', 3.00, 'Online'),
(9421, 72, 137, 76, 35, '15:00:00', '16:30:00', 'TH', 3.00, 'Face-to-face'),
(9422, 72, 137, 76, 50, '10:30:00', '12:00:00', 'T', 3.00, 'Online'),
(9423, 69, 137, 77, 46, '15:00:00', '16:30:00', 'F', 3.00, 'Face-to-face'),
(9424, 69, 137, 77, 50, '10:30:00', '12:00:00', 'W', 3.00, 'Online'),
(9425, 69, 137, 78, 47, '10:30:00', '12:00:00', 'M', 3.00, 'Face-to-face'),
(9426, 69, 137, 78, 50, '10:30:00', '12:00:00', 'TH', 3.00, 'Online'),
(9427, 69, 137, 79, 35, '07:30:00', '09:00:00', 'T', 3.00, 'Face-to-face'),
(9428, 69, 137, 79, 50, '10:30:00', '12:00:00', 'F', 3.00, 'Online'),
(9429, 68, 150, 83, 46, '13:30:00', '15:00:00', 'TH', 3.00, 'Face-to-face'),
(9430, 68, 150, 83, 50, '09:00:00', '10:30:00', 'T', 3.00, 'Online'),
(9431, 57, 146, 85, 32, '13:30:00', '15:00:00', 'T', 3.00, 'Face-to-face'),
(9432, 57, 146, 85, 50, '07:30:00', '09:00:00', 'F', 3.00, 'Online'),
(9433, 67, 150, 84, 47, '10:30:00', '12:00:00', 'F', 3.00, 'Face-to-face'),
(9434, 67, 150, 84, 50, '09:00:00', '10:30:00', 'W', 3.00, 'Online'),
(9435, 70, 150, 85, 35, '09:00:00', '10:30:00', 'M', 3.00, 'Face-to-face'),
(9436, 70, 150, 85, 50, '09:00:00', '10:30:00', 'TH', 3.00, 'Online'),
(9437, 71, 152, 86, 46, '07:30:00', '09:00:00', 'TH', 1.00, 'Face-to-face'),
(9438, 71, 152, 86, 50, '07:30:00', '09:00:00', 'T', 1.00, 'Online');

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_id` int(11) NOT NULL,
  `course_code` varchar(20) NOT NULL,
  `descriptive_title` varchar(200) NOT NULL,
  `units` int(11) NOT NULL,
  `course_type` enum('Major','Minor') DEFAULT 'Major',
  `year_level` int(11) DEFAULT 1,
  `semester` enum('1st Sem','2nd Sem') DEFAULT '1st Sem',
  `lecture_hours` float DEFAULT 1.5,
  `laboratory_hours` float DEFAULT 1.5,
  `delivery_mode` enum('Face-to-face','Online') DEFAULT 'Face-to-face',
  `program_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`course_id`, `course_code`, `descriptive_title`, `units`, `course_type`, `year_level`, `semester`, `lecture_hours`, `laboratory_hours`, `delivery_mode`, `program_id`) VALUES
(131, 'CCSIT 200', 'Discrete Mathematics', 3, 'Major', 1, '2nd Sem', 2, 1, 'Face-to-face', 19),
(132, 'CCSIT 201', 'Data Communication and Networking 1', 3, 'Major', 1, '2nd Sem', 2, 1, 'Face-to-face', 19),
(133, 'IT 103', 'Intermediate Programming', 3, 'Major', 1, '2nd Sem', 2, 1, 'Face-to-face', 19),
(134, 'IT 104', 'Data Structures and Algorithms', 3, 'Major', 1, '2nd Sem', 2, 1, 'Face-to-face', 19),
(135, 'RIZAL', 'Life and Works of Rizal', 3, 'Major', 1, '2nd Sem', 3, 0, 'Face-to-face', 19),
(136, 'GenEd 105', 'Science, Technology and Society', 3, 'Minor', 1, '2nd Sem', 3, 0, 'Face-to-face', 19),
(137, 'GenEd 107', 'The Contemporary World', 3, 'Minor', 1, '2nd Sem', 3, 0, 'Face-to-face', 19),
(138, 'CCSIT 204', 'Core Testing Principles', 3, 'Major', 2, '2nd Sem', 2, 1, 'Face-to-face', 19),
(139, 'IT 106', 'Application Development & Emerging Technologies', 3, 'Major', 2, '2nd Sem', 2, 1, 'Face-to-face', 19),
(140, 'EL 4', 'Mobile Development: Native', 3, 'Major', 2, '2nd Sem', 2, 1, 'Face-to-face', 19),
(141, 'EL 5', 'Mobile Development: Hybrid', 3, 'Major', 2, '2nd Sem', 2, 1, 'Face-to-face', 19),
(142, 'PRCT 100', 'Practicum/Immersion (320 Hrs)', 6, 'Major', 2, '2nd Sem', 0, 6, 'Face-to-face', 19),
(143, 'CCSIT 209', 'Information Assurance and Security', 3, 'Major', 3, '2nd Sem', 2, 1, 'Face-to-face', 19),
(144, 'CCSIT 210', 'Integrative Programming and Technologies', 3, 'Major', 3, '2nd Sem', 2, 1, 'Face-to-face', 19),
(145, 'CCSIT 211', 'Quantitative Methods', 3, 'Major', 3, '2nd Sem', 3, 0, 'Face-to-face', 19),
(146, 'CCSIT 212', 'Internet of Things', 3, 'Major', 3, '2nd Sem', 2, 1, 'Face-to-face', 19),
(147, 'CCSIT 213', 'UI/UX for Design Digital Devices', 3, 'Major', 3, '2nd Sem', 2, 1, 'Face-to-face', 19),
(148, 'ProfElective 3', 'Advanced Web Development: Front-End 2', 3, 'Major', 3, '2nd Sem', 2, 1, 'Face-to-face', 19),
(149, 'ProfElective 4', 'Advanced Mobile Development: Hybrid', 3, 'Major', 3, '2nd Sem', 2, 1, 'Face-to-face', 19),
(150, 'Free Elect 101', 'Research Methods', 3, 'Minor', 3, '2nd Sem', 3, 0, 'Face-to-face', 19),
(151, 'PRCT 200', 'Practicum/Immersion (486 Hrs)', 6, 'Major', 4, '2nd Sem', 0, 6, 'Face-to-face', 19),
(152, 'Free Elect 103', 'IT Seminar', 1, 'Minor', 4, '2nd Sem', 1, 0, 'Face-to-face', 19),
(153, 'Gen Ed 106', 'Ethics', 3, 'Minor', 1, '2nd Sem', 1.5, 1.5, 'Face-to-face', 19);

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `faculty_id` int(11) NOT NULL,
  `faculty_name` varchar(100) NOT NULL,
  `employment_type` enum('Permanent','Part-time','Affiliate') NOT NULL,
  `specialization` varchar(200) DEFAULT NULL,
  `program_id` int(11) DEFAULT NULL,
  `total_units` int(11) DEFAULT NULL,
  `total_equivalent_units` decimal(4,2) DEFAULT NULL,
  `total_hours` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`faculty_id`, `faculty_name`, `employment_type`, `specialization`, `program_id`, `total_units`, `total_equivalent_units`, `total_hours`) VALUES
(56, 'C. Bea', 'Permanent', 'CCSIT 213', 19, 15, 21.00, '25hrs'),
(57, 'J. Bea', 'Permanent', 'Free Elect 101', 19, 9, 9.00, '—'),
(58, 'J. Delos Reyes', 'Permanent', 'EL 4, ProfElective 4, EL 5, PRCT 200, PRCT 100', 19, 21, 25.00, '31hrs'),
(59, 'J. Eustaquio', 'Permanent', 'IT 106, ProfElective 3', 19, 21, 27.00, '31hrs'),
(60, 'MJ. Hipol', 'Permanent', 'CCSIT 209, CCSIT 210', 19, 18, 23.00, '26hrs'),
(61, 'Z. Mendoza', 'Permanent', 'CCSIT 212, Free Elect 103, PRCT 200, PRCT 100, IT 104, CCSIT 201, ProfElective 4', 19, 16, 19.00, '22hrs'),
(62, 'G. Villanueva Jr', 'Permanent', 'CCSIT 211, PRCT 200, PRCT 100', 19, 24, 30.50, '32hrs'),
(63, 'M. Jaramilla', 'Permanent', 'CCSIT 200, IT 103', 19, 18, 23.00, '26hrs'),
(64, 'J. Paulo', 'Permanent', 'IT 103, CCSIT 200, CCSIT 204, CCSIT 209', 19, 18, 23.00, '26hrs'),
(65, 'A. Terredaño', 'Permanent', 'CCSIT 204, IT 103', 19, 15, 20.00, '23hrs'),
(66, 'R. Azurin', 'Part-time', 'RIZAL', 19, 6, NULL, '—'),
(67, 'F.V. Balala', 'Part-time', 'GenEd 105', 19, 3, NULL, '—'),
(68, 'H. Alcanciado', 'Part-time', 'Gen Ed 106', 19, 3, NULL, '—'),
(69, 'G. Jacosalem', 'Part-time', 'GenEd 107, RIZAL', 19, 3, NULL, '—'),
(70, 'P. Carbonel', 'Part-time', 'GenEd 105', 19, 3, NULL, '—'),
(71, 'A. Panganiban', 'Part-time', 'EL 4', 19, 15, 20.00, '23hrs'),
(72, 'G. Somera', 'Affiliate', 'GenEd 107, GenEd 105, RIZAL', 19, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `programs`
--

CREATE TABLE `programs` (
  `program_id` int(11) NOT NULL,
  `program_code` varchar(20) NOT NULL,
  `program_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `programs`
--

INSERT INTO `programs` (`program_id`, `program_code`, `program_name`) VALUES
(19, 'BSIT', 'Bachelor of Science in Information Technology');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `room_id` int(11) NOT NULL,
  `room_name` varchar(20) NOT NULL,
  `room_type` varchar(50) DEFAULT 'Classroom',
  `capacity` int(11) DEFAULT 0,
  `program_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`room_id`, `room_name`, `room_type`, `capacity`, `program_id`) VALUES
(31, 'ITBR 202', 'Laboratory', 30, 19),
(32, 'ITBR 201', 'Laboratory', 21, 19),
(33, 'ITBR 203', 'Laboratory', 30, 19),
(35, 'ITBR 303', 'Classroom', 30, 19),
(46, 'Field / Practicum', 'Lecture Hall', 40, 19),
(47, 'LHS 201', 'Classroom', 40, 19),
(50, 'Online Classroom', 'Online', 1, 19);

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `section_id` int(11) NOT NULL,
  `program_id` int(11) DEFAULT NULL,
  `year_level` int(11) DEFAULT NULL,
  `section_name` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`section_id`, `program_id`, `year_level`, `section_name`) VALUES
(76, 19, 1, 'A'),
(77, 19, 1, 'B'),
(78, 19, 1, 'C'),
(79, 19, 1, 'D'),
(80, 19, 2, 'A'),
(81, 19, 2, 'B'),
(82, 19, 2, 'C'),
(83, 19, 3, 'A'),
(84, 19, 3, 'B'),
(85, 19, 3, 'C'),
(86, 19, 4, 'A');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `role` enum('admin','dean','program_head','registrar','faculty') NOT NULL,
  `program_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `full_name`, `email`, `role`, `program_id`, `created_at`, `updated_at`) VALUES
(1, 'admin', '$2y$10$SiLRsgsimQmr0tB0Qj/wcOCgPysOOOQ7htOpwVMCqGGKL2ZfCm5fu', 'System Administrator', 'admin@schedwise.com', 'admin', NULL, '2025-09-01 05:16:39', '2025-09-23 01:40:49'),
(2, 'dean', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'College Dean', 'dean@ispsct.edu.ph', 'dean', NULL, '2025-09-01 05:16:39', '2025-09-01 05:16:39'),
(3, 'registrar', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Registrar', 'registrar@ispsct.edu.ph', 'registrar', NULL, '2025-09-01 05:16:39', '2025-09-01 05:16:39');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `classschedules`
--
ALTER TABLE `classschedules`
  ADD PRIMARY KEY (`schedule_id`),
  ADD KEY `faculty_id` (`faculty_id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `section_id` (`section_id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`),
  ADD KEY `program_id` (`program_id`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`faculty_id`),
  ADD KEY `program_id` (`program_id`);

--
-- Indexes for table `programs`
--
ALTER TABLE `programs`
  ADD PRIMARY KEY (`program_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`room_id`),
  ADD KEY `idx_rooms_program_id` (`program_id`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`section_id`),
  ADD KEY `program_id` (`program_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `classschedules`
--
ALTER TABLE `classschedules`
  MODIFY `schedule_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9439;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=154;

--
-- AUTO_INCREMENT for table `faculty`
--
ALTER TABLE `faculty`
  MODIFY `faculty_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `programs`
--
ALTER TABLE `programs`
  MODIFY `program_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `section_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `classschedules`
--
ALTER TABLE `classschedules`
  ADD CONSTRAINT `classschedules_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`),
  ADD CONSTRAINT `classschedules_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  ADD CONSTRAINT `classschedules_ibfk_3` FOREIGN KEY (`section_id`) REFERENCES `sections` (`section_id`),
  ADD CONSTRAINT `classschedules_ibfk_4` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`);

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`);

--
-- Constraints for table `faculty`
--
ALTER TABLE `faculty`
  ADD CONSTRAINT `faculty_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`);

--
-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `fk_rooms_program` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sections`
--
ALTER TABLE `sections`
  ADD CONSTRAINT `sections_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `programs` (`program_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
