
--création des tables pour le projet

--Si les tables existent déjà, on les supprime et on recrée le tout
DROP TABLE IF EXISTS estDeveloppePar;
DROP TABLE IF EXISTS soigne;
DROP TABLE IF EXISTS ressent;
DROP TABLE IF EXISTS estAssocieA;
DROP TABLE IF EXISTS maladie;
DROP TABLE IF EXISTS provoque;
DROP TABLE IF EXISTS effetSecondaire;
DROP TABLE IF EXISTS symptome;
DROP TABLE IF EXISTS orientation;
DROP TABLE IF EXISTS recommandation;
DROP TABLE IF EXISTS estFabriquePar;
DROP TABLE IF EXISTS prescription;
DROP TABLE IF EXISTS medicament;
DROP TABLE IF EXISTS diagnostic;
DROP TABLE IF EXISTS traitement;
DROP TABLE IF EXISTS realise;
DROP TABLE IF EXISTS acte;
DROP TABLE IF EXISTS specialiste;
DROP TABLE IF EXISTS medecinReferent;
DROP TABLE IF EXISTS medecin;
DROP TABLE IF EXISTS laboratoire;
DROP TABLE IF EXISTS patient;


--Un patient se caractérise par son nom
--D'après l'énoncé, nous sommes tous des patients,
--donc la table medecin va héritier de patient
CREATE TABLE patient (
       nom VARCHAR(50) NOT NULL,
       age int NOT NULL,
       PRIMARY KEY (nom)
);

--Un laboratoire se caractérise par son nom
CREATE TABLE laboratoire (
       nom VARCHAR(50) NOT NULL,
       PRIMARY KEY(nom)
);

--Un médecin se caractérise par son nom et le labo dans lequel il travaille
--Un médecin ne peut travailler que dans un seul labo (pas de travail au noir)
--Comme un médecin est un patient, il hérite son nom de la table patient
CREATE TABLE medecin (
       nom VARCHAR(50) NOT NULL,
       nomLabo VARCHAR(50) NOT NULL,
       PRIMARY KEY (nom),
       FOREIGN KEY (nom) REFERENCES patient(nom),
       FOREIGN KEY (nomLabo) REFERENCES laboratoire(nom)
);

--Un médecin référent hérite de médecin et de ses caractéristiques
--Il est le seul médecin a pouvoir pratiquer le diagnostic
CREATE TABLE medecinReferent (
       nom VARCHAR(50) NOT NULL,
       nomLabo VARCHAR(50) NOT NULL,
       PRIMARY KEY (nom),
       FOREIGN KEY (nomLabo) REFERENCES laboratoire(nom)
);

