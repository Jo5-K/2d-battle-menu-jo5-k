# Alpha.16 — âncora independente do aliado

## Correção

A captura do usuário confirmou que a alpha.15 estava visualmente incorreta: o zoom calculado pela distância entre os Pokémon ampliava o adversário e arrastava o aliado para a esquerda. Esse cálculo foi removido. A alpha.15 não deve ser usada como referência visual aprovada.

Em **SELECT → Câmera → Perspectiva nativa**, nas batalhas simples, o aliado é deslocado individualmente: centro horizontal da área visível em 35% da largura da área do jogo, conforme o conceito `detalhe tela nativa camera nova/batalha unica.png`, e base visível a um pixel de janela além da borda inferior. A escala da cena é fixa em 1.05, como na alpha.14; não muda com a espécie, dimensões da textura ou distância até o inimigo. Escalas aplicadas por outros mods continuam respeitadas. O tamanho do inimigo deixa de ser ampliado pelo cálculo da alpha.15.

A câmera Atual, duplas, fundo ajustado pela altura e HUD não mudam nesta correção. Menus fora de batalha continuam nativos.

## Desenho, arena e sombras

Os limites transparentes e a origem real do sprite são medidos antes do deslocamento, através dos desenhadores já instalados. O observador mantém a medida da primeira pose estabilizada e aplica somente uma translação ao desenho do aliado. Não reescreve os limites medidos nem amplia o sprite. A distância de um pixel é convertida pela altura de `Display.fit`; redimensionamento e área de jogo menor que a janela são considerados.

Arena e sombra consultam os limites visuais já deslocados. Animações nativas continuam relativas à âncora; o corpo não é preso à borda durante um movimento de ataque. Trocar Pokémon descarta imediatamente a âncora antiga. Se não houver medição estável ou altura válida, usa-se a posição anterior até conseguir medi-las.

## Efeitos nativos

A ponte de apresentação de `anim_coords.coords` retorna uma cópia das coordenadas do aliado com a mesma translação. Isso mantém os pontos de origem/destino de partículas que usam o serviço nativo coerentes com o desenho. Tabelas nativas, objetos de apresentação da animação, overrides da VM e estado dos Pokémon não são alterados. Retornos de inimigos, duplas, overlay inativa e câmera Atual são delegados sem alteração.

O passe de partículas é marcado para que ecos que reutilizem a imagem do Pokémon não recebam o deslocamento duas vezes nem sejam confundidos com a medição do corpo. A posição retornada para o efeito de subida de nível também recebe a translação do aliado. Não há novo relógio de animação, simulação de ataque, input ou transação de jogo.

## Validação e pendências

`tests/foreground.lua`: 325 verificações com três tamanhos/origens de texturas, cinco alturas de janela, largura/altura dos dois sprites, âncora horizontal, base inferior, estabilidade, animação relativa, redimensionamento, área segura, alinhamento de arena/sombra, erros e restauração do desenhador. A fixture `AnimCoords-0.3.93.lua` é cópia exata da engine v0.3.93, commit ee7d657e1b242e15f723839cf8c7d3bd49e69499; verifica cópias e preservação dos overrides nativos.

O teste principal executa o passe de UI com o observador real do mod e confere posição, tamanho, ausência de zoom e preservação do inimigo. São 337 verificações por jogo. As regressões rodam em LuaJIT e Lua 5.4 para FireRed, LeafGreen, Ruby, Sapphire e Emerald; ver VALIDACAO-ALPHA16.txt.

Essas são verificações com gráficos/dados simulados. Não houve execução real de LÖVE/GPU, Windows ou ROM/save. O desenho final com G9 Battle Sprites, Gen3 HD Sprites e outros mods, animações de entrada, ataques com coordenadas próprias ou efeitos que ignorem o serviço nativo ainda precisa ser observado no jogo. A escala visual exata não é declarada aprovada apenas pelos testes.

## Instalação

Versão 1.2.0-alpha.16, requisito >=0.3.93, API 2. Baselines alpha.5 e demais anteriores mantidos; acrescentado alpha.15 com seus fontes verificados. Backup e substituição limitados ao próprio floating_glass_frlg. Não altera outros mods, engine, Gen1, Gen2 ou REFERENCIAS.
