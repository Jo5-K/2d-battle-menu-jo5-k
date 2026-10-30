# Alpha.8 — formato, HUD, posição dos Pokémon e grama ultrawide

## O que mudou

Em SELECT, Formato oferece Nativa (3:2), 4:3 e 16:9. A opção altera o quadro da
batalha e seus alvos de mouse juntos, sem mudar Display.W/H, dados da ROM ou a
configuração global da engine. A opção também aparece na página gráfica Options
e no gerenciador nativo. Nativa permanece como padrão para preservar preferências.

A HUD original continua em overlay, agora com escala uniforme de 65%: redução
exata de 35% em largura e altura na apresentação nativa, ancorada nos centros
originais das caixas. Não há esticamento das fontes/barras da HUD nos novos formatos.

Os Pokémon e a cena de efeitos descem oito unidades do plano 240×160 (5% da
altura nativa). As duas bases acompanham o deslocamento. SELECT também permite
12 ou zero. Apenas a transformação gráfica entre beginParticleFrame e a primeira
Healthbox.draw é deslocada; as coordenadas e o estado dos battlers não são escritos.
Treinadores, partículas e bolas desenhados nessa faixa acompanham os Pokémon.
O deslocamento atua nas paisagens customizadas; ao retornar ao cenário nativo,
o enquadramento nativo completo é preservado. A pilha gráfica é restaurada em erro.

## Fundo ultrawide real

Foi localizado o arquivo atualizado de APrendizado/backgrounds_gen3_1152x648/
01_grama.png: 2172×724, proporção 3:1, apesar do nome histórico da pasta.
Uma cópia independente está em assets/scenery/ultrawide/grass.png; o antigo
assets/scenery/backgrounds/01_grama.png permanece disponível.

Grama ultrawide = Tela inteira é o padrão. Nas batalhas simples de grama com
Cenário = Automático, esse fundo é desenhado atrás da cena, na resolução final
da janela. Sua escala é altura_da_janela / 724, aplicada igualmente a X e Y.
A largura não é forçada ao monitor. O desenho fica centralizado, com recorte
nas bordas da janela. Exemplo em 1920×1080: largura projetada 3240, x=-660.
Não há rolagem, hitboxes fora da tela, alteração da lógica ou deformação do fundo.
Se a janela for mais larga que 3:1, essa regra pode deixar margens laterais;
a imagem não é esticada para escondê-las.

Apenas o fundo antigo fica transparente no canvas de apresentação. As bases,
Pokémon, animações, efeitos e comandos continuam em suas camadas. O arquivo
nativo não é substituído. O desenho ultrawide ocorre antes do blit do canvas,
portanto não cobre os Pokémon. Desligar Grama ultrawide restaura o fundo comum.
Cavernas, outros terrenos, duplas e cenas especiais não recebem grama por engano.
Primeiro plano continua no plano da batalha e tem controle independente.

## Contratos da engine

Gen1Recomp v0.3.91 / commit 3806bf3df53f650e235b09f8d76feb731c30a076.
O caminho normal usa Renderer.blitCanvas; Display.fit sozinho mudaria a HUD,
mas deixaria a imagem no quadro antigo. framing.lua adapta os dois contratos,
incluindo clip e zonas de paleta, mantendo a rotina original de blit.
O caminho alternativo Display.present também é coberto quando planesBroken é
verdadeiro, reutilizando o canvas pronto sem executar a batalha outra vez.
SafeArea, cutout e o espaço reservado aos controles em retrato são respeitados
pelo quadro da batalha. O fundo ultrawide pode preencher a janela inteira,
pois é decorativo e não recebe input.

Os formatos 4:3 e 16:9 reajustam a projeção do canvas nativo; não constituem uma
câmera nova. Sprites, bases e efeitos acompanham essa projeção e podem mudar de
proporção. O fundo ultrawide e a HUD mantêm escala uniforme. Uma câmera com
reposicionamento individual de todos os efeitos é trabalho posterior, não uma
capacidade declarada desta versão.

## Verificação e limites

A captura enviada pelo usuário confirma a apresentação alpha.7 no FireRed em
quadro nativo. Não é prova de execução da alpha.8. Testes verificam o contrato
Display.fit original, o blit principal e o caminho alternativo simulados,
proporções, margens, clipping, alvos de mouse, escala da HUD, deslocamento e sua
restauração, recursos reais e retorno ao cenário original.
Nenhum teste equivale a execução real em ROM/Windows/LÖVE/GPU.

Depois de reiniciar, abrir SELECT e experimentar Formato, Pokémon mais baixos
e Grama ultrawide. Conferir entradas, golpes com efeitos de tela, captura,
desmaio, troca, retorno de mochila e mudança do tamanho da janela. Conferir
outros mods de shaders, câmera e composição, pois também podem possuir o blit.
