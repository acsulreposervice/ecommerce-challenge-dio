DROP DATABASE IF EXISTS ecommerce_db_dio;
CREATE DATABASE ecommerce_db_dio;
USE ecommerce_db_dio;

-- TABELAS INDEPENDENTES
CREATE TABLE Clientes (
	id_cliente			INTEGER					AUTO_INCREMENT		,
    p_nome				VARCHAR(45) 			NOT NULL			,
    u_nome				VARCHAR(45) 			NOT NULL			,
    cpf					VARCHAR(20)	 			NOT NULL			,
    sexo				ENUM('F', 'M', 'O')		DEFAULT 'O'			,
    telefone			VARCHAR(20)									,
    email				VARCHAR(100)			NOT NULL			,
    data_nascimento		DATE,
	
    CONSTRAINT pk_cliente 
		PRIMARY KEY (id_cliente)									,
    CONSTRAINT chk_email_cliente 
		CHECK (email LIKE '%@%')									,
    CONSTRAINT uq_clientes_cpf 
		UNIQUE (cpf)
);

CREATE TABLE Vendedores (
	id_vendedor		INTEGER					AUTO_INCREMENT		, -- PK
    p_nome			VARCHAR(45)				NOT NULL			,
    u_nome			VARCHAR(45)				NOT NULL			,
    telefone		CHAR(11)									, -- UQ
    email			VARCHAR(100)			NOT NULL			, -- UQ
    sexo			ENUM('F', 'M', 'O')		DEFAULT 'O'			,
    
    CONSTRAINT	pk_vendedores
		PRIMARY KEY (id_vendedor)								,
	CONSTRAINT uq_vendedores
		UNIQUE (telefone, email)
);

CREATE TABLE Fornecedores (
	id_fornecedor		INTEGER			AUTO_INCREMENT			,	
    razao_social		VARCHAR(45)		NOT NULL				,
    cnpj				CHAR(18)		NOT NULL 				,
    email				VARCHAR(100)	NOT NULL				,
    telefone			VARCHAR(20)								,
    
    CONSTRAINT pk_fornecedores 
		PRIMARY KEY (id_fornecedor)								,
    CONSTRAINT chk_email_fornecedor 
		CHECK (email LIKE '%@%')								,
    CONSTRAINT uq_fornecedores_cnpj 
		UNIQUE (cnpj)
);

CREATE TABLE Categorias (
	id_categoria		INTEGER		AUTO_INCREMENT		,
    descricao			TINYTEXT	NOT NULL			,
    
    CONSTRAINT pk_categorias 
		PRIMARY KEY (id_categoria)
);

CREATE TABLE Enderecos (
	id_endereco		INTEGER			AUTO_INCREMENT		, -- PK
    rua				VARCHAR(45)							,
    numero			VARCHAR(10)		NOT NULL			,
    bairro			VARCHAR(45)							,
    cidade			VARCHAR(45)		NOT NULL			,
    cep				CHAR(8)		NOT NULL			    , -- UQ
    estado			CHAR(2)		                    	,
    complemento		TINYTEXT							,
    
    CONSTRAINT pk_enderecos
		PRIMARY KEY (id_endereco),
	CONSTRAINT uq_enderecos_cep
		UNIQUE (cep)
);

CREATE TABLE Estoques (
	id_estoque		INTEGER			AUTO_INCREMENT		,
    nome        	VARCHAR(45)		NOT NULL			,
    cidade        	VARCHAR(45)		NOT NULL			,
    estado        	CHAR(2)		    NOT NULL            ,
    
    CONSTRAINT pk_estoque
		PRIMARY KEY (id_estoque)
);

CREATE TABLE TipoPagamento (
	id_tipo_pagamento	INTEGER			    AUTO_INCREMENT				,
    tipo			    ENUM("boleto","credito","debito","pix")	    	,
    
    CONSTRAINT pk_tipopagamento
		PRIMARY KEY (id_tipo_pagamento)
);

-- TABELAS DEPENDENTES

CREATE TABLE Produtos (
	id_produto		INTEGER 		AUTO_INCREMENT		,
	id_categoria	INTEGER								,
    nome			VARCHAR(45)							,
    modelo			VARCHAR(45)		NOT NULL			,
    preco           FLOAT           NOT NULL            ,
    fabricante		VARCHAR(20)							,
    avaliacao		FLOAT			DEFAULT 0			,
    
    CONSTRAINT pk_produtos 
		PRIMARY KEY (id_produto)						,
    CONSTRAINT fk_categoria 
		FOREIGN KEY (id_categoria) 
		REFERENCES Categorias (id_categoria)			,
    CONSTRAINT chk_avaliacao 
		CHECK (avaliacao <= 5.0)						,
    CONSTRAINT uq_produtos_modelo 
		UNIQUE (modelo)
);

