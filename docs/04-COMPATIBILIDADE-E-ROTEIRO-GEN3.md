# Cinco jogos: escopo e evidências da alpha.7

Alvos habilitados no manifesto, entrada e guard de runtime: FireRed, LeafGreen,
Ruby, Sapphire e Emerald. ID mantido: floating_glass_frlg, para atualizar a mesma
instalação. Nome exibido: Floating Glass Gen3. Gen1/Gen2 continuam excluídos,
mesmo se o carregador forçar a ativação do mod.
Engine consultada: tag v0.3.91, commit 3806bf3df53f650e235b09f8d76feb731c30a076.

As APIs compartilhadas de batalha/menu continuam responsáveis por input,
transações, callbacks e saves. Batalhas simples usam BattleAPI; especiais,
duplas, tutorial Wally/Old Man, Safari e link conservam os caminhos nativos.
Os títulos identificam os cinco jogos. Em RSE, Pokédex e mapa regional delegam
à tela nativa para não mostrar Kanto em Hoenn. Sevii também permanece nativo.
Isso habilita suporte experimental aos cinco jogos; não comprova compatibilidade
integral ou a conversão de toda tela de Hoenn para o visual KRS.

## Verificações efetuadas

Cinco suítes (sandbox/batalha, Options nativo, Journal, Boot/PalFade nativos e
geometria/navegação) em cinco jogos e dois runtimes: Lua 5.4 e LuaJIT.
O conjunto Journal exercita seus dados Kanto simulados explicitamente e testa
a delegação de mapa/Pokédex em Hoenn; não representa dados extraídos das ROMs RSE.
Uma sexta suíte usa bg/env_frlg/env_rse originais da engine e os 50 PNG reais para
conferir associação de cenas, composição, arena, desligamento, erro e fallback.
ManagerState original cobre a regressão do SELECT. Hosts, gráficos e dados de
jogo permanecem simulados. Ver VALIDACAO.json e VALIDACAO-ALPHA7.txt.

O erro real da alpha.6 no FireRed é evidência negativa conhecida. A alpha.7 ainda
não foi executada por este trabalho com ROM/save, Windows, GPU/LÖVE ou outros mods.

## Roteiro de validação real

1. Reiniciar a engine após instalar; confirmar versão alpha.7 no gerenciador.
2. Em cada um dos cinco jogos, iniciar batalha simples e mudar a primeira opção
   em SELECT; alternar todas as outras, fechar com A/B/SELECT e reabrir.
3. Reiniciar e conferir persistência das opções; nenhuma escolha deve atacar,
   gastar item, fugir ou trocar Pokémon enquanto o modal está aberto.
4. Conferir HUD em entrada, dano, cura, status, captura, nível/EXP, troca e desmaio;
   comparar visual com a HUD nativa do mesmo jogo e testar os dois lados da UI.
5. Conferir fundos/arenas/primeiro plano, introdução, ataques com fundo especial,
   fades e tamanhos de janela. Confirmar que Original / mods devolve a paisagem.
6. Conferir duplas, Safari, tutoriais, link e cenas exclusivas de RSE nos caminhos
   nativos; Pokédex/mapa Hoenn e mapa Sevii devem continuar corretos.
7. Verificar mochila, PC, salvar/carregar e integração com os mods realmente usados.

Próximos trabalhos: corrigir evidências reais desse roteiro, compositor de cenário
em resolução final, câmera/zoom, cenas especiais e arte/mapas Hoenn/Sevii.
Não marcar essas pendências como concluídas só porque as verificações passam.
