-- star siuanny sequences
CREATE SEQUENCE Produtos_seq START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Categorias_seq START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Marcas_seq START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Solicitacao_seq START WITH 1 INCREMENT BY 1 NOCYCLE;
-- end siuanny sequences

-- star siuanny tables
CREATE TABLE Produtos (
    id_produto INTEGER DEFAULT Produtos_seq.NEXTVAL,
    nome VARCHAR(50),
    descricao VARCHAR(500),
    margem_lucro DECIMAL(10,2),
    id_categoria INTEGER,
    id_marca INTEGER
);

CREATE TABLE Categorias (
    id_categoria INTEGER DEFAULT Categorias_seq.NEXTVAL,
    nome VARCHAR(50)
);

CREATE TABLE Marcas (
    id_marca INTEGER DEFAULT Marcas_seq.NEXTVAL,
    nome VARCHAR(50)
);

CREATE TABLE Solicitacao (
    id_solicitacao INTEGER  DEFAULT Solicitacao_seq.NEXTVAL,
    data_solicitacao DATE,
    data_prevista DATE,
    data_entrega DATE,
    valor_compra DECIMAL(10,2),
    prazo_pagamento DATE,
    id_filial INTEGER,
    cnpj_fonecedor CHAR(14)
);
-- end siuanny tables

-- start siuanny constraints
ALTER TABLE Produtos ADD CONSTRAINT PK_Produtos PRIMARY KEY (id_produto);
ALTER TABLE Produtos ADD CONSTRAINT FK_Produtos_Categorias FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categorias);
ALTER TABLE Produtos ADD CONSTRAINT FK_Produtos_Marcas FOREIGN KEY (id_marca) REFERENCES Marcas(id_marca);
ALTER TABLE Produtos ADD CONSTRAINT Ck_Produtos_lucro_maior_que_zero CHECK (margem_lucro > 0); 

ALTER TABLE Categorias ADD CONSTRAINT PK_Categorias PRIMARY KEY (id_categoria);

ALTER TABLE Marcas ADD CONSTRAINT PK_Marcas PRIMARY KEY (id_marca);

ALTER TABLE Solicitacao ADD CONSTRAINT PK_Solicitacao PRIMARY KEY (id_solicitacao);
ALTER TABLE Solicitacao ADD CONSTRAINT FK_Solicitacao_Filiais FOREIGN KEY (id_filial) REFERENCES Filiais(id_filial);
ALTER TABLE Solicitacao ADD CONSTRAINT FK_Solicitacao_Fornecedores FOREIGN KEY (cnpj_fornecedor) REFERENCES Fornecedores(cnpj);
-- end siuanny constraints