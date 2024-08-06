-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 31, 2021 at 09:43 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sistemasanitario`
--

-- --------------------------------------------------------

--
-- Table structure for table `farmaci`
--

CREATE TABLE `farmaci` (
  `id_Farmaco` int(11) NOT NULL,
  `nome` char(20) NOT NULL,
  `n_richieste` int(11) DEFAULT NULL,
  `id_Patologia` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `farmaci`
--

INSERT INTO `farmaci` (`id_Farmaco`, `nome`, `n_richieste`, `id_Patologia`) VALUES
(1, 'Beclometasone', 155, 1),
(2, 'Clobetasolo', 36, 2),
(3, 'Doxiciclina', 27, 2),
(4, 'Empagliflozin', 99, 5),
(5, 'Atropina', 478, 4),
(6, 'Tazarotene', 370, 3);

-- --------------------------------------------------------

--
-- Table structure for table `medici`
--

CREATE TABLE `medici` (
  `id_Medico` int(11) NOT NULL,
  `nome` char(20) NOT NULL,
  `cognome` char(20) NOT NULL,
  `data_nascita` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `medici`
--

INSERT INTO `medici` (`id_Medico`, `nome`, `cognome`, `data_nascita`) VALUES
(1, 'Massimo', 'Cuccia', '1975-04-06'),
(2, 'Guido', 'Bergamini', '1968-11-20'),
(3, 'Anna', 'Barozzi', '1979-05-07');

-- --------------------------------------------------------

--
-- Table structure for table `patologie`
--

CREATE TABLE `patologie` (
  `id_Patologia` int(11) NOT NULL,
  `nome` char(20) NOT NULL,
  `tipologia` char(20) DEFAULT NULL,
  `id_Medico` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patologie`
--

INSERT INTO `patologie` (`id_Patologia`, `nome`, `tipologia`, `id_Medico`) VALUES
(1, 'Asma', 'Pneumologia', 3),
(2, 'Dermatite', 'Dermatologia', 1),
(3, 'Scoliosi', 'Ortopedia', 2),
(4, 'Miopia', 'Oculistica', 2),
(5, 'Diabete', 'Diabetologia', 3);

-- --------------------------------------------------------

--
-- Table structure for table `patologie_pazienti`
--

CREATE TABLE `patologie_pazienti` (
  `id_PP` int(11) NOT NULL,
  `id_Patologia` int(11) DEFAULT NULL,
  `id_Paziente` int(11) DEFAULT NULL,
  `esenzione` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patologie_pazienti`
--

INSERT INTO `patologie_pazienti` (`id_PP`, `id_Patologia`, `id_Paziente`, `esenzione`) VALUES
(1, 1, 2, 0),
(2, 2, 4, 1),
(3, 3, 5, 1),
(4, 2, 2, 0),
(5, 3, 1, 0),
(6, 3, 3, 1),
(7, 4, 4, 0),
(8, 1, 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `pazienti`
--

CREATE TABLE `pazienti` (
  `id_Paziente` int(11) NOT NULL,
  `nome` char(20) NOT NULL,
  `cognome` char(20) NOT NULL,
  `data_nascita` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pazienti`
--

INSERT INTO `pazienti` (`id_Paziente`, `nome`, `cognome`, `data_nascita`) VALUES
(1, 'Cosimo', 'Nuti', '2002-04-03'),
(2, 'Mirko', 'Tognaccini', '1999-10-07'),
(3, 'Asia', 'Verdi', '1968-02-10'),
(4, 'Giulia', 'Nannini', '2001-12-12'),
(5, 'Ernesto', 'Mici', '1965-12-01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `farmaci`
--
ALTER TABLE `farmaci`
  ADD PRIMARY KEY (`id_Farmaco`),
  ADD KEY `fk_patologiafarmaco` (`id_Patologia`);

--
-- Indexes for table `medici`
--
ALTER TABLE `medici`
  ADD PRIMARY KEY (`id_Medico`);

--
-- Indexes for table `patologie`
--
ALTER TABLE `patologie`
  ADD PRIMARY KEY (`id_Patologia`),
  ADD KEY `fk_medicopatologia` (`id_Medico`);

--
-- Indexes for table `patologie_pazienti`
--
ALTER TABLE `patologie_pazienti`
  ADD PRIMARY KEY (`id_PP`),
  ADD KEY `fk_patologiapaziente` (`id_Patologia`),
  ADD KEY `fk_pazientepatologia` (`id_Paziente`);

--
-- Indexes for table `pazienti`
--
ALTER TABLE `pazienti`
  ADD PRIMARY KEY (`id_Paziente`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `farmaci`
--
ALTER TABLE `farmaci`
  MODIFY `id_Farmaco` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `medici`
--
ALTER TABLE `medici`
  MODIFY `id_Medico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `patologie`
--
ALTER TABLE `patologie`
  MODIFY `id_Patologia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `patologie_pazienti`
--
ALTER TABLE `patologie_pazienti`
  MODIFY `id_PP` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `pazienti`
--
ALTER TABLE `pazienti`
  MODIFY `id_Paziente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `farmaci`
--
ALTER TABLE `farmaci`
  ADD CONSTRAINT `fk_patologiafarmaco` FOREIGN KEY (`id_Patologia`) REFERENCES `patologie` (`id_Patologia`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `patologie`
--
ALTER TABLE `patologie`
  ADD CONSTRAINT `fk_medicopatologia` FOREIGN KEY (`id_Medico`) REFERENCES `medici` (`id_Medico`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `patologie_pazienti`
--
ALTER TABLE `patologie_pazienti`
  ADD CONSTRAINT `fk_patologiapaziente` FOREIGN KEY (`id_Patologia`) REFERENCES `patologie` (`id_Patologia`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pazientepatologia` FOREIGN KEY (`id_Paziente`) REFERENCES `pazienti` (`id_Paziente`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
