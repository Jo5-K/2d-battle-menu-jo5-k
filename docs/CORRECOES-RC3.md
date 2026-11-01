# 1.0.0-rc.3 — apresentação de batalha e evolução

Somente 2D Battle Menu e Glass Menu modificados. Floating Glass legado e Rematch permanecem intactos. Sem publicação nesta etapa.

## 2D Battle Menu

- Captura a evolução nativa em Canvas 240×160, separa uma cópia do fundo antes do primeiro desenho de Pokémon e estende somente esse fundo por cobertura uniforme da janela no render.hud. O conteúdo nativo é composto por escala uniforme de encaixe; não estica o sprite. Dois Canvases são reutilizados e liberados no encerramento.
- Bandejas de Pokébolas reposicionadas para a faixa superior exclusivamente na fase intro. Fora dela usam as coordenadas originais.
- Pausas explícitas da introdução cortadas pela metade. As entradas executadas por Anim.sendOutMon usam metade dos frames locais, incluindo a revelação agendada; não altera dt, velocidade global, duração de golpes, áudio ou decisões. A duração total da introdução ainda depende de textos, cries e ações nativas; não é prometida redução de 50% de toda a sequência.
- Desmaio adversário usa clarão branco, encolhimento e alpha decrescente durante 20 frames locais. Mantém som, callback e ocultação nativa da caixa de HP. Ao concluir, o mon fica invisível, e alpha/escala/blend são restaurados para a entrada seguinte.
- SELECT: IV e EV do adversário, desligado por padrão. Duas linhas passivas abaixo de Ajustes, com HP/ATK/DEF/SPA/SPD/SPE. Não recebem entrada nem alvos de toque. Fonte é mon.ivs/mon.evs; dados ausentes viram —, não valores inventados. Duplas priorizam o primeiro adversário e usam o segundo se o primeiro estiver derrotado. Textos novos traduzidos para PT-BR, EN, FR e ES.
- Resumo e seleção de golpes abertos pela batalha/evolução não passam mais pelo reestilo completo antigo. Adaptador específico altera somente texturas de fundo e o preenchimento integral; cores de tipos, dados, barras, retrato e controles permanecem nativos.

## Glass Menu 0.1.9

O mesmo adaptador de fundo do resumo funciona apenas fora da batalha. O reestilo amplo de texto e preenchimentos não interfere nessa tela. O adaptador da batalha usa os sinais de batalha/evolução e a origem do menu; o Glass Menu continua excluído desses contextos.

## Validação efetiva

- Suíte principal: 805 verificações de duplas e 456 FRLG, simuladas.
- Novo teste presentation_extras: redução local de duração e pausas, callbacks únicos, desmaio oculto e sem alpha residual, bandejas só na intro, dados reais IV/EV, separação do fundo antes do Pokémon e restauração do Canvas.
- Adaptador summary_background: badge de golpe preservado, fundo tratado, shader restaurado e escopo independente.
- Testes de quatro idiomas e 111 verificações de responsividade.
- Loader oficial 0.3.97, API 3, nos cinco jogos, para ambos os mods.

Não houve execução visual com ROM/GPU real nem Android físico. A conferência visual em evolução, entrada e desmaio no aplicativo continua necessária.
