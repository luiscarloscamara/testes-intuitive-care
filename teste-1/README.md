## Descrição
Este script em **Python** realiza o download automático dos **Anexos I e II** da página da **ANS** e os compacta em um arquivo ZIP.

## 🛠 O que o script faz?
- ✅ Acessa a página da **ANS** onde os anexos estão disponíveis;
- ✅ Extrai os links dos arquivos **Anexo I** e **Anexo II** no formato PDF;
- ✅ Baixa os arquivos para a pasta `downloads`;
- ✅ Compacta os arquivos em um único ZIP chamado `anexos.zip`;
- ✅ Exibe uma mensagem de conclusão quando o processo for finalizado.

## 🚀 Como usar?

### 1️⃣ Instale as dependências necessárias (caso ainda não tenha):
- `pip install requests beautifulsoup4` (use `pip3` se necessário, dependendo da sua versão do Python).

### 2️⃣ Execute:
- `python teste-1.py` (use `python3` se necessário, dependendo da sua versão do Python).

## ⚠️ Importante
- ⏳ O download pode demorar alguns minutos, dependendo da velocidade da sua conexão;
- ⏳ Aguarde até que a mensagem final apareça indicando que o ZIP foi gerado;
- ❌ Se houver erro, verifique sua conexão e tente novamente.
