#modelos.py

from pydantic import BaseModel
from typing import List, Dict, Any

class RequisicaoCodigo(BaseModel):
    codigo: str
    id_missao: int

class ResultadoAnalise(BaseModel):
    status: str
    mensagens: List[str]
    dados: Dict[str, Any] = {}
