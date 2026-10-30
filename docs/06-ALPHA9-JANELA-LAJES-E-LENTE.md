# Alpha.9 — janela, lajes, primeiro plano animado e paleta dos ícones

## Evidência e correções

A captura alpha.8 fornecida pelo usuário mostra as lajes achatadas/ampliadas e
bordas do primeiro plano presas ao quadro nativo. O fundo ultrawide já aparece.
A alpha.9 trata essas camadas separadamente; não altera ROM, saves ou comandos.

### Lajes

No caminho ultrawide, as bases deixam de ser rasterizadas em 240×160. Ficam em
resolução final, atrás dos Pokémon, no mesmo passe que desenha o fundo. Usa-se a
proporção original de cada PNG, com escala uniforme, largura menor (equivalentes
a 78 unidades para inimigo e 96 para aliado) e sombra suave de contato.
Os centros, o deslocamento vertical e o deslizamento da entrada acompanham as
coordenadas projetadas da cena. A imagem da base não é esticada horizontalmente.
No caminho comum, a base ainda passa pelo canvas nativo, mas recebe compensação
da proporção de saída para não ficar achatada. HD final de todas as paisagens
continua sendo trabalho posterior. Não foram alterados os PNGs de referência.

### Primeiro plano / lente

Agora é desenhado no render.hud em resolução de janela, depois da cena e antes
da HUD/comandos. O antigo desenho dentro do canvas nativo foi removido para não
haver duplicação. A cada frame usa viewport.width/height atuais, independentemente
da proporção do quadro. Escala uniforme de cobertura, centrada horizontalmente
e ancorada na borda inferior: recorta o excesso, sem deformar o recurso.

A animação é uma senoide de oito segundos, de 100,4% a 102% da escala de cobertura.
É leve, contínua e não deixa bordas vazias. Usa o relógio de apresentação; não
avança turnos nem timers nativos. SELECT → Movimento da lente permite desligar.
A opacidade e o desligamento do primeiro plano continuam disponíveis.

### HUD e janela

HUD, comandos e seus alvos de clique usam as dimensões atuais da janela, mesmo
se o quadro da batalha estiver em 3:2, 4:3 ou 16:9. Mantém-se a escala uniforme
reduzida em 35% da alpha.8. O redimensionamento invalida alvos de mouse antigos
até o próximo desenho, evitando cliques em posições desatualizadas.

SELECT → Formato inclui Janela, além de Nativa, 4:3 e 16:9. Janela preenche a área
útil disponível sem exigir proporção fixa e é o padrão para opções não salvas.
Uma escolha antiga de formato é preservada: selecione Janela para mudá-la.
O quadro respeita SafeArea, cutout e a reserva dos controles em retrato.
O fundo e primeiro plano podem ocupar toda a janela, pois são decorativos.
Os formatos ainda projetam o canvas nativo; não foi implementada câmera 3D ou
reposicionamento individual de toda animação. Sprites nativos acompanham essa
projeção; HUD, fundo ultrawide e lajes HD usam escala uniforme.

### Ícones

Os comandos usam pictogramas vetoriais em grafite sobre creme, com contornos e
cápsulas oliva/dourado compatíveis com a HUD de HP mostrada no FireRed. Os ícones
de golpes também recebem a base creme; nomes e etiquetas continuam informando
o tipo. As imagens coloridas antigas dos botões não são usadas nessa paleta.
O movimento de brilho e a indicação de seleção continuam ativos. Os cartões de
golpes conservam navy/ciano/glass; não foram transformados em caixas GBA.

## Validação e limites

Testes cobrem a janela em paisagem, retrato, 4:3 e ultrawide; a continuidade e os
limites da animação; opção de desligar; escala uniforme das lajes; precedência de
camadas; ícones sem as texturas coloridas anteriores; posição de cliques e
invalidação ao redimensionar. O contrato Display.fit original e as suítes dos
cinco jogos continuam sendo exercitados em hosts simulados Lua 5.4/LuaJIT.
Não há nova execução com ROM, Windows, GPU/LÖVE ou combinação real de outros mods.
A prévia 31 é composição simulada e omite a HUD nativa; não é captura de gameplay.

## Roteiro no jogo

Reiniciar a engine. Em batalha de grama, usar Grama ultrawide = Tela inteira e
Cenário = Automático. Experimentar Formato = Janela e redimensionar a janela.
Conferir bordas da lente, ícones, HUD, cliques, bases sob os pés e entradas/trocas.
Comparar Movimento da lente ligado/desligado; conferir efeitos de ataques e
retorno da mochila. Testar proporções e janelas pequenas. Ajustes finais de
perspectiva/encaixe devem partir dessas imagens reais, não só dos testes.
