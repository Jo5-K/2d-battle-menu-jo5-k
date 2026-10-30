# HUD original em uma camada de overlay

Requisito confirmado pelo usuário: manter a HUD como overlay, com aparência
idêntica à original, não apenas recolocar a antiga camada no canvas da batalha.

A alpha.7 deixa de desenhar os cartões navy personalizados de nome/HP/EXP.
Durante a cena, intercepta Healthbox.draw e guarda o renderizador, battler e
opções originais. No render.hud, executa esse mesmo desenho em uma transformação
240×160 ajustada ao viewport real, antes dos comandos flutuantes.
Assim são reutilizados os próprios recursos, fontes, cores, barras, números,
estados, marcadores e animações definidos pelo perfil nativo da engine. Ruby e
Sapphire mantêm as decisões específicas de seu perfil; não se copiam texturas de
FireRed por cima deles. Não se cria um modelo paralelo de HP/EXP.

No layout padrão, as coordenadas são as nativas. Se os comandos estiverem à
direita, as caixas mudam de lado por uma translação horizontal de 114 unidades,
sem espelhar texto ou redesenhar seu conteúdo. O marcador de capturado respeita
a opção já existente do mod. Os controles animados de mochila/troca/fugir foram
preservados. Golpes continuam nas modalidades lista e cartas em camadas.

Duplas, Safari, tutorial, link e cenas sem posse da overlay mantêm a renderização
nativa completa. Ao descarregar o mod, só se restauram wrappers que ainda são
seus. A reutilização do renderizador foi verificada por testes de encaminhamento;
não houve comparação pixel a pixel em LÖVE/ROM. Fades globais, efeitos, clipping,
fontes e encaixe nos monitores reais precisam de conferência no jogo.

Os comandos também reservam o espaço vertical da caixa inimiga: mochila e seu
botão animado ficam abaixo dela, inclusive ao mudar tamanho ou proporção da janela.
