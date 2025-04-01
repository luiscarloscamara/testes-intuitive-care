## Descrição
Este script em **Python** realiza a extração e transformação dos dados do **Anexo I da ANS**. Ele extrai as tabelas do PDF, substitui as abreviações de algumas colunas pelas descrições completas, e salva o resultado em um arquivo CSV compactado em ZIP.

## 🛠 O que o script faz?
- ✅ Extrai automaticamente a legenda do rodapé do Anexo I do PDF da ANS;
- ✅ Substitui as abreviações das colunas OD e AMB pelas descrições completas;
- ✅ Extrai todas as tabelas do PDF;
- ✅ Salva os dados extraídos em um arquivo CSV;
- ✅ Compacta o arquivo CSV em um arquivo ZIP chamado Teste_luis_carlos.zip;
- ✅ Exibe uma mensagem de conclusão quando o processo for finalizado.

## 🚀 Como usar?

### 1️⃣ Instale as dependências necessárias (caso ainda não tenha):
- `pip install pdfplumber pandas` (use `pip3` se necessário, dependendo da sua versão do Python).

### 2️⃣ Execute:
- `python teste-2.py` (use `python3` se necessário, dependendo da sua versão do Python).

### 3️⃣ Pré-requisito:
- Para funcionar corretamente, o **teste-1.py deve ser executado primeiro**, para garantir que o Anexo I seja baixado e esteja disponível na pasta teste-1/downloads.

## ⚠️ Importante
- ⏳ O processo de extração e transformação pode levar algum tempo, dependendo do tamanho do PDF e da velocidade do seu computador;
- ⏳ Aguarde até que a mensagem final apareça indicando que o ZIP foi gerado;
- ❌ Se houver erro, verifique a pasta teste-1/downloads para garantir que o arquivo do Anexo I esteja presente.