# Alpha.17 — câmeras Nativa, Original e Compatibilidade G9/HD

## Escolhas e migração

| Câmera | Identificador salvo | Comportamento |
| --- | --- | --- |
| Nativa (padrão) | native | Coordenadas e escala de cena nativas; sem sombra adicionada por este mod. |
| Original | current | Composição anterior do mod, usada na captura com Torchic/Poochyena nativos; sombras automáticas nos dois lados. |
| Compatibilidade G9/HD | g9_compat | Composição Original com correção individual do apoio dos sprites substituídos; sombras automáticas nos dois lados. |
| Primeiro plano | native_depth | Câmera do conceito anterior, com aliado no primeiro plano; mantém o ajuste da alpha.16. |

Novos perfis usam Nativa. Configurações existentes não são apagadas: current continua sendo Original, e native_depth passa a se chamar Primeiro plano. O nome anterior “Perspectiva nativa” não descrevia o que essa opção fazia.

A Nativa bloqueia as sombras deste mod independentemente de um valor antigo Ambos. Fora dela, Auto inclui os dois lados. A opção geral Desligadas foi retirada; o valor off de configurações antigas é interpretado como Auto, seguindo a regra de que apenas Nativa fica sem sombras. Inimigos/Ambos continuam disponíveis para ajustar os lados sombreados. Sombras de outros provedores não são desativadas.

## HUD

Em batalhas simples, em Original e Compatibilidade G9/HD, o HUD nativo de HP é desenhado com fator 0.8 sobre seu tamanho da alpha.16 (redução de 20%, não 20 pontos percentuais). A borda superior toma como referência sua posição anterior à redução e sobe cinco pixels de janela, limitada pela borda superior da área de jogo. Assim, reduzir a altura não desloca o HUD para baixo. Aplica-se aos dois lados. Nativa e Primeiro plano preservam seu tamanho e posicionamento anteriores.

O conteúdo continua vindo de Healthbox.draw: HP, EXP, status, mensagens e transações não são recalculados por este mod.

## O problema com sprites substituídos

As capturas enviadas distinguem o desenho nativo do substituído: o nativo repousa sobre a arena, enquanto o substituído pode parecer suspenso, embora sua animação e sombra funcionem. A nova câmera trata essa incompatibilidade separadamente, sem modificar o provedor.

G9 Battle Sprites pode fornecer um Canvas e uma origem próprios. Gen3 HD Sprites pode desenhar uma textura diferente do Canvas de apoio e executar Battle Fit, com outra câmera no compositor final. Medir apenas o retângulo do Canvas ou congelar o quadro de entrada como se fosse a animação final não basta.

O modo de compatibilidade usa, quando disponíveis, os metadados públicos tagOf: lowPivot, pivot, scale, body e quad. Assim, mede a posição de repouso fornecida pelo provedor, não somente o limite do Canvas reduzido. Quando a fonte troca do quadro nativo de entrada para Canvas ou HD, a âncora é medida novamente. Mudar apenas o quadro animado mantém a âncora; mudar o layout de apoio a recalibra.

O perfil de chão da composição Original usa (72,108) para o aliado e (176,64) para o inimigo, em unidades do plano de apresentação 240×160. A calibração corresponde à composição da captura nativa fornecida; não é uma alteração de coordenadas da ROM nem uma declaração de equivalência universal entre espécies. A elevação nativa do inimigo é preservada. Sprite, sombra e arena compartilham o apoio corrigido. Tamanho e velocidade da animação continuam sendo definidos pelo provedor.

Sem HD, a correção usa os limites visíveis e a origem de desenho medidos para o Canvas substituído. Sem provedor substituído, mantém o desenho nativo da composição Original. Não há dependência obrigatória ou arquivos copiados de outro mod.

## Cooperação com HD e efeitos

A integração opcional procura gen3-hd-sprites via mod:find e sua API pública. Durante Game3.draw no modo G9/HD, se Battle Fit estiver ativo, solicita sua suspensão temporária por setFit(false). Ao terminar, inclusive em erro, restaura o estado ativo por setFit(true). Se já estava desligado, não o liga. Não grava opções persistentes, não chama setEnabled, não altera tags e não edita arquivos do HD. A operação cobre o compositor final de sprites, evitando que duas câmeras reenquadrem a mesma cena.

Para sombras HD completas, o mod utiliza a textura e o quad atuais, com o pivô e a escala do tag. Não avança a animação por conta própria. Efeitos nativos recortados em faixas mantêm seus recortes, sem expandir uma faixa para um quadro inteiro.

Pontos de animação usam cópias dos retornos de anim_coords.coords para os dois lados. Tabelas nativas, overrides da VM e objetos de apresentação não são sobrescritos. Ecos de partículas não recebem o deslocamento do corpo duas vezes. Não há lógica paralela de ataques, consumo de itens, troca de Pokémon ou saves.

## Pacotes consultados

Os nomes informais G9 sprites/G9 HD/Gen9 Gen3 foram tratados como provedores de sprites. Nesta instalação, os pacotes encontrados são g9-battle-sprites-gen3 e gen3-hd-sprites. As interfaces consultadas e os hashes dos fontes lidos estão em COMPATIBILIDADE-SPRITES-ALPHA17.json. A identificação e integração são opcionais; os fontes consultados não foram modificados.

## Verificação e limitações

355 verificações do teste principal por jogo, incluindo o HUD real do mod (escala e deslocamento) e restauração do Battle Fit após erro no desenho. 102 verificações específicas da compatibilidade cobrem políticas das câmeras, fonte de entrada substituída, pivôs HD, frame animado da sombra, layout trocado, Canvas sem HD, ausência/desativação do provedor e alinhamento dos dois lados. Também são executadas as regressões de enquadramento, cenários, seleção de golpes e Primeiro plano em LuaJIT e Lua 5.4; ver VALIDACAO-ALPHA17.txt.

Não houve execução real de LÖVE/GPU, Windows ou ROM/save. A correção G9/HD está implementada para batalhas simples comuns; duplas e situações especiais mantêm os caminhos anteriores. Battle Fit, entradas, ataques com coordenadas próprias, espécies voadoras, formas alternativas e outros provedores precisam de verificação visual no jogo. Um provedor sem metadados públicos usa a medição de alfa, que pode recorrer ao retângulo da textura se o host não permitir leitura. Não se declara o resultado visual integralmente validado pelos testes simulados.

Para conferir: reinicie a engine e, em SELECT → Câmera, compare Original com sprites nativos e Compatibilidade G9/HD com os provedores ligados. Observe os pés e a sombra sobre a arena, o HP menor e cinco pixels mais alto. Nativa deve estar sem as sombras deste mod; Primeiro plano continua sendo uma escolha separada.

## Entrega

Versão 1.2.0-alpha.17; engine >=0.3.93, API 2. Mantidos alpha.5 e os demais baselines; acrescentado alpha.16 verificado. Instalação restrita a floating_glass_frlg, com backup e conferência de hashes. O caminho Windows continua H:\gen1recomp-0.3.51-windows\gen1recomp-win64\mods. Nenhuma alteração em outros mods, Gen1, Gen2 ou REFERENCIAS.
