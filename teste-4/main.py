from fastapi import FastAPI, Query
import pandas as pd

app = FastAPI()

# Carregar os dados do CSV com o delimitador correto
df = pd.read_csv('assets/Relatorio_cadop.csv', delimiter=';')

@app.get("/buscar-operadoras")
async def buscar_operadoras(query: str = Query(...)):
    print(f"Buscando por: {query}")
    
    # Filtrar os dados com base na consulta
    resultado = df[df.apply(lambda row: row.astype(str).str.contains(query, case=False).any(), axis=1)]
    
    print(f"Resultados encontrados: {resultado}")
    
    # Retornar os resultados como JSON
    return resultado.to_dict(orient='records')

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)