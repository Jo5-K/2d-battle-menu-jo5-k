# Alpha.10 — HUD junto ao sprite, botões pastel e vegetação menor

## Pedido e evidência

A captura de FireRed fornecida pelo usuário mostra a HUD do aliado perto do
inimigo e a HUD inimiga presa ao canto da tela. O usuário esclareceu: a caixa
aliada deve sobrepor **um pixel**, não “uma vez”. A caixa inimiga deve ficar
acima e à esquerda, a oito pixels do sprite. Ambas as medidas são em pixels
lógicos da janela LÖVE, não em pixels do canvas GBA; em telas com DPI escalado,
não equivalem necessariamente a pixels físicos do monitor.

## Posicionamento

`gen3/anchors.lua` observa as imagens devolvidas por Ui.sidePic e o desenho real
realizado durante Ui.draw. Também reconhece frames de animação, Substitute e
fantasma nativos. Mede a caixa dos pixels com alfa acima de 2%, aplica a
transformação efetiva (posição, escala, rotação, inversão e deslocamento da cena)
e projeta para o quadro de saída. Faixas de efeitos nativos são unidas.

A medição de transparência usa um canvas temporário e uma leitura por imagem,
com cache de chaves fracas. Canvas e estado gráfico são restaurados, inclusive
quando a leitura falha. O observador temporário de draw é removido quando o
passe nativo termina ou lança erro. A lógica da batalha não é executada novamente.

A HUD continua sendo o renderer Healthbox original, com escala de 65%. Sua
textura também é medida para descontar margens transparentes. A caixa aliada
fica centralizada abaixo do sprite: topo = borda inferior do sprite − 1 pixel.
A inimiga fica totalmente acima e à esquerda: borda direita = esquerda do
sprite − 8; borda inferior = topo do sprite − 8. Não se espelha texto ou barra.
As animações próprias de entrada/visibilidade da Healthbox continuam nativas.

Nas bordas da janela, manter a HUD visível tem prioridade sobre a distância
exata. Isso é especialmente relevante para janelas pequenas ou sprites enormes.
Se não houver leitura de textura, usa-se o retângulo da imagem, incluindo suas
margens transparentes. Se não houver sprite observado, permanece o posicionamento
anterior como fallback. Não há garantia de distância exata nesses casos.

Sprites substituídos por mods são medidos quando passam pelas funções de imagem
e desenho observadas. Mods que desenham o Pokémon inteiramente fora desse
caminho, transformações de posição feitas apenas em shaders, ou combinações que
substituem o renderer inteiro ainda precisam de integração e teste próprios.
Não foi declarada compatibilidade universal com mods.

## Botões pastel

SELECT → Cores dos botões: Pastel nativo (padrão) ou Metálico.
Mochila usa azul claro inspirado na barra de XP; troca usa verde claro inspirado
no HP; fugir usa coral claro inspirado nos detalhes rosados da HUD. Os círculos
são creme e os pictogramas/textos grafite. Não há bandas espelhadas ou reflexo
móvel no modo pastel. A seleção mantém borda e pulso suave. O deck de golpes
continua navy/ciano/glass. As cores são derivadas visualmente da HUD nativa;
não há amostragem dinâmica de paletas de terceiros.

## Vegetação e movimento

SELECT → Tamanho da vegetação: Reduzido (65%, padrão), Médio (80%), Original.
A escala é uniforme. Divide-se a imagem em duas metades, presas às laterais e
à borda inferior da janela. A redução abre espaço central transparente em vez
de deformar folhas ou reduzir a área de referência da janela. Cada metade é
recortada ao seu lado para evitar sobreposição central. As imagens originais
não são alteradas.

A animação elástica usa ciclo de quatro segundos, com harmônico discreto de dois
segundos e escala aproximadamente entre 100,2% e 102,2% antes do fator de tamanho.
É mais rápida que a alpha.9, mas de baixa amplitude. Movimento da lente continua
permitindo desligar. Foi escolhida elasticidade; não foi implementado filtro CRT
ou scanlines, que afetaria outra característica visual.

## Validação e continuidade

60 execuções passaram em Lua 5.4 e LuaJIT com host/ROM/gráficos simulados:
as cinco suítes principais em cada um dos cinco jogos, mais cenários, formatos,
ultrawide, lente/paleta e âncoras. Os testes de âncoras verificam transparência,
transformações, imagens maiores de mods, espaçamento em pixels da janela,
limites e restauração do observador. A leitura gráfica nesses testes é simulada.
A prévia 32 usa o renderer de apresentação e omite a HUD nativa; não comprova
encaixe dos pés, HUD ou efeitos em gameplay.

Próximo teste real: reiniciar, conferir ambas as HUDs em FireRed, redimensionar,
trocar Pokémon, testar sprite modificado, entradas, ataques e retornos da mochila.
Observar eventuais pausas no primeiro carregamento da imagem devido à leitura
da textura. Repetir nos demais jogos. Não houve execução aqui em ROM real,
Windows ou GPU/LÖVE. Preservam-se os fallbacks de duplas/especiais/Hoenn/Sevii.

A baseline alpha.9 foi preservada antes das edições. Alpha.5 e demais baselines
continuam disponíveis. ID e caminho Windows não mudam. Fontes de consulta,
KRS original, Gen1/Gen2, outros mods e saves não são alterados.
