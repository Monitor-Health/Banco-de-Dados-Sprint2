CREATE DATABASE MonitorHealth;
USE MonitorHealth;

CREATE TABLE Segmento(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200)
);

CREATE TABLE Estado(
    id INT PRIMARY KEY AUTO_INCREMENT,
    sigla CHAR(2) NOT NULL
);

CREATE TABLE Empresa (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nomeResposavel VARCHAR (60) NOT NULL,
  nomeFantasia VARCHAR (60) NOT NULL,
  cnpj CHAR (14) NOT NULL,
  tel CHAR (14) NOT NULL,
  cep CHAR(10),
  tipoLogradouro VARCHAR(100),
  logradouro VARCHAR (200) NOT NULL,
  numero VARCHAR (5) NOT NULL,
  complemento VARCHAR (20),
  bairro VARCHAR (200),
  cidade VARCHAR (200) NOT NULL,
  fkEstado INT,
  fkSegmento INT,
  CONSTRAINT fkEstadoConst FOREIGN KEY (fkEstado) REFERENCES Estado(id),
  CONSTRAINT fkSegmentoConst FOREIGN KEY (fkSegmento) REFERENCES Segmento(id)
);

CREATE TABLE Permissao(
    id INT PRIMARY KEY AUTO_INCREMENT,
    autoridade VARCHAR(100)
);

CREATE TABLE Usuario (
  id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR (60) NOT NULL,
  senha VARCHAR (60) NOT NULL,
  fkPermissao INT,
  fkEmpresa INT,
  CONSTRAINT fkPermissaoConst FOREIGN KEY (fkPermissao) REFERENCES Permissao(id),
  CONSTRAINT fkEmpresaConst FOREIGN KEY (fkEmpresa) REFERENCES Empresa(id)
);

CREATE TABLE TipoSensor(
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(100)
);

CREATE TABLE Sensor (
  id INT PRIMARY KEY AUTO_INCREMENT,
  fkTipoSensor INT,
  dtInstalacao DATE NOT NULL,
  ambiente VARCHAR (100) NOT NULL,
  fkEmpresa INT,
  CONSTRAINT fkTipoSensorConst FOREIGN KEY (fkTipoSensor) REFERENCES TipoSensor(id),
  CONSTRAINT fkEmpresaConstSensor FOREIGN KEY (fkEmpresa) REFERENCES Empresa(id)
);

CREATE TABLE Dados (
  valor FLOAT NOT NULL,
  dt_hora DATETIME NOT NULL,
  fkSensor INT,
  CONSTRAINT fkSensorConstTemp FOREIGN KEY (fkSensor) REFERENCES Sensor(id),
  constraint pkComposta primary key (fkSensor, dt_hora)
);


INSERT INTO Estado (sigla) VALUES
('AC'),
('AL'),
('AP'),
('AM'),
('BA'),
('CE'),
('DF'),
('ES'),
('GO'),
('MA'),
('MT'),
('MS'),
('MG'),
('PA'),
('PB'),
('PR'),
('PE'),
('PI'),
('RJ'),
('RN'),
('RS'),
('RO'),
('RR'),
('SC'),
('SP'),
('SE'),
('TO');

INSERT INTO Segmento (nome) VALUES
('Farmacêutico'),
('Seguros de saúde'),
('Tecnologia da Informação em Saúde');

INSERT INTO Empresa (nomeResposavel, nomeFantasia, cnpj, tel, cep, tipoLogradouro, logradouro, numero, complemento, bairro, cidade, fkEstado, fkSegmento) VALUES 
('João Silva', 'Vacina Fácil', '12345678901234', '(11)99999-9999', '00000-000', 'Rua', 'Rua das Flores', '123', 'Sala 2', 'Centro', 'São Paulo', 25, 1),
('Maria Santos', 'Imunização Segura', '23456789012345', '(21)88888-8888', '11111-111', 'Avenida', 'Avenida dos Coqueiros', '456', NULL, 'Praia do Futuro', 'Fortaleza', 6, 2),
('José Pereira', 'Vacine Já', '34567890123456', '(51)77777-7777', '22222-222', 'Rua', 'Rua das Palmeiras', '789', NULL, 'Jardim Botânico', 'Porto Alegre', 20, 1);

