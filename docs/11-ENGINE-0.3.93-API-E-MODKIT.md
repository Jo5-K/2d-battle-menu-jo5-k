# Gen1Recomp 0.3.93 — consulta de API (20/10/2026)

Tag v0.3.93, commit ee7d657e1b242e15f723839cf8c7d3bd49e69499, confirmado pela API oficial do GitHub. Fontes completos em research/ENGINE-0.3.93, fora das referências imutáveis da 0.3.91. PROVENIENCIA.json registra hashes e origem. A wiki é uma fotografia consultada nesta data, não documentação fixada pela tag.

## Descobertas verificadas

- src/core/Version.lua declara modApi = 3. A versão da engine no repositório é 0.0.0-dev; a distribuição recebe a versão no empacotamento. Não confundir o placeholder com um teste de compatibilidade da distribuição.
- docs/modding.md, Portable API 3: api 1 e 2 conservam seus contratos. API 3 é adesão explícita pelo manifesto; não basta trocar o número para migrar os formatos dos registros.
- API 3 oferece serviços portáveis, consulta de capacidades, snapshots/intenções de batalha com revisão e proteção contra repetição. A lógica nativa continua responsável por executar ações.
- Gen3 ganhou hooks battle.status_hud_visible, battle.bottom_ui_visible, battle.move_grid_navigation e battle.overlay. Os pontos reais estão em src/core/game3/battle/ui.lua. A captura atual da HUD deve respeitar visibilidade solicitada por outros mods, não forçar sua aparição.
- Healthbox passou a considerar status de mods e pokemon.level_visible. Manter o desenho nativo na overlay evita reimplementar essas regras.
- mod.ui da API 3 usa uma ponte Gen3: tela padrão 160×144 em (40,8), ou gbaCanvas=true para 240×160. Isso não fornece automaticamente o tamanho final da janela.
- Loader, Gen3Compat, Hooks e Renderer também mudaram. Fundo, renderização final e caminhos de menus precisam de regressão específica antes de declarar suporte à nova engine.

## modkit.py e wiki

Foram lidos o arquivo da tag e Guide-Modkit/Reference-Manifest/Concepts-Events-And-Hooks/Cookbook-UI-And-Infrastructure. O diff local modkit-091-093.diff compara os dois commits oficiais. A mudança principal do CLI é usar --api no manifesto gerado (antes havia api 2 fixo). O padrão continua 2; partes dos comentários e da mensagem de scaffold ainda dizem api 2. A wiki também mostra scaffold API 2: não é evidência de ausência da API 3.

Comandos executados com o mod atual e a engine-fonte 0.3.93:

- validate --base fixture --json: ok, com aviso MK305 de comparação de dados importados não executada, pois não há dataset importado.
- gen3check --json: sem erros, mas 53 chamadas de módulos indiretas e 2 acessos não resolvidos pelo analisador. O texto “will load” não garante os caminhos dinâmicos.

Resultados brutos estão em research/modkit-093-validate.json e research/modkit-093-gen3check.json. O loader usa o placeholder dev: passar aqui NÃO supera a restrição >=0.3.91 <0.3.92 do manifesto nem a trava explícita do bootstrap. A alpha.13 continua direcionada à 0.3.91 e API 2. A 0.3.93 foi pesquisada, não homologada ou instalada. Não houve execução Windows/LÖVE/GPU/ROM real.

## Próxima etapa de migração

Testar os pontos reais de UI, Healthbox, Renderer, LegacyCompat e Options da 0.3.93 nos cinco jogos; avaliar os hooks públicos em lugar das interceptações atuais; manter a execução nativa de comandos. Somente então ampliar manifesto/bootstrap e atualizar os testes de loader com versão release estampada. API 3 e suporte à engine 0.3.93 são decisões separadas.

Fontes oficiais:
- https://github.com/bryanthaboi/gen1recomp/tree/ee7d657e1b242e15f723839cf8c7d3bd49e69499
- https://github.com/bryanthaboi/gen1recomp/blob/ee7d657e1b242e15f723839cf8c7d3bd49e69499/docs/modding.md#portable-api-3
- https://github.com/bryanthaboi/gen1recomp/blob/ee7d657e1b242e15f723839cf8c7d3bd49e69499/tools/modkit.py
- https://github.com/bryanthaboi/gen1recomp/wiki/Guide-Modkit
