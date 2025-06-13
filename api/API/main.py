#Estrutura do projeto
#
# API
# |__analisador
#     |__base.py
#     |__missao1.py
# |__testes
#     |__missao1.py
# |__main.py
# |__modelos.py
# |__roteador.py

#venv\Scripts\activate
#cd API
#uvicorn main:app --reload

#main.py

from fastapi import FastAPI
from modelos import RequisicaoCodigo
from roteador import obter_analisador

app = FastAPI()

@app.post("/analisar_codigo")
def endpoint_analisar_codigo(requisicao: RequisicaoCodigo):
    try:
        analisador = obter_analisador(requisicao.id_missao, requisicao.codigo)
        return analisador.analisar()
    except ValueError as e:
        return {
            "status": "erro_desconhecido",
            "mensagens": [str(e)],
            "dados": {}
        }
