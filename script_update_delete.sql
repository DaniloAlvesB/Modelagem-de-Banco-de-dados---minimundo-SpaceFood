-- =====================================================
-- Script de UPDATE e DELETE - Manipulação de Dados
-- Banco de Dados: Sistema de Delivery
-- =====================================================

USE `mydb`;

-- =====================================================
-- COMANDOS UPDATE
-- =====================================================

-- -----------------------------------------------------
-- UPDATE 1: Atualizar preço de um produto específico
-- Aumentando o preço da Pizza Margherita em 10%
-- -----------------------------------------------------
UPDATE Produto
SET preco = preco * 1.10
WHERE id = 1;

-- Verificar alteração:
-- SELECT * FROM Produto WHERE id = 1;

-- -----------------------------------------------------
-- UPDATE 2: Atualizar status de disponibilidade de produto
-- Tornando a Pizza Portuguesa disponível novamente
-- -----------------------------------------------------
UPDATE Produto
SET disponivel = 1
WHERE nome = 'Pizza Portuguesa';

-- Verificar alteração:
-- SELECT * FROM Produto WHERE nome = 'Pizza Portuguesa';

-- -----------------------------------------------------
-- UPDATE 3: Atualizar pedido pendente - confirmar pagamento
-- Confirmando pagamento e atribuindo entregador ao pedido #5
-- -----------------------------------------------------
UPDATE Pedido
SET
    valor_pago = valor_total,
    meio_pagamento = 4,
    entrega_id = 2,
    atualizado_em = CURRENT_TIMESTAMP
WHERE id = 5;

-- Verificar alteração:
-- SELECT * FROM Pedido WHERE id = 5;

-- -----------------------------------------------------
-- UPDATE 4: Atualizar dados de contato de um cliente
-- Atualizando número de celular e referência de endereço
-- -----------------------------------------------------
UPDATE Cliente
SET
    numero_celular = '11999887766',
    referencia_endereco = 'Portão verde, ao lado do banco'
WHERE id = 4;

-- Verificar alteração:
-- SELECT * FROM Cliente WHERE id = 4;

-- -----------------------------------------------------
-- UPDATE 5: Atualizar equipamento do entregador
-- Entregador trocou de veículo
-- -----------------------------------------------------
UPDATE Entregador
SET equipamento = 'Moto Honda CG 160 Titan'
WHERE id = 1;

-- Verificar alteração:
-- SELECT * FROM Entregador WHERE id = 1;


-- =====================================================
-- COMANDOS DELETE
-- =====================================================

-- -----------------------------------------------------
-- DELETE 1: Remover uma avaliação específica
-- Removendo avaliação por ID
-- -----------------------------------------------------
DELETE FROM Avaliacao
WHERE id = 2;

-- Verificar alteração:
-- SELECT * FROM Avaliacao;

-- -----------------------------------------------------
-- DELETE 2: Remover transações de despesa do caixa
-- Removendo registro de despesa específico
-- -----------------------------------------------------
DELETE FROM caixa
WHERE id = 5;

-- Verificar alteração:
-- SELECT * FROM caixa;

-- -----------------------------------------------------
-- DELETE 3: Remover um meio de pagamento não utilizado
-- Primeiro verificamos se há pedidos usando este meio:
-- SELECT COUNT(*) FROM Pedido WHERE meio_pagamento = 5;
-- Como não há pedidos com Vale Refeição, podemos deletar
-- -----------------------------------------------------
DELETE FROM MeioDePagamento
WHERE id = 5 AND id NOT IN (SELECT DISTINCT meio_pagamento FROM Pedido WHERE meio_pagamento IS NOT NULL);

-- Verificar alteração:
-- SELECT * FROM MeioDePagamento;

-- -----------------------------------------------------
-- DELETE 4 (EXTRA): Remover produtos de um pedido específico
-- Removendo itens do pedido cancelado (se necessário)
-- CUIDADO: Este delete afeta a tabela associativa
-- -----------------------------------------------------
-- Exemplo de como seria a remoção (comentado para não executar):
-- DELETE FROM produto_pedido WHERE pedido_id = X;
-- DELETE FROM Pedido WHERE id = X;

-- -----------------------------------------------------
-- OBSERVAÇÕES IMPORTANTES SOBRE DELETE:
-- -----------------------------------------------------
-- 1. Sempre verificar dependências (chaves estrangeiras) antes de deletar
-- 2. A ordem de deleção importa: deletar registros filhos antes dos pais
-- 3. Usar WHERE para evitar deleções acidentais de todos os registros
-- 4. Considerar usar transações (BEGIN/COMMIT/ROLLBACK) para operações críticas
-- 5. Em produção, considerar "soft delete" (marcar como inativo) ao invés de DELETE
