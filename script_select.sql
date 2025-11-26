-- =====================================================
-- Script de SELECT - Consultas ao Banco de Dados
-- Banco de Dados: Sistema de Delivery
-- =====================================================

USE `mydb`;

-- -----------------------------------------------------
-- CONSULTA 1: Listar todos os clientes ordenados por nome
-- Uso de: SELECT, ORDER BY
-- -----------------------------------------------------
SELECT
    id,
    nome,
    numero_celular,
    cidade,
    estado
FROM Cliente
ORDER BY nome ASC;

-- -----------------------------------------------------
-- CONSULTA 2: Buscar produtos disponíveis com preço abaixo de R$40
-- Uso de: SELECT, WHERE, AND, ORDER BY
-- -----------------------------------------------------
SELECT
    nome AS produto,
    preco,
    descricao
FROM Produto
WHERE disponivel = 1 AND preco < 40
ORDER BY preco DESC;

-- -----------------------------------------------------
-- CONSULTA 3: Listar os 3 pedidos mais recentes com dados do cliente
-- Uso de: SELECT, JOIN, ORDER BY, LIMIT
-- -----------------------------------------------------
SELECT
    p.id AS pedido_id,
    c.nome AS cliente,
    c.cidade,
    p.valor_total,
    mp.nome AS forma_pagamento,
    p.criado_em
FROM Pedido p
INNER JOIN Cliente c ON p.cliente_id = c.id
LEFT JOIN MeioDePagamento mp ON p.meio_pagamento = mp.id
ORDER BY p.criado_em DESC
LIMIT 3;

-- -----------------------------------------------------
-- CONSULTA 4: Relatório completo de pedidos com produtos, cliente e entregador
-- Uso de: SELECT, múltiplos JOINs, GROUP_CONCAT
-- -----------------------------------------------------
SELECT
    p.id AS pedido,
    c.nome AS cliente,
    e.nome AS entregador,
    GROUP_CONCAT(pr.nome SEPARATOR ', ') AS produtos,
    p.valor_total,
    mp.nome AS pagamento,
    p.criado_em
FROM Pedido p
INNER JOIN Cliente c ON p.cliente_id = c.id
LEFT JOIN Entregador e ON p.entrega_id = e.id
LEFT JOIN MeioDePagamento mp ON p.meio_pagamento = mp.id
INNER JOIN produto_pedido pp ON p.id = pp.pedido_id
INNER JOIN Produto pr ON pp.produto_id = pr.id
GROUP BY p.id, c.nome, e.nome, p.valor_total, mp.nome, p.criado_em
ORDER BY p.criado_em;

-- -----------------------------------------------------
-- CONSULTA 5: Resumo de vendas - Total faturado e quantidade de pedidos pagos
-- Uso de: SELECT, WHERE, funções de agregação (SUM, COUNT)
-- -----------------------------------------------------
SELECT
    COUNT(*) AS total_pedidos_pagos,
    SUM(valor_total) AS faturamento_total,
    AVG(valor_total) AS ticket_medio
FROM Pedido
WHERE valor_pago > 0;

-- -----------------------------------------------------
-- CONSULTA EXTRA: Clientes que fizeram avaliações com suas notas
-- Uso de: SELECT, JOIN, ORDER BY
-- -----------------------------------------------------
SELECT
    c.nome AS cliente,
    a.descricao AS avaliacao,
    a.data AS data_avaliacao
FROM Avaliacao a
INNER JOIN Cliente c ON a.client_id = c.id
ORDER BY a.data DESC;

-- -----------------------------------------------------
-- CONSULTA EXTRA: Saldo do caixa (entradas - saídas)
-- Uso de: SELECT, funções de agregação, CASE
-- -----------------------------------------------------
SELECT
    SUM(CASE WHEN valor_transacao > 0 THEN valor_transacao ELSE 0 END) AS total_entradas,
    SUM(CASE WHEN valor_transacao < 0 THEN ABS(valor_transacao) ELSE 0 END) AS total_saidas,
    SUM(valor_transacao) AS saldo_atual
FROM caixa;