--Un spécialiste hérite de médecin et de ses caractéristiques
--Il est le seul médecin à pouvoir pratiquer des actes
--Il est le seul médecin vers lequel le référent peut orienter le patient
--(on n'oriente pas le patient vers un autre médecin référent)
CREATE TABLE specialiste (
       nom VARCHAR(50) NOT NULL,
       nomLabo VARCHAR(50) NOT NULL,
       PRIMARY KEY (nom),
       FOREIGN KEY (nom) REFERENCES medecin(nom),
       FOREIGN KEY (nomLabo) REFERENCES laboratoire(nom)
);
--Les actes sont effectués par les spécialistes
--Ils se caractérise par leur description
CREATE TABLE acte (
       description VARCHAR(50) NOT NULL,
       PRIMARY KEY (description)
);

--Les actes sont réalisés par les spécialistes
--Un acte est associé au nom d'un spécialiste
CREATE TABLE realise (
       nomSpecialiste VARCHAR(50) NOT NULL,
       descriptionActe VARCHAR(50) NOT NULL,
       PRIMARY KEY(nomSpecialiste, descriptionActe),
       FOREIGN KEY(nomSpecialiste) REFERENCES specialiste(nom),
       FOREIGN KEY(descriptionActe) REFERENCES acte(description)

);

--Un traitement est caractérisé par son nom
--La table indique aussi la hauteur de rembousement (0 si pas remboursé)
CREATE TABLE traitement(
       nom VARCHAR(50) NOT NULL,
       remboursement int NOT NULL,
       PRIMARY KEY(nom)
);

--En fonction du diagnostic, un médecin référent oriente un patient
--vers un certain traitement
--Si un médecin est un patient, il ne peut pas être son propre médecin référent ?
CREATE TABLE diagnostic (
       nomPatient VARCHAR(50) NOT NULL,
       nomMedecin VARCHAR(50) NOT NULL,
       nomTraitement VARCHAR(50) NOT NULL,
       datation DATE NOT NULL,
       PRIMARY KEY(nomPatient, nomMedecin, nomTraitement),
       FOREIGN KEY(nomPatient) REFERENCES patient(nom),
       FOREIGN KEY(nomMedecin) REFERENCES medecinReferent(nom),
       FOREIGN KEY(nomTraitement) REFERENCES traitement(nom)
);

--Un médicament se caractérise par son nom
--La table indique aussi la molécule active du médicament
--ainsi que le prix (on suppose que le prix est fixe quelque soit le laboratoire qui le produit)
CREATE TABLE medicament (
       nom VARCHAR(50) NOT NULL,
       moleculeActive VARCHAR(50) NOT NULL,
       prix int NOT NULL,
       PRIMARY KEY(nom)
);

--La prescription hérite de la table traitement
--Elle est caractérisée par le nom du traitement auquel elle appartient
--La table indique aussi la posologie du traitement, sa durée, le nom du médicament prescrit et le remboursement
--On pose qu'une prescription concerne au minimum 1 médicament (donc forme 1..n)
--(si on avait eu 0..n, on aurait eu des prescriptions sans médicaments, donc illogique)
CREATE TABLE prescription (
       nomTraitement VARCHAR(50) NOT NULL,
       posologie VARCHAR(50) NOT NULL,
       durée int NOT NULL,
       nomMedicament VARCHAR(50) NOT NULL,
       PRIMARY KEY(nomTraitement,nomMedicament),
       FOREIGN KEY(nomTraitement) REFERENCES traitement(nom),
       FOREIGN KEY(nomMedicament) REFERENCES medicament(nom)
);

--La table est caractérisée par un laboratoire et un médicament
--Chaque laboratoires peuvent fabriquer plusieurs médicaments
--Chaque médicaments peuvent être fabriqué par plusieurs laboratoires différents (cas des génériques)
--(Par soucis de simplicité, les génériques cités ci-dessus porteront le même nom que les médicaments originaux)
CREATE TABLE estFabriquePar (
      nomLabo VARCHAR(50) NOT NULL,
      nomMedicament VARCHAR(50) NOT NULL,
      PRIMARY KEY(nomLabo, nomMedicament),
      FOREIGN KEY(nomLabo) REFERENCES laboratoire(nom),
      FOREIGN KEY(nomMedicament) REFERENCES medicament(nom)
);

--recommandation hérite de traitement
--La table est caractérisée par le nom du traitement auquel elle appartient
--La table indique aussi la description de la recommandation ainsi que la possibilité de remboursement
CREATE TABLE recommandation (
      nomTraitement VARCHAR(50) NOT NULL,
      description VARCHAR(50) NOT NULL,
      prix int NOT NULL,
      PRIMARY KEY(nomTraitement),
      FOREIGN KEY(nomTraitement) REFERENCES traitement(nom)
);

--orientation hérite de traitement
--La table est caractérisée par le nom du traitement auquel elle appartient
--La table indique aussi la possibilité de remboursement, le prix ainsi que le nom du spécialiste
--vers lequel le patient est orienté (et qui pourra pratiquer des actes)
CREATE TABLE orientation (
       nomTraitement VARCHAR(50) NOT NULL,
       prix int NOT NULL,
       nomSPecialiste VARCHAR(50) NOT NULL,
       PRIMARY KEY(nomTraitement),
       FOREIGN KEY(nomTraitement) REFERENCES traitement(nom),
       FOREIGN KEY(nomSpecialiste) REFERENCES specialiste(nom)
);

--Les symptomes sont caractérisés par une description
CREATE TABLE symptome (
       description VARCHAR(50) NOT NULL,
       PRIMARY KEY(description)
);

--Un effet secondaire hérite de symptome
--La table est caractérisée par une description qu'elle hérite de symptome
CREATE TABLE effetSecondaire (
       description VARCHAR(50) NOT NULL,
       PRIMARY KEY(description),
       FOREIGN KEY(description) REFERENCES symptome(description)
);

--Un médicament peut provoquer 0 ou plusieurs effets secondaires (0..n)
--Un effet secondaire peut être retrouver chez 0 ou plusieurs médicaments (0..n)
CREATE TABLE provoque (
       nomMedicament VARCHAR(50) NOT NULL,
       descriptionEffet VARCHAR(50) NOT NULL,
       PRIMARY KEY(nomMedicament, descriptionEffet),
       FOREIGN KEY(nomMedicament) REFERENCES medicament(nom),
       FOREIGN KEY(descriptionEffet) REFERENCES effetSecondaire(description)
);

--Une maladie est caractérisée par un nom et un type
CREATE TABLE maladie (
       nom VARCHAR(50) NOT NULL,
       typeMaladie VARCHAR(50) NOT NULL,
       PRIMARY KEY(nom)
);

--Une maladie peut être associée à 0 ou plusieurs symptomes (on prend en compte les cas asymptomatiques)
--Une symptome peut apparaître dans 0 ou plusieurs maladies
--(être vert est un symptome, on ne le retrouve pourtant dans aucunes maladies connues)
CREATE TABLE estAssocieA (
       nomMaladie VARCHAR(50) NOT NULL,
       descriptionSymptome VARCHAR(50) NOT NULL,
       PRIMARY KEY(nomMaladie, descriptionSymptome),
       FOREIGN KEY(nomMaladie) REFERENCES maladie(nom),
       FOREIGN KEY(descriptionSymptome) REFERENCES symptome(description)
);

--Un patient peut ressentir 0 ou plusieurs symptomes (encore le cas des asymptomatiques)
--Un symptome peut être ressenti par 0 ou plusieurs patients
CREATE TABLE ressent (
       nomPatient VARCHAR(50) NOT NULL,
       descriptionSymptome VARCHAR(50) NOT NULL,
       PRIMARY KEY(nomPatient, descriptionSymptome),
       FOREIGN KEY(nomPatient) REFERENCES patient(nom),
       FOREIGN KEY(descriptionSymptome) REFERENCES symptome(description)
);

--Une traitement peut soigner 0 ou plusieurs maladies (il y a des traitements inefficaces)
--Une maladie peut être soignée par 0 ou plusieurs traitemements (par exemple, le SIDA ne se soigne pas)
CREATE TABLE soigne (
       nomTraitement VARCHAR(50) NOT NULL,
       nomMaladie VARCHAR(50) NOT NULL,
       PRIMARY KEY(nomTraitement, nomMaladie),
       FOREIGN KEY(nomTraitement) REFERENCES traitement(nom),
       FOREIGN KEY(nomMaladie) REFERENCES maladie(nom)
);

--Un médecin peut développer 0 ou plusieurs médicaments
--(un médecin peut ne pas participer à l'élaboration de médicament mais juste faire des consultations)
--Un médicament peut être réalisé par 0 ou plusieurs médecins
CREATE TABLE estDeveloppePar(
       nomMedicament VARCHAR(50) NOT NULL,
       nomDeveloppeur VARCHAR(50) NOT NULL,
       PRIMARY KEY (nomMedicament, nomDeveloppeur),
       FOREIGN KEY (nomMedicament) REFERENCES medicament(nom),
       FOREIGN KEY (nomDeveloppeur) REFERENCES medecin(nom)
);
