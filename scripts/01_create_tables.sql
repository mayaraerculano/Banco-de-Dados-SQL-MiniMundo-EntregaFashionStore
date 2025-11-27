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
