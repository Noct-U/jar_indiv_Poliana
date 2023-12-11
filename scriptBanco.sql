CREATE DATABASE noctuBD;

USE noctu;

CREATE TABLE empresa(
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    razaoSocial VARCHAR(100) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    telefoneFixo CHAR(12) NOT NULL
);

INSERT INTO empresa(nome, razaoSocial, cnpj, telefoneFixo) VALUES
	('Simpress', 'Ltda', '12356789019283', '119333576377');

CREATE TABLE endereco(
	idEndereco INT PRIMARY KEY AUTO_INCREMENT,
	cep CHAR(8) NOT NULL,
    uf CHAR(2) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    bairro VARCHAR(45) NOT NULL,
    logradouro VARCHAR(45) NOT NULL
);

INSERT INTO endereco (cep, uf, cidade, bairro, logradouro) VALUES
	('08474230', 'SP', 'São Paulo', 'Paulista', 'Rua Haddock Lobo');

CREATE TABLE local(
	idLocal INT AUTO_INCREMENT,
    numero INT NOT NULL,
    complemento VARCHAR(45),
    andar INT,
    sala VARCHAR(45),
    fkEndereco INT NOT NULL,
    fkEmpresa INT NOT NULL,
    FOREIGN KEY (fkEndereco) REFERENCES endereco(idEndereco),
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    PRIMARY KEY (idLocal, fkEndereco, fkEmpresa)
);

INSERT INTO local (numero, andar, sala, fkEndereco, fkEmpresa) VALUES
	(211, 7, '7A', 1, 1);

CREATE TABLE empresaLocataria (
	idEmpresaLocataria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    cnpj CHAR(14),
    fkMatriz INT,
    fkEmpresa INT,
    FOREIGN KEY (fkMatriz) REFERENCES empresaLocataria(idEmpresaLocataria),
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

INSERT INTO empresaLocataria (nome, cnpj, fkEmpresa) VALUES
	('SPTech', '10293029381203', 1);
    
CREATE TABLE tipoUsuario(
	idTipoUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nomeTipo VARCHAR(45) NOT NULL
);

INSERT INTO tipoUsuario (nomeTipo) VALUES
	('Admin'),
	('Funcionario');
    
CREATE TABLE usuario(
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
	email VARCHAR(45) NOT NULL,
    senha VARCHAR(45) NOT NULL,
    fkTipoUsuario INT NOT NULL,
    fkEmpresaLocadora INT NOT NULL,
    fkEmpresaAlocacao INT NOT NULL,
    FOREIGN KEY (fkEmpresaAlocacao) REFERENCES empresaLocataria(idEmpresaLocataria),
    FOREIGN KEY (fkTipoUsuario) REFERENCES tipoUsuario (idTipoUsuario)
);

INSERT INTO  usuario (nome, email, senha, fkTipoUsuario, fkEmpresaLocadora, fkEmpresaAlocacao) VALUES
	('Kevin', 'kevin.silva@sptech.school', '1234', 1, 1, 1);

CREATE TABLE modeloComputador(
	idModeloComputador INT PRIMARY KEY auto_increment,
    nome VARCHAR(45)
);

INSERT INTO modeloComputador (nome) VALUES
	('IdeaPad');

CREATE TABLE computador(
	idComputador INT PRIMARY KEY auto_increment,
    numeroSerie VARCHAR(45),
    fkEmpresa INT,
    fkModeloComputador INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    FOREIGN KEY (fkModeloComputador) REFERENCES modeloComputador(idModeloComputador)
);

INSERT INTO computador (numeroSerie, fkEmpresa, fkModeloComputador) VALUES
	('2213131xy321', 1, 1);
    
CREATE TABLE unidadeMedida(
	idUnidadeMedida INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(45),
	simbolo VARCHAR(3)
);

INSERT INTO unidadeMedida (titulo, simbolo) VALUES
	('Porcentagem', '%'),
	('GigaBytes', 'GB');

CREATE TABLE tipoHardware(
	idTipoHardware INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    fkUnidademedida INT,
    FOREIGN KEY (fkUnidadeMedida) REFERENCES unidadeMedida(idUnidadeMedida)
);

INSERT INTO tipoHardware VALUES
	(NULL, 'CPU', 1),
	(NULL, 'RAM', 1),
	(NULL, 'Disco', 2),
	(NULL, 'Janelas', NULL);

CREATE TABLE hardware(
	idHardware INT PRIMARY KEY auto_increment,
    nome VARCHAR(100) NOT NULL,
    especificidade VARCHAR(45),
    capacidade DECIMAL(10,2) NOT NULL,
	fkTipoHardware INT,
    FOREIGN KEY (fkTipoHardware) REFERENCES tipoHardware(idTipoHardware)
);

CREATE TABLE parametro(
	idParametro INT PRIMARY KEY AUTO_INCREMENT,
    min DECIMAL(10,2),
    max DECIMAL(10,2)
);

-- JAR pega

CREATE TABLE componente(
	idComponente INT AUTO_INCREMENT,
    fkHardware INT,
    fkComputador INT,
    codigoSerial VARCHAR(45),
    fkParametro INT,
    FOREIGN KEY (fkParametro) REFERENCES parametro(idParametro),
    FOREIGN KEY (fkHardware) REFERENCES hardware(idHardware),
    FOREIGN KEY (fkComputador) REFERENCES computador(idComputador),
    PRIMARY KEY (idComponente, fkHardware, fkComputador)
);
-- JAR pega

CREATE TABLE captura (
	idCaptura INT PRIMARY KEY AUTO_INCREMENT,
    valor DECIMAL(10,2),
    descricao VARCHAR(45),
    dtCaptura DATETIME,
    fkComputador INT,
    fkHardware INT,
    fkComponente INT,
    FOREIGN KEY (fkComputador) REFERENCES componente(fkComputador),
    FOREIGN KEY (fkHardware) REFERENCES componente(fkHardware),
    FOREIGN KEY (fkComponente) REFERENCES componente(idComponente)
);

CREATE TABLE alerta(
	idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100),
    descricao VARCHAR(100),
    dtAlerta DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkCaptura INT,
    FOREIGN KEY (fkCaptura) REFERENCES captura(idCaptura)
);

-- JAR pega

select * from hardware;
select * from componente;
select * from captura;

CREATE TABLE insercao(
    idInsercao INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    descricao VARCHAR(45) NOT NULL
    );
    
select * from insercao;

    
