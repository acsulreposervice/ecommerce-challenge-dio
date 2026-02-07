-- DML
USE ecommerce_db_dio;

-- ==========================================================
-- 1. TABELAS INDEPENDENTES (ENTIDADES FORTES)
-- ==========================================================

-- Clientes (Alguns sem telefone ou data de nascimento)
INSERT INTO Clientes (p_nome, u_nome, cpf, sexo, email, telefone, data_nascimento) VALUES 
('João', 'Gomes', '111.222.333-44', 'M', 'joao@email.com', NULL, '1985-03-20'),
('Maria', 'Ferreira', '222.333.444-55', 'F', 'maria@email.com', '11988887777', NULL),
('Pedro', 'Alcantara', '333.444.555-66', 'M', 'pedro@email.com', NULL, NULL),
('Alice', 'Monteiro', '444.555.666-77', 'F', 'alice@email.com', '21977776666', '1998-01-25'),
('Bruno', 'Souza', '555.666.777-88', 'M', 'bruno@email.com', NULL, '1988-05-14'),
('Carla', 'Diniz', '666.777.888-99', 'F', 'carla@email.com', NULL, NULL),
('Diego', 'Lopes', '777.888.999-00', 'M', 'diego@email.com', '31966665555', '1990-12-12'),
('Elena', 'Nunes', '888.999.000-11', 'F', 'elena@email.com', NULL, NULL),
('Fabio', 'Melo', '999.000.111-22', 'M', 'fabio@email.com', NULL, '1975-02-28'),
('Gisele', 'Brito', '000.111.222-33', 'F', 'gisele@email.com', '19955554444', NULL);

-- Vendedores (Alguns sem telefone)
INSERT INTO Vendedores (p_nome, u_nome, email, telefone, sexo) VALUES 
('Carlos', 'Silva', 'carlos.vendas@gmail.com', NULL, 'M'),
('Ana', 'Oliveira', 'ana.mkt@outlook.com', '21922223333', 'F'),
('Marcos', 'Pereira', 'marcos.vendedor@uol.com.br', NULL, 'M'),
('Julia', 'Costa', 'julia.costa@vendas.com', '41944445555', 'F'),
('Roberto', 'Santos', 'roberto.s@freelance.com', NULL, 'O'),
('Carla', 'Mendes', 'carla.m@loja.com', NULL, 'F'),
('Fernando', 'Rocha', 'fernando.r@mkt.com', '71977778888', 'M'),
('Luciana', 'Lima', 'lu.lima@vendas.com', NULL, 'F'),
('Ricardo', 'Alves', 'ricardo.alves@gmail.com', NULL, 'M'),
('Beatriz', 'Souza', 'beatriz.s@lojaonline.com', '11900001111', 'F');

-- Fornecedores (Alguns sem telefone)
INSERT INTO Fornecedores (razao_social, cnpj, email, telefone) VALUES 
('Tech World Dist.', '11.222.333/0001-01', 'vendas@techworld.com', NULL),
('Livraria Horizonte', '22.333.444/0001-02', 'comercial@horizonte.com', '2133221100'),
('Móveis Design Ltda', '33.444.555/0001-03', 'contato@mdesign.com', NULL),
('Eletro Giga S.A.', '44.555.666/0001-04', 'sac@eletrogiga.com', '1140045500'),
('Sport Mix Brasil', '55.666.777/0001-05', 'faturamento@sportmix.com', NULL),
('Beauty Pro Co.', '66.777.888/0001-06', 'vendas@beautypro.com', NULL),
('Kids Play Toys', '77.888.999/0001-07', 'loja@kidsplay.com', '1932556677'),
('Fashion Store', '88.999.000/0001-08', 'contato@fashion.com', NULL),
('Auto Parts Exp.', '99.000.111/0001-09', 'pecas@autoparts.com', '4133440099'),
('Cozinha Master', '00.111.222/0001-10', 'vendas@cozinhamaster.com', NULL);

-- Categorias
INSERT INTO Categorias (descricao) VALUES 
('Eletrônicos'), ('Informática'), ('Cozinha'), ('Livros'), ('Móveis'), 
('Esporte'), ('Beleza'), ('Brinquedos'), ('Moda'), ('Automotivo');

