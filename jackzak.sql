-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 25 jan. 2023 à 10:15
-- Version du serveur : 10.4.27-MariaDB
-- Version de PHP : 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `jackzak`
--

-- --------------------------------------------------------

--
-- Structure de la table `address`
--

CREATE TABLE `address` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `address` varchar(255) NOT NULL,
  `additional` varchar(255) DEFAULT NULL,
  `zip` varchar(5) NOT NULL,
  `city` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `carrier`
--

CREATE TABLE `carrier` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `img` varchar(45) DEFAULT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `slug` varchar(45) NOT NULL,
  `description` longtext DEFAULT NULL,
  `img` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `category`
--

INSERT INTO `category` (`id`, `name`, `slug`, `description`, `img`) VALUES
(1, 'Roman Policier et Thriller', 'roman-policier-et-thriller', 'des romans avec des intrigues qui vont vous tenir en haleine', NULL),
(2, 'Fantasy et Science-Fiction', 'fantasy-et-science-fiction', 'Voyagez dans des univers irréelles', NULL),
(3, 'Roman et Nouvelles', 'roman-et-nouvelles', 'Des romans à lire.', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20230116085728', '2023-01-19 17:50:54', 994);

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `carrier_id` int(11) NOT NULL,
  `delivery_address_id` int(11) NOT NULL,
  `billing_address_id` int(11) NOT NULL,
  `reference` varchar(45) NOT NULL,
  `amount` double NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `paid` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `order_has_product`
--

CREATE TABLE `order_has_product` (
  `id` int(11) NOT NULL,
  `order_id_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `abstract` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` double NOT NULL,
  `editor` varchar(45) DEFAULT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `img1` varchar(45) NOT NULL,
  `alt1` varchar(255) NOT NULL,
  `img2` varchar(45) DEFAULT NULL,
  `alt2` varchar(255) DEFAULT NULL,
  `img3` varchar(45) DEFAULT NULL,
  `alt3` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `product`
--

INSERT INTO `product` (`id`, `category_id`, `name`, `slug`, `abstract`, `description`, `quantity`, `price`, `editor`, `created_at`, `img1`, `alt1`, `img2`, `alt2`, `img3`, `alt3`) VALUES
(1, 1, 'L\'effondrement', 'l-effondrement', 'La flamboyante « Lille », capitale du Nord enviée, Et toutes ces cendres qui obscurcissent l’horizon, Ses authentiques quartiers et ses rues animées, Et ces corps qui gisent sur cette mer de béton…', 'N’ayez crainte, car le mal qui la ronge,\r\nCe fléau, ces miasmes qui s’y sont répandues,\r\nCouvert par ces odieux mensonges,\r\nSe rependront dans le monde sans retenue.\r\n\r\nUne belle invitation à l’exploration urbaine vous ne trouvez pas ? Peut-être même devraient-ils écrire ces « maux » forts bien inspirés sur les prochaines brochures touristiques !\r\nLille, il est vrai, n’a plus d’accueillant que les quelques refuges offerts aux rescapés. Joh, jeune infirmier banal et sans histoire, est bien malgré lui piégé au cœur de cet enfer. Hier en blouse blanche, le lendemain couvert de souillures et d’ecchymoses, une seule chose l’anime dorénavant : survivre, dans l’espoir de trouver les réponses aux doutes qui l’assiègent.\r\n\r\nQuelle est l’origine de ce mal qui vous précipite dans la tombe en quelques jours ?\r\nL’humanité est-elle sur le point de rendre son dernier souffle ?\r\n\r\nBienvenue dans les sous-secteurs ! Ici, même les plus robustes finissent par perdre la raison !\r\nPrenez garde où vous posez vos pieds, et évitez tout contact suspect !\r\nAu moindre faux pas, votre existence sur cette terre poisseuse sera comptée !', 45, 11.9, 'JackZak', '2023-01-20 11:52:51', '1674211971-1.jpg', 'couverture du livre', NULL, NULL, NULL, NULL),
(2, 3, 'Impardonnables', 'impardonnables', 'Lorsque des militants écologistes envahissent l’Europa Tower, un centre d’affaires réunissant des multinationales aux pratiques controversées, c’est pour dénoncer leurs activités dévastatrices pour la planète.', 'Une opération de communication magistralement orchestrée, le coup de force est diffusé sur les réseaux sociaux, jusqu’à l’accident. Un militant dérape, et une innocente est tuée sous l’œil effaré de cinq témoins. Incapables d’agir, le meurtrier s’enfuit. Tandis qu’une traque nationale s’organise, les cinq témoins, prisonniers de leur lâcheté, ne parviennent pas à reprendre pied. Vivre est leur châtiment, alors la violence devient l’issue. Cette souffrance, ils vont désormais l’imposer aux autres. Sans savoir que l’assassin les poursuit encore. Sans savoir que la mort les réunira une nouvelle fois. Six auteurs, six nouvelles interconnectées dans un même roman. Projet d’écriture ambitieux et novateur, « Impardonnables » n’a d’égal que la noirceur de ses personnages, torturés et condamnables, perdus dans leur quête d’un impossible pardon.', 58, 13, 'JackZak', '2023-01-20 11:54:51', '1674212091-1.jpg', 'couverture du livre', NULL, NULL, NULL, NULL),
(3, 3, 'Les morsures du passé', 'les-morsures-du-passe', 'Le destin a décidé d’offrir à Anaël Lacroix une seconde chance ; celle de tourner la page d’un passé douloureux et de vivre enfin une existence pleine de promesses. Une chance d’être comme tous les jeunes de son âge qui se laissent bercer par l’insoucianc', 'Ce pourrait être le début d’une belle histoire, si on faisait abstraction de cette vilaine cicatrice à l’arrière du crâne, des semaines de rééducation et de ce diagnostic : Amnésie post-traumatique. Les souvenirs d’Anaël ne sont plus que débris de verre sur lesquels il marche pieds nus.\r\n\r\nReste ce pan de six mois tombés dans l’oubli ; période qui peut sembler dérisoire, sauf lorsqu’elle recèle de sordides secrets.\r\n\r\nCe vide laisse un goût amer, surtout lorsqu’il commence à se méfier des dires de sa propre mère ; Eléonore, sa génitrice, sa pierre angulaire, qui prend toutes les décisions pour lui et lui ment ouvertement ! Qu’a-t-elle de si laid à enfouir ?\r\n\r\nIl doit réapprendre à vivre en faisant taire les fantômes du passé. Impossible pourtant de renoncer à sa quête de vérité. Et il n’est pas le seul à vouloir la déterrer…\r\n\r\nEt si finalement toute son existence n’était qu’illusion ? Il y a des histoires de famille bien trop lourdes à porter… Des secrets bien trop odieux pour prendre le risque de les murmurer.', 12, 17.5, 'JackZak', '2023-01-20 11:56:08', '1674212168-1.jpg', 'couverture du livre', NULL, NULL, NULL, NULL),
(4, 3, 'Sur les ailes d\'un papillon', 'sur-les-ailes-d-un-papillon', 'La vie peut être un terrible fardeau pour Florent, ce jeune papa divorcé aux prises avec ses démons intérieurs.', 'Alcoolique, mélancolique et instable, il observe son monde s’effondrer un peu plus chaque jour. S’il ne pouvait pas s’accrocher à l’amour qu’il porte pour son chien, sa petite fille et la bouteille, il le sait, il ne serait déjà plus de ce monde.\r\nAlors qu’il se bat violemment pour retrouver le goût de vivre, pour retrouver un sens à sa sombre existence, le bonheur finit par frapper à sa porte. Mais malgré tous ses efforts, son passé n’est jamais loin, semant sans pudeur les cadavres qu’il tente d’enfouir.\r\nCe livre vous immergera dans les limbes du cerveau torturé de Florent où vous rencontrerez la folie à l’état brut, mais aussi « L’ombre », cette ignoble ombre qui habite dans les entrailles de chaque Homme et qui prend un malin plaisir à nous pousser au bord du précipice.\r\nParanoïa ? Personne malintentionnée ? Délire d’un homme brisé qui lutte vainement ? Qui ou qu’est ce qui se cache derrière tous ses malheurs ? Il le pense, il le sait, ou pense le savoir ! On essaie de le détruire. Mais pourquoi ?', 24, 18.5, 'JackZak', '2023-01-20 11:57:16', '1674212236-1.jpg', 'couverture du livre', NULL, NULL, NULL, NULL),
(5, 2, 'Les chroniques des gardiens 1. Enfants de Nonna', 'les-chroniques-des-gardiens-1-enfants-de-nonna', 'Dans la Fédération, pays érigé sur les vestiges d’un monde détruit par l’arrogance de l’humanité, la vie s’écoule simplement, rythmée par les saisons et les célébrations en l’honneur de la déesse Noona.', 'Depuis tout petit Cid Malone, modeste villageois de Tomis, aspire à devenir artiste. Sur le point de réaliser sa cérémonie du recensement qui concrétise le passage des jeunes gens à l’âge adulte, un autre destin se prépare pour lui en secret.\r\nEntre les intrigues politiques et une ombre menaçante qui plane sur la nation, Cid devra trouver sa place parmi les treize Gardiens, les protecteurs de la Fédération, et surtout appréhender le pouvoir antique, tant fabuleux que terrifiant.', 8, 15, 'JackZak', '2023-01-20 11:58:16', '1674212296-1.jpg', 'couverture du livre', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) NOT NULL,
  `roles` longtext NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `is_verified` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `first_name`, `last_name`, `phone`, `created_at`, `is_verified`) VALUES
(1, 'gregoire.constant.gc@gmail.com', '[\"ROLE_SUPER_ADMIN\"]', '$2y$13$WE3qj26Hpd1IZ.abhlmJ9elrAun.XlwOCrz5hrim.No0wbXAfoGfy', 'gregoire', 'constant', '0626104434', '2023-01-19 17:57:02', 1);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D4E6F81A76ED395` (`user_id`);

--
-- Index pour la table `carrier`
--
ALTER TABLE `carrier`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Index pour la table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_F5299398A76ED395` (`user_id`),
  ADD KEY `IDX_F529939821DFC797` (`carrier_id`),
  ADD KEY `IDX_F5299398EBF23851` (`delivery_address_id`),
  ADD KEY `IDX_F529939879D0C0E4` (`billing_address_id`);

--
-- Index pour la table `order_has_product`
--
ALTER TABLE `order_has_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_AF0913F0FCDAEAAA` (`order_id_id`),
  ADD KEY `IDX_AF0913F04584665A` (`product_id`);

--
-- Index pour la table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D34A04AD12469DE2` (`category_id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `address`
--
ALTER TABLE `address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `carrier`
--
ALTER TABLE `carrier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `order_has_product`
--
ALTER TABLE `order_has_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `FK_D4E6F81A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `FK_F529939821DFC797` FOREIGN KEY (`carrier_id`) REFERENCES `carrier` (`id`),
  ADD CONSTRAINT `FK_F529939879D0C0E4` FOREIGN KEY (`billing_address_id`) REFERENCES `address` (`id`),
  ADD CONSTRAINT `FK_F5299398A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `FK_F5299398EBF23851` FOREIGN KEY (`delivery_address_id`) REFERENCES `address` (`id`);

--
-- Contraintes pour la table `order_has_product`
--
ALTER TABLE `order_has_product`
  ADD CONSTRAINT `FK_AF0913F04584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `FK_AF0913F0FCDAEAAA` FOREIGN KEY (`order_id_id`) REFERENCES `order` (`id`);

--
-- Contraintes pour la table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FK_D34A04AD12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
