--Criação do banco de dados
--DROP DATABASE IF EXISTS bd_MaisSaudePlus;
--CREATE DATABASE bd_MaisSaudePlus;

--Deletando as tabelas caso elas existam
DROP TABLE IF EXISTS GerarNotificacao; 
DROP TABLE IF EXISTS ConsultaRealizada;
DROP TABLE IF EXISTS Procedimento;
DROP TABLE IF EXISTS Consulta;
DROP TABLE IF EXISTS Medico;
DROP TABLE IF EXISTS Paciente;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Medicamento;

--Criação das tabelas do banco de dados
CREATE TABLE Medicamento (
  codMedicamento SERIAL NOT NULL,
  nomeMedicamento VARCHAR(50) NOT NULL,
  descMedicamento VARCHAR(500)   NOT NULL,
  valorMedicamento FLOAT   NOT NULL,
 PRIMARY KEY(codMedicamento)
);

CREATE TABLE Funcionario (
  codFuncionario SERIAL  NOT NULL,
  nomeFuncionario VARCHAR(50),
  dataAdmissao DATE,
  cpfFuncionario VARCHAR(11),
  emailFuncionario VARCHAR(45),
  telefone VARCHAR(50),
PRIMARY KEY(codFuncionario)
);

CREATE TABLE Medico (
  codMedico SERIAL  NOT NULL,
  cpf VARCHAR(11)   NOT NULL,
  crmMedico VARCHAR(45)   NOT NULL,
  nomeMedico VARCHAR(45)   NOT NULL,
  dataAdmissao DATE   NOT NULL,
  email VARCHAR(45)   NOT NULL,
  telefone VARCHAR(50),
PRIMARY KEY(codMedico)
);

CREATE TABLE Procedimento (
  codProcedimento SERIAL  NOT NULL,
  nomeProcedimento VARCHAR(50),
  descProcedimento VARCHAR(200)   NOT NULL,
  valorProcedimento FLOAT   NOT NULL,
  flagObesidade BOOL   NOT NULL,
PRIMARY KEY(codProcedimento)
);

CREATE TABLE Paciente (
  codPaciente SERIAL  NOT NULL,
  cpf VARCHAR(11)   NOT NULL,
  nomePaciente VARCHAR(45)   NOT NULL,
  dataNascimento DATE   NOT NULL,
  altura FLOAT   NOT NULL,
  peso FLOAT   NOT NULL,
  sexo CHAR(1)   NOT NULL,
  email VARCHAR(50)   NOT NULL,
  telefone VARCHAR(14)   NOT NULL,
  numConsultas int,
PRIMARY KEY(codPaciente)
);

CREATE TABLE GerarNotificacao (
  codGerarNotificacao SERIAL  NOT NULL ,
  Paciente_codPaciente INTEGER   NOT NULL ,
  dataNotificacao DATE   NOT NULL   ,
PRIMARY KEY(codGerarNotificacao)  ,
  FOREIGN KEY(Paciente_codPaciente)
    REFERENCES Paciente(codPaciente)
);

CREATE TABLE Consulta (
  codConsulta SERIAL NOT NULL,
  Medico_codMedico INTEGER   NOT NULL,
  Funcionario_codFuncionario SERIAL  NOT NULL,
  Paciente_codPaciente INTEGER   NOT NULL,
  dataConsulta DATE   NOT NULL,
  horaConsulta TIME   NOT NULL,
  duracaoConsulta INTEGER   NOT NULL ,
  statusConsulta VARCHAR(15),
PRIMARY KEY(codConsulta),
  FOREIGN KEY(Paciente_codPaciente)
    REFERENCES Paciente(codPaciente),
  FOREIGN KEY(Funcionario_codFuncionario)
    REFERENCES Funcionario(codFuncionario),
  FOREIGN KEY(Medico_codMedico)
    REFERENCES Medico(codMedico)
);

