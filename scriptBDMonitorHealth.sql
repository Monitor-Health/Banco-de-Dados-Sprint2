CREATE DATABASE dbMonitorHealth;
USE dbMonitorHealth;

CREATE TABLE tbSegmento(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(200)
);

CREATE TABLE tbEstado(
    id INT PRIMARY KEY AUTO_INCREMENT,
    sigla CHAR(2) NOT NULL
);

CREATE TABLE tbEmpresa (
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
  CONSTRAINT fkEstadoConst FOREIGN KEY (fkEstado) REFERENCES tbEstado(id),
  CONSTRAINT fkSegmentoConst FOREIGN KEY (fkSegmento) REFERENCES tbSegmento(id)
);

CREATE TABLE tbPermissao(
    id INT PRIMARY KEY AUTO_INCREMENT,
    autoridade VARCHAR(100)
);

CREATE TABLE tbUsuario (
  id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR (60) NOT NULL,
  senha VARCHAR (60) NOT NULL,
  fkPermissao INT,
  fkEmpresa INT,
  CONSTRAINT fkPermissaoConst FOREIGN KEY (fkPermissao) REFERENCES tbPermissao(id),
  CONSTRAINT fkEmpresaConst FOREIGN KEY (fkEmpresa) REFERENCES tbEmpresa(id)
);

CREATE TABLE tbTipoSensor(
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(100)
);

CREATE TABLE tbSensor (
  id INT PRIMARY KEY AUTO_INCREMENT,
  fkTipoSensor INT,
  dtInstalacao DATE NOT NULL,
  ambiente VARCHAR (100) NOT NULL,
  fkEmpresa INT,
  CONSTRAINT fkTipoSensorConst FOREIGN KEY (fkTipoSensor) REFERENCES tbTipoSensor(id),
  CONSTRAINT fkEmpresaConstSensor FOREIGN KEY (fkEmpresa) REFERENCES tbEmpresa(id)
);

CREATE TABLE tbEntradaSensor (
  valor FLOAT NOT NULL,
  dt_hora DATETIME NOT NULL,
  fkSensor INT,
  CONSTRAINT fkSensorConstTemp FOREIGN KEY (fkSensor) REFERENCES tbSensor(id),
  constraint pkComposta primary key (fkSensor, dt_hora)
);


INSERT INTO tbEstado VALUES
(NULL, 'SP'),
(NULL, 'MG');

INSERT INTO tbSegmento VALUES
(NULL, 'Farmacêutico'),
(NULL, 'Seguros de saúde'),
(NULL, 'Tecnologia da Informação em Saúde');

INSERT INTO tbEmpresa VALUES
(NULL,'Fulano 1','QLL Logística', '12610534000119', '(11)3185-4820' ,'07182-000', 'Avenida',
'Jaime Regalo Pereira', '563' , null, 'Jardim Cumbica', 'Guarulhos', 1, 2);

INSERT INTO tbPermissao VALUES
(NULL, 'ADMIN'),
(NULL, 'OPERADOR');

INSERT INTO tbUsuario VALUES
(NULL, 'mariabrown@gmail.com', 'maria12345', 1, 1),
(NULL, 'alexgreen@gmail.com', 'alex12345', 2, 1);

INSERT INTO tbTipoSensor VALUES
(NULL, 'Presença'),
(NULL, 'Temperatura');

INSERT INTO tbSensor VALUES
(NULL, 1, '2022-12-15', 'geladeira 150L', 1),
(NULL, 2, '2020-02-24', 'geladeira 150L', 1);

INSERT INTO tbEntradaSensor values
(20.8, '2023-01-01 12:00:00', 3),
(21.8, '2023-01-01 12:01:00', 3),
(20.8, '2023-01-01 12:00:00', 4),
(21.8, '2023-01-01 12:01:00', 4);

SELECT * FROM tbSegmento;
SELECT * FROM tbEstado;
SELECT * FROM tbEmpresa;
SELECT * FROM tbPermissao;
SELECT * FROM tbUsuario;
SELECT * FROM tbTipoSensor;
SELECT * FROM tbSensor;
select * from tbEntradaSensor;

select * from tbEmpresa
	join tbSensor
		on tbSensor.fkEmpresa = tbEmpresa.id
			join tbEntradaSensor
				on tbEntradaSensor.fkSensor = tbSensor.id;