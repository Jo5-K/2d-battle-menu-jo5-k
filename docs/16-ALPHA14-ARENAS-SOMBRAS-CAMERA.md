# Alpha.14 — arenas por nome, sombras de silhueta e câmera

## Uso

Reinicie a engine após instalar. SELECT no momento de decisão abre os ajustes, tanto em simples quanto em duplas. Escolha Câmera → Perspectiva nativa para ativar o novo enquadramento. Atual permanece como padrão. O gerenciador nativo também expõe BATTLE CAMERA, SPRITE SHADOWS e SHADOW CONTACT.

Sombras: Auto / Inimigos / Ambos / Desligadas. Apoio: Pés / Joelhos. Auto usa sombras nos adversários com sprites nativos; ao observar uma substituição de sprite, inclui aliados. A opção Ambos força o comportamento quando um mod não fornece origem distinguível. Nenhuma ação de jogo é executada para mudar esses ajustes: persistência pelo ManagerState nativo.

## Arenas

Nove PNGs fornecidos em APrendizado/Arena foram copiados sem editar pixels. Associação explícita normaliza o espaço final do nome da clareira e mapeia cada nome para seu fundo existente. Fontes/hashes/recortes em ARENAS-ORIGEM.json; catálogo em gen3/arena_catalog.lua. São associados: deserto, praia, caverna, grama alta, planície, clareira, lagoa, mar e montanhoso. O fundo rochoso RSE não recebe a arena montanhoso, pois os nomes/fundos diferem.

Sem imagem correspondente, não há arena nem fallback genérico. Os recursos antigos continuam no pacote para upgrades, mas o compositor ativo usa somente o catálogo novo. Cada círculo é isolado da folha RGBA com uma malha poligonal e dimensionado em proporção própria sob o ponto de chão do respectivo Pokémon. A geometria da clareira foi revista manualmente; os demais separadores foram medidos entre os dois componentes principais de alpha. Os halos transparentes continuam pertencendo à arte fornecida.

Em duplas, há uma arena por battler presente, sem inventar bases para posições ausentes. As quatro âncoras são independentes mesmo quando a textura/species é compartilhada. O ponto fica estável durante animação ociosa, acompanha resize e é renovado em troca de Pokémon/câmera. A elevação nativa do adversário é considerada quando disponível. Fundos mantêm a escala proporcional pela altura da janela; a câmera não altera fundo ou lente.

## Sombras

Shader usa somente o alpha do sprite e devolve RGB preto com opacidade multiplicada pela visibilidade nativa. O próprio frame/quad e os parâmetros do desenho são reutilizados; nenhuma animação é avançada pela sombra. A projeção comprime verticalmente a silhueta, inclina-a no chão e se apoia nos pés ou joelhos. Não utiliza elipse genérica nem uma cópia apenas deslocada atrás do corpo.

A sombra é desenhada antes do corpo, acima da arena, seguindo flip/rotação/quadro atual, invisibilidade e alpha. Deslocamentos de salto são compensados para mantê-la no plano de chão; a elevação nativa do adversário é adicionada ao contato. O mesmo corpo não ganha múltiplas sombras quando os efeitos de máscara o redesenham. Efeitos nativos que dividem o corpo em faixas reutilizam os mesmos recortes. Shader, cor e transformações são restaurados após cada chamada. Falha do shader desativa a sombra sem substituir a batalha.

Auto reconhece entradas nativas com marcador/cache da engine e os quadros de MonAnim; canvases, dimensões/atlas diferentes e entradas de provedores sem origem nativa são tratados como substituições. Um mod que altere apenas o frame nativo preservando seus marcadores pode ser indistinguível; use Ambos. Não há dependência de G9, Emerald Lens ou outro mod. Sombras externas já desenhadas por outros mods não podem ser identificadas universalmente: use Desligadas se houver duplicação. Não se promete detecção perfeita de toda modificação arbitrária.

## Câmera e duplas

Perspectiva nativa é uma opção adicional baseada nos PNGs fornecidos: aliado em primeiro plano inferior, adversário à direita ao fundo, HUD adversária superior esquerda e HUD aliada na parte inferior direita. Duplas usam quatro HUDs separadas. Não reproduz os retângulos pretos, recortes de montagem ou altera os controles/paleta dos conceitos.

A transformação é afim e uniforme para a camada nativa inteira (sprites, partículas, treinadores e Pokébolas): simples T(-8,16) S(1,05), duplas T(8,28), mais a queda configurada. Isso evita separar efeitos dos sprites e não modifica coordenadas de lógica ou animação. Não há zoom independente por espécie ou transformação perspectiva não linear. A comparação visual fina com os exemplos, especialmente sprites grandes de mods, permanece necessária.

As HUDs usam o renderer nativo original, somente reposicionado; callbacks, barras, status, fades e regras continuam nativos. Em duplas, comandos, seleção de alvo e telas especiais permanecem nativos. SELECT abre um modal apenas de apresentação na fase de comando; cliques no modal não confirmam ações atrás dele. Fora do modal a navegação segue a engine. Duplas não receberam um novo menu de golpes HD neste release.

Cenas especiais mantêm sua interface/projeção nativa; quando há estado de batalha e sprites observáveis, o observador pode desenhar apenas as sombras. Link, Safari, tutoriais e pós-captura não são declarados como port HD. Nenhum menu fora da batalha foi reativado.

## Validação e continuidade

Testes usam host/dados/gráficos simulados. Incluem catálogo sem fallback, separação das duas bases, proporção e janelas diferentes, seleção de câmera, silhueta/frame/alpha/restauração de shader, detecção de substituição, quatro identidades em duplas, HUD nativa executada uma vez por battler, ausentes, modal/input e ausência de comandos paralelos. Prévias 36–38 são composições dos módulos reais com sprites simulados; não fabricam HUDs nativas nem representam gameplay.

LÖVE/GPU, ROM/save real e Windows não foram executados pelo agente. Ainda precisa de avaliação visual no jogo com os mods ativos, golpes de faixa/rotação/salto, substitutos/transformações e Pokémon voadores. A base das fixtures anteriores é 0.3.91; o código 0.3.93 foi consultado para pontos de chamada e contratos. Requisito da instalação continua >=0.3.93, sem teto; API 2 mantida.

Manifesto/bootstrap, hashes e instalador atualizados. Baseline alpha.13.4 adicionada; alpha.5 e demais versões preservadas. KRS original, outros mods, Gen1/Gen2 e fontes de referência não são modificados. Windows continua H:\gen1recomp-0.3.51-windows\gen1recomp-win64\mods.
