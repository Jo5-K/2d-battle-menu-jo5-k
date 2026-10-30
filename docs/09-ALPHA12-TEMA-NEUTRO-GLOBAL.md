# Alpha.12 — tema neutro em toda a apresentação própria do mod

## Escopo aplicado

O tema solicitado na alpha.11 foi estendido aos componentes que desenham as
telas próprias. `gen3/theme.lua` centraliza cores, funções dos botões e painéis.
Bootstrap fornece o tema a Journal, Options, ponte nativa e batalha.

| Superfície | Aplicação |
| --- | --- |
| Título e galeria de saves | Painéis neutros, texto marfim, seleção dourada; arte de título e miniaturas preservadas |
| Menu principal | Cartões sólidos; mochila dourada, equipe azul-claro, opções cinza-azulado, saída coral; pictogramas em círculos marfim |
| Equipe, resumo, atributos e golpes | Painéis azul-ardósia e seleção dourada; sprites, HP, XP e dados nativos preservados |
| Mochila e ações de itens | Listas neutras, botões de bolsos dourados, ícones de itens preservados |
| Pokédex e mapas HD existentes | Painéis, abas e marcadores de seleção padronizados; mapas e imagens mantidos |
| Treinador, salvar, PC e boxes | Painéis e ações padronizados; transações continuam nativas |
| Gerenciador e ponte genérica | Molduras, texto e seleção no tema neutro; recursos externos capturados mantidos |
| Options | Tema próprio substituído pelo tema central: painéis sólidos, seleção/scroll dourados, texto marfim |
| Mensagens e ajustes da batalha | Painéis neutros sólidos; controles da alpha.11 usam a paleta central |
| Molduras nativas já interceptadas | Fundo neutro e contorno escuro, seleção dourada; não se convertem telas inteiras em HD |

## Paleta e componentes

- Mochila: #E8C77D / #846A3B.
- Equipe/troca: #AFC9E8 / #577AA3.
- Golpes e painéis de conteúdo: #303B50 / #171F2E.
- Ajustes: #3B4254 / #1C2231.
- Fechar, voltar e cancelar: #E7A6A0 / #9D5555.
- Contorno externo #10141D, ícones/texto claro #FFF8E5, seleção #FFD36B.
- Texto secundário #C2C9D5; texto sobre botões claros #171F2E.

Painéis e botões são sólidos. Cartões do menu principal conservam suas posições
e áreas clicáveis, mas as imagens de fundo usadas como botões foram substituídas
por pictogramas vetoriais em círculos marfim. As imagens originais continuam no
pacote, sem edição. Retratos, Pokémon, itens, mapas e miniaturas são conteúdo e
não recebem uma recoloração global. Escurecimento atrás de modais é mantido;
não equivale a transparência do controle em primeiro plano.

HP, XP, status e informações semânticas conservam suas cores. Indicadores de
tipo não determinam a cor funcional dos botões. Não há verde funcional novo.
A opção Metálico da batalha continua sendo uma alternativa legada explícita;
o padrão Pastel neutro corresponde ao tema geral. HUD aliada mantém os três
pixels de sobreposição da alpha.11, sem novo deslocamento nesta versão.

## Validação e limites

60 execuções das suítes existentes em Lua 5.4/LuaJIT passaram, cobrindo os cinco
jogos com host, ROM e gráficos simulados. Navegação, confirmações, callbacks,
saves, inventário, PC e ações de batalha não foram reimplementados.
Os gravadores de prévia foram atualizados para suportar primitivas vetoriais e
cores em tabela. As prévias do Journal e Options foram regeneradas; elas não
são capturas do jogo e seus dados são fictícios.

A alteração cobre as interfaces já desenhadas ou interceptadas pelo mod. Não
conclui o port integral KRS. Telas especiais, duplas, Hoenn/Sevii e interfaces
de terceiros fora dessas pontes mantêm os fallbacks documentados. Arte externa
com cores próprias não é alterada. Não há execução real desta versão em ROM,
Windows ou GPU/LÖVE.

## Continuidade

Conferir no jogo principal, mochila, equipe, resumo, salvar, PC e Options, com
teclado/controle e mouse, além da batalha. Registrar tela/opção e imagem de
qualquer inconsistência. Baseline alpha.11 preservada, junto às anteriores
inclusive alpha.5. Manifesto/bootstrap, hashes, documentação e instalador são
atualizados. Referências, KRS original, Gen1/Gen2 e outros mods permanecem intactos.
Destino Windows continua H:\gen1recomp-0.3.51-windows\gen1recomp-win64\mods.
