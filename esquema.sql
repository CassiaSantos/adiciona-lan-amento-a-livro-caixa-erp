CREATE TABLE IF NOT EXISTS `erpl`.`mgt_contas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  `data_inicial` DATETIME NULL,
  `saldo_inicial` DECIMAL(12,2) NULL,
  `saldo` DECIMAL(12,2) NULL,
  `forma_pagamento` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB

------------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpl`.`mgt_planodecontas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `item` VARCHAR(10) NOT NULL,
  `descricao` VARCHAR(100) NULL,
  `pai` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB

------------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpl`.`sis_contaspagar` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `uuid_contaspagar` VARCHAR(48) NULL,
  `vencimento` DATETIME NULL,
  `valor` DECIMAL(12,2) NULL,
  `valor_pago` DECIMAL(12,2) NULL,
  `emissao` DATETIME NULL,
  `nrdocumento` VARCHAR(50) NULL,
  `usergerou` VARCHAR(50) NULL,
  `historico` VARCHAR(255) NULL,
  `numparcelas` INT NULL,
  `observacao` TEXT NULL,
  `parcatual` INT NULL,
  `status` VARCHAR(50) NULL,
  `datapg` DATETIME NULL,
  `fornecedor_id` INT NOT NULL,
  `compra_id` INT NULL,
  PRIMARY KEY (`id`),
  -- INDEX `fk_sis_contaspagar_sis_fornecedor1_idx` (`fornecedor_id` ASC) VISIBLE,
  -- INDEX `fk_sis_contaspagar_mgt_compra1_idx` (`compra_id` ASC) VISIBLE,
  -- CONSTRAINT `fk_sis_contaspagar_sis_fornecedor1`
  --   FOREIGN KEY (`fornecedor_id`)
  --   REFERENCES `erpl`.`sis_fornecedor` (`id`)
  --   ON DELETE NO ACTION
  --   ON UPDATE NO ACTION,
  -- CONSTRAINT `fk_sis_contaspagar_mgt_compra1`
  --   FOREIGN KEY (`compra_id`)
  --   REFERENCES `erpl`.`mgt_compra` (`id`)
  --   ON DELETE NO ACTION
  --   ON UPDATE NO ACTION)
ENGINE = InnoDB

----------------- POPULAÇÃO---------------------------------
-- Inserção de registros na tabela sis_contaspagar
INSERT INTO `erpl`.`sis_contaspagar` 
    (`uuid_contaspagar`, `vencimento`, `valor`, `valor_pago`, `emissao`, `nrdocumento`, 
    `usergerou`, `historico`, `numparcelas`, `observacao`, `parcatual`, `status`, 
    `datapg`, `fornecedor_id`, `compra_id`)
VALUES
    ('b459b75e-8d36-4c1a-b7c1-6d329a504f82', '2024-10-01 12:00:00', 1500.00, 1500.00, '2024-09-20 12:00:00', 'DOC123', 
     'admin', 'Pagamento de fornecedor', 1, 'Pago integralmente', 1, 'pago', '2024-09-20 14:00:00', 1, 101),

    ('c874b37a-9d23-4b87-9351-8b1024b8071a', '2024-11-01 12:00:00', 2000.00, 0.00, '2024-09-21 12:00:00', 'DOC124', 
     'admin', 'Compra de materiais', 2, 'Pagamento parcelado', 1, 'pendente', NULL, 2, 102),

    ('d8cba378-7c1b-4d58-8d87-019a7a89529c', '2024-12-01 12:00:00', 3000.00, 1500.00, '2024-09-22 12:00:00', 'DOC125', 
     'admin', 'Serviço prestado', 3, 'Parcela paga', 2, 'parcial', '2024-09-22 16:00:00', 3, 103),

    ('f1d3548d-7a0f-420b-9a9c-4c2c2b5a9c21', '2024-10-15 12:00:00', 2500.00, 2500.00, '2024-09-23 12:00:00', 'DOC126', 
     'admin', 'Pagamento de aluguel', 1, 'Pago integralmente', 1, 'pago', '2024-09-23 18:00:00', 4, 104),

    ('e7129f42-9b29-4211-9c7b-9054af8141d9', '2024-10-20 12:00:00', 1000.00, 0.00, '2024-09-24 12:00:00', 'DOC127', 
     'admin', 'Compra de suprimentos', 5, 'Pagamento parcelado', 1, 'pendente', NULL, 5, 105);

