extends RoteiroMissao

func executar() -> void:
	await dialogo("Nossa! Olha só essa bagunça na cozinha... tem copos espalhados por toda parte!")
	await dialogo("Que tal organizarmos isso? Mas antes, deixa eu te explicar uma coisa: na programação, usamos algo chamado variáveis para armazenar informações.")
	await dialogo("Uma variável é como um copo: ela tem um nome e pode conter algo dentro. Por exemplo:")
	await codigo("copo = \"suco\"")
	await dialogo("Aqui, temos uma variável chamada copo, e ela está armazenando o valor 'suco'. Mas olha só, se eu quiser trocar o que tem dentro do copo, basta fazer assim:")
	await codigo("copo = \"água\"")
	await dialogo("Agora, o copo contém água! Isso mostra que variáveis podem mudar de valor ao longo do tempo.")
	await dialogo("Agora é sua vez! Pegue um dos copos sujos na cozinha e atribua um valor a ele!")

	var sucesso = false
	while not sucesso:
		var resultado = await obter_codigo_analisado()
		
		if resultado.status == ResultadoAPI.Status.SUCESSO:
			await dialogo("Muito bem! Agora o seu copo possui um contudo, assim como uma variável pode conter!")
			sucesso = true
		else: 
			if resultado.status == ResultadoAPI.Status.ERRO_SINTATICO:
				await dialogo("Ops, parece que ocorreu um erro sintático: " + resultado.mensagem_erro)
			elif resultado.status == ResultadoAPI.Status.ERRO_SEMANTICO:
				await dialogo("Eita! Notei um erro semântico: " + resultado.mensagem_erro)
			else:
				await dialogo("Hmm... algo deu errado. Tente novamente!")

	concluir_missao()
