#Estrutura do projeto
#
# API
# |__ analisador
#     |__ __init__.py
#     |__ base.py
#     |__ missao1.py
#     |__ missao2.py
#     |__ ...
# |__ testes
#     |__ test_missao1.py
#     |__ test_missao2.py
#     |__ ...
# |__ main.py
# |__ modelos.py
# |__ roteador.py

#cd api
#venv\Scripts\activate
#cd API
#uvicorn main:app --reload

#main.py

from fastapi import FastAPI
from modelos import RequisicaoCodigo
from roteador import obter_analisador
import analisador

app = FastAPI()

@app.post("/analisar_codigo")
def endpoint_analisar_codigo(requisicao: RequisicaoCodigo):
    try:
        analisador = obter_analisador(requisicao.id_missao, requisicao.codigo, requisicao.contexto)
        return analisador.analisar()
    except ValueError as e:
        return {
            "status": "erro_desconhecido",
            "mensagens": [str(e)],
            "dados": {}
        }
