## Descrição
Este script em **SQL** realiza a criação e população do banco de dados **ANS Data**, que armazena informações sobre operadoras ativas e suas demonstrações contábeis, permitindo consultas analíticas sobre despesas com assistência à saúde.

## 🛠 O que o script faz?
- ✅ Cria o banco de dados **ans_data**;
- ✅ Cria a tabela operadoras_ativas com informações sobre operadoras registradas na ANS;
- ✅ Cria a tabela demonstracoes_contabeis para armazenar os dados financeiros das operadoras;
- ✅ Importa os dados de operadoras ativas a partir de um arquivo CSV;
- ✅ Importa os dados financeiros trimestrais de demonstrações contábeis (de 2023 e 2024);
- ✅ Executa consultas SQL para identificar operadoras com maiores despesas em eventos/sinistros conhecidos ou avisados;
- ✅ Permite análises financeiras ao longo dos trimestres e anos.

## 🚀 Como usar?

### 1️⃣ Configurar permissões no MySQL:
- Certifique-se de que o MySQL está configurado para permitir LOAD DATA INFILE.
- Execute no MySQL: `SET GLOBAL local_infile = 1;`
- Inicie a conexão com a opção de carregamento local habilitada: `mysql --local-infile=1 -u root -p`

### 2️⃣ Execute:
- No terminal do MySQL, rode o comando: `SOURCE {caminho_do_script}/teste-3.sql;`

### 3️⃣ Pré-requisito:
- Os arquivos CSV contendo os dados precisam estar na pasta assets/ dentro do diretório de trabalho do MySQL.

## ⚠️ Importante
- ⚠️ Certifique-se de que os arquivos CSV estejam acessíveis e com permissão de leitura para o MySQL;
- ❌ Se houver erro de permissão, tente rodar: `sudo chmod 644 assets/*.csv`
- ❌ Se o erro persistir, verifique se o MySQL possui acesso ao diretório assets/ e, se necessário, ajuste as permissões: `sudo chmod -R 755 /{caminho_para_pasta_assets}`
- Script desenvolvido em MySQL 8.