CREATE DATABASE BdStreaming;

USE BdStreaming;

-- ===================================
-- TABELAS RELACIONADAS AOS FILMES
-- ===================================
CREATE TABLE GeneroFilme(
	IdGeneroFilme INT AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    CONSTRAINT PK_GeneroFilme PRIMARY KEY(IdGeneroFilme)
);

CREATE TABLE Ator(
	IdAtor INT AUTO_INCREMENT,
    Nome VARCHAR(150) NOT NULL,
    DataNascimento DATE,
    -- Foto LONGBLOB,
    CONSTRAINT PK_Ator PRIMARY KEY(IdAtor)
);

CREATE TABLE Diretor(
	IdDiretor INT AUTO_INCREMENT,
    Nome VARCHAR(150) NOT NULL,
    DataNascimento DATE,
    -- Foto LONGBLOB,
    CONSTRAINT PK_Diretor PRIMARY KEY(IdDiretor)
);

CREATE TABLE Roteirista(
	IdRoteirista INT AUTO_INCREMENT,
    Nome VARCHAR(150) NOT NULL,
    DataNascimento DATE,
    -- Foto LONGBLOB,
    CONSTRAINT PK_Roteirista PRIMARY KEY(IdRoteirista)
);

CREATE TABLE Produtora(
	IdProdutora INT AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Produtora PRIMARY KEY(IdProdutora)
);

CREATE TABLE Filme(
	IdFilme INT AUTO_INCREMENT,
    Titulo VARCHAR(200) NOT NULL,
    Enredo TEXT NOT NULL,
    DataLancamento DATE NOT NULL,
    Investimento DECIMAL CHECK(Investimento > 0.00),
    Duracao TIME NOT NULL,
    -- Poster LONGBLOB NOT NULL,
    IdGeneroFilme INT,
    IdDiretor INT,
    IdProdutora INT,
    CONSTRAINT PK_Filme PRIMARY KEY(IdFilme),
    CONSTRAINT FK_GeneroFilme FOREIGN KEY(IdGeneroFilme) REFERENCES GeneroFilme(IdGeneroFilme),
    CONSTRAINT FK_Diretor FOREIGN KEY(IdDiretor) REFERENCES Diretor(IdDiretor),
    CONSTRAINT FK_Produtora FOREIGN KEY(IdProdutora) REFERENCES Produtora(IdProdutora)
);

CREATE TABLE FilmeAtor(
	IdFilme INT,
    IdAtor INT,
    CONSTRAINT PKC_FilmeAtor PRIMARY KEY(IdFilme, IdAtor),
    CONSTRAINT FK_FilmeFA FOREIGN KEY(IdFilme) REFERENCES Filme(IdFilme),
    CONSTRAINT FK_AtorFA FOREIGN KEY(IdAtor) REFERENCES Ator(IdAtor)
);

CREATE TABLE FilmeRoteirista(
	IdFilme INT,
    IdRoteirista INT,
    CONSTRAINT PKC_FilmeRoteirista PRIMARY KEY(IdFilme, IdRoteirista),
    CONSTRAINT FK_FilmeFR FOREIGN KEY(IdFilme) REFERENCES Filme(IdFilme),
    CONSTRAINT FK_RoteiristaFR FOREIGN KEY(IdRoteirista) REFERENCES Roteirista(IdRoteirista)
);

-- =================================================
-- TABELAS RELACIONADAS AO STREAMING E ASSINATES
-- =================================================