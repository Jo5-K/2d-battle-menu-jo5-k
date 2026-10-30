# Alpha.13 — fundos por jogo e HUD fixa

## Comportamento

HUD aliada à direita do limite visível do Pokémon, separada por 5 pixels da janela e alinhada à base. HUD inimiga no superior esquerdo, com 8 pixels de separação. A HUD mantém a redução de 35%. Bordas da janela limitam a posição para não cortar os dados: nessas situações o espaçamento solicitado pode diminuir.

As âncoras congelam na primeira pose disponível sem deslocamento/escala de entrada, até trocar o Pokémon, iniciar outra batalha ou alterar a queda da câmera. Redimensionar a janela reprojeta a âncora; animação ociosa e troca de quadro não deslocam a HUD. A posição do sprite continua nativa. O primeiro quadro observado pode conter uma fase da animação ociosa; não se promete detectar a pose artística neutra de qualquer mod.

A medição usa transparência e desenho real quando o host permite leitura de canvas, incluindo correções de origem instaladas por mods de sprites. Sem essa capacidade usa o retângulo da textura. O observador preserva wrappers de desenho instalados durante a batalha; não importa nem exige G9 ou Emerald Lens. Compatibilidade conjunta em jogo permanece pendente.

## Fundos e arenas

24 arquivos fornecidos, não 22, copiados sem transformação de APrendizado/fundo com camera definida. para assets/scenery/camera21x9. Origem e hashes em FUNDOS-CAMERA-ORIGEM.json. As imagens têm proporção aproximadamente 21:9 (1915/1916×821). Escala uniforme pela altura da janela; largura excedente é recortada ao centro. Janelas mais largas que a imagem recebem margem neutra, sem esticar a arte nem revelar fundo nativo.

O terreno nativo é consultado por nome semântico, nunca por números compartilhados entre FRLG e RSE. Ao encontrar imagem, não se chama o desenho do fundo/arenas nativos; o plano da cena fica transparente e a nova arte é composta atrás dos sprites. A faixa de entrada nativa é suprimida na cena substituída. Nenhuma arena separada é desenhada. Os arquivos antigos ficam apenas para integridade de upgrades. Sombras futuras NÃO implementadas.

SELECT: Cenário Automático/Nativo e Fundo 21:9 com Automático + 24 escolhas manuais. Automático preserva cenas únicas sem imagem correspondente. A opção manual é uma substituição explícita do usuário. Menus especiais/duplas conservam a interface nativa, podendo receber somente o fundo; isso não conclui seu port HD.

## Correspondência automática

| Contexto | FRLG | RSE |
|---|---|---|
| Grama | Clareira Florestal | Clareira Florestal |
| Grama alta | Arena de Grama | Arena de Grama |
| Areia | Praia | Deserto |
| Montanha | montanhoso | Arena Rochosa |
| Água / lagoa / caverna | Imagens correspondentes | Imagens correspondentes |
| Interior genérico | Arena Pokémon Retro | Arena Pokémon Retro |
| Ginásio / líder | Ginásio / Grande Arena Azul e Dourado | Ginásio / Grande Arena Azul e Dourado |
| Lorelei / Glacia | Guardiões de Gelo | Guardiões de Gelo |
| Bruno | Pedra com Emblemas | — |
| Agatha / Phoebe | Fantasmas Roxa | Fantasmas Roxa |
| Lance / Drake | Dragões ao Crepúsculo | Dragões ao Crepúsculo |
| Sidney | — | Umbreon |
| Campeão | Liga Pokémon (Blue, confirmado pelo usuário) | Cachoeiras Lendárias (Wallace/Emerald, confirmado) |
| Link / Frontier | Virtual Neon / — | Virtual Neon |

FRLG indoor_1 usa Interior Pokémon-Style e indoor_2 Industrial Rocket, por interpretação temática; revisar em jogo. ghostBattle FRLG usa lavander. Grama não é aplicada em salas da Elite. Steven em Ruby/Sapphire, submarino, especiais Groudon/Kyogre/Rayquaza e outros sem entrada dedicada conservam fundo nativo. Os nomes temáticos da Elite foram inferidos; só Blue/Wallace foram confirmados individualmente pelo usuário.

## Validação e continuidade

Testes simulados verificam nomes de terrenos nos cinco jogos, escolha manual dos 24 fundos, escala uniforme/resize, zero arenas, fallback e HUD fixa/reset/troca de wrapper. Não substituem teste de batalha real com os mods ativos. Ver VALIDACAO.json e VALIDACAO-ALPHA13.txt para resultados finais.

Base anterior alpha.12 preservada em ATUALIZAR-DE-ALPHA12.json e fixtures; baseline alpha.5 mantida. ID floating_glass_frlg, APIs e transações nativas preservados. Nenhum outro mod, KRS original, Gen1/Gen2 ou referência antiga é editado.

A consulta da engine 0.3.93 está no documento 11. Este release mantém o alvo 0.3.91; não declara suporte à 0.3.93 por simples aprovação do modkit em modo dev.
