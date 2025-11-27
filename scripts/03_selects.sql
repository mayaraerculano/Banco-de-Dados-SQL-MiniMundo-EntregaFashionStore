-----------------------------------------
-- PASSO 3: CRIAÇÃO DE VIEWS E FUNÇÕES (OBJETOS AVANÇADOS)
-----------------------------------------

CREATE OR REPLACE VIEW v_relatorio_pedidos_resumo AS
SELECT
    p.id_pedido,
    c.nome AS nome_cliente,
    p.data_pedido,
    p.total AS valor_total_pedido
FROM 
    pedidos p
JOIN 
    clientes c ON p.id_cliente = c.id_cliente
WHERE 
    p.data_pedido >= CURRENT_DATE - INTERVAL '30 days'
ORDER BY 
    p.data_pedido DESC;

CREATE OR REPLACE FUNCTION calcular_total_pedido(p_id_pedido INT)
RETURNS NUMERIC(10,2) AS $$
DECLARE
    total_calculado NUMERIC(10,2);
BEGIN
    SELECT 
        SUM(ip.quantidade * ip.preco_unit) INTO total_calculado
    FROM 
        itens_pedido ip
    WHERE 
        ip.id_pedido = p_id_pedido;
    RETURN COALESCE(total_calculado, 0.00);
END;
$$ LANGUAGE plpgsql;