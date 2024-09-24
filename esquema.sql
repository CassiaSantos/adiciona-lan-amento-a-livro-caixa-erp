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
  INDEX `fk_sis_contaspagar_sis_fornecedor1_idx` (`fornecedor_id` ASC) VISIBLE,
  INDEX `fk_sis_contaspagar_mgt_compra1_idx` (`compra_id` ASC) VISIBLE,
  CONSTRAINT `fk_sis_contaspagar_sis_fornecedor1`
    FOREIGN KEY (`fornecedor_id`)
    REFERENCES `erpl`.`sis_fornecedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sis_contaspagar_mgt_compra1`
    FOREIGN KEY (`compra_id`)
    REFERENCES `erpl`.`mgt_compra` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

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
  INDEX `fk_mgt_caixa_aux_mgt_planodecontas1_idx` (`mgt_planodecontas_id` ASC) VISIBLE,
  INDEX `fk_mgt_caixa_aux_mgt_contas1_idx` (`mgt_contas_id` ASC) VISIBLE,
  INDEX `fk_mgt_caixa_aux_sis_caixa1_idx` (`sis_caixa_id` ASC) VISIBLE,
  INDEX `fk_mgt_caixa_aux_sis_contaspagar1_idx` (`sis_contaspagar_id` ASC) VISIBLE,
  INDEX `fk_mgt_caixa_aux_sis_lanc1_idx` (`sis_lanc_id` ASC) VISIBLE,
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
    ON UPDATE NO ACTION)
ENGINE = InnoDB