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

--start beatriz sequences
CREATE SEQUENCE caixas_seq 
    START WITH 1 INCREMENT BY 1 NOCYCLE;


--end beatriz sequences

--start beatriz tables
CREATE TABLE clientes(
    cpf CHAR(11),
    nome VARCHAR(50)NOT NULL,
    email VARCHAR(40),
    pontos INTEGER
)

CREATE TABLE telefonesClientes(
    cpf_cliente CHAR(11),
    telefone CHAR(9)
)

CREATE TABLE enderecos(
    cpf_cliente CHAR(11),
    rua VARCHAR(100) NOT NULL,
    numero VARCHAR(4),
    bairro VARCHAR(30) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(50) NOT NULL
)

CREATE TABLE ordemCompras(
    nota_fiscal CHAR(44),
    data_compra DATE, 
    id_caixa INTEGER,
    cpf_cliente CHAR(9)
)

CREATE TABLE caixas(
    num_caixas INTEGER DEFAULT caixas_seq.NEXTVAL,
    num_filial CHAR(9) NOT NULL
)
--end beatriz tables

--start beatriz constraints
ALTER TABLE clientes ADD CONSTRAINT PK_cliente 
    PRIMARY KEY (cpf);

ALTER TABLE telefonesClientes ADD CONSTRAINT PK_telefonesClientes
    PRIMARY KEY (cpf_cliente, telefone);

ALTER TABLE enderecos ADD CONSTRAINT PK_enderecos
    PRIMARY KEY (cpf_cliente);

ALTER TABLE ordemCompras ADD CONSTRAINT PK_ordemCompras 
    PRIMARY KEY (nota_fiscal);




ALTER TABLE telefonesClientes ADD CONSTRAINT TelefonesClientesREFcpfCliente 
    FOREIGN KEY(cpf_cliente) REFERENCES clientes(cpf)
INITIALLY DEFERRED DEFERRABLE

ALTER TABLE enderecos ADD CONSTRAINT cpfClienteREFcpfCliente
   	 FOREIGN KEY(cpf_cliente) REFERENCES clientes(cpf)
INITIALLY DEFERRED DEFERRABLE

ALTER TABLE ordemCompras ADD CONSTRAINT caixaRefIdCaixa
    FOREIGN KEY(id_caixa) REFERENCES caixas(num_caixas)
  INITIALLY DEFERRED DEFERRABLE
--end Beatriz constraints

-- start mariana tables 

CREATE TABLE FUNCIONARIO (
    MATRICULA CHAR(9),
    CPF CHAR(11) NOT NULL,
    IDENTIDADE CHAR(7) NOT NULL,
    NOME VARCHAR(50) NOT NULL,
    ENDERECO VARCHAR(200),
    SALARIO NUMBER(9,2),
    FUNCAO VARCHAR(40),
    CODIGO_DE_IDENTIFICACAO CHAR(9),
    GERENTE VARCHAR(50)
    
);


CREATE TABLE TELEFONES_FUNCIONARIOS (
    MATRICULA CHAR(9),
    TELEFONE CHAR(9)

);


CREATE TABLE FORNECEDOR (
    CNPJ CHAR(14),
    NOME VARCHAR(50) NOT NULL,
    ENDERECO VARCHAR(200),
    EMAIL VARCHAR(40),
    SITE VARCHAR(30),
    IDENTIFICADOR INTEGER

);


CREATE TABLE TELEFONES_FORNECEDORES (
    CNPJ CHAR(14),
    TELEFONE CHAR(9)

);

CREATE TABLE DEPENDENTE (
    CPF CHAR(11),
    DATA_DE_NASCIMENTO DATE,
    MATRICULA CHAR(9),
    NOME VARCHAR(50) NOT NULL

);

-- end mariana tables

-- start mariana constraints



ALTER TABLE FUNCIONARIO ADD CONSTRAINT PK_MATRICULA PRIMARY KEY (MATRICULA);

ALTER TABLE TELEFONES_FUNCIONARIOS ADD CONSTRAINT PK_TELEFONES_FUNCIONARIOS PRIMARY KEY (MATRICULA, TELEFONE);

ALTER TABLE FORNECEDOR ADD CONSTRAINT PK_CNPJ PRIMARY KEY (CNPJ);

ALTER TABLE TELEFONES_FORNECEDORES ADD CONSTRAINT PK_TELEFONES_FORNECEDORES PRIMARY KEY (CNPJ, TELEFONE);

ALTER TABLE DEPENDENTE ADD CONSTRAINT PK_CPF PRIMARY KEY (CPF);

ALTER TABLE FORNECEDOR ADD CONSTRAINT FK_IDENTIFICADOR FOREIGN KEY (IDENTIFICADOR) REFERENCES CATEGORIA(IDENTIFICADOR);

ALTER TABLE TELEFONES_FORNECEDORES ADD CONSTRAINT FK_CNPJ FOREIGN KEY (CNPJ) REFERENCES FORNECEDOR(CNPJ);

ALTER TABLE DEPENDENTE ADD CONSTRAINT FK_MATRICULA FOREIGN KEY (MATRICULA) REFERENCES FUNCIONARIO(MATRICULA);

ALTER TABLE FUNCIONARIO ADD CONSTRAINT FK_CODIGO_DE_IDENTIFICACAO FOREIGN KEY (CODIGO_DE_IDENTIFICACAO) REFERENCES FILIAL(CODIGO_DE_IDENTIFICACAO);


-- end mariana constraints