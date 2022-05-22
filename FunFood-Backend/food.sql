-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 15, 2022 at 06:09 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `food`
--

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE `city` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `image` varchar(100) NOT NULL,
  `num` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `image` varchar(100) NOT NULL,
  `audio` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `benefits` varchar(500) NOT NULL,
  `type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `user_id`, `image`, `audio`, `name`, `benefits`, `type`) VALUES
(1, 0, 'images/Apple.png', 'audio/Apple.mp3', 'Apple', 'Whiter, healthier teeth. •	Avoiding Alzheimer\'s. •	Protection from Parkinson\'s. A defender against cancers.', 1),
(2, 0, 'images/Banana.jpg', 'audio/Banana.mp3', 'Banana', '•	Lots of potassium. •	Creates energy. •	Aids digestion. Increases vitamin B6.', 1),
(3, 0, 'images/Orange.png', 'audio/Orange.mp3', 'Orange', '•	High in Vitamin C. •	Healthy immune system. •	Prevents skin damage. Keeps blood pressure under check.', 1),
(4, 0, 'images/Watermelon.jpg', 'audio/watermelon.mp3', 'Watermelon', '•	Lycopene Levels. •	Vitamin A and Vitamin B6. •	Phenolic Antioxidant. Potassium.', 1),
(5, 0, 'images/Strawberry.png', 'audio/Strawberry.mp3', 'Strawberry', '•	Maintains Eye Health •	Aids in Weight Loss •	Boosts Immunity Treats Inflammation', 1),
(6, 0, 'images/Mango.png', 'audio/Mango.mp3', 'Mango', '•	Lowering cholesterol levels •	Making your skin look and feel younger •	An essential digestion aid Anti-cancer properties', 1),
(7, 0, 'images/Fig.jpg', 'audio/Fig.mp3', 'Fig', '•	Prevent Heart Disease •	Cancer Preventative •	Promote Digestive Health Strengthen Bones', 1),
(8, 0, 'images/Pineapple.png', 'audio/Pineapple.mp3', 'Pineapple', '•	Cures Symptoms of Cough and Cold •	Strengthens Bones •	Improves Oral Health Boosts Immunity', 1),
(9, 0, 'images/Grapes.png', 'audio/Grapes.mp3', 'Grapes', '•	Heart Health •	Healthy Eyes •	Blood Pressure Diabetes', 1),
(10, 0, 'images/Pear.png', 'audio/Pear.mp3', 'Pear ', '•	Vitamin C, K, Potassium •	reduce the risk of heart disease •	Good for skin and hair   •	improve bone health', 1),
(11, 0, 'images/Cherry.png', 'audio/Cherry.mp3', 'Cherry ', 'Supports brain health High in fiber . Heart-healthy', 1),
(12, 0, 'images/Blueberry.png', 'audio/blueberry.mp3', 'Blueberry', '•	Brain health and memory •	Heart health Helps Bone Growth', 1),
(13, 0, 'images/Plum.png', 'audio/plum.mp3', 'Plum ', 'Vitamin C healthy bone growth   Niacin – this B vitamin helps with healthy blood circulation and energy production Vitamin A', 1),
(14, 0, 'images/Kiwi.png', 'audio/kiwi.mp3', 'Kiwi ', 'potassium, phosphorus, calcium and vitamins E and B perfect to strengthen the immune system', 1),
(15, 0, 'images/Apricot.jpg', 'audio/Apricot.mp3', 'Apricot ', 'Help in clearing bowels Treat infections  Boost immunity Protein Vitamin A', 1),
(16, 0, 'images/Avocado.png', 'audio/Avocado.mp3', 'Avocado ', 'great source of potassium high in fiber  rich in folate', 1),
(17, 0, 'images/Coconut.png', 'audio/coconut.mp3', 'Coconut ', 'Boosts Skin Health Promotes Digestion Develops Strong Bones Boosts Energy', 1),
(18, 0, 'images/Pomegranate.png', 'audio/pomegranate.mp3', 'Pomegranate ', 'Boosts Skin Health Promotes Digestion Develops Strong Bones Boosts Energy', 1),
(19, 0, 'images/Lettuce.jpg', 'audio/lettuce.mp3', 'Lettuce', '•	Fight Inflammation •	Aid Weight Loss •	Promote Brain Health Boost Heart Health', 2),
(20, 0, 'images/lemon.bmp', 'audio/Lemon.mp3', 'Lemon', '•	Aids in Digestion •	Promotes Weight Loss •	Encourages Liver Detox Boosts Immune Function', 2),
(21, 0, 'images/Tomatoes.png', 'audio/Tomatoes.mp3', 'Tomatoes', '•	Good for the Skin and Hair •	It’s Anti-Carcinogenic •	Good for Your Bones Works on Your Immunity', 2),
(22, 0, 'images/carrout.bmp', 'audio/Carrots.mp3', 'Carrots', '•	Combats cancer •	It prevents cardiovascular problems •	Liver protection Anti-Aging effects', 2),
(23, 0, 'images/cucamber.bmp', 'audio/Cucumber.mp3', 'Cucumber', '•	Hydrates the Body •	Prevents Overheating •	Flushes Toxins Loads of Vitamins', 2),
(24, 0, 'images/Potatoes.jpg', 'audio/Potatoes.mp3', 'Potatoes', '•	Reducing Inflammation •	Improve Brain Health •	Good for bones Removes Dead Skin Cells', 2),
(25, 0, 'images/Onions.jpg', 'audio/Onions.mp3', 'Onions', '•	Onion cough syrup •	Improved Immunity •	Reduce inflammation Regulate blood sugar', 2),
(27, 3, 'images/Apple.png', 'audio/Apple.mp3', 'Apple', 'Whiter, healthier teeth. •	Avoiding Alzheimer\'s. •	Protection from Parkinson\'s. A defender against cancers.', 1),
(28, 3, 'images/Banana.jpg', 'audio/Banana.mp3', 'Banana', '•	Lots of potassium. •	Creates energy. •	Aids digestion. Increases vitamin B6.', 1),
(29, 3, 'images/Orange.png', 'audio/Orange.mp3', 'Orange', '•	High in Vitamin C. •	Healthy immune system. •	Prevents skin damage. Keeps blood pressure under check.', 1),
(30, 3, 'images/Watermelon.jpg', 'audio/watermelon.mp3', 'Watermelon', '•	Lycopene Levels. •	Vitamin A and Vitamin B6. •	Phenolic Antioxidant. Potassium.', 1),
(31, 3, 'images/Strawberry.png', 'audio/Strawberry.mp3', 'Strawberry', '•	Maintains Eye Health •	Aids in Weight Loss •	Boosts Immunity Treats Inflammation', 1),
(32, 3, 'images/Mango.png', 'audio/Mango.mp3', 'Mango', '•	Lowering cholesterol levels •	Making your skin look and feel younger •	An essential digestion aid Anti-cancer properties', 1),
(33, 3, 'images/Fig.jpg', 'audio/Fig.mp3', 'Fig', '•	Prevent Heart Disease •	Cancer Preventative •	Promote Digestive Health Strengthen Bones', 1),
(34, 3, 'images/Pineapple.png', 'audio/Pineapple.mp3', 'Pineapple', '•	Cures Symptoms of Cough and Cold •	Strengthens Bones •	Improves Oral Health Boosts Immunity', 1),
(35, 3, 'images/Grapes.png', 'audio/Grapes.mp3', 'Grapes', '•	Heart Health •	Healthy Eyes •	Blood Pressure Diabetes', 1),
(36, 3, 'images/Pear.png', 'audio/Pear.mp3', 'Pear ', '•	Vitamin C, K, Potassium •	reduce the risk of heart disease •	Good for skin and hair   •	improve bone health', 1),
(37, 3, 'images/Cherry.png', 'audio/Cherry.mp3', 'Cherry ', 'Supports brain health High in fiber . Heart-healthy', 1),
(38, 3, 'images/Blueberry.png', 'audio/blueberry.mp3', 'Blueberry', '•	Brain health and memory •	Heart health Helps Bone Growth', 1),
(39, 3, 'images/Plum.png', 'audio/plum.mp3', 'Plum ', 'Vitamin C healthy bone growth   Niacin – this B vitamin helps with healthy blood circulation and energy production Vitamin A', 1),
(40, 3, 'images/Kiwi.png', 'audio/kiwi.mp3', 'Kiwi ', 'potassium, phosphorus, calcium and vitamins E and B perfect to strengthen the immune system', 1),
(41, 3, 'images/Apricot.jpg', 'audio/Apricot.mp3', 'Apricot ', 'Help in clearing bowels Treat infections  Boost immunity Protein Vitamin A', 1),
(42, 3, 'images/Avocado.png', 'audio/Avocado.mp3', 'Avocado ', 'great source of potassium high in fiber  rich in folate', 1),
(43, 3, 'images/Coconut.png', 'audio/coconut.mp3', 'Coconut ', 'Boosts Skin Health Promotes Digestion Develops Strong Bones Boosts Energy', 1),
(44, 3, 'images/Pomegranate.png', 'audio/pomegranate.mp3', 'Pomegranate ', 'Boosts Skin Health Promotes Digestion Develops Strong Bones Boosts Energy', 1),
(45, 3, 'images/Lettuce.jpg', 'audio/lettuce.mp3', 'Lettuce', '•	Fight Inflammation •	Aid Weight Loss •	Promote Brain Health Boost Heart Health', 2),
(46, 3, 'images/lemon.bmp', 'audio/Lemon.mp3', 'Lemon', '•	Aids in Digestion •	Promotes Weight Loss •	Encourages Liver Detox Boosts Immune Function', 2),
(47, 3, 'images/Tomatoes.png', 'audio/Tomatoes.mp3', 'Tomatoes', '•	Good for the Skin and Hair •	It’s Anti-Carcinogenic •	Good for Your Bones Works on Your Immunity', 2),
(48, 3, 'images/carrout.bmp', 'audio/Carrots.mp3', 'Carrots', '•	Combats cancer •	It prevents cardiovascular problems •	Liver protection Anti-Aging effects', 2),
(49, 3, 'images/cucamber.bmp', 'audio/Cucumber.mp3', 'Cucumber', '•	Hydrates the Body •	Prevents Overheating •	Flushes Toxins Loads of Vitamins', 2),
(50, 3, 'images/Potatoes.jpg', 'audio/Potatoes.mp3', 'Potatoes', '•	Reducing Inflammation •	Improve Brain Health •	Good for bones Removes Dead Skin Cells', 2),
(51, 3, 'images/Onions.jpg', 'audio/Onions.mp3', 'Onions', '•	Onion cough syrup •	Improved Immunity •	Reduce inflammation Regulate blood sugar', 2);

-- --------------------------------------------------------

--
-- Table structure for table `meals`
--

CREATE TABLE `meals` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `year` varchar(10) NOT NULL,
  `mounth` varchar(10) NOT NULL,
  `day` varchar(10) NOT NULL,
  `accepted` int(11) NOT NULL,
  `m_time` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `pin` varchar(20) NOT NULL,
  `houses` int(11) NOT NULL,
  `coins` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `pin`, `houses`, `coins`) VALUES
(3, 'test', 'test', 'test', 'test', 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`id`);


--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `meals`
--
ALTER TABLE `meals`
  ADD PRIMARY KEY (`id`);


--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `city`
--
ALTER TABLE `city`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fruits`
--
ALTER TABLE `fruits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `meals`
--
ALTER TABLE `meals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `palaces`
--
ALTER TABLE `palaces`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
