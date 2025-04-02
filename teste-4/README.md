## Descrição
Este script em **SQL** realiza a criação e população do banco de dados **ANS Data**, que armazena informações sobre operadoras ativas e suas demonstrações contábeis, permitindo consultas analíticas sobre despesas com assistência à saúde.

## 🛠 O que o script faz?
- ✅ Permite que o usuário pesquise operadoras de planos de saúde por nome ou outros atributos;
- ✅ O servidor em Python processa a requisição e retorna os registros mais relevantes;
- ✅ A interface web exibe os resultados de forma intuitiva;
- ✅ Inclui uma coleção do Postman para testes das rotas da API.

## 🚀 Como usar?

### 1️⃣ Configurar o Servidor Python:
- Instale as dependências necessárias: `pip install fastapi uvicorn pandas`
- Execute o servidor: `uvicorn main:app --reload`

### 2️⃣ Executar a Interface Vue.js:
- Instale as dependências do projeto: `npm install`
- Inicie o servidor de desenvolvimento: `npm run dev`

## ⚠️ Importante
- ⚠️ Certifique-se de que os arquivos CSV estejam acessíveis e com permissão de leitura para o MySQL;
- Certifique-se de que o arquivo CSV com os dados das operadoras está localizado corretamente no diretório esperado pelo servidor.
- Verifique se as portas utilizadas pelo FastAPI e Vue.js não estão bloqueadas por firewall ou outros serviços.