-- Endereços (Alguns sem bairro, estado ou complemento)
INSERT INTO Enderecos (rua, numero, bairro, cidade, cep, estado, complemento) VALUES 
('Av. Paulista', '1500', 'Bela Vista', 'São Paulo', '01311200', 'SP', 'Ap 42'),
(NULL, '12', NULL, 'Curitiba', '80010010', 'PR', NULL),
('Rua Bahia', '450', 'Lourdes', 'Belo Horizonte', '30160011', 'MG', NULL),
('Av. Atlântica', '2000', NULL, 'Rio de Janeiro', '22021001', 'RJ', 'Bloco B'),
(NULL, '100', 'Centro', 'São Luís', '65010120', NULL, NULL),
('Av. Caxangá', '300', 'Cordeiro', 'Recife', '50711000', 'PE', NULL),
(NULL, '800', NULL, 'Cuiabá', '78032000', 'MT', NULL),
('Av. Independência', '10', 'Centro', 'Porto Alegre', '90035070', 'RS', NULL),
('Rua João de Barro', '55', 'Nova Cidade', 'Manaus', '69097000', NULL, 'Casa de Fundos'),
(NULL, '123', NULL, 'Goiânia', '74005010', 'GO', NULL);

-- Estoques
INSERT INTO Estoques (nome, cidade, estado) VALUES 
('CD Principal', 'Guarulhos', 'SP'), ('Filial Sul', 'Curitiba', 'PR'), 
('Filial Nordeste', 'Jaboatão', 'PE'), ('Depósito Express', 'São Paulo', 'SP'),
('Centro Logístico', 'Rio de Janeiro', 'RJ'), ('Filial Oeste', 'Cuiabá', 'MT'),
('CD Minas', 'Contagem', 'MG'), ('CD SC', 'Joinville', 'SC'),
('Filial Norte', 'Manaus', 'AM'), ('Depósito Rápido', 'Campinas', 'SP');

-- TipoPagamento
INSERT INTO TipoPagamento (tipo) VALUES ('pix'), ('credito'), ('debito'), ('boleto'), ('pix'), ('credito'), ('credito'), ('debito'), ('boleto'), ('pix');

-- ==========================================================
-- 2. TABELAS DEPENDENTES
-- ==========================================================

-- Produtos (Alguns sem nome, id_categoria ou fabricante)
INSERT INTO Produtos (id_categoria, nome, modelo, preco, fabricante, avaliacao) VALUES 
(1, 'Smartphone X', 'Model 2024', 2500.00, 'Samsung', 4.5),
(2, NULL, 'Slim 15-A', 4800.00, 'Dell', 4.8),
(3, 'Cafeteira Express', 'Bivolt-XP', 350.00, NULL, 4.2),
(NULL, 'Livro SQL Expert', 'ISBN-9982', 120.00, 'O Reilly', 5.0),
(5, 'Cadeira Gamer', 'RGB-77', 1200.00, NULL, 0),
(6, NULL, 'FUT-2024', 150.00, 'Adidas', 4.0),
(7, 'Kit Maquiagem', 'GLOW-10', 250.00, 'MAC', 4.9),
(NULL, 'LEGO Star Wars', 'LEGO-75192', 800.00, 'LEGO', 5.0),
(9, 'Camisa Polo', 'POLO-PIMA', 180.00, NULL, 4.4),
(10, NULL, 'OIL-5W30', 60.00, 'Mobil', 4.7);

-- ProdutosEstoques
INSERT INTO ProdutosEstoques (id_produto, id_estoque, quantidade, lote) VALUES 
(1, 1, 50, 'LOT01'), (2, 1, 20, 'LOT02'), (3, 2, 100, 'LOT03'), (4, 4, 200, 'LOT04'),
(5, 5, 15, 'LOT05'), (6, 2, 80, 'LOT06'), (7, 3, 40, 'LOT07'), (8, 7, 10, 'LOT08'),
(9, 8, 150, 'LOT09'), (10, 9, 300, 'LOT10');

-- FornecedorProduto
INSERT INTO FornecedorProduto (id_fornecedor, id_produto) VALUES 
(1, 1), (2, 4), (3, 5), (4, 2), (5, 6), (6, 7), (7, 8), (8, 9), (9, 10), (10, 3);

