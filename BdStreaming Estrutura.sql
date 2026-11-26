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
    Investimento DECIMAL(14, 2) CHECK(Investimento > 0.00),
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
CREATE TABLE MetodoPagamento(
	IdMetodoPagamento INT AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    CONSTRAINT PK_MetodoPagamento PRIMARY KEY(IdMetodoPagamento)
);

CREATE TABLE Assinatura(
	IdAssinatura INT AUTO_INCREMENT,
    DataAssinatura DATE,
    IdPlano INT,
    CONSTRAINT PK_Assinatura PRIMARY KEY(IdAssinatura)
);

CREATE TABLE Plano(
	IdPlano INT AUTO_INCREMENT,
    Nome VARCHAR(50),
    Preco DECIMAL(5, 2) NOT NULL CHECK(Preco > 0.00),
    Descricao TEXT NOT NULL,
    CONSTRAINT PK_Plano PRIMARY KEY(IdPlano)
);

CREATE TABLE Perfil(
	IdPerfil INT AUTO_INCREMENT,
    NomePerfil VARCHAR(150),
    -- FotoPerfil LONGBLOB NOT NULL,
    IdAssinatura INT,
    CONSTRAINT PK_Perfil PRIMARY KEY(IdPerfil),
    CONSTRAINT FK_AssinaturaP FOREIGN KEY(IdAssinatura) REFERENCES Assinatura(IdAssinatura)
);

CREATE TABLE Assinante(
	IdAssinante INT AUTO_INCREMENT,
    NomeUtilizador VARCHAR(150) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE CHECK(Email LIKE "%@%"),
    IdAssinatura INT,
    IdMetodoPagamento INT,
	CONSTRAINT PK_Assinate PRIMARY KEY(IdAssinante),
    CONSTRAINT FK_Assinatura FOREIGN KEY(IdAssinatura) REFERENCES Assinatura(IdAssinatura),
    CONSTRAINT FK_MetodoPagamento FOREIGN KEY(IdMetodoPagamento) REFERENCES MetodoPagamento(IdMetodoPagamento)
);

CREATE TABLE Favorito(
	IdFilme INT,
    IdPerfil INT,
    CONSTRAINT PKC_Favorito PRIMARY KEY(IdFilme, IdPerfil),
    CONSTRAINT FK_FilmeF FOREIGN KEY(IdFilme) REFERENCES Filme(IdFilme),
    CONSTRAINT FK_PerfilF FOREIGN KEY(IdPerfil) REFERENCES Perfil(IdPerfil)
);

CREATE TABLE Resenha(
	IdResenha INT AUTO_INCREMENT,
    Avaliacao DECIMAL(3, 2) NOT NULL CHECK(Avaliacao BETWEEN 1.00 AND 5.00),
    Comentario TEXT,
    IdFilme INT,
    IdPerfil INT,
	CONSTRAINT PK_Resenha PRIMARY KEY(IdResenha),
    CONSTRAINT FK_FilmeR FOREIGN KEY(IdFilme) REFERENCES Filme(IdFilme),
    CONSTRAINT FK_PerfilR FOREIGN KEY(IdPerfil) REFERENCES Perfil(IdPerfil)
);