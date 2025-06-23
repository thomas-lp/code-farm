#missao2.py

import ast
from .base import AnalisadorMissao
from roteador import registrar_missao

@registrar_missao(2)
class AnalisadorMissao2(AnalisadorMissao):
    def analisar_semantica(self) -> dict:
        etapa = self.contexto.get("etapa", "parte1")
        if etapa == "parte1":
            return self._analisar_parte1()
        elif etapa == "parte2":
            return self._analisar_parte2()
        else:
            return {
                "status": "erro_desconhecido",
                "mensagens": [f"Etapa desconhecida: {etapa}. Por favor, contate um desenvolvedor para solucionar o problema."],
                "dados": {}
            }

    def _analisar_parte1(self) -> dict:
        # Verifica comentários de uma linha com #
        linhas = self.codigo.splitlines()
        comentarios = [linha.strip() for linha in linhas if linha.strip().startswith("#")]

        if len(comentarios) >= 3:
            return {
                "status": "sucesso",
                "mensagens": ["Ótimo! Você escreveu comentários de uma linha corretamente."],
                "dados": {
                    "comentarios": comentarios
                }
            }
        else:
            return {
                "status": "erro_semantico",
                "mensagens": [
                    f"Você escreveu apenas {len(comentarios)} comentário(s). Escreva pelo menos 3 usando # no início de cada linha."
                ],
                "dados": {
                    "quantidade_comentarios": len(comentarios)
                }
            }

    def _analisar_parte2(self) -> dict:
        # Procura por comentários de múltiplas linhas usando ast.Expr com ast.Constant do tipo str
        comentarios_multilinha = []

        for node in ast.walk(self.tree):
            if isinstance(node, ast.Expr) and isinstance(node.value, ast.Constant):
                if isinstance(node.value.value, str):
                    # Pode ser um docstring ou comentário de múltiplas linhas
                    comentario = node.value.value.strip()
                    if "\n" in comentario or len(comentario.split()) > 5:
                        comentarios_multilinha.append(comentario)

        if comentarios_multilinha:
            return {
                "status": "sucesso",
                "mensagens": ["Excelente! Você usou um comentário de múltiplas linhas com aspas triplas."],
                "dados": {
                    "comentarios_multilinha": comentarios_multilinha
                }
            }
        else:
            return {
                "status": "erro_semantico",
                "mensagens": ["Tente usar um comentário de múltiplas linhas com aspas triplas (\"\"\" seu texto \"\"\")."],
                "dados": {}
            }