-- EnderecosFornecedores
INSERT INTO EnderecosFornecedores (id_fornecedor, id_endereco) VALUES 
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- EnderecosClientes
INSERT INTO EnderecosClientes (id_cliente, id_endereco) VALUES 
(1, 10), (2, 9), (3, 8), (4, 7), (5, 6), (6, 5), (7, 4), (8, 3), (9, 2), (10, 1);

-- Pedidos (Alguns sem id_tipo_pagamento simulando abandono ou erro no checkout)
INSERT INTO Pedidos (id_pedido, id_cliente, data_fim_pedido, status_pedido, frete, id_tipo_pagamento) VALUES 
(1, 1, '2024-01-10 10:00:00', 'concluido', 15.00, 1),
(2, 2, '2024-01-11 14:00:00', 'processando', 20.00, NULL),
(3, 3, '2024-01-12 16:30:00', 'aguardando', 10.00, 3),
(4, 4, '2024-01-13 09:15:00', 'cancelado', 0.00, 4),
(5, 5, '2024-01-14 11:00:00', 'concluido', 25.00, 5),
(6, 6, '2024-01-15 15:20:00', 'ativo', 12.00, NULL),
(7, 7, '2024-01-16 18:00:00', 'concluido', 0.00, 7),
(8, 8, '2024-01-17 12:00:00', 'processando', 18.00, 8),
(9, 9, '2024-01-18 10:45:00', 'concluido', 30.00, 9),
(10, 10, '2024-01-19 13:00:00', 'ativo', 15.00, 10);

-- ProdutosPedidos
INSERT INTO ProdutosPedidos (id_pedido, id_produto, id_vendedor, quantidade) VALUES 
(1, 1, 1, 1), (1, 4, 2, 1), (2, 2, 1, 1), (3, 3, 3, 2), (5, 5, 5, 1),
(6, 6, 6, 1), (7, 7, 7, 1), (8, 8, 8, 1), (9, 9, 9, 2), (10, 10, 10, 5);

USE ecommerce_db_dio;

-- ==========================================================
-- 1. TABELAS INDEPENDENTES (DADOS ADICIONAIS)
-- ==========================================================

-- 10 Clientes (Padrão: Alguns sem CPF formatado, e-mails corporativos e ausência de sexo)
INSERT INTO Clientes (p_nome, u_nome, cpf, sexo, email, telefone, data_nascimento) VALUES 
('Roberto', 'Junior', '22233344455', 'M', 'roberto.jr@empresa.com.br', '11922221111', '1970-10-10'),
('Empresa', 'Alpha', '11222333000199', 'O', 'compras@alpha.com', NULL, NULL),
('Sandra', 'Helena', '555.444.333-22', 'F', 'sandra.h@gmail.com', NULL, '1993-12-25'),
('Lucas', 'Moraes', '888.777.666-55', 'M', 'lucas.m@yahoo.com', '21988887777', NULL),
('Patrícia', 'Luz', '101.202.303-44', 'F', 'patty.luz@icloud.com', NULL, '1989-02-14'),
('Distribuidora', 'Sul', '99.888.777/0001-01', 'O', 'contato@distrisul.com', '5133445566', NULL),
('Marcos', 'Viana', '404.505.606-77', 'M', 'viana.marcos@uol.com.br', NULL, NULL),
('Tatiane', 'Oliveira', '303.404.505-88', 'F', 'tati.oli@outlook.com', '31977665544', '1995-06-20'),
('Fernando', 'Costa', '707.808.909-00', 'M', 'f.costa@gmail.com', NULL, NULL),
('Bruna', 'Marques', '909.808.707-11', 'F', 'bruna.m@empresa.com', '11966554433', '2000-01-01');

