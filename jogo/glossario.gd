class_name Glossario

extends Resource

var _termos_disponiveis: Dictionary = {
	"print()": {
		"nome": "Função print()",
		"descricao": "Exibe uma mensagem no console.",
		"exemplo": "print(\"Olá, mundo!\")",
		"missao": 1
	},
	"A": {
		"nome": "A",
		"descricao": "Aaaa.",
		"exemplo": "Aaaa",
		"missao": 1
	},
	"AA": {
		"nome": "AA",
		"descricao": "Aaaa.",
		"exemplo": "Aaaa",
		"missao": 1
	},
	"AAA": {
		"nome": "AA",
		"descricao": "Aaaa.",
		"exemplo": "Aaaa",
		"missao": 1
	},
	"B": {
		"nome": "B",
		"descricao": "Bbbb.",
		"exemplo": "Bbbb",
		"missao": 1
	},
	"C": {
		"nome": "C",
		"descricao": "Cccc.",
		"exemplo": "Cccc",
		"missao": 1
	},
	"#": {
		"nome": "Comentário #",
		"descricao": "Indica um comentário em Python.",
		"exemplo": "# Isso é um comentário",
		"missao": 2
	},
	"Variáveis": {
		"nome": "Variáveis",
		"descricao": "Variáveis armazenam valores de diferentes tipos.",
		"exemplo": "copo = \"água\"",
		"missao": 3
	},
}

func _obter_termos_aprendidos() -> Dictionary:
	var aprendidos := {}
	for termo in _termos_disponiveis:
		var dados = _termos_disponiveis[termo]
		if dados.get("missao") <= Global.missao_atual:
			aprendidos[termo] = dados
	return aprendidos

func obter_lista_termos_aprendidos() -> Array:
	return _obter_termos_aprendidos().keys()

func obter_dados_termo(termo: String) -> Dictionary:
	return _obter_termos_aprendidos()[termo]

func possui_termo(termo: String) -> bool:
	return _obter_termos_aprendidos().has(termo)
