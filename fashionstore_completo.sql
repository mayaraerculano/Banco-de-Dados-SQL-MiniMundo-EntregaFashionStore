-----------------------------------------
-- PASSO 1: LIMPEZA TOTAL E CRIAÇÃO DAS TABELAS (ESTRUTURA)
-----------------------------------------

-- 1. Garante que VIEWS e FUNÇÕES sejam removidas primeiro
DROP VIEW IF EXISTS v_relatorio_pedidos_resumo;
DROP FUNCTION IF EXISTS calcular_total_pedido(INT);

-- 2. Exclui tabelas usando CASCADE para remover Foreign Keys e outros objetos
DROP TABLE IF EXISTS itens_pedido CASCADE;
DROP TABLE IF EXISTS pedidos CASCADE;
DROP TABLE IF EXISTS produtos CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;

-- CRIAÇÃO DAS TABELAS
CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telefone VARCHAR(20)
);

CREATE TABLE produtos (
    id_produto SERIAL PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    categoria VARCHAR(50),
    preco NUMERIC(10,2) NOT NULL,
    estoque INT NOT NULL
);

CREATE TABLE pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES clientes(id_cliente),
    data_pedido DATE NOT NULL DEFAULT CURRENT_DATE,
    total NUMERIC(10,2) 
);

CREATE TABLE itens_pedido (
    id_item SERIAL PRIMARY KEY,
    id_pedido INT REFERENCES pedidos(id_pedido),
    id_produto INT REFERENCES produtos(id_produto),
    quantidade INT NOT NULL,
    preco_unit NUMERIC(10,2) NOT NULL
);
ALTER TABLE itens_pedido ADD CONSTRAINT unique_item_produto UNIQUE (id_pedido, id_produto);


-----------------------------------------
-- PASSO 2: INSERÇÃO DE DADOS INICIAIS
-----------------------------------------

INSERT INTO clientes (nome, email, telefone) VALUES
('Ana Souza', 'ana@gmail.com', '11988880000'),
('Marcos Silva', 'marcos@hotmail.com', '11999997777'),
('Julia Reis', 'julia@gmail.com', '11977776666'),
('Pedro Lima', 'pedro@email.com', '21966665555');

INSERT INTO produtos (nome, categoria, preco, estoque) VALUES
('Calça Jeans', 'Roupas', 129.90, 50),
('Camiseta Oversized', 'Roupas', 79.90, 100),
('Tênis Casual', 'Calçados', 229.90, 30),
('Meia Esportiva (Par)', 'Acessórios', 19.90, 200),
('Vestido Midi Estampado', 'Roupas', 189.90, 40);

INSERT INTO pedidos (id_cliente, total, data_pedido) VALUES (1, 209.80, '2025-11-20');
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unit) VALUES 
(1, 2, 1, 79.90), 
(1, 1, 1, 129.90); 

INSERT INTO pedidos (id_cliente, total, data_pedido) VALUES (2, 129.90, '2025-11-25');
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unit) VALUES 
(2, 1, 1, 129.90); 

INSERT INTO pedidos (id_cliente, total, data_pedido) VALUES (1, 249.70, '2025-11-26');
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unit) VALUES 
(3, 3, 1, 229.90), 
(3, 4, 1, 19.90);  


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


-----------------------------------------
-- PASSO 5: MANIPULAÇÃO DE DADOS (UPDATES e DELETES)
-----------------------------------------

UPDATE clientes
SET email = 'ana.souza@novoemail.com'
WHERE id_cliente = 1;

UPDATE produtos
SET preco = preco * 1.10
WHERE categoria = 'Roupas';

DELETE FROM itens_pedido
WHERE id_item = 3;

DELETE FROM clientes
WHERE id_cliente NOT IN (SELECT id_cliente FROM pedidos);

SELECT '-- Clientes Finais (Pedro excluído)' AS Confirmação;
SELECT * FROM clientes;