INSERT INTO Permissao (autoridade) VALUES 
('Administrador'),
('Usuário comum');

INSERT INTO Usuario (email, senha, fkPermissao, fkEmpresa) VALUES
('joao.silva@vacinafacil.com', 'senhajoao', 1, 1),
('maria.santos@imunizacaosegura.com', 'senhamaria', 2, 2),
('jose.pereira@vacineja.com', 'senhajose', 2, 3);

INSERT INTO TipoSensor VALUES
(NULL, 'Presença'),
(NULL, 'Temperatura');

INSERT INTO Sensor (fkTipoSensor, dtInstalacao, ambiente, fkEmpresa) VALUES
(2, '2022-01-01', 'Geladeira 01', 1),
(2, '2022-01-01', 'Geladeira 02', 1),
(2, '2022-02-01', 'Freezer 01', 2),
(1, '2022-02-01', 'Freezer 02', 2),
(2, '2022-03-01', 'Geladeira 01', 3),
(2, '2022-03-01', 'Geladeira 02', 3);

INSERT INTO Dados VALUES
(2.5, '2022-02-01 10:00:00', 1),
(2.0, '2022-02-01 11:00:00', 1),
(3.0, '2022-02-02 10:00:00', 2),
(2.5, '2022-02-01 10:00:00', 2),
(2.0, '2022-02-01 11:00:00', 3),
(3.0, '2022-02-02 10:00:00', 3),
(0, '2022-02-01 10:00:00', 4),
(2.0, '2022-02-01 11:00:00', 5),
(1, '2022-02-02 10:00:00', 6);


SELECT * FROM Segmento;
SELECT * FROM Estado;
SELECT * FROM Empresa;
SELECT * FROM Permissao;
SELECT * FROM Usuario;
SELECT * FROM TipoSensor;
SELECT * FROM Sensor;
select * from Dados;

 -- Sensores e seus respectivos dados de suas respectivas empresas
select Empresa.nomeFantasia, Sensor.ambiente, tiposensor.tipo, dados.valor, dados.dt_hora
 from Empresa
	join Sensor
		on Sensor.fkEmpresa = Empresa.id
			join Dados
				on Dados.fkSensor = Sensor.id
					join TipoSensor
						on tiposensor.id = sensor.fktiposensor;

 -- Sensores e seus respectivos dados da empresa de ID igual a 1                      
select Empresa.nomeFantasia, Sensor.ambiente, tiposensor.tipo, dados.valor, dados.dt_hora
 from Empresa
	join Sensor
		on Sensor.fkEmpresa = Empresa.id
			join Dados
				on Dados.fkSensor = Sensor.id
					join TipoSensor
						on tiposensor.id = sensor.fktiposensor
							where empresa.id = 1;

 -- Sensores e seus respectivos dados de suas respectivas empresas onde a temperatura é menor que 3 graus                         
select Empresa.nomeFantasia, Sensor.ambiente, tiposensor.tipo, dados.valor, dados.dt_hora
 from Empresa
	join Sensor
		on Sensor.fkEmpresa = Empresa.id
			join Dados
				on Dados.fkSensor = Sensor.id
					join TipoSensor
						on tiposensor.id = sensor.fktiposensor
							where tiposensor.tipo = "Temperatura" and dados.valor < 3;             
                            
 -- Sensores e seus respectivos dados de suas respectivas empresas onde a porta da geladeira esteja aberta                         
select Empresa.nomeFantasia, Sensor.ambiente, tiposensor.tipo, dados.valor, dados.dt_hora
 from Empresa
	join Sensor
		on Sensor.fkEmpresa = Empresa.id
			join Dados
				on Dados.fkSensor = Sensor.id
					join TipoSensor
						on tiposensor.id = sensor.fktiposensor
							where tiposensor.tipo = "Presença" and dados.valor = 0;                                 