-- start siuanny sequences
CREATE SEQUENCE Produtos_seq START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Categorias_seq START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Marcas_seq START WITH 1 INCREMENT BY 1 NOCYCLE;
CREATE SEQUENCE Solicitacao_seq START WITH 1 INCREMENT BY 1 NOCYCLE;
-- end siuanny sequences

-- start siuanny tables
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

-- starts Guilherme sequences
CREATE SEQUENCE Equipamentos_seq START WITH 1 INCREMENT BY 1 NOCYCLE;
-- ends Guilherme sequences 

-- starts Guilherme tables
CREATE TABLE filiais (
    id_filial CHAR(9),
    nome VARCHAR(50),
    endereco VARCHAR(200),
    telefone VARCHAR(13),
    id_gerente CHAR(9)
);

CREATE TABLE nota_fiscal (
    numero_nota_fiscal CHAR(9) UNIQUE,
    cnpj CHAR(14),
    quantidade INTEGER,
    data DATE,
    valor_item DECIMAL(10, 2),
    id_solicitacao INTEGER
);

CREATE TABLE equipamentos (
    id_equipamento INTEGER DEFAULT Equipamentos_seq.NEXTVAL,
    descricao VARCHAR(500),
    num_caixa INTEGER,
);

CREATE TABLE reclamacao (
    cpf_cliente CHAR(11),
    id_filial_reclamacao CHAR(9),
    data_hora TIMESTAMP,
    descricao VARCHAR(500),
);

CREATE TABLE manutencao (
    id_equipamento INTEGER,
    mat_funcionario CHAR(9),
    data_hora TIMESTAMP,
    custo DECIMAL(10, 2)
);
-- ends Guilherme tables

-- start Guilherme constraints
ALTER TABLE filiais ADD CONSTRAINT PK_filiais  PRIMARY KEY (id_filial);
ALTER TABLE filiais ADD CONSTRAINT FK_filiais_gerente FOREIGN KEY (id_gerente) REFERENCES Funcionarios(mat_funcionario);

ALTER TABLE nota_fiscal ADD CONSTRAINT PK_nota_fiscal PRIMARY KEY (numero_nota_fiscal); 
ALTER TABLE nota_fiscal ADD CONSTRAINT FK_nota_fical_solicitacao FOREIGN KEY (id_solicitacao) REFERENCES Solicitacao(id_solicitacao);

ALTER TABLE equipamentos ADD CONSTRAINT PK_equimamentos PRIMARY KEY (id_equipamento);
ALTER TABLE equipamentos ADD CONSTRAINT FK_equipamentos_num_caixa FOREIGN KEY (num_caixa) REFERENCES caixas(num_caixa);

ALTER TABLE reclamacao ADD CONSTRAINT PK_reclamacao PRIMARY KEY (cpf, id_filial_reclamacao);
ALTER TABLE reclamacao ADD CONSTRAINT FK_reclamacao_cliente FOREIGN KEY (cpf_cliente) REFERENCES Clientes(cpf_cliente);
ALTER TABLE reclamacao ADD CONSTRAINT FK_reclamacao_filial FOREIGN KEY (id_filial_reclamacao) REFERENCES filiais(id_filial); 

ALTER TABLE manutencao ADD CONSTRAINT PK_manutencao PRIMARY KEY (id_equipamento, mat_funcionario);
ALTER TABLE manutencao ADD CONSTRAINT FK_manutencao_equipamento FOREIGN KEY (id_equipamento) REFERENCES equipamentos(id_equipamento);
ALTER TABLE manutencao ADD CONSTRAINT FK_manutencao_funcionario FOREIGN KEY (mat_funcionario) REFERENCES Funcionarios(mat_funcionario);
-- ends Guilherme constraints