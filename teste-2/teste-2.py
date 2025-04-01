import pdfplumber
import pandas as pd
import zipfile
import os
import re

# Definir caminhos
pdf_path = "../teste-1/downloads/Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf"
csv_path = "Teste_luis_carlos.csv"
zip_path = "Teste_luis_carlos.zip"

# Função para extrair legendas do rodapé
def extrair_legendas(pdf_path):
    legendas = {}
    with pdfplumber.open(pdf_path) as pdf:
        for page in pdf.pages[-3:]:  # Verificar últimas páginas
            text = page.extract_text()
            if text and "Legenda:" in text:
                lines = text.split("\n")
                legenda_texto = " ".join(lines)  # Unir todas as linhas para capturar legendas quebradas
                matches = re.findall(r"(\w{2,3}): ([^\d]+?)(?= \w{2,3}:|$)", legenda_texto)  # Captura os pares corretamente
                for chave, valor in matches:
                    legendas[chave.strip()] = valor.strip()
    return legendas

# Obter legendas dinamicamente
descricoes = extrair_legendas(pdf_path)

# Remover HSO e PAC da substituição
descricoes.pop("HSO", None)
descricoes.pop("PAC", None)

# Extrair tabelas do PDF
data = []
with pdfplumber.open(pdf_path) as pdf:
    for page in pdf.pages:
        tables = page.extract_table()
        if tables:
            for row in tables:
                data.append(row)

# Criar DataFrame
df = pd.DataFrame(data[1:], columns=data[0])  # Primeira linha como cabeçalho

# Substituir as siglas pelas descrições completas apenas nas colunas desejadas
for col in descricoes.keys():
    if col in df.columns:
        df[col] = df[col].replace(descricoes)

# Salvar CSV
df.to_csv(csv_path, index=False, encoding="utf-8")

# Compactar o CSV em um ZIP
with zipfile.ZipFile(zip_path, 'w', zipfile.ZIP_DEFLATED) as zipf:
    zipf.write(csv_path, os.path.basename(csv_path))

print(f"Processo concluído! Arquivo ZIP gerado em: {zip_path}")
