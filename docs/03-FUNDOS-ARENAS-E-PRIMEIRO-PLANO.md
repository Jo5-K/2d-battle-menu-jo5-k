# Recursos de APrendizado e composição

Origem consultada e preservada: pasta APrendizado informada pelo usuário.
Foram copiados para assets/scenery do mod independente:

- backgrounds_gen3_1152x648: 20 fundos PNG.
- arenas_duplas_gen3_transparentes/bases_separadas: dez PNG, duas bases para cada
  uma das cinco arenas. Usam-se os recortes separados, não a montagem duplicada.
- primeiro_plano_gen3_transparentes: 20 PNG transparentes correspondentes aos fundos.

A terceira pasta contém elementos próximos da câmera. Não implementa shader de
lente, desfoque, profundidade de campo, movimento da câmera ou zoom.

## Ordem de desenho

1. Fundo, com recorte central para preencher o plano nativo 240×160.
2. Base inimiga (x128,y54,96×20) e aliada (x16,y96,112×26).
3. Pokémon, treinadores, partículas e animações: renderização nativa intacta.
4. Primeiro plano, antes das caixas de HP.
5. HUD original em overlay, comandos glass, mensagens e modal SELECT.

As bases seguem os deslocamentos de entrada enemyOx/playerOx. O fundo recebe
bgOx. Nenhum Pokémon muda de posição, turno, alvo ou estado por essa camada.
São recursos HD compostos no plano nativo da cena; não afirmar que existe um
compositor HD final para toda a paisagem. A prévia 29 mostra a composição sem
Pokémon/HUD; não é captura de jogo nem prova de desempenho na GPU.

## Opções

SELECT oferece Cenário (Automático / Original-mods), cinco Arenas e Primeiro
plano (65%, desligado ou 100%), além de layout, tamanho, opacidade e posição.
As mesmas três opções estão no esquema do gerenciador nativo do mod.
Se outro mod controla a paisagem, selecionar Original / mods.
O antigo fundo KRS opcional continua disponível quando a nova paisagem está
em Original / mods. Ausência/erro de recurso restaura o desenho anterior.

## Associação de terrenos

| Chave nativa | Número do recurso |
| --- | --- |
| grass / long_grass | 01 / 02 |
| sand / plain | 03 / 04 |
| underwater / water / pond | 05 / 06 / 07 |
| mountain / cave / building | 08 / 09 / 10 |
| gym / indoor_1 / indoor_2 | 11 / 12 / 13 |
| link / leader | 14 / 15 |
| lorelei / bruno / agatha / lance / champion | 16 / 17 / 18 / 19 / 20 |

A chave vem do ambiente nativo da família, nunca de uma tabela numérica FRLG
aplicada a RSE. Cenas não mapeadas, como Frontier, Sidney, Phoebe, Glacia, Drake,
Groudon, Kyogre e Rayquaza, conservam os fundos nativos. Link possui recurso no
pacote mas permanece fora da posse da overlay. As arenas foram fornecidas como
arte para duplas, mas nesta versão a composição customizada atua só nas batalhas
simples; duplas continuam nativas. Isso é pendência, não port concluído.