-- Explicação dos dados inseridos:
-- uuid_contaspagar: Um UUID fictício para identificar de forma única cada conta a pagar.
-- vencimento: Data de vencimento da conta.
-- valor: Valor total da conta.
-- valor_pago: Valor já pago até o momento (total ou parcial).
-- emissao: Data de emissão do documento.
-- nrdocumento: Número de documento para referência.
-- usergerou: Usuário que gerou o registro.
-- historico: Descrição sobre a conta, como motivo ou razão do pagamento.
-- numparcelas: Número total de parcelas.
-- observacao: Observações adicionais sobre o pagamento.
-- parcatual: Parcela atual que está sendo paga.
-- status: Status da conta, podendo ser "pago", "pendente", ou "parcial".
-- datapg: Data de pagamento (caso já tenha sido efetuado).
-- fornecedor_id: ID do fornecedor associado à conta.
-- compra_id: ID de uma compra associada, caso aplicável.
----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpl`.`sis_lanc` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `datavenc` DATETIME NULL,
  `nossonum` VARCHAR(64) NULL,
  `datapag` DATETIME NULL,
  `status` VARCHAR(255) NULL,
  `obs` VARCHAR(255) NULL,
  `coletor` VARCHAR(20) NULL,
  `linhadig` VARCHAR(255) NULL,
  `valor` DECIMAL(12,2) NULL,
  `valorpag` DECIMAL(12,2) NULL,
  `referencia` VARCHAR(8) NULL,
  `formapag` VARCHAR(100) NULL,
  `deltitulo` TINYINT NULL,
  `datadel` DATETIME NULL,
  `sis_cliente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_sis_lanc_sis_cliente1`
    FOREIGN KEY (`sis_cliente_id`)
    REFERENCES `erpl`.`sis_cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
----------------- POPULAÇÃO -------------------------
-- Inserção de registros na tabela sis_lanc
INSERT INTO `erpl`.`sis_lanc` 
    (`datavenc`, `nossonum`, `datapag`, `status`, `obs`, `coletor`, `linhadig`, 
     `valor`, `valorpag`, `referencia`, `formapag`, `deltitulo`, `datadel`, `sis_cliente_id`)
VALUES
    ('2024-10-10 12:00:00', '123456789012345', '2024-10-12 15:00:00', 'Pago', 'Pagamento de fatura', 
     'Coletor1', '001234567890123456789012345678901234567890', 500.00, 500.00, 'REF001', 'Boleto', 0, NULL, 1),

    ('2024-11-01 12:00:00', '234567890123456', NULL, 'Pendente', 'Pagamento agendado', 
     'Coletor2', '002345678901234567890123456789012345678901', 800.00, 0.00, 'REF002', 'Transferência', 0, NULL, 2),

    ('2024-12-05 12:00:00', '345678901234567', NULL, 'Pendente', 'Aguardando pagamento', 
     'Coletor3', '003456789012345678901234567890123456789012', 1200.00, 0.00, 'REF003', 'Cartão de Crédito', 0, NULL, 3),

    ('2024-09-30 12:00:00', '456789012345678', '2024-09-29 10:00:00', 'Pago', 'Pagamento antecipado', 
     'Coletor4', '004567890123456789012345678901234567890123', 600.00, 600.00, 'REF004', 'Pix', 0, NULL, 4),

    ('2024-08-20 12:00:00', '567890123456789', NULL, 'Cancelado', 'Pagamento não realizado', 
     'Coletor5', '005678901234567890123456789012345678901234', 400.00, 0.00, 'REF005', 'Dinheiro', 1, '2024-08-25 14:00:00', 5);

