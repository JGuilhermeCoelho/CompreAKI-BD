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

CREATE TABLE funcionarios (
    matricula CHAR(9) PRIMARY KEY,
    cpf CHAR(11) NOT NULL,
    rg CHAR(7) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    endereco VARCHAR(200),
    salario NUMBER(9,2),
    funcao VARCHAR(40),
    id_filial CHAR(9),
    gerente VARCHAR(50),
    
    FOREIGN KEY (id_filial) REFERENCES filial(id_filial)
);


CREATE TABLE telefones_funcionarios (
    mat_funcionario CHAR(9),
    telefone CHAR(9),
    PRIMARY KEY (mat_funcionario, telefone)

);


CREATE TABLE fornecedores (
    cnpj_id CHAR(14) PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    endereco VARCHAR(200),
    email VARCHAR(40),
    site VARCHAR(30),
    id_categoria SERIAL()

);


CREATE TABLE telefones_fornecedores (
    cnpj_fornecedor CHAR(14),
    telefone CHAR(9)
    PRIMARY KEY (cnpj_fornecedor, telefone)

);

CREATE TABLE dependente (
    cpf CHAR(11) PRIMARY KEY,
    data_nasc DATE,
    mat_funcionario CHAR(9),
    nome VARCHAR(50) NOT NULL

);

-- end mariana tables

-- start mariana constraints

ALTER TABLE funcionarios ADD CONSTRAINT PK_matricula PRIMARY KEY (matricula);

ALTER TABLE telefones_funcionarios ADD CONSTRAINT PK_telefones_funcionarios PRIMARY KEY (mat_funcionario, telefone);

ALTER TABLE fornecedores ADD CONSTRAINT PK_cnpj_id PRIMARY KEY (cnpj_id);

ALTER TABLE telefones_fornecedores ADD CONSTRAINT PK_cnpj_fornecedor PRIMARY KEY (cnpj_fornecedor, telefone);

ALTER TABLE dependente ADD CONSTRAINT PK_cpf PRIMARY KEY (cpf);

ALTER TABLE fornecedores ADD CONSTRAINT FK_ig_categoria FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria);

ALTER TABLE telefones_fornecedores ADD CONSTRAINT FK_cnpj_fornecedor FOREIGN KEY (cnpj_fornecedor) REFERENCES fornecedores(cnpj);

ALTER TABLE dependente ADD CONSTRAINT FK_matricula FOREIGN KEY (matricula) REFERENCES funcionarios(matricula);

ALTER TABLE funcionarios ADD CONSTRAINT FK_id_filial FOREIGN KEY (id_filial) REFERENCES filiais(id_filial);

-- end mariana constraints
