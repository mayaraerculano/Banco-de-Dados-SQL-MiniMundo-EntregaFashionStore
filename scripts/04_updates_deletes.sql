-----------------------------------------
-- PASSO 4: CONSULTAS DE DEMONSTRAÇÃO (SELECTS)
-----------------------------------------

SELECT '-- A. Clientes Ordenados' AS Consulta;
SELECT * FROM clientes ORDER BY nome;

SELECT '-- B. Produtos Caros' AS Consulta;
SELECT nome, preco FROM produtos WHERE preco > 100;

SELECT '-- C. Detalhes do Pedido 1 (JOIN Duplo)' AS Consulta;
SELECT i.id_item, pr.nome, i.quantidade, i.preco_unit
FROM itens_pedido i
JOIN produtos pr ON pr.id_produto = i.id_produto
WHERE id_pedido = 1;

SELECT '-- D. Clientes Recorrentes (AGREGAÇÃO e HAVING)' AS Consulta;
SELECT
    c.nome AS nome_cliente,
    COUNT(p.id_pedido) AS numero_de_pedidos
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.nome
HAVING COUNT(p.id_pedido) > 1
ORDER BY numero_de_pedidos DESC;

SELECT '-- E. Teste da VIEW' AS Consulta;
SELECT * FROM v_relatorio_pedidos_resumo;

SELECT '-- F. Teste da FUNÇÃO' AS Consulta;
SELECT calcular_total_pedido(3) AS total_calculado_pedido_3;