-- Explicação dos dados inseridos:
-- datavenc: Data de vencimento do lançamento.
-- nossonum: Número do documento ou identificação associada (ex. número do boleto).
-- datapag: Data em que o pagamento foi realizado (ou NULL, se ainda não foi pago).
-- status: Status do lançamento, como "Pago", "Pendente", ou "Cancelado".
-- obs: Observação sobre o lançamento ou pagamento.
-- coletor: Nome do coletor de dados ou responsável pelo lançamento.
-- linhadig: Linha digitável, geralmente associada a boletos.
-- valor: Valor total do lançamento.
-- valorpag: Valor pago até o momento (pode ser parcial ou total).
-- referencia: Código de referência do lançamento.
-- formapag: Forma de pagamento (ex. Boleto, Pix, Transferência, etc.).
-- deltitulo: Indicador se o título foi deletado (0 para não e 1 para sim).
-- datadel: Data em que o título foi deletado (se aplicável).
-- sis_cliente_id: ID do cliente associado ao lançamento (referência estrangeira à tabela sis_cliente).
------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpl`.`sis_cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NULL,
  `endereco` VARCHAR(255) NULL,
  `bairro` VARCHAR(255) NULL,
  `cidade` VARCHAR(255) NULL,
  `cep` VARCHAR(9) NULL,
  `estado` VARCHAR(2) NULL,
  `cpf_cnpj` VARCHAR(20) NULL,
  `fone` VARCHAR(50) NULL,
  `obs` TEXT NULL,
  `nascimento` VARCHAR(45) NULL,
  `estado_civil` ENUM('S', 'C', 'D', 'V') NULL,
  `rg_ie` VARCHAR(32) NULL,
  `celular` VARCHAR(32) NULL,
  `tags` LONGTEXT NULL,
  `data_ins` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '				'
---------------POPULAÇÃO ------------------------
-- Inserção de registros na tabela sis_cliente
INSERT INTO `erpl`.`sis_cliente` 
    (`nome`, `email`, `endereco`, `bairro`, `cidade`, `cep`, `estado`, `cpf_cnpj`, 
     `fone`, `obs`, `nascimento`, `estado_civil`, `rg_ie`, `celular`, `tags`, `data_ins`)
VALUES
    ('João Silva', 'joao.silva@gmail.com', 'Rua das Flores, 123', 'Centro', 'São Paulo', '01001-000', 'SP', '123.456.789-00', 
     '(11) 98765-4321', 'Cliente fiel desde 2020', '1985-05-10', 'C', 'MG-12.345.678', '(11) 91234-5678', 'cliente_vip, ativo', '2024-09-20 14:30:00'),

    ('Maria Oliveira', 'maria.oliveira@hotmail.com', 'Av. Brasil, 456', 'Jardins', 'Rio de Janeiro', '20031-170', 'RJ', '987.654.321-99', 
     '(21) 99876-5432', 'Preferência por e-mails para contato', '1990-12-25', 'S', 'RJ-98.765.432', '(21) 92345-6789', 'cliente_novo, potencial', '2024-09-21 10:15:00'),

    ('Carlos Mendes', 'carlos.mendes@empresa.com.br', 'R. das Palmeiras, 789', 'Vila Mariana', 'São Paulo', '04101-300', 'SP', '456.789.123-77', 
     '(11) 96543-2100', 'Empresa de grande porte', '1978-11-15', 'C', 'SP-34.567.890', '(11) 93456-7890', 'corporativo, grande', '2024-09-22 09:00:00'),

    ('Fernanda Costa', 'fernanda.costa@yahoo.com', 'Rua do Comércio, 100', 'Bela Vista', 'Belo Horizonte', '30111-050', 'MG', '567.890.234-12', 
     '(31) 97654-3210', 'Contato preferencial por celular', '1983-03-08', 'S', 'MG-56.789.012', '(31) 92345-6780', 'cliente_vip, recorrente', '2024-09-22 11:45:00'),

    ('Ana Souza', 'ana.souza@outlook.com', 'Av. Paulista, 987', 'Consolação', 'São Paulo', '01310-100', 'SP', '678.901.345-66', 
     '(11) 94321-6543', 'Cliente cadastrada via evento promocional', '1995-07-20', 'S', 'SP-67.890.123', '(11) 91234-5677', 'evento_promocional', '2024-09-23 13:30:00');

-- Explicação dos dados inseridos:
-- nome: Nome completo do cliente.
-- email: Endereço de e-mail do cliente.
-- endereco: Endereço residencial ou comercial do cliente.
-- bairro: Bairro onde o cliente reside.
-- cidade: Cidade do cliente.
-- cep: Código postal (CEP) do endereço do cliente.
-- estado: Estado onde o cliente reside (abrev. de 2 letras).
-- cpf_cnpj: CPF ou CNPJ do cliente.
-- fone: Número de telefone do cliente.
-- obs: Observações gerais sobre o cliente.
-- nascimento: Data de nascimento do cliente (ou outra data relevante).
-- estado_civil: Estado civil do cliente (S: Solteiro, C: Casado, D: Divorciado, V: Viúvo).
-- rg_ie: Registro Geral (RG) ou Inscrição Estadual (IE) do cliente.
-- celular: Número de celular do cliente.
-- tags: Tags associadas ao cliente para categorizações (ex. cliente_vip, corporativo).
-- data_ins: Data de inserção do registro no sistema.
------------------------------------------------

