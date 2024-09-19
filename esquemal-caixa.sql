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

-- ---------------------------------------------------------------------
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