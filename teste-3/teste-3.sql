-- Criar banco de dados
CREATE DATABASE IF NOT EXISTS ans_data;
USE ans_data;

-- Criar tabela para Operadoras Ativas
CREATE TABLE IF NOT EXISTS operadoras_ativas (
    registro_ans INT PRIMARY KEY,
    data_registro DATE,
    cd_conta_contabil VARCHAR(20),
    descricao VARCHAR(255),
    vl_saldo_inicial DECIMAL(15,2),
    vl_saldo_final DECIMAL(15,2)
);

-- Criar tabela para Demonstrações Contábeis
CREATE TABLE IF NOT EXISTS demonstracoes_contabeis (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registro_ans INT NOT NULL,
    data_registro DATE NOT NULL,
    cd_conta_contabil VARCHAR(20),
    descricao VARCHAR(255),
    vl_saldo_inicial DECIMAL(15,2) DEFAULT 0,
    vl_saldo_final DECIMAL(15,2) DEFAULT 0,
    FOREIGN KEY (registro_ans) REFERENCES operadoras_ativas(registro_ans)
);

-- Habilitar carregamento local
SET GLOBAL local_infile = 1;

-- Carregar dados para Operadoras Ativas
LOAD DATA LOCAL INFILE 'assets/Relatorio_cadop.csv'
INTO TABLE operadoras_ativas
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data_registro, @registro_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET 
    data_registro = STR_TO_DATE(@data_registro, '%Y-%m-%d'),
    registro_ans = @registro_ans,
    cd_conta_contabil = @cd_conta_contabil,
    descricao = @descricao,
    vl_saldo_inicial = IF(@vl_saldo_inicial = '', 0, CAST(@vl_saldo_inicial AS DECIMAL(15,2))),
    vl_saldo_final = IF(@vl_saldo_final = '', 0, CAST(@vl_saldo_final AS DECIMAL(15,2)));

-- Carregar dados para Demonstrações Contábeis
SET @arquivos = '1T2023.csv,2T2023.csv,3T2023.csv,4T2023.csv,1T2024.csv,2T2024.csv,3T2024.csv,4T2024.csv';
SET @arquivo_atual = '';

-- Loop para importar todos os arquivos
DELIMITER $$
CREATE PROCEDURE importar_dados()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE arquivo VARCHAR(255);
    DECLARE cur CURSOR FOR SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(@arquivos, ',', numbers.n), ',', -1) FROM
        (SELECT 1 n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8) numbers;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO arquivo;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        SET @sql = CONCAT(
            "LOAD DATA LOCAL INFILE 'assets/", arquivo, "' INTO TABLE demonstracoes_contabeis ",
            "FIELDS TERMINATED BY ';' ENCLOSED BY '""' LINES TERMINATED BY '\n' IGNORE 1 ROWS ",
            "(@data_registro, @registro_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final) ",
            "SET data_registro = STR_TO_DATE(@data_registro, '%Y-%m-%d'), ",
            "registro_ans = @registro_ans, cd_conta_contabil = @cd_conta_contabil, descricao = @descricao, ",
            "vl_saldo_inicial = IF(@vl_saldo_inicial = '', 0, CAST(@vl_saldo_inicial AS DECIMAL(15,2))), ",
            "vl_saldo_final = IF(@vl_saldo_final = '', 0, CAST(@vl_saldo_final AS DECIMAL(15,2)))"
        );
        
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END LOOP;
    
    CLOSE cur;
END $$
DELIMITER ;

CALL importar_dados();

-- Query para encontrar as 10 operadoras com maiores despesas no último trimestre
SELECT registro_ans, SUM(vl_saldo_final) AS total_despesa
FROM demonstracoes_contabeis
WHERE descricao LIKE 'EVENTOS/ SINISTROS%'
AND YEAR(data_registro) = YEAR(CURDATE())
AND QUARTER(data_registro) = QUARTER(CURDATE())
GROUP BY registro_ans
ORDER BY total_despesa DESC
LIMIT 10;

-- Query para encontrar as 10 operadoras com maiores despesas no último ano
SELECT registro_ans, SUM(vl_saldo_final) AS total_despesa
FROM demonstracoes_contabeis
WHERE descricao LIKE 'EVENTOS/ SINISTROS%'
AND YEAR(data_registro) = YEAR(CURDATE())
GROUP BY registro_ans
ORDER BY total_despesa DESC
LIMIT 10;