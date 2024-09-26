-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 26/09/2024 às 05:29
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `erpl`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `mgt_caixa_aux`
--

CREATE TABLE `mgt_caixa_aux` (
  `id` int(11) NOT NULL,
  `mgt_planodecontas_id` int(11) NOT NULL,
  `mgt_contas_id` int(11) NOT NULL,
  `sis_caixa_id` int(11) NOT NULL,
  `sis_contaspagar_id` int(11) NOT NULL,
  `sis_lanc_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `mgt_contas`
--

CREATE TABLE `mgt_contas` (
  `id` int(11) NOT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  `data_inicial` datetime DEFAULT NULL,
  `saldo_inicial` decimal(12,2) DEFAULT NULL,
  `saldo` decimal(12,2) DEFAULT NULL,
  `forma_pagamento` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `mgt_contas`
--

INSERT INTO `mgt_contas` (`id`, `descricao`, `data_inicial`, `saldo_inicial`, `saldo`, `forma_pagamento`) VALUES
(1, 'Conta Corrente Banco A', '2024-01-01 10:00:00', 10000.00, 9500.00, 'Transferência Bancária'),
(2, 'Conta Poupança Banco B', '2024-01-05 11:30:00', 5000.00, 5200.00, 'Depósito em Poupança'),
(3, 'Conta Pagamento Online C', '2024-02-15 09:15:00', 2000.00, 1850.00, 'Pagamento Online'),
(4, 'Cartão de Crédito D', '2024-03-10 14:00:00', 1500.00, 1200.00, 'Cartão de Crédito'),
(5, 'Conta Corrente Banco E', '2024-04-12 16:45:00', 8000.00, 7600.00, 'Cheque'),
(6, 'Conta Salário Banco F', '2024-05-22 13:10:00', 6000.00, 5900.00, 'Transferência Bancária');

-- --------------------------------------------------------

--
-- Estrutura para tabela `mgt_planodecontas`
--

CREATE TABLE `mgt_planodecontas` (
  `id` int(11) NOT NULL,
  `item` varchar(10) NOT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  `pai` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `mgt_planodecontas`
--

INSERT INTO `mgt_planodecontas` (`id`, `item`, `descricao`, `pai`) VALUES
(1, '001', 'Despesas Gerais', NULL),
(2, '002', 'Receitas Operacionais', NULL),
(3, '003', 'Impostos', NULL),
(4, '001.01', 'Despesas com Pessoal', 1),
(5, '001.02', 'Despesas com Materiais', 1),
(6, '002.01', 'Vendas de Produtos', 2),
(7, '002.02', 'Serviços Prestados', 2),
(8, '003.01', 'Impostos Federais', 3),
(9, '003.02', 'Impostos Estaduais', 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `sis_caixa`
--

CREATE TABLE `sis_caixa` (
  `id` int(11) NOT NULL,
  `uuid_caixa` varchar(48) DEFAULT NULL,
  `data` datetime NOT NULL,
  `historico` varchar(255) NOT NULL,
  `complemento` longtext DEFAULT NULL,
  `entrada` decimal(12,2) DEFAULT NULL,
  `saida` decimal(12,2) DEFAULT NULL,
  `usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `sis_caixa`
--

INSERT INTO `sis_caixa` (`id`, `uuid_caixa`, `data`, `historico`, `complemento`, `entrada`, `saida`, `usuario`) VALUES
(1, '3f8d31e8-79f5-4e94-b2c8-1e6c71ef1234', '2024-09-23 14:30:00', 'Venda de produtos', 'Cliente comprou produtos diversos', 150.00, NULL, 1),
(2, '4a1e5b9e-89f4-46bd-bf78-1aef98d6b567', '2024-09-22 10:15:00', 'Pagamento de fornecedor', 'Pagamento do fornecedor de insumos', NULL, 200.00, 2),
(3, '9c3a5d8f-a716-4dbd-8f19-69a1c97c3f89', '2024-09-20 09:45:00', 'Recebimento de serviço', 'Prestação de serviço de manutenção', 300.00, NULL, 3),
(4, '5d6e1f7a-51a8-499f-ace3-0e45f78b9123', '2024-09-19 13:00:00', 'Compra de equipamentos', 'Compra de novos computadores para o escritório', NULL, 1000.00, 4),
(5, 'd2c6e67d-65f3-4f54-8b8f-0b7c7ea456df', '2024-09-18 16:00:00', 'Recebimento de pagamento', 'Cliente pagou o serviço de consultoria', 500.00, NULL, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `sis_cliente`
--

CREATE TABLE `sis_cliente` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `bairro` varchar(255) DEFAULT NULL,
  `cidade` varchar(255) DEFAULT NULL,
  `cep` varchar(9) DEFAULT NULL,
  `estado` varchar(2) DEFAULT NULL,
  `cpf_cnpj` varchar(20) DEFAULT NULL,
  `fone` varchar(50) DEFAULT NULL,
  `obs` text DEFAULT NULL,
  `nascimento` varchar(45) DEFAULT NULL,
  `estado_civil` enum('S','C','D','V') DEFAULT NULL,
  `rg_ie` varchar(32) DEFAULT NULL,
  `celular` varchar(32) DEFAULT NULL,
  `tags` longtext DEFAULT NULL,
  `data_ins` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `sis_cliente`
--

INSERT INTO `sis_cliente` (`id`, `nome`, `email`, `endereco`, `bairro`, `cidade`, `cep`, `estado`, `cpf_cnpj`, `fone`, `obs`, `nascimento`, `estado_civil`, `rg_ie`, `celular`, `tags`, `data_ins`) VALUES
(1, 'João Silva', 'joao.silva@gmail.com', 'Rua das Flores, 123', 'Centro', 'São Paulo', '01001-000', 'SP', '123.456.789-00', '(11) 98765-4321', 'Cliente fiel desde 2020', '1985-05-10', 'C', 'MG-12.345.678', '(11) 91234-5678', 'cliente_vip, ativo', '2024-09-20 14:30:00'),
(2, 'Maria Oliveira', 'maria.oliveira@hotmail.com', 'Av. Brasil, 456', 'Jardins', 'Rio de Janeiro', '20031-170', 'RJ', '987.654.321-99', '(21) 99876-5432', 'Preferência por e-mails para contato', '1990-12-25', 'S', 'RJ-98.765.432', '(21) 92345-6789', 'cliente_novo, potencial', '2024-09-21 10:15:00'),
(3, 'Carlos Mendes', 'carlos.mendes@empresa.com.br', 'R. das Palmeiras, 789', 'Vila Mariana', 'São Paulo', '04101-300', 'SP', '456.789.123-77', '(11) 96543-2100', 'Empresa de grande porte', '1978-11-15', 'C', 'SP-34.567.890', '(11) 93456-7890', 'corporativo, grande', '2024-09-22 09:00:00'),
(4, 'Fernanda Costa', 'fernanda.costa@yahoo.com', 'Rua do Comércio, 100', 'Bela Vista', 'Belo Horizonte', '30111-050', 'MG', '567.890.234-12', '(31) 97654-3210', 'Contato preferencial por celular', '1983-03-08', 'S', 'MG-56.789.012', '(31) 92345-6780', 'cliente_vip, recorrente', '2024-09-22 11:45:00'),
(5, 'Ana Souza', 'ana.souza@outlook.com', 'Av. Paulista, 987', 'Consolação', 'São Paulo', '01310-100', 'SP', '678.901.345-66', '(11) 94321-6543', 'Cliente cadastrada via evento promocional', '1995-07-20', 'S', 'SP-67.890.123', '(11) 91234-5677', 'evento_promocional', '2024-09-23 13:30:00');

-- --------------------------------------------------------

--
-- Estrutura para tabela `sis_contaspagar`
--

CREATE TABLE `sis_contaspagar` (
  `id` int(11) NOT NULL,
  `uuid_contaspagar` varchar(48) DEFAULT NULL,
  `vencimento` datetime DEFAULT NULL,
  `valor` decimal(12,2) DEFAULT NULL,
  `valor_pago` decimal(12,2) DEFAULT NULL,
  `emissao` datetime DEFAULT NULL,
  `nrdocumento` varchar(50) DEFAULT NULL,
  `usergerou` varchar(50) DEFAULT NULL,
  `historico` varchar(255) DEFAULT NULL,
  `numparcelas` int(11) DEFAULT NULL,
  `observacao` text DEFAULT NULL,
  `parcatual` int(11) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `datapg` datetime DEFAULT NULL,
  `fornecedor_id` int(11) NOT NULL,
  `compra_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `sis_contaspagar`
--

INSERT INTO `sis_contaspagar` (`id`, `uuid_contaspagar`, `vencimento`, `valor`, `valor_pago`, `emissao`, `nrdocumento`, `usergerou`, `historico`, `numparcelas`, `observacao`, `parcatual`, `status`, `datapg`, `fornecedor_id`, `compra_id`) VALUES
(1, 'b459b75e-8d36-4c1a-b7c1-6d329a504f82', '2024-10-01 12:00:00', 1500.00, 1500.00, '2024-09-20 12:00:00', 'DOC123', 'admin', 'Pagamento de fornecedor', 1, 'Pago integralmente', 1, 'pago', '2024-09-20 14:00:00', 1, 101),
(2, 'c874b37a-9d23-4b87-9351-8b1024b8071a', '2024-11-01 12:00:00', 2000.00, 0.00, '2024-09-21 12:00:00', 'DOC124', 'admin', 'Compra de materiais', 2, 'Pagamento parcelado', 1, 'pendente', NULL, 2, 102),
(3, 'd8cba378-7c1b-4d58-8d87-019a7a89529c', '2024-12-01 12:00:00', 3000.00, 1500.00, '2024-09-22 12:00:00', 'DOC125', 'admin', 'Serviço prestado', 3, 'Parcela paga', 2, 'parcial', '2024-09-22 16:00:00', 3, 103),
(4, 'f1d3548d-7a0f-420b-9a9c-4c2c2b5a9c21', '2024-10-15 12:00:00', 2500.00, 2500.00, '2024-09-23 12:00:00', 'DOC126', 'admin', 'Pagamento de aluguel', 1, 'Pago integralmente', 1, 'pago', '2024-09-23 18:00:00', 4, 104),
(5, 'e7129f42-9b29-4211-9c7b-9054af8141d9', '2024-10-20 12:00:00', 1000.00, 0.00, '2024-09-24 12:00:00', 'DOC127', 'admin', 'Compra de suprimentos', 5, 'Pagamento parcelado', 1, 'pendente', NULL, 5, 105);

-- --------------------------------------------------------

--
-- Estrutura para tabela `sis_lanc`
--

CREATE TABLE `sis_lanc` (
  `id` int(11) NOT NULL,
  `datavenc` datetime DEFAULT NULL,
  `nossonum` varchar(64) DEFAULT NULL,
  `datapag` datetime DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `obs` varchar(255) DEFAULT NULL,
  `coletor` varchar(20) DEFAULT NULL,
  `linhadig` varchar(255) DEFAULT NULL,
  `valor` decimal(12,2) DEFAULT NULL,
  `valorpag` decimal(12,2) DEFAULT NULL,
  `referencia` varchar(8) DEFAULT NULL,
  `formapag` varchar(100) DEFAULT NULL,
  `deltitulo` tinyint(4) DEFAULT NULL,
  `datadel` datetime DEFAULT NULL,
  `sis_cliente_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `sis_lanc`
--

INSERT INTO `sis_lanc` (`id`, `datavenc`, `nossonum`, `datapag`, `status`, `obs`, `coletor`, `linhadig`, `valor`, `valorpag`, `referencia`, `formapag`, `deltitulo`, `datadel`, `sis_cliente_id`) VALUES
(6, '2024-10-10 12:00:00', '123456789012345', '2024-10-12 15:00:00', 'Pago', 'Pagamento de fatura', 'Coletor1', '001234567890123456789012345678901234567890', 500.00, 500.00, 'REF001', 'Boleto', 0, NULL, 1),
(7, '2024-11-01 12:00:00', '234567890123456', NULL, 'Pendente', 'Pagamento agendado', 'Coletor2', '002345678901234567890123456789012345678901', 800.00, 0.00, 'REF002', 'Transferência', 0, NULL, 2),
(8, '2024-12-05 12:00:00', '345678901234567', NULL, 'Pendente', 'Aguardando pagamento', 'Coletor3', '003456789012345678901234567890123456789012', 1200.00, 0.00, 'REF003', 'Cartão de Crédito', 0, NULL, 3),
(9, '2024-09-30 12:00:00', '456789012345678', '2024-09-29 10:00:00', 'Pago', 'Pagamento antecipado', 'Coletor4', '004567890123456789012345678901234567890123', 600.00, 600.00, 'REF004', 'Pix', 0, NULL, 4),
(10, '2024-08-20 12:00:00', '567890123456789', NULL, 'Cancelado', 'Pagamento não realizado', 'Coletor5', '005678901234567890123456789012345678901234', 400.00, 0.00, 'REF005', 'Dinheiro', 1, '2024-08-25 14:00:00', 5);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `mgt_caixa_aux`
--
ALTER TABLE `mgt_caixa_aux`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_mgt_caixa_aux_mgt_planodecontas1_idx` (`mgt_planodecontas_id`),
  ADD KEY `fk_mgt_caixa_aux_mgt_contas1_idx` (`mgt_contas_id`),
  ADD KEY `fk_mgt_caixa_aux_sis_caixa1_idx` (`sis_caixa_id`),
  ADD KEY `fk_mgt_caixa_aux_sis_contaspagar1_idx` (`sis_contaspagar_id`),
  ADD KEY `fk_mgt_caixa_aux_sis_lanc1_idx` (`sis_lanc_id`);

--
-- Índices de tabela `mgt_contas`
--
ALTER TABLE `mgt_contas`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `mgt_planodecontas`
--
ALTER TABLE `mgt_planodecontas`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `sis_caixa`
--
ALTER TABLE `sis_caixa`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `sis_cliente`
--
ALTER TABLE `sis_cliente`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `sis_contaspagar`
--
ALTER TABLE `sis_contaspagar`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `sis_lanc`
--
ALTER TABLE `sis_lanc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_sis_lanc_sis_cliente1` (`sis_cliente_id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `mgt_caixa_aux`
--
ALTER TABLE `mgt_caixa_aux`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `mgt_contas`
--
ALTER TABLE `mgt_contas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `mgt_planodecontas`
--
ALTER TABLE `mgt_planodecontas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `sis_caixa`
--
ALTER TABLE `sis_caixa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de tabela `sis_cliente`
--
ALTER TABLE `sis_cliente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `sis_contaspagar`
--
ALTER TABLE `sis_contaspagar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `sis_lanc`
--
ALTER TABLE `sis_lanc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `mgt_caixa_aux`
--
ALTER TABLE `mgt_caixa_aux`
  ADD CONSTRAINT `fk_mgt_caixa_aux_mgt_contas1` FOREIGN KEY (`mgt_contas_id`) REFERENCES `mgt_contas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_mgt_caixa_aux_mgt_planodecontas1` FOREIGN KEY (`mgt_planodecontas_id`) REFERENCES `mgt_planodecontas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_mgt_caixa_aux_sis_caixa1` FOREIGN KEY (`sis_caixa_id`) REFERENCES `sis_caixa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_mgt_caixa_aux_sis_contaspagar1` FOREIGN KEY (`sis_contaspagar_id`) REFERENCES `sis_contaspagar` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_mgt_caixa_aux_sis_lanc1` FOREIGN KEY (`sis_lanc_id`) REFERENCES `sis_lanc` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `sis_lanc`
--
ALTER TABLE `sis_lanc`
  ADD CONSTRAINT `fk_sis_lanc_sis_cliente1` FOREIGN KEY (`sis_cliente_id`) REFERENCES `sis_cliente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
