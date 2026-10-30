# Alpha.11 — paleta funcional neutra e HUD aliada dois pixels acima

Pedido de 20/10/2026. Continuação direta da alpha.10, sem alteração da lógica
nativa, posicionamento dos sprites ou saves.

## Paleta aplicada no modo Pastel neutro

| Função | Fundo | Borda interna |
| --- | --- | --- |
| Mochila | #E8C77D | #846A3B |
| Golpes | #303B50 | #171F2E |
| Trocar Pokémon | #AFC9E8 | #577AA3 |
| Ajustes | #3B4254 | #1C2231 |
| Fugir | #E7A6A0 | #9D5555 |

Base universal: contorno externo #10141D, fundos sólidos (opacidade 100%),
ícones circulares #FFF8E5, texto escuro #171F2E nos botões claros e claro nos
painéis escuros. Seleção #FFD36B, inclusive nos golpes e nas linhas de ajustes.
O botão Ajustes também recebe pictograma circular. Não há verde funcional nos
botões desta paleta, gradiente espelhado ou brilho metálico.

As cores dos tipos ficam nos indicadores dos golpes. No modo neutro, foram
removidas a coloração de toda a carta e a faixa lateral por tipo. As cartas
mantêm geometria, navegação e animação de movimento, com fundo azul-ardósia
sólido mesmo nas camadas traseiras. O controle antigo de opacidade continua
válido no modo Metálico; o modo Pastel neutro fixa a opacidade dos controles
para manter contraste em qualquer cenário. A vegetação tem opacidade separada.

A chave persistida `button_palette=pastel` é preservada; seu rótulo agora é
Pastel neutro. O modo Metálico permanece como alternativa explícita. Nenhuma
paleta nativa de HP/XP foi modificada.

## HUD aliada

O usuário pediu subir mais dois pixels a partir da alpha.10. Assim, o topo
visível passa de `borda inferior do sprite - 1` para `borda inferior - 3`:
sobreposição final de três pixels lógicos da janela. A HUD inimiga permanece
a oito pixels acima e à esquerda. Permanecem as exceções de limite da janela,
leitura de textura e renderizadores de terceiros descritas em DOCUMENTACAO/07.

## Verificação e retomada

Suítes executadas em Lua 5.4 e LuaJIT com gráficos, host e ROM simulados; veja
VALIDACAO-ALPHA11.txt e VALIDACAO.json. Prévia 33: apresentação simulada, sem HUD
nativa; não comprova alinhamento no jogo real. Verificar em FireRed após reiniciar:
posição aliada, seleção dourada, contraste em cenários claros/escuros e ajustes.
Não houve validação desta versão com ROM real, Windows ou GPU/LÖVE.

Baseline alpha.10 preservada, junto às anteriores inclusive alpha.5.
ID floating_glass_frlg e engine v0.3.91 permanecem. Outros mods e referências
não são alterados. Destino Windows continua exatamente
H:\gen1recomp-0.3.51-windows\gen1recomp-win64\mods.
