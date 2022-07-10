-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 02, 2022 at 10:54 PM
-- Server version: 10.3.34-MariaDB-cll-lve
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `slumber6_mytutordb`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_subjects`
--

CREATE TABLE `tbl_subjects` (
  `subject_id` int(4) NOT NULL,
  `subject_name` varchar(150) NOT NULL,
  `subject_description` varchar(500) NOT NULL,
  `subject_price` float NOT NULL,
  `tutor_id` varchar(4) NOT NULL,
  `subject_sessions` int(3) NOT NULL,
  `subject_rating` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_subjects`
--

INSERT INTO `tbl_subjects` (`subject_id`, `subject_name`, `subject_description`, `subject_price`, `tutor_id`, `subject_sessions`, `subject_rating`) VALUES
(1, 'Programming 101', 'Basic programming for new student with no background in programming.', 250, '1', 15, 4.5),
(2, 'Programming 201', 'Intermediate programming course that aim for those who has basic programming knowledge.', 200, '2', 10, 4),
(3, 'Introduction to Web programming ', 'Basic introduction to HTML, CSS, JavaScript, PHP and MySQL.', 180, '5', 15, 3.8),
(4, 'Web programming advanced', 'Course aim for those who are familiar with basic web programming.', 150, '3', 15, 4.2),
(5, 'Python for Everybody', 'This Specialization builds on the success of the Python for Everybody course and will introduce fundamental programming concepts including data structures, networked application program interfaces, and databases, using the Python programming language.', 120, '6', 5, 4.5),
(6, 'Introduction to Computer Science', 'This specialisation covers topics ranging from basic computing principles to the mathematical foundations required for computer science. ', 180, '3', 10, 4.2),
(7, 'Code Yourself! An Introduction to Programming', 'This course will teach you how to program in Scratch, an easy to use visual programming language. More importantly, it will introduce you to the fundamental principles of computing and it will help you think like a software engineer.', 120, '4', 5, 4),
(8, 'IBM Full Stack Software Developer Professional Certificate', 'ickstart your career in application development. Master Cloud Native and Full Stack Development using hands-on projects involving HTML, JavaScript, Node.js, Python, Django, Containers, Microservices and more. No prior experience required.', 230, '8', 8, 4.3),
(9, 'Graphic Design Specialization', 'his four-course sequence exposes students to the fundamental skills required to make sophisticated graphic design: process, historical context, and communication through image-making and typography. T', 200, '1', 5, 4.2),
(10, 'Fundamentals of Graphic Design', 'At the end of this course you will have learned how to explore and investigate visual representation through a range of image-making techniques; understand basic principles of working with shape, color and pattern; been exposed to the language and skills of typography; and understand and have applied the principles of composition and visual contrast. ', 150, '2', 5, 3.8),
(11, 'Fundamentals of Graphic Design', 'Project centered courses are designed specifically to help you complete a personally meaningful real-world project, with your instructor and a community of like-minded learners providing guidance and suggestions along the way.', 150, '5', 5, 4.8),
(12, 'Full-Stack Web Development with React', 'Learners will work on hands-on exercises, culminating in development of a full-fledged application at the end of each course. Each course also includes a mini-Capstone Project as part of the Honors Track where you’ll apply your skills to build a fully functional project.', 250, '7', 10, 4.2),
(13, 'Software Design and Architecture', 'In the Software Design and Architecture Specialization, you will learn how to apply design principles, patterns, and architectures to create reusable and flexible software applications and systems. You will learn how to express and document the design and architecture of a software system using a visual notation.', 170, '8', 3, 4.2),
(14, 'Software Testing and Automation', 'Learners will build test plans, test suites, and test analysis reports. Learners will develop properties and assertions in code to facilitate automated test generation. Learners will also create pre-conditions for methods to facilitate formal proofs of correctness.', 170, '9', 5, 4.1),
(15, 'Introduction to Cyber Security', 'The learning outcome is simple: We hope learners will develop a lifelong passion and appreciation for cyber security, which we are certain will help in future endeavors. ', 200, '9', 5, 4.2);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_tutors`
--

CREATE TABLE `tbl_tutors` (
  `tutor_id` int(5) NOT NULL,
  `tutor_email` varchar(50) NOT NULL,
  `tutor_phone` varchar(15) NOT NULL,
  `tutor_name` varchar(50) NOT NULL,
  `tutor_password` varchar(40) NOT NULL,
  `tutor_description` varchar(300) NOT NULL,
  `tutor_datereg` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_tutors`