CREATE TABLE ConsultaRealizada (
  codConsultaRealizada SERIAL  NOT NULL,
  Consulta_codConsulta INTEGER   NOT NULL,
  Procedimento_codProcedimento INTEGER,
  Medicamento_codMedicamento INTEGER,
PRIMARY KEY(codConsultaRealizada),
  FOREIGN KEY(Consulta_codConsulta)
    REFERENCES Consulta(codConsulta),
  FOREIGN KEY(Procedimento_codProcedimento)
    REFERENCES Procedimento(codProcedimento),
  FOREIGN KEY(Medicamento_codMedicamento)
    REFERENCES Medicamento(codMedicamento)
);

-- Criação do usúario que ira utilizar o banco de dados
DROP USER IF EXISTS user_saudeplus;

CREATE USER user_saudeplus WITH PASSWORD 'ifes2023';
	
--Grant para ceder permissão total as tabelas
GRANT INSERT, SELECT, UPDATE, DELETE ON Medico, Paciente, Procedimento, GerarNotificacao, Consulta, ConsultaRealizada, Funcionario, Medicamento
	TO user_saudeplus;

--Grant para ceder permissão nas sequencias de cada tabela
GRANT ALL ON paciente_codpaciente_seq, consulta_codconsulta_seq, consulta_funcionario_codfuncionario_seq,
		 consultarealizada_codconsultarealizada_seq, funcionario_codfuncionario_seq, gerarnotificacao_codgerarnotificacao_seq,
		 medico_codmedico_seq, procedimento_codprocedimento_seq, medicamento_codmedicamento_seq
TO user_saudeplus;

--Revogando permissões das tabelas
-- REVOKE ALL ON Medico, Paciente, Procedimento, GerarNotificacao, Consulta, ConsultaRealizada, Funcionario, Medicamento
-- 	FROM user_saudeplus;

-- --Revogando permissões das sequencias
-- REVOKE ALL ON paciente_codpaciente_seq, consulta_codconsulta_seq, consulta_funcionario_codfuncionario_seq,
-- 			 consultarealizada_codconsultarealizada_seq, funcionario_codfuncionario_seq, gerarnotificacao_codgerarnotificacao_seq,
-- 			 medico_codmedico_seq, procedimento_codprocedimento_seq, medicamento_codmedicamento_seq
-- 	FROM user_saudeplus;
	
-- Inserção de dados para popular a base de dados (Por enquanto, Pacientes e Médicos somente)
INSERT INTO Medico (cpf, crmMedico, nomeMedico, dataAdmissao, email, telefone) 
		VALUES	('11122233344', 'ES-36724', 'NORONHA RAMOS','2022-02-20', 'doutor.noronha@Gmail.com', '(28)99988-7766'),
				    ('35641285425', 'ES-54862', 'LORENA RAMOS', '2022-02-20', 'doutora.lorena@gmail.com', '(28)99921-4586'),
				    ('15674284684', 'RJ-48562', 'JÚLIO ARMANDO', '2022-03-04', 'doutor.julio@Gmail,com', '(28)99956-4158');
				
INSERT INTO Paciente (cpf, nomePaciente, dataNascimento, altura, peso, sexo, email, telefone, numConsultas)
		VALUES	('23541756364', 'JOEL ALMEIDA', '1981-09-26', 1.82, 91.00, 'M','Joel.456@hotmail.com', '(22)99948-7523', 1),
				    ('65478932119', 'ELLIE WILLIAMS', '2003-09-30', 1.60, 60.00, 'F', 'EllieWilliams@gmail.com', '(28)99948-5261', 0),
				    ('15248659124', 'RENATO SILVA', '1979-08-03', 1.81, 75.00, 'M', 'RenatoSilva@gmail.com', '(28)99921-5689', 0),
				    ('85296374198', 'RENATA SILVA', '1979-08-03', 1.79, 70, 'F', 'RenataSilva@gmail.com', '(28)99948-7263', 0),
				    ('47823685212', 'EVANDRO ARAUJO', '1985-09-01', 1.67, 95, 'M', 'EvandroFlamengo@hotmail.com', '(28)99945-8621', 0);

