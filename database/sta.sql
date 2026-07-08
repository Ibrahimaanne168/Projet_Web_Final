-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: sta_bd
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activites`
--

DROP TABLE IF EXISTS `activites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activites` (
  `id_activite` int(11) NOT NULL AUTO_INCREMENT,
  `titre_activite` varchar(255) NOT NULL,
  `description_activite` text NOT NULL,
  `image_activite` varchar(255) DEFAULT NULL,
  `date_activite` date DEFAULT curdate(),
  PRIMARY KEY (`id_activite`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activites`
--

LOCK TABLES `activites` WRITE;
/*!40000 ALTER TABLE `activites` DISABLE KEYS */;
INSERT INTO `activites` VALUES (1,'Journée d\'Excellence de l\'UFR STA','Une journée consacrée à la célébration de l\'excellence académique avec des conférences, des expositions de projets, des démonstrations scientifiques ainsi qu\'une cérémonie officielle de remise des distinctions aux meilleurs étudiants.\n\nRemise des prix aux majors de promotion.\nPrésentation des meilleurs projets étudiants.\nExposition scientifique des différents départements.\nRencontre entre étudiants, enseignants et partenaires.','journee-excellence.png','0000-00-00'),(2,'Compétition de Génie en Herbe Inter-Départements','Cette compétition met en opposition les étudiants des différents départements de l\'UFR STA autour d\'épreuves de mathématiques, informatique, physique, culture scientifique et logique.\n\nLes équipes qualifiées disputent une grande finale et les vainqueurs sont récompensés lors de la Journée d\'Excellence.','genie-herbe.png','0000-00-00'),(3,'Sortie pédagogique des étudiants de SML','Les étudiants de Sciences de la Mer et du Littoral effectuent une visite pédagogique ou école de terrain sur la lagune de la Somone; un géosystème naturel à mangrove situé sur la Petite côte du Sénégal.','sortie-sml.png','0000-00-00'),(4,'Présentation des projets IoT des étudiants de L3 Informatique','Les étudiants présentent leurs projets de fin de semestre en Internet des Objets : maison intelligente, station météo, agriculture intelligente, sécurité connectée et systèmes automatisés utilisant des cartes Arduino et ESP32.','projets-iot.png','0000-00-00'),(5,'Conférence scientifique','En Avril 2025, Dr Isabelle BRENON a animé une conférence scientifique à UAM, en partenariat avec l\'UFR STA sur les systèmes littoraux semi-fermés tels que les baies ...','conference1.png','0000-00-00');
/*!40000 ALTER TABLE `activites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actualites`
--

DROP TABLE IF EXISTS `actualites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actualites` (
  `id_actu` int(11) NOT NULL AUTO_INCREMENT,
  `titre_actu` text NOT NULL,
  `contenu_actu` text NOT NULL,
  `image_actu` text DEFAULT NULL,
  `categorie_actu` text DEFAULT NULL,
  `date_publication` date DEFAULT NULL,
  PRIMARY KEY (`id_actu`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actualites`
--

LOCK TABLES `actualites` WRITE;
/*!40000 ALTER TABLE `actualites` DISABLE KEYS */;
INSERT INTO `actualites` VALUES (1,'Journée Internationale des Gens de Mer','L\'UFR STA informe les étudiants intéressés par les métiers du transport maritime, de la logistique et de l\'ingénierie navale de la tenue de la Journée Internationale des Gens de Mer organisée autour du thème : « Transporter le commerce mondial, supporter les risques. »','journe-mer.png','Evenement','2026-06-25'),(2,'Suivi des cours en ligne','Dans le cadre des préparatifs des Jeux Olympiques de la Jeunesse Dakar 2026, les enseignements en présentiel sont suspendus et les étudiants poursuivent les activités pédagogiques en ligne jusqu\'au 4 juillet 2026.','cours-en-ligne.png','Etudiants','2026-06-01'),(3,'Information destinée aux étudiants de Licence 3','Les étudiants de Licence 3 sont invités à consulter les dernières informations concernant l\'organisation pédagogique, le choix des projets titorée ou stage coditionnées pour la memoire de licence 3.','projet-titore.png','Information','2026-01-01'),(4,'Conference Modelisation','Les enseignants-chercheurs et les étudiants présentent leurs travaux de recherche, leurs projets innovants et les résultats obtenus dans les différents départements.','conference.png','Evenement','2026-01-01'),(5,'L\'UFR STA a accueilli les éleves du lycée de yeumbeul','L\'UFR STA a accueilli les éleves du lycée de yeumbeul pour une viste au sein du campus. Ce visite leurs a permi de decouvrir le BU, la salle information de l\'ufr sta ....','visite.png','Evenement','2026-01-01'),(6,'Nouveaux partenariats académiques','L\'UFR STA renforce sa coopération avec plusieurs entreprises afin d\'offrir davantage d\'opportunités aux étudiants de trouver un stage pour leur fin d\'etude licence selon leurs sujets de projet .','partenariat.png','Information','2026-02-01');
/*!40000 ALTER TABLE `actualites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'Ibrahima','Abcd1234'),(2,'Amy','scrypt:32768:8:1$eKRgn059uB84fdYU$9bd25440b8aeb6aa5861249fe347bdfada24eab22cfb5445e21969175f2613db24e2b7a39e60031da9896c27ba4df0ca5a093d9f58f3ad1a1698bd4b69c0a7ef');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albums` (
  `id_album` int(11) NOT NULL AUTO_INCREMENT,
  `titre_album` varchar(255) NOT NULL,
  `description_album` text DEFAULT NULL,
  `date_album` varchar(255) NOT NULL,
  PRIMARY KEY (`id_album`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums`
--

LOCK TABLES `albums` WRITE;
/*!40000 ALTER TABLE `albums` DISABLE KEYS */;
INSERT INTO `albums` VALUES (1,'Journée d\'Excellence UFR STA',' Cérémonie de remise des distinctions aux meilleurs étudiants, exposition des projets innovants, rencontres entre enseignants, partenaires et étudiants dans une ambiance de célébration.','Juin 2026'),(2,'Compétition de Génie en Herbe',' Les départements de l\'UFR STA s\'affrontent autour d\'épreuves scientifiques, logiques et culturelles. Les finalistes sont récompensés lors de la Journée d\'Excellence.','Mai 2026'),(3,'Sortie Pédagogique des étudiants de Licence 3 SML','Une immersion sur le terrain permettant aux étudiants de mettre en pratique leurs connaissances, de découvrir le monde professionnel et d\'échanger avec des spécialistes du domaine.','Avril 2026'),(4,'Projets IoT étudiants L3','Les étudiants de Licence 3 Informatique présentent leurs réalisations en Internet des Objets devant les enseignants, les étudiants et les partenaires de l\'UFR STA.','Mars 2026'),(7,'Conférence de Modélisation','Dans le cadre de son Programme « Cycle des Grandes Conférences », l’UFR Sciences et Technologies Avancées (STA), résolument orientée vers le Calcul scientifique, le Numérique et l’Innovation technologique, a accueilli le 30 avril 2025, une personnalité éminente du monde scientifique : Pr Abdou SENE, spécialiste de renommée internationale en Mathématiques appliquées et en Modélisation numérique.','Avril 2025');
/*!40000 ALTER TABLE `albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contacts` (
  `id_contact` int(11) NOT NULL,
  `nom_contact` varchar(100) DEFAULT NULL,
  `prenom_contact` varchar(100) DEFAULT NULL,
  `email_contact` varchar(150) DEFAULT NULL,
  `sujet_contact` varchar(200) DEFAULT NULL,
  `message_contact` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES (0,'Sylla','Amy','sylla@gmail.com','Demande','Je ne vois pas mes cours sur Kairos');
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departements`
--

DROP TABLE IF EXISTS `departements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(255) NOT NULL,
  `chef_nom` varchar(150) NOT NULL,
  `chef_email` varchar(150) DEFAULT NULL,
  `chef_photo` varchar(255) NOT NULL,
  `ordre` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departements`
--

LOCK TABLES `departements` WRITE;
/*!40000 ALTER TABLE `departements` DISABLE KEYS */;
INSERT INTO `departements` VALUES (1,'Département Mathématiques, Informatique et Modélisation','Ce département a pour objectif de permettre aux étudiants d’acquérir des connaissances fondamentales, de développer des compétences analytiques et de résolution de problèmes, d’explorer les intersections interdisciplinaires et de préparer aux spécialisations et à la recherche scientifique.','mim.jpg','Dr. Thierno M. M. SOW','chef-departement-mim@uam.edu.sn','cdmim.jpg',1),(2,'Département des Sciences de la Matière et de l\'Univers','Ce département propose des formations innovantes dans les domaines de la mer, de la physique et de ses applications. Il offre aux étudiants la possibilité d’acquérir une formation qui leur permette d’accéder au plus haut niveau des connaissances académiques tant en recherche que dans le domaine professionnel.','smu.jpg','Dr. Makha NDAO','makhandao@uam.edu.sn','cdsmu.jpg',1);
/*!40000 ALTER TABLE `departements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enseignants`
--

DROP TABLE IF EXISTS `enseignants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enseignants` (
  `id_enseignant` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(150) NOT NULL,
  `grade` varchar(255) NOT NULL,
  `departement` varchar(255) NOT NULL,
  `email` varchar(150) NOT NULL,
  `recherche` text NOT NULL,
  `photo` varchar(255) NOT NULL,
  PRIMARY KEY (`id_enseignant`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enseignants`
--

LOCK TABLES `enseignants` WRITE;
/*!40000 ALTER TABLE `enseignants` DISABLE KEYS */;
INSERT INTO `enseignants` VALUES (1,'Amadou Dahirou GUEYE','Professeur Titulaire - Enseignant-chercheur','Département Mathématiques, Informatique et Modélisation','dahirou.gueye@uam.edu.sn','Informatique | Télé-laboratoires, IA appliquée, IoT, Cloud','prof.png'),(2,'Thierno Mohamadane SOW','Maitre de Conférences Titulaire - Enseignant-chercheur','Département Mathématiques, Informatique et Modélisation','chef-departement-mim@uam.edu.sn','Mathématiques Appliquées | Analyse Non linéaire, Géométrie des Banach, Optimisation, Analyse fonctionnelle, Calcul des variations','prof2.jpg'),(3,'Siny NDOYE','Maitre de Conférences Titulaire - Enseignant-chercheur','Département Sciences de la Matière et de l\'Univers','siny.ndoye@uam.edu.sn','Physique - Océanographie | Dynamique océanique, Upwelling, Pollution marine, Changement climatique, Modélisation hydrodynamique','prof3.png'),(4,'Makha NDAO','Maitre de Conférences Titulaire - Enseignant-chercheur','Département Sciences de la Matière et de l\'Univers','makha.ndao@uam.edu.sn','Nanosciences & Matériaux | Biomasse, stockage énergie, polymères, microplastiques, traitement des eaux, nanofiltration','prof4.png'),(5,'Alioune COULIBALY','Maitre de Conférences Titulaire - Directeur UFR STA','Département Mathématiques, Informatique et Modélisation','alioune.coulibaly@uam.edu.sn','Mathématiques Appliquées | EDP, EDS, Probabilité, Statistique, systèmes dynamiques, calcul stochastique','prof5.png'),(6,'Issa SAKHO','Professeur assimilé - Vice-Recteur Recherche et Innovation','Département Sciences de la Matière et de l\'Univers','issa.sakho@uam.edu.sn','Géosciences marines | Sédiments littoraux, risques côtiers, transfert de matières, écosystèmes carbone bleu','prof6.png'),(7,'Modou THIAW','Maître de Conférence CAMES - Ecologie marine','Département Sciences de la Matière et de l\'Univers','modou.thiaw@uam.edu.sn','Écologie marine | Pêches, AMP, gestion durable, bioéconomie, écosystèmes côtiers, modélisation marine','prof7.png');
/*!40000 ALTER TABLE `enseignants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filieres`
--

DROP TABLE IF EXISTS `filieres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filieres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `departement_id` int(11) NOT NULL,
  `nom` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `texte_specialisation` text DEFAULT NULL,
  `ordre` int(11) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `departement_id` (`departement_id`),
  CONSTRAINT `filieres_ibfk_1` FOREIGN KEY (`departement_id`) REFERENCES `departements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filieres`
--

LOCK TABLES `filieres` WRITE;
/*!40000 ALTER TABLE `filieres` DISABLE KEYS */;
INSERT INTO `filieres` VALUES (1,1,'Mathématiques, Physique et Informatique (MPI)','Cette filière a pour objectif de permettre aux étudiants d’acquérir des connaissances fondamentales, de développer des compétences analytiques et de résolution de problèmes, d’explorer les intersections interdisciplinaires et de préparer aux spécialisations et à la recherche scientifique.','mpi.jpg','A partir de la Licence 3, un choix de spécialisation s\'impose pour la filière MPI. Les étudiants peuvent choisir entre les spécialisations suivantes : <br>Mathématiques et Modélisation (MM), <br>Informatique Appliquée (IA), <br>Physique et Applications (PA) qui migre vers le département SMU.',1),(2,1,'Mathématiques et Informatique Appliquées aux Sciences Sociales (MIASS)','Cette filière forme des professionnels capables de travailler dans les compagnies d’assurances, les cabinets d’études de prévision et de conseil, le commerce, le marketing, le management des projets, le management des entreprises, la finance, la gestion, la comptabilité, la gestion industrielle, la logistique et la qualité, l’enseignement et la recherche.','miass.jpg',NULL,2),(3,1,'Mathématiques et Modélisation','La filière Mathématiques et Modélisation (MM) forme des étudiants à l\'analyse, à la modélisation et à la résolution de problèmes complexes. Elle prépare aux métiers de la modélisation mathématique, de la recherche, de la finance, de la science des données, de l\'optimisation et de la simulation numérique.','mm.jpg',NULL,3),(4,1,'Informatique Appliquée','La filière Informatique Appliquée (IA) forme des spécialistes capables de concevoir, développer et administrer des solutions informatiques répondant aux besoins des entreprises et des organisations. Elle prépare aux métiers du développement logiciel, des bases de données, des réseaux, de la cybersécurité, de l’intelligence artificielle et de la science des données.','ia.jpg',NULL,4),(5,2,'Sciences de la Mer et du Littoral (SML)','Cette filière forme des spécialistes de la gestion et de l’aménagement des espaces côtiers et maritimes, avec des compétences en génie côtier, génie portuaire, ressources marines et économie bleue.','sml.jpg',NULL,1),(6,2,'Physique et Applications','La filière Physique et Applications (PA) forme des étudiants aux métiers de la physique et de ses applications. Le tronc commun (S1 à S4) est partagé avec la filière MPI, puis, à partir du S5, la formation est assurée par le département Sciences de la Matière et de l’Univers (SMU). Elle prépare des compétences répondant aux besoins du développement durable, notamment dans les domaines des matériaux, des énergies, de l’eau et du spatial.','pa.jpg',NULL,2);
/*!40000 ALTER TABLE `filieres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maquettes`
--

DROP TABLE IF EXISTS `maquettes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maquettes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filiere_id` int(11) NOT NULL,
  `semestre` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `filiere_id` (`filiere_id`),
  CONSTRAINT `maquettes_ibfk_1` FOREIGN KEY (`filiere_id`) REFERENCES `filieres` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maquettes`
--

LOCK TABLES `maquettes` WRITE;
/*!40000 ALTER TABLE `maquettes` DISABLE KEYS */;
INSERT INTO `maquettes` VALUES (1,1,1,'mpis1.png'),(2,1,2,'mpis2.png'),(3,1,3,'mpis3.png'),(4,2,1,'miasss1.png'),(5,2,2,'miasss2.png'),(6,2,3,'miasss3.png'),(7,5,1,'smls1.png'),(8,5,2,'smls2.png'),(9,5,3,'smls3.png');
/*!40000 ALTER TABLE `maquettes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photos` (
  `id_photo` int(11) NOT NULL AUTO_INCREMENT,
  `album_id` int(11) DEFAULT NULL,
  `image_album` varchar(255) NOT NULL,
  PRIMARY KEY (`id_photo`),
  KEY `album_id` (`album_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `albums` (`id_album`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` VALUES (1,1,'excellence1.jpeg'),(2,1,'excellence2.png'),(3,1,'excellence3.png'),(4,1,'excellence4.png'),(5,1,'excellence5.png'),(6,1,'excellence6.png'),(7,2,'genie1.png'),(8,2,'genie2.png'),(9,2,'genie3.png'),(10,2,'genie4.png'),(11,2,'genie5.png'),(12,2,'genie-herbe.png'),(13,3,'sortie1.png'),(14,3,'sortie2.png'),(15,3,'sortie3.png'),(16,3,'sortie4.png'),(17,3,'sortie5.png'),(18,3,'sortie6.png'),(19,4,'projets-iot.png'),(20,4,'iot2.png'),(21,4,'iot3.png'),(22,4,'iot4.png'),(23,4,'iot5.png'),(24,4,'iot6.png'),(26,7,'con1.png'),(27,7,'con2.png'),(28,7,'con3.png'),(29,7,'con4.png'),(30,7,'conference.png'),(31,7,'conf.png');
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semestres`
--

DROP TABLE IF EXISTS `semestres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `semestres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filiere_id` int(11) NOT NULL,
  `numero` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `filiere_id` (`filiere_id`),
  CONSTRAINT `semestres_ibfk_1` FOREIGN KEY (`filiere_id`) REFERENCES `filieres` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semestres`
--

LOCK TABLES `semestres` WRITE;
/*!40000 ALTER TABLE `semestres` DISABLE KEYS */;
INSERT INTO `semestres` VALUES (1,1,4),(2,3,5),(3,3,6),(4,4,5),(5,4,6),(6,6,5),(7,6,6);
/*!40000 ALTER TABLE `semestres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ues`
--

DROP TABLE IF EXISTS `ues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `semestre_id` int(11) NOT NULL,
  `ue` varchar(200) NOT NULL,
  `ec` text NOT NULL,
  `credits` varchar(20) DEFAULT NULL,
  `ordre` int(11) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `semestre_id` (`semestre_id`),
  CONSTRAINT `ues_ibfk_1` FOREIGN KEY (`semestre_id`) REFERENCES `semestres` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ues`
--

LOCK TABLES `ues` WRITE;
/*!40000 ALTER TABLE `ues` DISABLE KEYS */;
INSERT INTO `ues` VALUES (1,1,'Mathématiques','Analyse 4<br>Algèbre 4<br>Probabilités','9',1),(2,1,'Physique','Mécanique Quantique<br>Électro-Relativité','8',2),(3,1,'Informatique','Système d\'Exploitation<br>Algorithmes Avancés<br>Datascience et IA','8',3),(4,1,'Analyse du Signal','Outils Mathématiques pour le Signal<br>Traitement du Signal et Image','3',4),(5,1,'Outils de Bases','Anglais 4<br>Projet Personnel','2',5),(6,4,'Informatique 5.2','Programmation Java Avancée<br>Programmation Data Science<br>Programmation Web','-',1),(7,4,'Informatique 5.3','Internet des Objets (IoT)<br>Introduction aux Réseaux','-',2),(8,4,'Informatique 5.4','Génie Logiciel<br>SI et Modélisation UML','-',3),(9,4,'Mathématiques 5.1','Analyse de données<br>Recherche Opérationnelle','-',4),(10,4,'Humanités','Anglais Technique<br>Leadership et Développement Personnel<br>Techniques de Rédaction Scientifique','-',5),(11,5,'Informatique 6.1','Introduction aux Routage<br>Sécurité du Système Informatique et Réseaux','-',1),(12,5,'Informatique 6.2','Virtualisation/Cloud<br>Services Réseaux','-',2),(13,5,'Informatique 6.3','Développement d\'applications mobiles<br>JavaScript et Framework','-',3),(14,5,'Informatique 6.4','Big Data<br>Deep Learning','8',4),(15,5,'Projets de Fin d\'Études','Projets Tutorés','-',5),(16,2,'Mathématiques 5.1','Analyse 5<br>Variables Complexes<br>Statistique Inférentielle','-',1),(17,2,'Mathématiques 5.2','Solveurs Numériques 1 (EDO)<br>Recherche Opérationnelle<br>Mesure et Intégration','-',2),(18,2,'Informatique 5','Bases de Données et Visualisation<br>Calculs Intensifs','-',3),(19,2,'Humanités','Anglais Technique<br>Leadership et Développement Personnel<br>Techniques de Rédaction Scientifique','-',4),(20,3,'Mathématiques 6.1','Introduction aux EDP<br>Optimisation non linéaire<br>Calcul Différentiel','-',1),(21,3,'Mathématiques 6.2','Solveurs Numériques 2<br>Modélisation des Données<br>Introduction au Calcul Parallèle','-',2),(22,3,'Informatique 6','IoT et IA<br>Outils Informatiques','-',3),(23,3,'Projet de Fin d\'Études','Projets Tutorés','-',4),(24,6,'Physique 5.2','Physique Quantique 1<br>Electromagnétisme','-',1),(25,6,'Mathématiques 5','Mathématiques pour la Physique<br>Méthode Numérique 1','-',2),(26,6,'Chimie Générale','Atomistique et Liaisons chimiques<br>Thermochimie','-',3),(27,6,'Humanités','Anglais Technique<br>Leadership et Développement Personnel<br>Techniques de Rédaction Scientifique','-',4),(28,7,'Physique 6.1','Mécanique des Fluides<br>Mécanique des milieux continus','-',1),(29,7,'Physique 6.2','Optique Physique<br>Optique Cristalline','-',2),(30,7,'Chimie de la matière','Chimie inorganique<br>Chimie organique','-',3),(31,7,'Mathématiques 6','Mathématiques pour la Physique 2<br>Méthode Numérique 2','-',4),(32,7,'Electronique','Electronique Analogique<br>Electronique Numérique','-',5),(33,7,'Projets de Fin de Cycle','Projet','-',6);
/*!40000 ALTER TABLE `ues` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-07 12:18:12