-- 10 Vendedores (Padrão: Novos vendedores sem muitos dados de contato)
INSERT INTO Vendedores (p_nome, u_nome, email, telefone, sexo) VALUES 
('Loja', 'Games', 'sac@lojagames.com', NULL, 'O'),
('Pedro', 'Vendedor', 'pedro.v@mkt.com', '11955443322', 'M'),
('Mariana', 'Eletro', 'mari.eletro@vendas.com', NULL, 'F'),
('Tech', 'Import', 'import@tech.com.br', '2133449988', 'O'),
('Vendas', 'Rápidas', 'contato@vendasrapidas.com', NULL, 'O'),
('André', 'Souza', 'andre.s@gmail.com', '41988776655', 'M'),
('Cláudia', 'Modas', 'claudia.moda@outlook.com', NULL, 'F'),
('Bazar', 'Central', 'bazar@central.com', '1933221100', 'O'),
('Felipe', 'Peças', 'felipe.parts@uol.com.br', NULL, 'M'),
('Sônia', 'Móveis', 'sonia.moveis@vendas.com', '11900112233', 'F');

-- 10 Fornecedores (Padrão: Razões sociais longas e ausência de telefone)
INSERT INTO Fornecedores (razao_social, cnpj, email, telefone) VALUES 
('Importadora de Componentes Eletrônicos LTDA', '10.200.300/0001-10', 'sac@importeletron.com', NULL),
('Fábrica de Móveis Rústicos do Brasil', '20.300.400/0001-20', 'vendas@rusticofabrica.com', '4733221144'),
('Editora de Livros Técnicos e Científicos', '30.400.500/0001-30', 'contato@editoratent.com', NULL),
('Atacado de Peças Automotivas S.A.', '40.500.600/0001-40', 'comercial@atacadoautoparts.com', '1140041010'),
('Confecções de Vestuário Estilo Nobre', '50.600.700/0001-50', 'faturamento@estilonobre.com', NULL),
('Suplementos Alimentares Força Total', '60.700.800/0001-60', 'vendas@forcavital.com', NULL),
('Brinquedos Educativos e Pedagógicos', '70.800.900/0001-70', 'loja@brinquedoseduc.com', '1932559988'),
('Perfumaria e Cosméticos Fragrância', '80.900.000/0001-80', 'contato@fragrancia.com', NULL),
('Artigos Esportivos de Alta Performance', '90.000.100/0001-90', 'pecas@esportehigh.com', '2122334455'),
('Utensílios Domésticos Premium', '00.100.200/0001-00', 'vendas@utilpremium.com', NULL);

-- 10 Endereços (Padrão: Muitos valores nulos para simular cadastro incompleto)
INSERT INTO Enderecos (rua, numero, bairro, cidade, cep, estado, complemento) VALUES 
('Rua das Américas', 'S/N', NULL, 'Santos', '11000000', 'SP', NULL),
(NULL, '500', 'Industrial', 'Joinville', '89200100', 'SC', 'Galpão 4'),
('Av. Central', '10', NULL, 'Brasília', '70000000', 'DF', NULL),
(NULL, '0', NULL, 'Vitória', '29000000', 'ES', NULL),
('Rua XV de Novembro', '123', 'Centro', 'Blumenau', '89010000', 'SC', NULL),
(NULL, '44', 'Bairro Novo', 'Olinda', '53000000', 'PE', NULL),
('Rodovia BR-101', 'KM 20', NULL, 'Palhoça', '88130000', 'SC', 'Lado B'),
(NULL, '99', NULL, 'Natal', '59000000', 'RN', NULL),
('Rua do Comércio', '1', 'Centro', 'Manaus', '69000000', 'AM', NULL),
(NULL, '15', NULL, 'Belém', '66000000', 'PA', NULL);

-- 10 Estoques (Novos pontos logísticos)
INSERT INTO Estoques (nome, cidade, estado) VALUES 
('CD Brasília', 'Brasília', 'DF'), ('Filial Espírito Santo', 'Serra', 'ES'), 
('Depósito Norte 2', 'Belém', 'PA'), ('CD Santa Catarina 2', 'Blumenau', 'SC'),
('Ponto de Retirada SP', 'São Paulo', 'SP'), ('Filial Interior RJ', 'Resende', 'RJ'),
('CD Goiás', 'Aparecida de Goiânia', 'GO'), ('Depósito Nordeste 2', 'Salvador', 'BA'),
('Filial Mato Grosso', 'Sinop', 'MT'), ('CD Londrina', 'Londrina', 'PR');

-- ==========================================================
-- 2. TABELAS DEPENDENTES (RELACIONAMENTOS)
-- ==========================================================

