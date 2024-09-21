CREATE TABLE IF NOT EXISTS `erpl`.`sis_caixa`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `uuid_caixa` VARCHAR(48) NULL,
    `data` DATETIME NOT NULL,
    `historico` VARCHAR(255) NOT NULL,
    `complemento` LONGTEXT NULL,
    `entrada` DECIMAL(12, 2) NULL,
    `saida` DECIMAL(12, 2) NULL,
    `usuario` INT NOT NULL,
    PRIMARY KEY(`id`)) ENGINE = InnoDB
-- -------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpl`.`mgt_contas`(
    `id_conta` INT NOT NULL AUTO_INCREMENT,
    `descricao` VARCHAR(45) NULL,
    `data_inicial` DATETIME NULL,
    `saldo_inicial` DECIMAL(12, 2) NULL,
    `saldo` DECIMAL(12, 2) NULL,
    `forma_pagamento` VARCHAR(100) NULL,
    PRIMARY KEY(`id`)
) ENGINE = InnoDB
-- ------------------------------------------
CREATE TABLE IF NOT EXISTS `erpl`.`mgt_planodecontas`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `item` VARCHAR(10) NOT NULL,
    `descricao` VARCHAR(100) NULL,
    `pai` INT NULL,
    PRIMARY KEY(`id`)
) ENGINE = InnoDB
-- ------------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpl`.`mgt_caixa_aux`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `mgt_planodecontas_id` INT NOT NULL,
    `mgt_contas_id` INT NOT NULL,
    `sis_caixa_id` INT NOT NULL,
    `sis_contaspagar_id` INT NOT NULL,
    `sis_lanc_id` INT NOT NULL,
    PRIMARY KEY(`id`),
    INDEX `fk_mgt_caixa_aux_mgt_planodecontas1_idx`(`mgt_planodecontas_id` ASC) VISIBLE,
    INDEX `fk_mgt_caixa_aux_mgt_contas1_idx`(`mgt_contas_id` ASC) VISIBLE,
    INDEX `fk_mgt_caixa_aux_sis_caixa1_idx`(`sis_caixa_id` ASC) VISIBLE,
    INDEX `fk_mgt_caixa_aux_sis_contaspagar1_idx`(`sis_contaspagar_id` ASC) VISIBLE,
    INDEX `fk_mgt_caixa_aux_sis_lanc1_idx`(`sis_lanc_id` ASC) VISIBLE,
    CONSTRAINT `fk_mgt_caixa_aux_mgt_planodecontas1` FOREIGN KEY(`mgt_planodecontas_id`) REFERENCES `erpl`.`mgt_planodecontas`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_mgt_caixa_aux_mgt_contas1` FOREIGN KEY(`mgt_contas_id`) REFERENCES `erpl`.`mgt_contas`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_mgt_caixa_aux_sis_caixa1` FOREIGN KEY(`sis_caixa_id`) REFERENCES `erpl`.`sis_caixa`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_mgt_caixa_aux_sis_contaspagar1` FOREIGN KEY(`sis_contaspagar_id`) REFERENCES `erpl`.`sis_contaspagar`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_mgt_caixa_aux_sis_lanc1` FOREIGN KEY(`sis_lanc_id`) REFERENCES `erpl`.`sis_lanc`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB
-- ------------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpl`.`sis_contaspagar`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `uuid_contaspagar` VARCHAR(48) NULL,
    `vencimento` DATETIME NULL,
    `valor` DECIMAL(12, 2) NULL,
    `valor_pago` DECIMAL(12, 2) NULL,
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
    PRIMARY KEY(`id`),
    INDEX `fk_sis_contaspagar_sis_fornecedor1_idx`(`fornecedor_id` ASC) VISIBLE,
    INDEX `fk_sis_contaspagar_mgt_compra1_idx`(`compra_id` ASC) VISIBLE,
    CONSTRAINT `fk_sis_contaspagar_mgt_compra1` FOREIGN KEY(`compra_id`) REFERENCES `erpl`.`mgt_compra`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB
-- ------------------------------------------------------
CREATE TABLE IF NOT EXISTS `erpl`.`mgt_compra`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `uuid_compra` VARCHAR(48) NULL,
    `data` DATE NULL,
    `cfop` VARCHAR(45) NULL,
    `valor_total` FLOAT(12, 2) NULL,
    `parcelas` INT NULL,
    `nota_fiscal` VARCHAR(45) NULL,
    `fornecedor_id` INT NOT NULL,
    `excluido` TINYINT NOT NULL DEFAULT 0,
    PRIMARY KEY(`id`),
) ENGINE = InnoDB
-- --------------------------------------------
CREATE TABLE IF NOT EXISTS `erpl`.`mgt_compradetalhe`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `uuid_compradetalhe` VARCHAR(48) NULL,
    `unidade` VARCHAR(45) NULL,
    `qtd` INT NULL,
    `valor_unitario` DECIMAL(12, 2) NULL,
    `valor_total` DECIMAL(12, 2) NULL,
    `planodecontas` INT NULL,
    `compra_id` INT NOT NULL,
    `produto_id` INT NOT NULL,
    PRIMARY KEY(`id`),
    CONSTRAINT `fk_mgt_comprasdetalhes_mgt_compras` FOREIGN KEY(`compra_id`) REFERENCES `erpl`.`mgt_compra`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
) ENGINE = InnoDB
