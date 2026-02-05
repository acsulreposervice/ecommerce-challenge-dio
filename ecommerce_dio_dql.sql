-- 1: CLIENTES NASCIDOS ENTRE 1900 E 2000
SELECT
	CONCAT(p_nome,' ', u_nome) AS nome_completo,
    cpf
FROM
	clientes
WHERE
	YEAR(data_nascimento) BETWEEN 1990 AND 2000;
    
-- 2: NÚMERO DE CLIENTES POR ESTADO (MAIOR PARA A MENOR QUANTIDADE):
SELECT
	COUNT(ec.id_cliente) AS n_clientes,
    ed.estado
FROM
	enderecosclientes ec
INNER JOIN
	enderecos ed USING (id_endereco)
GROUP BY
	ed.estado
ORDER BY
	n_clientes DESC;
	
-- 3: TIPOS DE PAGAMENTO MAIS USADO (PARA FUTURAS PROMOÇÕES):
SELECT
	COUNT(*) AS recorrencias,
    tpg.tipo AS tipo_pagamento
FROM
	pedidos AS pdd
INNER JOIN
	tipopagamento AS tpg USING (id_tipo_pagamento) -- PODERIA USAR O WHERE PARA JUNÇÃO, PORÉM SERIA MAIS VERBOSO
GROUP BY 
	tipo_pagamento;
    
-- 4: PRODUTOS EM ESTOQUE (CONTROLE)
SELECT
	prod.nome,
    prod.modelo,
    prest.quantidade,
    CASE
		WHEN prest.quantidade >= 80 THEN "excesso"
        WHEN prest.quantidade >= 30 THEN "normal"
        WHEN prest.quantidade <  30 THEN "critico"
	END AS status_estoque
FROM
	produtos AS prod
INNER JOIN
	produtosestoques AS prest USING (id_produto)
ORDER BY
	prest.quantidade DESC;
    
-- 5: RANKING DE CLIENTES COM OS MAIORES QUANTIDADES DE PRODUTOS PEDIDOS
SELECT
	CONCAT(cli.p_nome, ' ', cli.u_nome) AS nome,
    SUM(ppd.quantidade) AS total_pedido
FROM
	clientes AS cli
INNER JOIN
	pedidos AS pdd USING (id_cliente)
INNER JOIN
	produtospedidos AS ppd USING (id_pedido)
GROUP BY
	id_cliente
ORDER BY
	total_pedido DESC;

-- VARIANTE COM SUBQUERY: RANKING DE CLIENTES COM QUANTIDADE DE PRODUTOS PEDIDOS
-- ACIMA DA METADE DO CLIENTE COM O MAIOR NÚMERO DE PRODUTOS PEDIDOS (FIDELIZAÇÃO EM POTENCIAL)

SELECT
	CONCAT(cli.p_nome, ' ', cli.u_nome) AS nome,
    SUM(ppd.quantidade) AS total_pedido
FROM
	clientes AS cli
INNER JOIN
	pedidos AS pdd USING (id_cliente)
INNER JOIN
	produtospedidos AS ppd USING (id_pedido)
GROUP BY
	id_cliente
HAVING
	SUM(ppd.quantidade) > (SELECT
								MAX(quantidade)
							FROM
								produtospedidos)/2
ORDER BY
	total_pedido DESC;
    
-- 6: RELAÇÃO COM TODOS OS NOMES REGISTRADOS
SELECT
	c.p_nome,
    c.u_nome
FROM
	clientes AS c
UNION ALL
	SELECT
	v.p_nome,
    v.u_nome
FROM
	vendedores AS v;
    
-- 7: NÚMERO DE ESTOQUES MAIS PRÓXIMO DE CADA CLIENTE
    
SELECT
	c.id_cliente,
    c.p_nome, c.u_nome,
    COUNT(e.nome) AS estoques_proximos
FROM
	estoques AS e,
    clientes AS c
INNER JOIN
	enderecosclientes AS ec USING (id_cliente)
INNER JOIN
	enderecos AS endr USING (id_endereco)
WHERE
	endr.estado IN (e.estado)
GROUP BY
	c.id_cliente
ORDER BY
	c.p_nome;

-- 8: MAIOR RECORRÊNCIA DE UM PRODUTO EM UM PEDIDO
SELECT
	prod.nome,
    prod.modelo,
    SUM(prodp.quantidade) AS recorrencia_produto
FROM
	produtos AS prod
INNER JOIN
	produtospedidos AS prodp USING (id_produto)
GROUP BY
	prod.modelo
ORDER BY
	recorrencia_produto DESC;

-- 9: PRODUTOS E SEUS FORNECEDORES

SELECT
	prod.nome,
    prod.modelo,
    forn.razao_social
FROM
	produtos AS prod
INNER JOIN
	fornecedorproduto AS fp USING (id_produto)
INNER JOIN
	fornecedores AS forn USING (id_fornecedor);