INSERT INTO Funcionario (nomefuncionario, dataadmissao, cpffuncionario, emailfuncionario, telefone)
	  VALUES	('LUIZA MOREIRA', '1981-01-30', '85496732149', 'luiza@MaisSaudePlus.com', '(20)99911-9845'),
	  			  ('LEANDRO MEIRINHO', '1990-04-16', '17455869410', 'leandro@MaisSaudePlus.com', '(24)99971-1175'),
     		 	  ('JULIANO PEREIRA', '1970-10-10', '17563487940', 'juliano@MaisSaudePlus.com', '(27)99915-1733');

INSERT INTO Consulta (medico_codmedico, funcionario_codfuncionario, paciente_codpaciente, dataconsulta, horaconsulta, duracaoconsulta, statusconsulta)
	  VALUES	(1, 1, 2, '2023-01-01', '14:00', 30, 'Realizada'),
				    (2, 2, 3, '2023-01-02', '14:00', 30, 'Realizada'),
				    (3, 1, 4, '2023-02-03', '14:00', 60, 'Realizada'),
            (1, 3, 4, '2023-02-04', '14:00', 60, 'Realizada'),
				    (2, 3, 3, '2023-02-05', '14:00', 45, 'Realizada'),
				    (3, 2, 2, '2023-02-07', '14:00', 60, 'Realizada'),
            (1, 2, 2, '2023-02-08', '14:00', 30, 'Realizada'),
				    (2, 1, 5, '2023-03-09', '14:00', 45, 'Realizada'),
				    (3, 1, 5, '2023-03-10', '14:00', 60, 'Realizada'),
            (1, 1, 2, '2023-04-11', '14:00', 30, 'Realizada'),
				    (2, 2, 2, '2023-04-12', '14:00', 60, 'Realizada'),
				    (3, 3, 5, '2023-04-13', '14:00', 45, 'Realizada'),
				
	 			    (1, 1, 1, '2023-05-14', '13:00', 60, 'Agendada'),
            (2, 1, 1, '2023-05-15', '14:00', 30, 'Agendada'),
				    (1, 1, 1, '2023-05-16', '14:00', 45, 'Agendada'),
				    (2, 1, 1, '2023-05-17', '14:00', 60, 'Agendada');
				
INSERT INTO Procedimento (nomeProcedimento, descProcedimento, valorProcedimento, flagObesidade)	
    VALUES
            ('Não há procedimento', 'Não há procedimento',0 ,false),
            ('Hemograma','Hemograma com contagem de plaquetas ou frações (eritrograma, leucograma, plaquetas)', 10.00, true),
            ('Cintilografia', 'Cintilografia para pesquisa de refluxo gastro-esofágico', 20.00, true),
            ('Hemoglobina glicada', 'Hemoglobina glicada (A1 total), dosagem', 18.00, true),
            ('Miopatias', 'Doença de natureza muscular que atingem exclusivamente os músculos (1C)', 30.00, false);

INSERT INTO Medicamento(nomeMedicamento,descMedicamento,valorMedicamento)
    VALUES
            ('Não há medicamento','Não há medicamento',0),
            ('Dietilpropiona', 'Dietilpropiona atua no sistema nervoso central, estimulando os neurônios a liberarem ou manterem elevados os níveis das catecolaminas, um grupo de neurotransmissores do qual fazem parte a dopamina e a norepinefrina.', 150.00),
            ('Sibutramina', 'Sibutramina atua no Sistema Nervoso Central (SNC) para inibir o apetite e aumentar a sensação de saciedade durante a alimentação', 50.00),
            ('Dipirona', 'analgésico e antitérmico utilizado em enfermidades que tenham dor e febre como sintomas', 10.00);

INSERT INTO ConsultaRealizada (consulta_codconsulta, procedimento_codprocedimento, medicamento_codmedicamento)
	  VALUES	(1, 1, 1),
	  			  (2, 5, 2),
	  			  (3, 3, 2),
	  			  (4, 2, 1),	  
	  			  (5, 5, 3),	  
	  			  (6, 4, 2),	  
	  			  (7, 3, 3),				
	  			  (8, 5, 3),				
	  			  (9, 4, 3),				
	  			  (10, 2, 4),
				    (11, 2, 4),
				    (12, 2, 4);
				