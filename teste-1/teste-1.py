import os
import requests
import zipfile
from bs4 import BeautifulSoup

# URL da página
URL = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"

# Diretório para armazenar os PDFs
download_dir = "downloads"
os.makedirs(download_dir, exist_ok=True)

# Fazendo requisição HTTP para obter o conteúdo da página
response = requests.get(URL)
response.raise_for_status()

# Usando BeautifulSoup para extrair os links dos PDFs
soup = BeautifulSoup(response.text, 'html.parser')
links = soup.find_all('a', href=True)

pdf_urls = []
for link in links:
    href = link['href']
    if "Anexo" in href and href.endswith(".pdf"):
        if href.startswith("http"):
            pdf_urls.append(href)
        else:
            pdf_urls.append(f"https://www.gov.br{href}")

# Verificando se os links foram encontrados
if not pdf_urls:
    print("Nenhum link de PDF encontrado. Verifique a estrutura da página.")
    exit()

print("Links encontrados:")
for url in pdf_urls:
    print(url)

# Baixando os arquivos PDF
def download_file(url, folder):
    filename = os.path.join(folder, url.split("/")[-1])
    response = requests.get(url, stream=True)
    response.raise_for_status()
    with open(filename, "wb") as file:
        for chunk in response.iter_content(chunk_size=8192):
            file.write(chunk)
    return filename

pdf_files = [download_file(url, download_dir) for url in pdf_urls]

# Compactando os arquivos em um único ZIP
zip_filename = "anexos.zip"
with zipfile.ZipFile(zip_filename, "w", zipfile.ZIP_DEFLATED) as zipf:
    for pdf in pdf_files:
        zipf.write(pdf, os.path.basename(pdf))

print(f"Download e compactação concluídos! Arquivo gerado: {zip_filename}")
