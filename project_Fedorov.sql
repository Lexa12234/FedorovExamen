-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost:3306
-- Время создания: Апр 16 2026 г., 16:14
-- Версия сервера: 10.6.22-MariaDB-0ubuntu0.22.04.1
-- Версия PHP: 8.1.2-1ubuntu2.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `project_Fedorov`
--

-- --------------------------------------------------------

--
-- Структура таблицы `films`
--

CREATE TABLE `films` (
  `id_film` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `duration_min` int(11) NOT NULL CHECK (`duration_min` > 0 and `duration_min` <= 300),
  `age_rating` varchar(10) NOT NULL DEFAULT '0+',
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `films`
--

INSERT INTO `films` (`id_film`, `title`, `duration_min`, `age_rating`, `description`, `created_at`) VALUES
(1, 'Дюна: Часть вторая', 166, '12+', 'Продолжение эпической саги Пола Атрейдеса', '2026-04-16 08:27:23'),
(2, 'Барби', 114, '12+', 'Сказочная комедия о самой известной кукле', '2026-04-16 08:27:23'),
(3, 'Оппенгеймер', 180, '18+', 'История создателя атомной бомбы', '2026-04-16 08:27:23'),
(4, 'Ёлки 11', 95, '6+', 'Новогодняя комедия для всей семьи', '2026-04-16 08:27:23');

-- --------------------------------------------------------

--
-- Структура таблицы `halls`
--

CREATE TABLE `halls` (
  `id_hall` int(11) NOT NULL,
  `hall_name` varchar(50) NOT NULL,
  `capacity` int(11) NOT NULL CHECK (`capacity` between 10 and 500)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `halls`
--

INSERT INTO `halls` (`id_hall`, `hall_name`, `capacity`) VALUES
(1, 'Зал 1 (Красный)', 120),
(2, 'Зал 2 (Синий)', 80),
(3, 'Зал 3 (VIP)', 40);

-- --------------------------------------------------------

--
-- Структура таблицы `seats`
--

CREATE TABLE `seats` (
  `id_seat` int(11) NOT NULL,
  `id_hall` int(11) NOT NULL,
  `row_num` int(11) NOT NULL CHECK (`row_num` between 1 and 30),
  `seat_num` int(11) NOT NULL CHECK (`seat_num` between 1 and 50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `seats`
--

INSERT INTO `seats` (`id_seat`, `id_hall`, `row_num`, `seat_num`) VALUES
(1, 1, 1, 1),
(2, 1, 1, 2),
(3, 1, 1, 3),
(4, 1, 1, 4),
(5, 1, 1, 5),
(6, 1, 1, 6),
(7, 1, 1, 7),
(8, 1, 1, 8),
(9, 1, 2, 1),
(10, 1, 2, 2),
(11, 1, 2, 3),
(12, 1, 2, 4),
(13, 1, 2, 5),
(14, 1, 2, 6),
(15, 1, 2, 7),
(16, 1, 2, 8),
(17, 1, 3, 1),
(18, 1, 3, 2),
(19, 1, 3, 3),
(20, 1, 3, 4),
(21, 1, 3, 5),
(22, 1, 3, 6),
(23, 1, 3, 7),
(24, 1, 3, 8),
(25, 1, 4, 1),
(26, 1, 4, 2),
(27, 1, 4, 3),
(28, 1, 4, 4),
(29, 1, 4, 5),
(30, 1, 4, 6),
(31, 1, 4, 7),
(32, 1, 4, 8),
(33, 1, 5, 1),
(34, 1, 5, 2),
(35, 1, 5, 3),
(36, 1, 5, 4),
(37, 1, 5, 5),
(38, 1, 5, 6),
(39, 1, 5, 7),
(40, 1, 5, 8),
(41, 1, 6, 1),
(42, 1, 6, 2),
(43, 1, 6, 3),
(44, 1, 6, 4),
(45, 1, 6, 5),
(46, 1, 6, 6),
(47, 1, 6, 7),
(48, 1, 6, 8),
(49, 1, 7, 1),
(50, 1, 7, 2),
(51, 1, 7, 3),
(52, 1, 7, 4),
(53, 1, 7, 5),
(54, 1, 7, 6),
(55, 1, 7, 7),
(56, 1, 7, 8),
(57, 1, 8, 1),
(58, 1, 8, 2),
(59, 1, 8, 3),
(60, 1, 8, 4),
(61, 1, 8, 5),
(62, 1, 8, 6),
(63, 1, 8, 7),
(64, 1, 8, 8),
(65, 1, 9, 1),
(66, 1, 9, 2),
(67, 1, 9, 3),
(68, 1, 9, 4),
(69, 1, 9, 5),
(70, 1, 9, 6),
(71, 1, 9, 7),
(72, 1, 9, 8),
(73, 1, 10, 1),
(74, 1, 10, 2),
(75, 1, 10, 3),
(76, 1, 10, 4),
(77, 1, 10, 5),
(78, 1, 10, 6),
(79, 1, 10, 7),
(80, 1, 10, 8),
(81, 1, 11, 1),
(82, 1, 11, 2),
(83, 1, 11, 3),
(84, 1, 11, 4),
(85, 1, 11, 5),
(86, 1, 11, 6),
(87, 1, 11, 7),
(88, 1, 11, 8),
(89, 1, 12, 1),
(90, 1, 12, 2),
(91, 1, 12, 3),
(92, 1, 12, 4),
(93, 1, 12, 5),
(94, 1, 12, 6),
(95, 1, 12, 7),
(96, 1, 12, 8),
(97, 1, 13, 1),
(98, 1, 13, 2),
(99, 1, 13, 3),
(100, 1, 13, 4),
(101, 1, 13, 5),
(102, 1, 13, 6),
(103, 1, 13, 7),
(104, 1, 13, 8),
(105, 1, 14, 1),
(106, 1, 14, 2),
(107, 1, 14, 3),
(108, 1, 14, 4),
(109, 1, 14, 5),
(110, 1, 14, 6),
(111, 1, 14, 7),
(112, 1, 14, 8),
(113, 1, 15, 1),
(114, 1, 15, 2),
(115, 1, 15, 3),
(116, 1, 15, 4),
(117, 1, 15, 5),
(118, 1, 15, 6),
(119, 1, 15, 7),
(120, 1, 15, 8),
(121, 2, 1, 1),
(122, 2, 1, 2),
(123, 2, 1, 3),
(124, 2, 1, 4),
(125, 2, 1, 5),
(126, 2, 1, 6),
(127, 2, 1, 7),
(128, 2, 1, 8),
(129, 2, 2, 1),
(130, 2, 2, 2),
(131, 2, 2, 3),
(132, 2, 2, 4),
(133, 2, 2, 5),
(134, 2, 2, 6),
(135, 2, 2, 7),
(136, 2, 2, 8),
(137, 2, 3, 1),
(138, 2, 3, 2),
(139, 2, 3, 3),
(140, 2, 3, 4),
(141, 2, 3, 5),
(142, 2, 3, 6),
(143, 2, 3, 7),
(144, 2, 3, 8),
(145, 2, 4, 1),
(146, 2, 4, 2),
(147, 2, 4, 3),
(148, 2, 4, 4),
(149, 2, 4, 5),
(150, 2, 4, 6),
(151, 2, 4, 7),
(152, 2, 4, 8),
(153, 2, 5, 1),
(154, 2, 5, 2),
(155, 2, 5, 3),
(156, 2, 5, 4),
(157, 2, 5, 5),
(158, 2, 5, 6),
(159, 2, 5, 7),
(160, 2, 5, 8),
(161, 2, 6, 1),
(162, 2, 6, 2),
(163, 2, 6, 3),
(164, 2, 6, 4),
(165, 2, 6, 5),
(166, 2, 6, 6),
(167, 2, 6, 7),
(168, 2, 6, 8),
(169, 2, 7, 1),
(170, 2, 7, 2),
(171, 2, 7, 3),
(172, 2, 7, 4),
(173, 2, 7, 5),
(174, 2, 7, 6),
(175, 2, 7, 7),
(176, 2, 7, 8),
(177, 2, 8, 1),
(178, 2, 8, 2),
(179, 2, 8, 3),
(180, 2, 8, 4),
(181, 2, 8, 5),
(182, 2, 8, 6),
(183, 2, 8, 7),
(184, 2, 8, 8),
(185, 2, 9, 1),
(186, 2, 9, 2),
(187, 2, 9, 3),
(188, 2, 9, 4),
(189, 2, 9, 5),
(190, 2, 9, 6),
(191, 2, 9, 7),
(192, 2, 9, 8),
(193, 2, 10, 1),
(194, 2, 10, 2),
(195, 2, 10, 3),
(196, 2, 10, 4),
(197, 2, 10, 5),
(198, 2, 10, 6),
(199, 2, 10, 7),
(200, 2, 10, 8),
(201, 3, 1, 1),
(202, 3, 1, 2),
(203, 3, 1, 3),
(204, 3, 1, 4),
(205, 3, 1, 5),
(206, 3, 1, 6),
(207, 3, 1, 7),
(208, 3, 1, 8),
(209, 3, 2, 1),
(210, 3, 2, 2),
(211, 3, 2, 3),
(212, 3, 2, 4),
(213, 3, 2, 5),
(214, 3, 2, 6),
(215, 3, 2, 7),
(216, 3, 2, 8),
(217, 3, 3, 1),
(218, 3, 3, 2),
(219, 3, 3, 3),
(220, 3, 3, 4),
(221, 3, 3, 5),
(222, 3, 3, 6),
(223, 3, 3, 7),
(224, 3, 3, 8),
(225, 3, 4, 1),
(226, 3, 4, 2),
(227, 3, 4, 3),
(228, 3, 4, 4),
(229, 3, 4, 5),
(230, 3, 4, 6),
(231, 3, 4, 7),
(232, 3, 4, 8),
(233, 3, 5, 1),
(234, 3, 5, 2),
(235, 3, 5, 3),
(236, 3, 5, 4),
(237, 3, 5, 5),
(238, 3, 5, 6),
(239, 3, 5, 7),
(240, 3, 5, 8);

-- --------------------------------------------------------

--
-- Структура таблицы `sessions`
--

CREATE TABLE `sessions` (
  `id_session` int(11) NOT NULL,
  `id_film` int(11) NOT NULL,
  `id_hall` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `base_price` decimal(10,2) NOT NULL CHECK (`base_price` >= 0),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `sessions`
--

INSERT INTO `sessions` (`id_session`, `id_film`, `id_hall`, `start_time`, `base_price`, `created_at`) VALUES
(1, 1, 1, '2025-05-20 19:00:00', '350.00', '2026-04-16 08:27:27'),
(2, 1, 1, '2025-05-21 21:30:00', '400.00', '2026-04-16 08:27:27'),
(3, 2, 2, '2025-05-20 18:00:00', '300.00', '2026-04-16 08:27:27'),
(4, 3, 3, '2025-05-22 20:00:00', '800.00', '2026-04-16 08:27:27'),
(5, 4, 2, '2025-05-23 16:00:00', '250.00', '2026-04-16 08:27:27');

-- --------------------------------------------------------

--
-- Структура таблицы `tickets`
--

CREATE TABLE `tickets` (
  `id_ticket` int(11) NOT NULL,
  `id_session` int(11) NOT NULL,
  `id_seat` int(11) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `purchase_time` datetime DEFAULT current_timestamp(),
  `status` enum('active','refunded') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `tickets`
--

INSERT INTO `tickets` (`id_ticket`, `id_session`, `id_seat`, `customer_name`, `purchase_time`, `status`) VALUES
(1, 1, 1, 'Иван Петров', '2026-04-16 15:27:28', 'active'),
(2, 1, 2, 'Мария Сидорова', '2026-04-16 15:27:28', 'active'),
(3, 2, 5, 'Алексей Иванов', '2026-04-16 15:27:28', 'active'),
(4, 3, 10, 'Ольга Смирнова', '2026-04-16 15:27:28', 'refunded');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `films`
--
ALTER TABLE `films`
  ADD PRIMARY KEY (`id_film`);

--
-- Индексы таблицы `halls`
--
ALTER TABLE `halls`
  ADD PRIMARY KEY (`id_hall`),
  ADD UNIQUE KEY `hall_name` (`hall_name`);

--
-- Индексы таблицы `seats`
--
ALTER TABLE `seats`
  ADD PRIMARY KEY (`id_seat`),
  ADD UNIQUE KEY `unique_seat_in_hall` (`id_hall`,`row_num`,`seat_num`);

--
-- Индексы таблицы `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id_session`),
  ADD UNIQUE KEY `unique_hall_time` (`id_hall`,`start_time`),
  ADD KEY `id_film` (`id_film`);

--
-- Индексы таблицы `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id_ticket`),
  ADD UNIQUE KEY `unique_session_seat` (`id_session`,`id_seat`),
  ADD KEY `id_seat` (`id_seat`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `films`
--
ALTER TABLE `films`
  MODIFY `id_film` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `halls`
--
ALTER TABLE `halls`
  MODIFY `id_hall` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `seats`
--
ALTER TABLE `seats`
  MODIFY `id_seat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=241;

--
-- AUTO_INCREMENT для таблицы `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id_session` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id_ticket` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `seats`
--
ALTER TABLE `seats`
  ADD CONSTRAINT `seats_ibfk_1` FOREIGN KEY (`id_hall`) REFERENCES `halls` (`id_hall`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`id_film`) REFERENCES `films` (`id_film`),
  ADD CONSTRAINT `sessions_ibfk_2` FOREIGN KEY (`id_hall`) REFERENCES `halls` (`id_hall`);

--
-- Ограничения внешнего ключа таблицы `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`id_session`) REFERENCES `sessions` (`id_session`) ON DELETE CASCADE,
  ADD CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`id_seat`) REFERENCES `seats` (`id_seat`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
