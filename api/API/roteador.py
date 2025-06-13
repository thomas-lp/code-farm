#roteador

from analisador.missao1 import AnalisadorMissao1
from analisador.missao4 import AnalisadorMissao4

def obter_analisador(id_missao: int, codigo: str):
    if id_missao == 1:
        return AnalisadorMissao1(codigo)
    elif id_missao == 4:
        return AnalisadorMissao4(codigo)
    else:
        raise ValueError(f"Missão {id_missao} não implementada.")