--

INSERT INTO `tbl_tutors` (`tutor_id`, `tutor_email`, `tutor_phone`, `tutor_name`, `tutor_password`, `tutor_description`, `tutor_datereg`) VALUES
(1, 'prashanthini@mytutor.com.my', '+60188816970', 'Prashanthini a/l Manjit Ramasamy', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 'Nunc venenatis bibendum odio, in fermentum sem ultrices sed. Integer in quam turpis. Curabitur sed euismod sem, sed fringilla arcu. Sed justo felis, hendrerit eget elit ac, consequat sodales nibh.', '2022-06-02 10:29:14.000000'),
(2, 'sinnathuray.bakzi@yang.com', '+601132339126', 'Chai Tan Hiu', '86e40acfd92d4c5f44de76963ab68208ef0ab389', 'Integer nulla dui, blandit eu sollicitudin vitae, malesuada at est. Curabitur varius nisl vitae felis sagittis, sit amet porta urna mollis. Proin venenatis justo lorem, vitae tincidunt dui pharetra vel.', '2022-05-24 15:21:25.000000'),
(3, 'huzir42@bakry.org', '+6095798898', 'Nur Maya binti Aidil Hafizee ', '02dd38ccd56a4efbe22f4599f4717a8cf3eb9281', 'Maecenas vitae leo in ipsum pulvinar hendrerit vitae ac urna. Maecenas consequat aliquet leo pulvinar tincidunt. Vivamus placerat neque sit amet hendrerit feugiat.', '2022-03-03 15:21:25.000000'),
(4, 'dkok@majid.biz', '+60377236036', 'Ling Liang Thok', '76b241504f3904db725c01fcc532c2bdfae609ae', 'Aliquam dignissim ut libero non aliquet. Etiam eu ultricies enim. Phasellus gravida ac libero in porta. Phasellus tincidunt feugiat est, quis pellentesque risus eleifend vitae.', '2022-06-09 21:47:05.000000'),
(5, 'melissa57@hotmail.com', '+6069427992', 'Teoh Chum Liek', '86e40acfd92d4c5f44de76963ab68208ef0ab389', 'Morbi at turpis in quam gravida facilisis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ac nisl lorem. ', '2022-06-27 21:48:25.000000'),
(6, 'azizy.kavita@foong.info', '+60152045292', 'Amirah binti Che Aznizam', '02dd38ccd56a4efbe22f4599f4717a8cf3eb9281', 'Nullam sed fringilla nisl. Proin aliquet metus quis ornare faucibus. Proin non mauris maximus, mollis enim non, bibendum nibh. Morbi feugiat fermentum imperdiet. ', '2022-03-03 15:21:25.000000'),
(7, 'teoki57@hotmail.com', '+6069427992', 'Teoh Chum Liek', '86e40acfd92d4c5f44de76963ab68208ef0ab389', 'Morbi at turpis in quam gravida facilisis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ac nisl lorem. ', '2022-06-27 21:48:25.000000'),
(8, 'nelson.jaini@parthiban.info', '+60102727980', 'Muhammet Firdaus Miskoulan bin Jamal', 'b4b9c99d312bf05bfb05341d981d6a17ace24b51', 'Duis at iaculis ante. Praesent in risus blandit, tempus nibh eu, imperdiet nunc. Ut quis lobortis quam. Nullam sed purus eros. Donec ac viverra orci. Pellentesque non neque et tellus gravida interdum', '2022-05-29 22:10:53.000000'),
(9, 'vetils@veerasamy.com', '+6089-64 4857', 'P. Veetil a/l Ramadas', '49bd6349e19baa02a3adb1d770cb873fcca2cf38', 'Proin venenatis justo lorem, vitae tincidunt dui pharetra vel. Duis ultricies gravida condimentum. Phasellus pellentesque sodales dolor, dictum pulvinar felis convallis ut.', '2022-06-15 22:11:49.000000');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_subjects`
--
ALTER TABLE `tbl_subjects`
  ADD PRIMARY KEY (`subject_id`);

--
-- Indexes for table `tbl_tutors`
--
ALTER TABLE `tbl_tutors`
  ADD PRIMARY KEY (`tutor_id`),
  ADD UNIQUE KEY `tutor_email` (`tutor_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_subjects`
--
ALTER TABLE `tbl_subjects`
  MODIFY `subject_id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tbl_tutors`
--
ALTER TABLE `tbl_tutors`
  MODIFY `tutor_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
