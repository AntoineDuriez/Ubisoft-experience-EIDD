--Peuplement de la table patient
--Par l'énoncé, chacun est un patient potentiel
INSERT INTO patient VALUES
('Toto', 65),	--médecin référent
('Adrien', 20),	--patient type
('Titi', 86),	--patient type
('Brenda',69),	--patient type
('Tata', 67);	--spécialiste

--Peuplement de la table laboratoire
INSERT INTO laboratoire VALUES
('Institut Pasteur'),
('Hopital Bichat');

--Peuplement de la table medecin
--Parmi les patients potentiels, seuls Toto et Tata sont des médecins
INSERT INTO medecin VALUES
('Toto', 'Institut Pasteur'),
('Tata', 'Hopital Bichat');

--Peuplement de la table medecinReferent
--Parmi les médecins, seul Toto est un médecin référent
--Toto est le seul médecin à pouvoir pratiquer un diagnostic
INSERT INTO medecinReferent VALUES
('Toto', 'Institut Pasteur');

--Peuplement de la table specialiste
--Parmi les médecins, seul Tata est un spécialiste
--Tata est le seul médecin à pouvoir pratiquer des actes sur les patients
INSERT INTO specialiste VALUES
('Tata', 'Hopital Bichat');

--Peuplement de la table acte
INSERT INTO acte VALUES
('kinésithérapie'),
('hypnose');

--Peuplement de la table realise
--Seul les spécialistes peuvent pratiquer des actes
--Un spécialiste peut pratiquer plusieurs actes
INSERT INTO realise VALUES
('Tata', 'kinésithérapie'),
('Tata', 'hypnose');

--Peuplement de la table traitement
INSERT INTO traitement VALUES
('Traitement contre le corona', 50),
('Anti-allergique', 0),
('Doliprane', 100),
('Mal de dos', 30),
('Traitement experimental',70),
('Traitement contre la grippe',23);

--Peuplement de la table diagnostic
--Le médecin référent peut avoir plusieurs patients
--Un patient ne peut avoir qu'un seul médecin référent
INSERT INTO diagnostic VALUES
('Adrien', 'Toto', 'Traitement contre le corona', '2020-03-18'),
('Titi', 'Toto', 'Mal de dos', '2015-06-14'),
('Tata', 'Toto', 'Anti-allergique', '2016-07-08'),
('Titi', 'Toto', 'Traitement contre la grippe', '2018-04-06'),
('Brenda','Toto','Traitement contre le corona','2015-12-24'),
('Brenda','Toto','Traitement experimental', '2018-07-15'),
('Titi','Toto','Anti-allergique','2018-08-24'),
('Adrien', 'Toto', 'Traitement contre la grippe', '2019-11-16');

--Peuplement de la table medicament
INSERT INTO medicament VALUES
('Hydroxichloroquine', 'Chloroquine', 350),
('Huile essentielle de menthe', 'Menthe', 2000),
('Pommade', 'bounyte', 40);

--Peuplement de la table prescription
INSERT INTO prescription VALUES
('Traitement contre le corona', '3 cachets par jour', 5, 'Hydroxichloroquine'),
('Traitement experimental','1 cachet par semaine', 45,'Pommade'),
('Traitement experimental','2 flacon par jour',30,'Huile essentielle de menthe'),
('Traitement experimental','2 flacon par jour',30,'Hydroxichloroquine');

--Peuplement de la table estFabriquePar
--Un laboratoire peut fabriquer plusieurs médicaments
--Un médicament peut être fabriqué par plusieurs laboratoires
INSERT INTO estFabriquePar VALUES
('Hopital Bichat', 'Hydroxichloroquine'),
('Hopital Bichat', 'Pommade'),
('Institut Pasteur', 'Pommade'),
('Institut Pasteur', 'Huile essentielle de menthe');

--Peuplement de la table recommandation
INSERT INTO recommandation VALUES
('Anti-allergique', 'Raser le chat',25),
('Traitement contre le corona', 'Rester à la maison',25);

--Peuplement de la table orientation
INSERT INTO orientation VALUES
('Mal de dos', 100, 'Tata');

--Peuplement de la table symptome
INSERT INTO symptome VALUES
('difficultés à respirer'),
('devient vert'),
('vomissement'),
('maux de tete'),
('mal de pied'),
('anemie');

--Peuplement de la table effetSecondaire
--Certains symptomes peuvent aussi être des effets secondaires
--Tous les effets secondaires ne sont pas des symptomes
INSERT INTO effetSecondaire VALUES
('vomissement'),
('maux de tete'),
('anemie');

--Peuplement de la table provoque
--Un médicament peut provoquer plusieurs effets secondaires
--Un effet secondaire peut apparaître sur plusieurs médicaments différents
INSERT INTO provoque VALUES
('Hydroxichloroquine', 'maux de tete'),
('Hydroxichloroquine', 'vomissement'),
('Hydroxichloroquine', 'anemie'),
('Huile essentielle de menthe', 'maux de tete');

--Peuplement de la table maladie
--Un maladie n'a qu'un type
--Un type peut correspondre à plusieurs maladies
INSERT INTO maladie VALUES
('Covid-19', 'pulmonaire'),
('Grippe', 'pulmonaire'),
('Maladie X','inconnue'),
('Allergie', 'réaction cutanée'),
('Pneumonie','pulmonaire');

--Peuplement de la table estAssocieA
--Une maladie peut être associée à plusieurs symptomes
--Un symptome peut apparaître dans plusieurs maladies différentes
INSERT INTO estAssocieA VALUES
('Covid-19', 'difficultés à respirer'),
('Covid-19', 'maux de tete'),
('Allergie', 'devient vert'),
('Maladie X', 'mal de pied'),
('Grippe', 'difficultés à respirer');

--Peuplement de la table ressent
--Un patient peut ressentir plusieurs symptomes ou aucuns
--Un symptome peut être ressenti par plusieurs patients, ou aucuns
INSERT INTO ressent VALUES
('Adrien', 'difficultés à respirer'),
('Adrien', 'anemie'),
('Adrien', 'mal de pied'),
('Titi', 'difficultés à respirer'),
('Tata', 'devient vert');

--Peuplement de la table soigne
INSERT INTO soigne VALUES
('Traitement contre le corona', 'Covid-19'),
('Traitement contre la grippe','Grippe'),
('Traitement experimental','Pneumonie');

--peuplement de la table estDeveloppePar
INSERT INTO estDeveloppePar VALUES
('Hydroxichloroquine', 'Tata'),
('Pommade', 'Tata'),
('Pommade', 'Toto');