CREATE TABLE ProdutosEstoques (
	id_produto				INTEGER							                , -- PK FK
    id_estoque				INTEGER						                	, -- PK FK
    quantidade				INTEGER			NOT NULL	                	,
    data_armazenamento		DATETIME		DEFAULT CURRENT_TIMESTAMP()	    ,
    lote					VARCHAR(10)		NOT NULL	                	,
    
    CONSTRAINT pk_produtosestoques
		PRIMARY KEY (id_produto, id_estoque)					            ,
	CONSTRAINT fk_produtosestoques_produto
		FOREIGN KEY (id_produto)
        REFERENCES Produtos(id_produto)						                ,
	CONSTRAINT fk_produtosestoques_estoque
		FOREIGN KEY (id_estoque)
        REFERENCES Estoques(id_estoque)					                	,
	CONSTRAINT chk_produtosestoques_quantidade	-- EVITA VALORES NEGATIVOS
		CHECK (quantidade >= 0)
);

CREATE TABLE FornecedorProduto (
	id_fornecedor		INTEGER						,
    id_produto			INTEGER						,
    
    CONSTRAINT pk_fornecedorproduto
		PRIMARY KEY (id_fornecedor, id_produto)		,
	CONSTRAINT fk_fornecedorproduto_fornecedor
		FOREIGN KEY (id_fornecedor)
		REFERENCES Fornecedores(id_fornecedor)		,
	CONSTRAINT fk_fornecedorproduto_produto
		FOREIGN KEY (id_produto)
        REFERENCES Produtos(id_produto)
);

CREATE TABLE EnderecosFornecedores (
	id_fornecedor		INTEGER							,
    id_endereco			INTEGER							,
    
    CONSTRAINT pk_enderecosfornecedores
		PRIMARY KEY (id_fornecedor, id_endereco)		,
	CONSTRAINT fk_enderecosfornecedores_fornecedor
		FOREIGN KEY (id_fornecedor)
        REFERENCES Fornecedores(id_fornecedor)			,
	CONSTRAINT fk_enderecosfornecedores_endereco
		FOREIGN KEY (id_endereco)
        REFERENCES Enderecos(id_endereco)
);

CREATE TABLE EnderecosClientes (
	id_cliente		INTEGER						,
    id_endereco		INTEGER						,
    
    CONSTRAINT pk_enderecosclientes
		PRIMARY KEY (id_cliente, id_endereco)	,
	CONSTRAINT fk_enderecosclientes_cliente
		FOREIGN KEY (id_cliente)
        REFERENCES Clientes(id_cliente)			,
	CONSTRAINT fk_enderecosclientes_endereco
		FOREIGN KEY (id_endereco)
        REFERENCES Enderecos(id_endereco)
);

CREATE TABLE Pedidos (
	id_pedido				INTEGER																AUTO_INCREMENT				    ,
    id_cliente				INTEGER																							    ,
    data_inicio_pedido		DATETIME															DEFAULT CURRENT_TIMESTAMP()		,
    data_fim_pedido			DATETIME															NOT NULL				    	,
    status_pedido			ENUM("aguardando","processando","ativo","concluido","cancelado")	DEFAULT "aguardando"	    	, 
    frete					FLOAT																NOT NULL				    	,
    id_tipo_pagamento		INTEGER																						    	,
    
    CONSTRAINT pk_pedidos
		PRIMARY KEY (id_pedido, id_cliente)																				    	,
	CONSTRAINT fk_pedidos_cliente
		FOREIGN KEY (id_cliente)
        REFERENCES Clientes(id_cliente)																					    	,
	CONSTRAINT fk_pedidos_tipopagamento 
		FOREIGN KEY (id_tipo_pagamento)
        REFERENCES TipoPagamento(id_tipo_pagamento)
);

CREATE TABLE ProdutosPedidos (
	id_pedido			INTEGER								,
    id_produto			INTEGER								,
    id_vendedor			INTEGER								,
    quantidade			INTEGER								,
    
    CONSTRAINT pk_produtospedidos
		PRIMARY KEY	(id_pedido, id_produto, id_vendedor)	,
	CONSTRAINT fk_produtospedidos_pedido
		FOREIGN KEY (id_pedido)
        REFERENCES Pedidos(id_pedido)						,
	CONSTRAINT fk_produtospedidos_produto
		FOREIGN KEY (id_produto)
        REFERENCES Produtos(id_produto)						,
	CONSTRAINT fk_produtospedidos_vendedor
		FOREIGN KEY (id_vendedor)
        REFERENCES Vendedores(id_vendedor)					,
	CONSTRAINT chk_quantidade
		CHECK (quantidade > 0)
);

