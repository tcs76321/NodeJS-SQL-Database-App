-- TREVOR STAHL stahltr@oreognstate.edu  

-- INTRODUCTION TO DATABASES (CS_340_400_F2018)

-- characteristics table
DROP TABLE IF EXISTS `characteristics_tcs`;

CREATE TABLE `characteristics_tcs` (
  `c_id` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(255) NOT NULL,
  PRIMARY KEY (`c_id`),
  UNIQUE KEY `cname` (`cname`)
) ENGINE=InnoDB;

-- pantheon table
DROP TABLE IF EXISTS `pantheons_tcs`;

CREATE TABLE `pantheons_tcs` (
  `p_id` int(11) NOT NULL AUTO_INCREMENT,
  `pname` varchar(255) NOT NULL,
  `loca` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`p_id`),
  UNIQUE KEY `pname` (`pname`)
) ENGINE=InnoDB;

-- IPA table
DROP TABLE IF EXISTS `ipas_tcs`;

CREATE TABLE `ipas_tcs` (
  `ipa_id` int(11) NOT NULL AUTO_INCREMENT,
  `ipname` varchar(255) NOT NULL,
  `p_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`ipa_id`),
  UNIQUE KEY `ipname` (`ipname`),
  FOREIGN KEY (`p_id`) REFERENCES pantheons_tcs(`p_id`)
) ENGINE=InnoDB;

-- MPID table
DROP TABLE IF EXISTS `mpids_tcs`;

CREATE TABLE `mpids_tcs` (
  `mp_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`mp_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB;


-- beings table
DROP TABLE IF EXISTS `beings_tcs`;

CREATE TABLE `beings_tcs` (
  `b_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `p_id` int(11) NOT NULL,
  `gender` char(1) NOT NULL DEFAULT 'N',
  `ipa_id` int(11) DEFAULT NULL,
  `narrative` varchar(255) DEFAULT NULL,
  `mp_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`b_id`),
  UNIQUE KEY `name` (`name`),
  FOREIGN KEY (`p_id`) REFERENCES pantheons_tcs(`p_id`),
  FOREIGN KEY (`ipa_id`) REFERENCES ipas_tcs(`ipa_id`),
  FOREIGN KEY (`mp_id`) REFERENCES mpids_tcs(`mp_id`)
) ENGINE=InnoDB;


-- is like relation table
DROP TABLE IF EXISTS `ilr_tcs`;

CREATE TABLE `ilr_tcs` (
	`b_id` int(11) NOT NULL,
	`c_id` int(11) NOT NULL,
	FOREIGN KEY (`b_id`) REFERENCES beings_tcs(`b_id`) ON DELETE CASCADE,
	FOREIGN KEY (`c_id`) REFERENCES characteristics_tcs(`c_id`) ON DELETE CASCADE
) ENGINE=InnoDB;



-- insert into characteristics
-- INSERT INTO characteristics_tcs () VALUES();
INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('merry-making'); 

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('friendship'); 

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('gluttony');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('betrayal');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('evil');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('wrath');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('deceit');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('laziness');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('learning');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('wisdom');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('light');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('dark');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('sun');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('moon');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('courage');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('cowardice');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('nature');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('fertillity');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('oceans');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('mountains');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('thunder');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('lightning');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('fire');

INSERT INTO `characteristics_tcs` (`cname`)
VALUES ('ice');

-- insert into pantheons
-- INSERT INTO pantheons_tcs () VALUES();
INSERT INTO `pantheons_tcs` (`pname`, `loca`)
VALUES ('Norse Pagan', 'Scandinavia');

INSERT INTO `pantheons_tcs` (`pname`, `loca`)
VALUES ('Roman Pagan', 'Italy');

INSERT INTO `pantheons_tcs` (`pname`, `loca`)
VALUES ('Hellenic', 'Greece');

INSERT INTO `pantheons_tcs` (`pname`, `loca`)
VALUES ('Hindu', 'India');

INSERT INTO `pantheons_tcs` (`pname`, `loca`)
VALUES ('Shinto', 'Japan');

INSERT INTO `pantheons_tcs` (`pname`, `loca`)
VALUES ('Celtic', 'Western Europe');

INSERT INTO `pantheons_tcs` (`pname`, `loca`)
VALUES ('Slavic Pagan', 'Eastern Europe');

-- insert into MPID
-- INSERT INTO mpids_tcs () VALUES();
INSERT INTO mpids_tcs (`name`)
VALUES ('Sky Father');

INSERT INTO mpids_tcs (`name`)
VALUES ('Dawn Goddess');

INSERT INTO mpids_tcs (`name`)
VALUES ('Divine Twins');

INSERT INTO mpids_tcs (`name`)
VALUES ('Fire Devil');

INSERT INTO mpids_tcs (`name`)
VALUES ('Earth Mother');

INSERT INTO mpids_tcs (`name`)
VALUES ('God of War');

INSERT INTO mpids_tcs (`name`)
VALUES ('Trickster');



-- insert into IPA
-- INSERT INTO ipas_tcs () VALUES();
INSERT INTO ipas_tcs SET p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Norse Pagan'), ipname='Aesir';
INSERT INTO ipas_tcs SET p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Norse Pagan'), ipname='Vanir';
INSERT INTO ipas_tcs SET p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Norse Pagan'), ipname='Frost Giants';
INSERT INTO ipas_tcs SET p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Norse Pagan'), ipname='Fire Demons';

INSERT INTO ipas_tcs SET p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Hellenic'), ipname='Olympians';
INSERT INTO ipas_tcs SET p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Hellenic'), ipname='Titans';
INSERT INTO ipas_tcs SET p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Hellenic'), ipname='Monsters';


-- insert into beings
-- INSERT INTO beings_tcs () VALUES();
INSERT INTO beings_tcs SET name='Thor', p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Norse Pagan'), gender='M', ipa_id=(SELECT ipa_id FROM ipas_tcs WHERE ipname='Aesir'), mp_id=(SELECT mp_id FROM mpids_tcs WHERE name='Sky Father');
INSERT INTO beings_tcs SET name='Loki', p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Norse Pagan'), gender='N', ipa_id=(SELECT ipa_id FROM ipas_tcs WHERE ipname='Aesir'), mp_id=(SELECT mp_id FROM mpids_tcs WHERE name='Trickster');
INSERT INTO beings_tcs SET name='Frigg', p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Norse Pagan'), gender='F', ipa_id=(SELECT ipa_id FROM ipas_tcs WHERE ipname='Aesir'), mp_id=(SELECT mp_id FROM mpids_tcs WHERE name='Earth Mother');

INSERT INTO beings_tcs SET name='Vesna', p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Slavic Pagan'), gender='F', mp_id=(SELECT mp_id FROM mpids_tcs WHERE name='Dawn Goddess');

INSERT INTO beings_tcs SET name='Brighid', p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Celtic'), gender='F', mp_id=(SELECT mp_id FROM mpids_tcs WHERE name='Earth Mother');

INSERT INTO beings_tcs SET name='Hachiman', p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Shinto'), gender='M', mp_id=(SELECT mp_id FROM mpids_tcs WHERE name='God of War');

INSERT INTO beings_tcs SET name='Ganesh', p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Hindu'), gender='M';

INSERT INTO beings_tcs SET name='Zeus', p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Hellenic'), gender='M', mp_id=(SELECT mp_id FROM mpids_tcs WHERE name='Sky Father');
INSERT INTO beings_tcs SET name='Athena', p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Hellenic'), gender='F', mp_id=(SELECT mp_id FROM mpids_tcs WHERE name='Dawn Goddess');
INSERT INTO beings_tcs SET name='Ares', p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Hellenic'), gender='M', mp_id=(SELECT mp_id FROM mpids_tcs WHERE name='God of War');

INSERT INTO beings_tcs SET name='Jupiter', p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Roman Pagan'), gender='M', mp_id=(SELECT mp_id FROM mpids_tcs WHERE name='Sky Father');
INSERT INTO beings_tcs SET name='Minerva', p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Roman Pagan'), gender='F', mp_id=(SELECT mp_id FROM mpids_tcs WHERE name='Dawn Goddess');
INSERT INTO beings_tcs SET name='Mars', p_id=(SELECT p_id FROM pantheons_tcs WHERE pname='Roman Pagan'), gender='M', mp_id=(SELECT mp_id FROM mpids_tcs WHERE name='God of War');

-- IRL table insert
INSERT INTO ilr_tcs SET c_id=(SELECT c_id FROM characteristics_tcs WHERE cname='gluttony'), b_id=(SELECT b_id FROM beings_tcs WHERE name='Thor');
INSERT INTO ilr_tcs SET c_id=(SELECT c_id FROM characteristics_tcs WHERE cname='friendship'), b_id=(SELECT b_id FROM beings_tcs WHERE name='Thor');
INSERT INTO ilr_tcs SET c_id=(SELECT c_id FROM characteristics_tcs WHERE cname='merry-making'), b_id=(SELECT b_id FROM beings_tcs WHERE name='Thor');

INSERT INTO ilr_tcs SET c_id=(SELECT c_id FROM characteristics_tcs WHERE cname='deceit'), b_id=(SELECT b_id FROM beings_tcs WHERE name='Loki');
INSERT INTO ilr_tcs SET c_id=(SELECT c_id FROM characteristics_tcs WHERE cname='cowardice'), b_id=(SELECT b_id FROM beings_tcs WHERE name='Loki');