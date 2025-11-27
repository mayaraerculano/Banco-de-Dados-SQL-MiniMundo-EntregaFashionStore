<<<<<<< HEAD
# 🛍️ FashionStore Database Project (PostgreSQL)

Este projeto demonstra a criação e manipulação de um banco de dados relacional para uma loja de moda/vestuário utilizando PostgreSQL.

## Estrutura do Banco de Dados

O banco de dados, chamado `fashionstore`, é composto pelas seguintes tabelas:

* **`clientes`**: Informações sobre os clientes.
* **`produtos`**: Catálogo de itens disponíveis na loja.
* **`pedidos`**: Registros das transações de compra.
* **`itens_pedido`**: Tabela de relacionamento (N:N) que detalha os produtos incluídos em cada pedido.

## 📁 Arquivos do Projeto

| Arquivo | Descrição |
| :--- | :--- |
| `fashionstore_completo.sql` | Script único para rodar todas as etapas (limpeza, criação e inserção) de uma vez no pgAdmin. **Recomendado para demonstração.** |
| `README.md` | Este arquivo de documentação. |
| **`scripts/01_create_tables.sql`** | Criação da estrutura (`CREATE TABLE`). Inclui comandos de limpeza (`DROP TABLE CASCADE`). |
| **`scripts/02_inserts.sql`** | Inserção dos dados iniciais (`INSERT INTO`). |
| **`scripts/03_selects.sql`** | Demonstração de consultas complexas (`JOIN`, `GROUP BY`, `HAVING`, `EXCEPT`). |
| **`scripts/04_updates_deletes.sql`** | Criação de objetos avançados (`VIEW`, `FUNCTION`) e manipulação de dados (`UPDATE`, `DELETE`). |

## ⚙️ Instruções de Execução (pgAdmin)

1.  **Conexão:** Conecte-se ao seu servidor PostgreSQL (versão 18, porta 5432).
2.  **Criação do DB:** Crie um novo banco de dados chamado **`fashionstore`**.
3.  **Execução:**
    * Abra o **Query Tool** no banco de dados `fashionstore`.
    * Copie e cole o conteúdo do script **`fashionstore_completo.sql`**.
    * Execute (ícone de raio ⚡) o script completo para criar, popular e demonstrar todas as funcionalidades do banco em uma única execução.
=======
# Banco-de-Dados-SQL---MiniMundo-EntregaFashionStore
>>>>>>> 4ade40fb742a6fe7521f446340eeddf63ef3e98c