-- 10 Produtos (Padrão: Sem fabricante ou avaliação zerada)
INSERT INTO Produtos (id_categoria, nome, modelo, preco, fabricante, avaliacao) VALUES 
(1, 'Monitor 4K', 'MNT-4K-27', 1800.00, 'LG', 4.9),
(2, 'Teclado Mecânico', 'RGB-SW-B', 450.00, NULL, 0),
(3, 'Liquidificador', 'TURBO-900', 220.00, 'Arno', 3.8),
(4, 'O Hobbit', 'ISBN-0001', 55.00, 'HarperCollins', 5.0),
(5, 'Mesa de Escritório', 'WOOD-PRO', 890.00, NULL, 4.2),
(6, 'Tênis de Corrida', 'RUN-FAST-10', 320.00, 'Nike', 0),
(7, 'Perfume Masculino', 'NIGHT-BLUE', 210.00, NULL, 4.5),
(8, 'Boneco de Ação', 'HERO-01', 120.00, 'Hasbro', 4.7),
(9, 'Vestido de Festa', 'SILK-RED', 450.00, NULL, 0),
(10, 'Pneu Aro 15', '195/55R15', 380.00, 'Pirelli', 4.1);

-- 10 ProdutosEstoques
INSERT INTO ProdutosEstoques (id_produto, id_estoque, quantidade, lote) VALUES 
(11, 11, 25, 'B-101'), (12, 11, 40, 'B-102'), (13, 12, 60, 'E-201'), (14, 14, 150, 'S-301'),
(15, 15, 10, 'P-401'), (16, 12, 45, 'E-202'), (17, 13, 30, 'N-501'), (18, 17, 100, 'G-601'),
(19, 18, 20, 'BA-701'), (20, 20, 80, 'L-801');

-- 10 FornecedorProduto
INSERT INTO FornecedorProduto (id_fornecedor, id_produto) VALUES 
(11, 11), (14, 20), (12, 15), (13, 14), (15, 19), (16, 17), (17, 18), (18, 17), (19, 16), (20, 13);

-- 10 EnderecosFornecedores
INSERT INTO EnderecosFornecedores (id_fornecedor, id_endereco) VALUES 
(11, 11), (12, 15), (13, 13), (14, 11), (15, 15), (16, 16), (17, 17), (18, 18), (19, 17), (20, 19);

-- 10 EnderecosClientes
INSERT INTO EnderecosClientes (id_cliente, id_endereco) VALUES 
(11, 11), (12, 12), (13, 13), (14, 14), (15, 15), (16, 16), (17, 17), (18, 18), (19, 19), (20, 20);

-- 10 Pedidos (Padrão: Muitos cancelados e fretes altos)
INSERT INTO Pedidos (id_pedido, id_cliente, data_fim_pedido, status_pedido, frete, id_tipo_pagamento) VALUES 
(11, 11, '2024-02-01 10:00:00', 'concluido', 45.00, 1),
(12, 12, '2024-02-02 11:00:00', 'cancelado', 0.00, NULL),
(13, 13, '2024-02-03 12:00:00', 'aguardando', 15.00, 4),
(14, 14, '2024-02-04 09:00:00', 'concluido', 12.00, 2),
(15, 15, '2024-02-05 14:00:00', 'processando', 50.00, 3),
(16, 16, '2024-02-06 15:00:00', 'cancelado', 0.00, NULL),
(17, 17, '2024-02-07 16:00:00', 'concluido', 10.00, 1),
(18, 18, '2024-02-08 17:00:00', 'ativo', 25.00, 2),
(19, 19, '2024-02-09 18:00:00', 'concluido', 0.00, 1),
(20, 20, '2024-02-10 19:00:00', 'processando', 30.00, 4);

-- 10 Itens de Pedidos (Padrão: Quantidades industriais/atacado)
INSERT INTO ProdutosPedidos (id_pedido, id_produto, id_vendedor, quantidade) VALUES 
(11, 11, 11, 2), (12, 20, 19, 4), (13, 13, 13, 1), (14, 14, 12, 10), (15, 15, 20, 1),
(16, 16, 16, 2), (17, 17, 17, 1), (18, 18, 18, 3), (19, 19, 17, 1), (20, 12, 11, 12);