# SELECT: causa e correção — alpha.7

O log fornecido registra a falha em 2026-10-19T20:23:57Z, em Linux/LÖVE
11.5-nx1: `gen3/battle.lua:28: attempt to call method 'set' (a nil value)`.
A ação foi SELECT durante batalha e mudança da primeira opção.

A alpha.6 chamou `mod.options:set`. Loader.lua v0.3.91 expõe somente `define`
e `get` nesse objeto. O mesmo erro existia na página gráfica de Options.
A suíte anterior inventava `set` no host simulado, portanto não detectou a
incompatibilidade. Seus resultados não comprovavam esse fluxo no jogo.

Agora battle.lua e menus.lua usam R.setOption, que obtém
`src.mods.ManagerState` via R.module e chama `ManagerState.new(game):setOption`.
É o mesmo escritor usado pelo gerenciador nativo: atualiza save.options.modOptions,
loader.modOptions, solicita game:writeOptions e emite mod.options_changed.
Não há gravação paralela de saves nem uso de package.loaded em chunks do mod.
O guard verifica disponibilidade do contexto; erros retornam false e são
registrados, em vez de encerrar o jogo por uma chamada inexistente.

O teste carrega o arquivo integral ManagerState da engine exata; as dependências
não usadas são simuladas. O objeto público de opções não possui set.
As asserções verificam persistência solicitada, evento e chave correta, além da
navegação SELECT sem submissão acidental de golpe/item. O disco e o host do jogo
continuam simulados: confirmar reinício e persistência real faz parte do roteiro.
