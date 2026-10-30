# Alpha.15 — aliado na borda inferior

Na câmera **Perspectiva nativa**, em batalhas simples, a base visível da pose estabilizada do aliado fica um pixel de janela além da borda inferior da área do jogo. Isso substitui o deslocamento fixo que deixava Rayquaza inteiro acima da borda. Ativação: SELECT → Câmera → Perspectiva nativa.

## Enquadramento

Usamos os limites de alfa medidos no desenho real, incluindo origens e escalas de mods de sprites. Após a primeira pose estabilizada de ambos os lados, o enquadramento é calculado no próximo desenho. O ponto central inferior do inimigo permanece no mesmo lugar; a cena recebe um zoom uniforme ao redor desse ponto. O tamanho aparente dos dois Pokémon pode aumentar: não há deslocamento isolado do aliado nem deformação da imagem.

Sprites, partículas, treinadores e bolas continuam na mesma transformação nativa. Não alteramos coordenadas de lógica, estado de animação, dano, input ou callbacks. Arena e sombra usam os limites reprojetados. HP mantém o posicionamento da câmera alpha.14.

O pixel é convertido pela altura da área apresentada por Display.fit, recalculada ao redimensionar. Não corresponde a um pixel GBA ampliado. A medida usa a primeira pose estabilizada; movimentos nativos durante ataques e animações continuam livres. Troca de Pokémon ou mudança de cenário reinicia a medição. Sem limites válidos, mantém-se o enquadramento anterior da alpha.14; situações degeneradas ou zoom superior a 8 não são aplicados.

A câmera Atual e a câmera de duplas permanecem como na alpha.14. O fundo continua preenchendo pela altura sem distorção. Menus fora da batalha continuam nativos. Exigência da engine: >=0.3.93, API 2.

## Verificação e limites

Testes com gráficos simulados cobrem três alturas de sprites, cinco alturas de janela, redimensionamento, área de jogo menor que a janela, estabilidade sem acumulação de zoom, preservação do apoio inimigo, ausência de medições e isolamento da câmera Atual/duplas. As regressões incluem os cinco jogos em LuaJIT e Lua 5.4.

Não houve execução real de LÖVE/GPU, Windows, ROM ou save. A compatibilidade visual com cada mod de sprite e os ataques ainda precisa ser observada no jogo. A captura enviada pelo usuário é evidência do problema anterior, não uma validação desta correção.

## Atualização

Manifesto e bootstrap: 1.2.0-alpha.15. Mantidos os baselines anteriores, incluindo alpha.5; acrescentado baseline alpha.14 e seus fontes verificados. Instalação restrita à pasta floating_glass_frlg, com backup e recusa de arquivos alterados desconhecidos. Não modifica outros mods.
