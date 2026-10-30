# Alpha.13.2 — arenas da clareira para comparação

Adicionada a imagem fornecida “Clareira Florestal em Pixel Art arena 2 circulos.png” (1983×793 RGBA, transparência preservada), sem edição dos pixels, em assets/scenery/camera21x9/forest_arenas.png.

A camada aparece somente quando o fundo selecionado é a clareira florestal (seleção automática de grama ou manual). Desenhada após o fundo e antes do canvas dos Pokémon, é centralizada e escalada uniformemente pela altura da janela. A largura excedente pode ser cortada, como no fundo. O arquivo tem proporção diferente do fundo: não é esticado para forçar encaixe.

Teste visual solicitado pelo usuário: as posições atuais dos sprites e HUDs não foram deslocadas para o centro dos círculos. Esta etapa permite comparar onde estão e decidir o posicionamento. Não representa alinhamento final dos Pokémon. Arenas antigas e arenas de outros cenários continuam desativadas; sombras não implementadas. Mod independente, requisito >=0.3.93, API 2, sem mudanças na lógica nativa.

Validação: composição e escala em gráficos simulados; sem execução de ROM/GPU. Reiniciar a engine após instalar e abrir batalha na clareira. A prévia 34 é montagem do renderizador com sprites simulados, não captura do jogo.
