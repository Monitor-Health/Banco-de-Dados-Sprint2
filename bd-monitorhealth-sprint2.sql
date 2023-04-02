CREATE DATABASE dbSprint1;
USE dbSprint1;

CREATE TABLE tbEmpresa (
  idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
  nomeResposavel VARCHAR (60) NOT NULL,
  nomeEmpresa VARCHAR (60) NOT NULL,
  cnpjEmpresa CHAR (18) NOT NULL, 
  segmento VARCHAR (20) NOT NULL,
  telEmpresa CHAR (14) NOT NULL,
  emailEmpresa VARCHAR (30) NOT NULL,
  cepEndereco CHAR(10),
  ruaEmpresa VARCHAR  (200) NOT NULL,
  numeroEndereco VARCHAR (5) NOT NULL,
  complemento VARCHAR (20),
  bairroEndereco VARCHAR (200),
  cidadeEndereco VARCHAR (200) NOT NULL,
  estadoEndereco VARCHAR (200) NOT NULL
);

CREATE TABLE tbUsuario (
  idUsuario INT PRIMARY KEY AUTO_INCREMENT,
  emailUsuario VARCHAR (60) NOT NULL,
  senhaUsuario VARCHAR (60) NOT NULL,
  permissoes CHAR (13) NOT NULL,
  idEmpresa INT -- foreign key sp2
);
 
CREATE TABLE tbSensor (
	idSensor INT PRIMARY KEY AUTO_INCREMENT,
	tipoSensor CHAR (21) NOT NULL,
	dtInstalacao DATE NOT NULL,
	localInstalado VARCHAR (100) NOT NULL,
    idEmpresa INT -- foreign key sp2
);

CREATE TABLE tbEntradaSensorTemperatura (
  idEntrada INT PRIMARY KEY AUTO_INCREMENT,
  valorEntrada FLOAT NOT NULL,
  dtEntrada DATETIME NOT NULL,
  idSensor INT -- foreign key sp2
  );

CREATE TABLE tbEntradaSensorPresença (
  idEntrada INT PRIMARY KEY AUTO_INCREMENT,
  valorEntrada FLOAT NOT NULL,
  dtEntrada DATETIME NOT NULL,
  idSensor INT -- foreign key sp2
  );
  

SELECT * FROM tbEmpresa;
SELECT * FROM tbUsuario;
SELECT * FROM tbSensor;
SELECT * FROM tbEntradaSensorTemperatura;
SELECT * FROM tbEntradaSensorPresença;

-- Permissão basica: Apenas visualização dos dados;
-- Permissão intermediario: Visualização dos dados, permissão para alterar algumas configurações;
-- Permissão total: Permissão para realizar todas as ações dentro do sistema, incluindo criar novos usuarios dentro da empresa.
ALTER TABLE tbusuario
	ADD  CONSTRAINT chkPermissao CHECK (permissoes IN ('basico', 'intermediario', 'total'));
   
-- Diferenciar os sensores entre o sensor de presença ou o de temperatura e umidade
ALTER TABLE tbSensor
	ADD CONSTRAINT chkTipo CHECK (tipoSensor IN ('presenca', 'temperatura'));
    
    
-- INSERT Empresa
INSERT INTO tbEmpresa VALUES
	(null,'Fulano 1','QLL Logística', '12.610.534/0001-19', 'Medicamentos', '(11)3185-4820' , 'contato@qll.com.br','07182-000',
		'Av. Sargtbempresaento da Aeronáutica Jaime Regalo Pereira', 563 , null, 'Jardim Cumbica', 'Guarulhos', 'SP');

-- INSERT Usuario
INSERT INTO tbUsuario VALUES
	(null,'Ricardo Vicente', '123#Asd', 'intermediario', 1),
    (null,'Mark Zuckenberg', 'Mark@012', 'basico', 2),
    (null,'Guilherme Scarabelli', 'Gui#212', 'intermediario', 3),
    (null,'Alan Turing', 'loveComputacao#1912', 'total', 4),
    (null,'Ada Lovelace', 'PrimeiroAlgoritmo@1815', 'total', 5);

-- INSERT Sensor
INSERT INTO tbsensor VALUES
	(null,'Presença', '2022-12-15', 'geladeira 150L'),
    (null,'Temperatura', '2020-02-24', 'geladeira 150L');

-- INSERT EntradaDados
INSERT INTO tbentradasensor VALUES 
	(null,1 , '2022-12-16 08:00:00', 1),
    (null,-20, '2020-02-24 18:00:00',2);    
    
    
