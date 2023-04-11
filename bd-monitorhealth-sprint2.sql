CREATE DATABASE dbMonitorHealth;
USE dbMonitorHealth;

CREATE TABLE tbEmpresa (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nomeResposavel VARCHAR (60) NOT NULL,
  nomeFantasia VARCHAR (60) NOT NULL,
  cnpj CHAR (18) NOT NULL, 
  segmento VARCHAR (20) NOT NULL,
  tel CHAR (14) NOT NULL,
  email VARCHAR (30) NOT NULL,
  cep CHAR(10),
  rua VARCHAR  (200) NOT NULL,
  numero VARCHAR (5) NOT NULL,
  complemento VARCHAR (20),
  bairro VARCHAR (200),
  cidade VARCHAR (200) NOT NULL,
  estado CHAR (2) NOT NULL
);

CREATE TABLE tbUsuario (
  id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR (60) NOT NULL,
  senha VARCHAR (60) NOT NULL,
  permissoes CHAR (13) NOT NULL,
  fkEmpresa INT,
  CONSTRAINT fkEmpresaConst FOREIGN KEY (fkEmpresa) REFERENCES tbEmpresa(fkEmpresa) 
);
 
CREATE TABLE tbSensor (
	id INT PRIMARY KEY AUTO_INCREMENT,
	tipo CHAR (21) NOT NULL,
	dtInstalacao DATE NOT NULL,
	ambiente VARCHAR (100) NOT NULL,
  fkEmpresa INT,
  FOREIGN KEY (fkEmpresa) REFERENCES tbEmpresa(id) 
);

CREATE TABLE tbEntradaSensorTemperatura (
  id INT PRIMARY KEY AUTO_INCREMENT,
  valor FLOAT NOT NULL,
  dt DATETIME NOT NULL,
  fkSensor INT,
  FOREIGN KEY (fkSensor) REFERENCES tbSensor(id)
);

CREATE TABLE tbEntradaSensorPresenca (
  id INT PRIMARY KEY AUTO_INCREMENT,
  valor BOOLEAN NOT NULL,
  dt DATETIME NOT NULL,
  fkSensor INT,
  FOREIGN KEY (fkSensor) REFERENCES tbSensor(id)
);
  

SELECT * FROM tbEmpresa;
SELECT * FROM tbUsuario;
SELECT * FROM tbSensor;
SELECT * FROM tbEntradaSensorTemperatura;
SELECT * FROM tbEntradaSensorPresenca;

-- Permissão basica: Apenas visualização dos dados;
-- Permissão intermediario: Visualização dos dados, permissão para alterar algumas configurações;
-- Permissão total: Permissão para realizar todas as ações dentro do sistema, incluindo criar novos usuarios dentro da empresa.
ALTER TABLE tbusuario
	ADD  CONSTRAINT chkPermissao CHECK (permissoes IN ('basico', 'intermediario', 'total'));
   
-- Diferenciar os sensores entre o sensor de presença ou o de temperatura e umidade
ALTER TABLE tbSensor
	ADD CONSTRAINT chkTipo CHECK (tipo IN ('presenca', 'temperatura'));
    
    
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
INSERT INTO tbSensor VALUES
(null,'Presença', '2022-12-15', 'geladeira 150L'),
(null,'Temperatura', '2020-02-24', 'geladeira 150L');
