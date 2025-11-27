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