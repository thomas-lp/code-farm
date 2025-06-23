class_name Glossario

extends Resource

var _termos_disponiveis: Dictionary = {
	"print()": {
		"nome": "Função print()",
		"descricao": "A função print() é usada para exibir mensagens na tela (console). Ela é muito útil para mostrar resultados, textos ou acompanhar a execução do programa.",
		"exemplo": "print(\"Olá, mundo!\")",
		"missao": 1
	},
	"#": {
		"nome": "# Comentários de uma linha",
		"descricao": "Em Python, tudo que vem após o símbolo # em uma linha é ignorado pelo programa. Isso serve para deixar anotações no código, facilitando o entendimento.",
		"exemplo": "# Isso é um comentário explicativo",
		"missao": 2
	},
	"\"\"\"": {
		"nome": "\"\"\" Comentários de múltiplas linhas \"\"\"",
		"descricao": "Usa-se três aspas duplas para escrever comentários que ocupam várias linhas. Eles são úteis para explicar melhor o funcionamento do código ou escrever descrições longas.",
		"exemplo": "\"\"\"\nEste código faz parte do jogo Code Farm.\nEle ajuda a organizar e explicar o código faz.\n\"\"\"",
		"missao": 2
	},
	"Variáveis": {
		"nome": "Variáveis",
		"descricao": "Variáveis são usadas para armazenar informações. Elas recebem um nome e podem guardar textos, números, listas e outros valores que podem mudar durante a execução do programa.",
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
