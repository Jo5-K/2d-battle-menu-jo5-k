# Alpha.13.4 — interfaces fora da batalha desativadas

Por solicitação do usuário, o bootstrap deixou de carregar/instalar Journal HD, Options HD e a ponte de skins de menus. Título, seleção de save, Start, equipe, resumo, mochila, Pokédex, treinador, salvar, PC/boxes, mapa e gerenciador usam a apresentação nativa. As fontes/recursos anteriores foram preservados para retomada futura, sem ativação nesta versão.

A interface flutuante de batalha, HUD, cenários, arenas da clareira, lente e ajustes por SELECT continuam ativos. Ao entrar em mochila/equipe através da batalha, essas telas também usam o caminho nativo. As opções do mod ainda existem no gerenciador nativo; o mod não injeta sua antiga tela de Options. Input, callbacks e transações permanecem nativos. Reiniciar a engine é necessário para remover hooks da versão anterior já carregados.

Versão mínima >=0.3.93, API 2, ID independente floating_glass_frlg. Baseline alpha.13.3 adicionada; alpha.5 preservada. Não altera KRS, outros mods, Gen1/Gen2 ou saves. Testes de integração usam host/gráficos simulados; não representam execução real de ROM/GPU/Windows. Os testes isolados de Journal/Options existentes passam a ser testes do código arquivado, não de recursos ativos.
