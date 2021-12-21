-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 13-12-2021 a las 04:27:22
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `Projecte`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `CATEGORIES`
--

CREATE TABLE `CATEGORIES` (
  `Codi_cat` int(8) NOT NULL,
  `Nom` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `CATEGORIES`
--

INSERT INTO `CATEGORIES` (`Codi_cat`, `Nom`) VALUES
(1, 'Components'),
(2, 'Electrodomèstics'),
(3, 'PC'),
(4, 'Periferics');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `EQUIVALENT`
--

CREATE TABLE `EQUIVALENT` (
  `Codi_id` int(8) NOT NULL,
  `Codi_id_2` int(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PERTANY`
--

CREATE TABLE `PERTANY` (
  `Codi_id` int(8) NOT NULL,
  `Codi_cat` int(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `PERTANY`
--

INSERT INTO `PERTANY` (`Codi_id`, `Codi_cat`) VALUES
(3, 1),
(5, 2),
(6, 2),
(4, 3),
(1, 4),
(2, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PRODUCTES`
--

CREATE TABLE `PRODUCTES` (
  `Codi_id` int(8) NOT NULL,
  `Nom` varchar(100) DEFAULT NULL,
  `Stock` int(8) DEFAULT NULL,
  `Codi_prov` int(8) DEFAULT NULL,
  `Materials` varchar(50) DEFAULT NULL,
  `Descr` varchar(200) DEFAULT NULL,
  `Preu` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `PRODUCTES`
--

INSERT INTO `PRODUCTES` (`Codi_id`, `Nom`, `Stock`, `Codi_prov`, `Materials`, `Descr`, `Preu`) VALUES
(1, 'Ratoli Logitech SuperLight G pro X ', 15, 2, 'Alumini', 'Pes: 63g, Velocitat Resposta: 1ms, Microprocesador: ARM 32 bits, Batería: 70h.', 155),
(2, 'Cascos Logitech g pro', 12, 2, 'Alumini', 'Cable: 2m, Resposta FreQ: 20HZ-20KHZ', 79),
(3, 'RAM Corsair Vengeance 2X16GB DDR4 3200MHz', 8, 1, 'Alumini', '2X16GB, DDR4, 3200MHz, CL16,', 182),
(4, 'PC GAMING Gold', 4, 3, 'Alumini', 'Ryzen 5 3600, GTX 1650 4GB, 16GB, M.2 512GB, HDD 1TB', 920),
(5, 'AEG L6FBI821U LAVADORA BLANCA 8KG', 4, 4, 'Alumini', 'PES: 8KG, VELOCITAT: 1200 RPM, CLASE: E, POTES: 4, POTÈNCIA: 2200W', 445),
(6, 'MÀQUINA CAFÈ FILTRO ORBEGOZO - CG 4014', 7, 5, 'Alumini', 'Capacitat de 6 tases de cafè, Filtre permanent, Jarra de vidre, Cafè calent durant 30 minuts, Potència: 650W', 17);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PROVEIDOR`
--

CREATE TABLE `PROVEIDOR` (
  `Codi_pro` int(8) NOT NULL,
  `Nom_prov` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `PROVEIDOR`
--

INSERT INTO `PROVEIDOR` (`Codi_pro`, `Nom_prov`) VALUES
(1, 'Corsair'),
(2, 'Logitech'),
(3, 'NitroPC'),
(4, 'AEG'),
(5, 'Orbegozo');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `CATEGORIES`
--
ALTER TABLE `CATEGORIES`
  ADD PRIMARY KEY (`Codi_cat`);

--
-- Indices de la tabla `EQUIVALENT`
--
ALTER TABLE `EQUIVALENT`
  ADD PRIMARY KEY (`Codi_id`),
  ADD KEY `Codi_id_2` (`Codi_id_2`);

--
-- Indices de la tabla `PERTANY`
--
ALTER TABLE `PERTANY`
  ADD PRIMARY KEY (`Codi_id`),
  ADD KEY `Codi_cat` (`Codi_cat`);

--
-- Indices de la tabla `PRODUCTES`
--
ALTER TABLE `PRODUCTES`
  ADD PRIMARY KEY (`Codi_id`),
  ADD KEY `Codi_prov` (`Codi_prov`);

--
-- Indices de la tabla `PROVEIDOR`
--
ALTER TABLE `PROVEIDOR`
  ADD PRIMARY KEY (`Codi_pro`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `CATEGORIES`
--
ALTER TABLE `CATEGORIES`
  MODIFY `Codi_cat` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `PRODUCTES`
--
ALTER TABLE `PRODUCTES`
  MODIFY `Codi_id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `EQUIVALENT`
--
ALTER TABLE `EQUIVALENT`
  ADD CONSTRAINT `EQUIVALENT_ibfk_1` FOREIGN KEY (`Codi_id`) REFERENCES `PRODUCTES` (`Codi_id`),
  ADD CONSTRAINT `EQUIVALENT_ibfk_2` FOREIGN KEY (`Codi_id_2`) REFERENCES `PRODUCTES` (`Codi_id`);

--
-- Filtros para la tabla `PERTANY`
--
ALTER TABLE `PERTANY`
  ADD CONSTRAINT `PERTANY_ibfk_1` FOREIGN KEY (`Codi_id`) REFERENCES `PRODUCTES` (`Codi_id`),
  ADD CONSTRAINT `PERTANY_ibfk_2` FOREIGN KEY (`Codi_cat`) REFERENCES `CATEGORIES` (`Codi_cat`);

--
-- Filtros para la tabla `PRODUCTES`
--
ALTER TABLE `PRODUCTES`
  ADD CONSTRAINT `PRODUCTES_ibfk_1` FOREIGN KEY (`Codi_prov`) REFERENCES `PROVEIDOR` (`Codi_pro`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