CREATE TABLE IF NOT EXISTS `erpl`.`sis_caixa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `uuid_caixa` VARCHAR(48) NULL,
  `data` DATETIME NOT NULL,
  `historico` VARCHAR(255) NOT NULL,
  `complemento` LONGTEXT NULL,
  `entrada` DECIMAL(12,2) NULL,
  `saida` DECIMAL(12,2) NULL,
  `usuario` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sis_caixa_sis_acesso1_idx` (`usuario` ASC) VISIBLE,
  CONSTRAINT `fk_sis_caixa_sis_acesso1`
    FOREIGN KEY (`usuario`)
    REFERENCES `erpl`.`sis_acesso` (`idacesso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

-- Inserir registros na tabela sis_caixa
INSERT INTO `erpl`.`sis_caixa` (`uuid_caixa`, `data`, `historico`, `complemento`, `entrada`, `saida`, `usuario`) 
VALUES ('3f8d31e8-79f5-4e94-b2c8-1e6c71ef1234', '2024-09-23 14:30:00', 'Venda de produtos', 'Cliente comprou produtos diversos', 150.00, NULL, 1),
       ('4a1e5b9e-89f4-46bd-bf78-1aef98d6b567', '2024-09-22 10:15:00', 'Pagamento de fornecedor', 'Pagamento do fornecedor de insumos', NULL, 200.00, 2),
       ('9c3a5d8f-a716-4dbd-8f19-69a1c97c3f89', '2024-09-20 09:45:00', 'Recebimento de serviço', 'Prestação de serviço de manutenção', 300.00, NULL, 3),
       ('5d6e1f7a-51a8-499f-ace3-0e45f78b9123', '2024-09-19 13:00:00', 'Compra de equipamentos', 'Compra de novos computadores para o escritório', NULL, 1000.00, 4),
       ('d2c6e67d-65f3-4f54-8b8f-0b7c7ea456df', '2024-09-18 16:00:00', 'Recebimento de pagamento', 'Cliente pagou o serviço de consultoria', 500.00, NULL, 1);

------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpl`.`mgt_caixa_aux` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `mgt_planodecontas_id` INT NOT NULL,
  `mgt_contas_id` INT NOT NULL,
  `sis_caixa_id` INT NOT NULL,
  `sis_contaspagar_id` INT NOT NULL,
  `sis_lanc_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  
  -- Índices para as chaves estrangeiras
  INDEX `fk_mgt_caixa_aux_mgt_planodecontas1_idx` (`mgt_planodecontas_id`),
  INDEX `fk_mgt_caixa_aux_mgt_contas1_idx` (`mgt_contas_id`),
  INDEX `fk_mgt_caixa_aux_sis_caixa1_idx` (`sis_caixa_id`),
  INDEX `fk_mgt_caixa_aux_sis_contaspagar1_idx` (`sis_contaspagar_id`),
  INDEX `fk_mgt_caixa_aux_sis_lanc1_idx` (`sis_lanc_id`),
  
  -- Definição das chaves estrangeiras
  CONSTRAINT `fk_mgt_caixa_aux_mgt_planodecontas1`
    FOREIGN KEY (`mgt_planodecontas_id`)
    REFERENCES `erpl`.`mgt_planodecontas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

  CONSTRAINT `fk_mgt_caixa_aux_mgt_contas1`
    FOREIGN KEY (`mgt_contas_id`)
    REFERENCES `erpl`.`mgt_contas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

  CONSTRAINT `fk_mgt_caixa_aux_sis_caixa1`
    FOREIGN KEY (`sis_caixa_id`)
    REFERENCES `erpl`.`sis_caixa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

  CONSTRAINT `fk_mgt_caixa_aux_sis_contaspagar1`
    FOREIGN KEY (`sis_contaspagar_id`)
    REFERENCES `erpl`.`sis_contaspagar` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,

  CONSTRAINT `fk_mgt_caixa_aux_sis_lanc1`
    FOREIGN KEY (`sis_lanc_id`)
    REFERENCES `erpl`.`sis_lanc` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;