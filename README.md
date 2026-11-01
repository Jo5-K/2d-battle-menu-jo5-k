# 2D Battle Menu - Jo5-k — 1.0.0-rc.3

## Português

Beta Final, pré-release 2: interface de batalha, cenários em camadas, iluminação, controles por toque e layouts verticais. Migração independente para a API 3. Corrige herança de preferências de apresentação, deslocamento vertical e proporções de tela. Não substitui nem atualiza a instalação do antigo Floating Glass. Não ative os dois mods de batalha simultaneamente.

Requer **G1R 0.3.97+ / API 3**. FireRed, LeafGreen, Ruby, Sapphire e Emerald. Importe o ZIP da release no gerenciador de mods; para instalação manual, extraia a pasta `battle_menu_2d_jo5k` em `mods/`. Ative o mod no gerenciador.

## English

Beta Final, pre-release 2: battle UI, layered scenery, lighting, touch controls and portrait layouts. Independent API 3 migration with presentation preference recovery, vertical offset and aspect-ratio fixes. Does not overwrite the original Floating Glass installation. Do not enable both battle mods together.

Requires **G1R 0.3.97+ / API 3**. Supports FireRed, LeafGreen, Ruby, Sapphire and Emerald. Import the release ZIP through the mod manager, or extract `battle_menu_2d_jo5k` under `mods/` and enable it.

## Validation / Validação

Official 0.3.97 loader and simulated tests passed for the five games. No physical Android or ROM/GPU visual validation is claimed. / Carregador oficial 0.3.97 e testes simulados passaram nos cinco jogos. Não há validação visual com ROM/GPU real ou Android físico nesta publicação.

## Downloads / Créditos

[Releases](https://github.com/Jo5-K/2d-battle-menu-jo5-k/releases). The manifest declares this repository for the native updater. / O manifesto indica este repositório para o atualizador nativo.

See LICENSE.md and THIRD_PARTY_NOTICES.md for inherited code and resources. / Consulte os arquivos de licença e créditos dos recursos herdados.

## 1.0.0-rc.3

## Português
- Evolução: fundo expandido para preencher a janela; Pokémon e conteúdo nativo mantêm escala uniforme.
- Resumo e seleção de golpes abertos durante batalha/evolução: altera apenas o fundo, preservando textos, cores dos tipos, dados, barras, retrato e navegação.
- Indicadores de Pokébolas reposicionados para a faixa superior somente na introdução.
- Desmaio adversário: clarão branco, encolhimento e ocultação final. Alpha e escala restaurados para a próxima entrada.
- Entrada: duração local de Anim.sendOutMon e pausas explícitas da introdução reduzidas pela metade. Não acelera o jogo inteiro; o tempo total continua dependendo de textos, cries e outras etapas nativas.
- SELECT: nova opção IV e EV do adversário, desligada por padrão, com duas linhas passivas sob Ajustes. Usa valores reais disponíveis; dados ausentes aparecem como —. Inclui PT-BR, inglês, francês e espanhol.

## English
- Evolution background fills the window while Pokémon and native content retain uniform scaling.
- Battle/evolution summary and move selection: background-only styling preserves text, type colors, data, bars, portraits and navigation.
- Party Poké Ball indicators move to the upper area during the intro only.
- Opponent fainting uses a white flash, shrinking and final hiding; alpha and scale reset for the next entry.
- Local Anim.sendOutMon duration and explicit intro waits are halved. Global game speed is unchanged; full intro duration still depends on text, cries and other native stages.
- New SELECT option for opponent IV/EV, off by default, displays two passive rows below Settings. Uses available real values; missing data is shown as —. Supports PT-BR, English, French and Spanish.

**Compatibility / Compatibilidade:** G1R 0.3.97+, API 3; FireRed, LeafGreen, Ruby, Sapphire, Emerald. Independent pre-release / pré-release independente. Do not enable alongside legacy Floating Glass / não ative junto do Floating Glass legado.

**Validation / Validação:** official API 3 loader passed in five games; 805 doubles and 456 FRLG checks, new presentation tests, four-language checks and 111 responsive checks passed in simulation. No ROM/GPU or physical Android visual validation was performed. / Sem validação visual em ROM/GPU real ou Android físico.

Import the ZIP and restart G1R. / Importe o ZIP e reinicie o G1R.
