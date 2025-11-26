-- =====================================================
-- Script de INSERT - Povoamento das Tabelas
-- Banco de Dados: Sistema de Delivery
-- =====================================================

USE `space_food`;

-- -----------------------------------------------------
-- Inserção de Clientes
-- -----------------------------------------------------
INSERT INTO `Cliente` (`id`, `nome`, `numero_celular`, `estado`, `cidade`, `bairro`, `rua`, `numero_casa`, `referencia_endereco`) VALUES
(1, 'João Silva', '11987654321', 'São Paulo', 'São Paulo', 'Centro', 'Rua das Flores', '100', 'Próximo à padaria'),
(2, 'Maria Oliveira', '11976543210', 'São Paulo', 'Campinas', 'Jardim América', 'Av. Brasil', '250', 'Em frente ao mercado'),
(3, 'Carlos Santos', '21987651234', 'Rio de Janeiro', 'Rio de Janeiro', 'Copacabana', 'Rua Barata Ribeiro', '45', 'Apartamento 302'),
(4, 'Ana Costa', '31998765432', 'Minas Gerais', 'Belo Horizonte', 'Savassi', 'Rua Pernambuco', '1020', NULL),
(5, 'Pedro Almeida', '41987654123', 'Paraná', 'Curitiba', 'Batel', 'Av. do Batel', '500', 'Casa amarela');

-- -----------------------------------------------------
-- Inserção de Produtos
-- -----------------------------------------------------
INSERT INTO `Produto` (`id`, `nome`, `preco`, `descricao`, `disponivel`) VALUES
(1, 'Pizza Margherita', 45.90, 'Pizza tradicional com molho de tomate, mussarela e manjericão', 1),
(2, 'Pizza Calabresa', 42.90, 'Pizza com calabresa fatiada e cebola', 1),
(3, 'Hambúrguer Artesanal', 32.50, 'Hambúrguer 180g com queijo, bacon e molho especial', 1),
(4, 'Refrigerante 2L', 12.00, 'Refrigerante de cola 2 litros', 1),
(5, 'Suco Natural', 8.50, 'Suco de laranja natural 500ml', 1),
(6, 'Pizza Portuguesa', 48.90, 'Pizza com presunto, ovos, cebola, azeitona e mussarela', 0),
(7, 'Batata Frita', 18.00, 'Porção de batata frita crocante', 1);

-- -----------------------------------------------------
-- Inserção de Entregadores
-- -----------------------------------------------------
INSERT INTO `Entregador` (`id`, `nome`, `equipamento`) VALUES
(1, 'Roberto Souza', 'Moto Honda CG 160'),
(2, 'Fernando Lima', 'Moto Yamaha Factor'),
(3, 'Lucas Pereira', 'Bicicleta Elétrica'),
(4, 'Marcos Rodrigues', 'Moto Honda Biz');

-- -----------------------------------------------------
-- Inserção de Meios de Pagamento
-- -----------------------------------------------------
INSERT INTO `MeioDePagamento` (`id`, `nome`) VALUES
(1, 'Dinheiro'),
(2, 'Cartão de Crédito'),
(3, 'Cartão de Débito'),
(4, 'PIX'),
(5, 'Vale Refeição');

-- -----------------------------------------------------
-- Inserção de Pedidos
-- -----------------------------------------------------
INSERT INTO `Pedido` (`id`, `cliente_id`, `entrega_id`, `valor_total`, `valor_pago`, `meio_pagamento`, `criado_em`, `atualizado_em`) VALUES
(1, 1, 1, 90.80, 90.80, 4, '2025-11-20 18:30:00', '2025-11-20 19:15:00'),
(2, 2, 2, 45.90, 45.90, 2, '2025-11-21 19:00:00', '2025-11-21 19:45:00'),
(3, 3, 1, 63.00, 63.00, 1, '2025-11-22 20:00:00', '2025-11-22 20:50:00'),
(4, 1, 3, 32.50, 32.50, 3, '2025-11-23 12:30:00', '2025-11-23 13:10:00'),
(5, 4, NULL, 57.40, 0, NULL, '2025-11-24 19:30:00', '2025-11-24 19:30:00'),
(6, 5, 4, 109.70, 109.70, 4, '2025-11-25 20:15:00', '2025-11-25 21:00:00');

-- -----------------------------------------------------
-- Inserção de Produtos nos Pedidos (tabela associativa)
-- -----------------------------------------------------
INSERT INTO `produto_pedido` (`produto_id`, `pedido_id`) VALUES
(1, 1),  -- Pedido 1: Pizza Margherita
(2, 1),  -- Pedido 1: Pizza Calabresa
(1, 2),  -- Pedido 2: Pizza Margherita
(3, 3),  -- Pedido 3: Hambúrguer Artesanal
(4, 3),  -- Pedido 3: Refrigerante 2L
(7, 3),  -- Pedido 3: Batata Frita
(3, 4),  -- Pedido 4: Hambúrguer Artesanal
(2, 5),  -- Pedido 5: Pizza Calabresa
(5, 5),  -- Pedido 5: Suco Natural
(1, 6),  -- Pedido 6: Pizza Margherita
(2, 6),  -- Pedido 6: Pizza Calabresa
(4, 6),  -- Pedido 6: Refrigerante 2L
(7, 6);  -- Pedido 6: Batata Frita

-- -----------------------------------------------------
-- Inserção de Avaliações
-- -----------------------------------------------------
INSERT INTO `Avaliacao` (`id`, `client_id`, `descricao`, `data`) VALUES
(1, 1, 'Excelente atendimento! Comida chegou quentinha e no prazo.', '2025-11-20 19:30:00'),
(2, 2, 'Pizza muito boa, mas demorou um pouco para chegar.', '2025-11-21 20:00:00'),
(3, 3, 'Hambúrguer sensacional! Recomendo!', '2025-11-22 21:00:00'),
(4, 5, 'Melhor delivery da região! Sempre peço aqui.', '2025-11-25 21:30:00');

-- -----------------------------------------------------
-- Inserção de Movimentações no Caixa
-- -----------------------------------------------------
INSERT INTO `caixa` (`id`, `nome_transacao`, `decricao_transacao`, `valor_transacao`, `data`) VALUES
(1, 'Venda', 'Pedido #1', 90.80, '2025-11-20 19:15:00'),
(2, 'Venda', 'Pedido #2', 45.90, '2025-11-21 19:45:00'),
(3, 'Venda', 'Pedido #3', 63.00, '2025-11-22 20:50:00'),
(4, 'Venda', 'Pedido #4', 32.50, '2025-11-23 13:10:00'),
(5, 'Despesa', 'Compra de ingredientes', -150.00, '2025-11-23 10:00:00'),
(6, 'Venda', 'Pedido #6', 109.70, '2025-11-25 21:00:00'),
(7, 'Despesa', 'Pagamento entregadores', -200.00, '2025-11-25 22:00:00');
