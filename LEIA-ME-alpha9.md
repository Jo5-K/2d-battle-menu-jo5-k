# Floating Glass Gen3 — 1.2.0-alpha.9

Mod independente para Gen1Recomp 0.3.91. ID floating_glass_frlg preservado.
Alvos: FireRed, LeafGreen, Ruby, Sapphire e Emerald, com suporte experimental.

A alpha.9 conecta HUD e primeiro plano à janela, adiciona Formato = Janela,
animação suave da lente, ícones creme/oliva e lajes proporcionais em resolução
final no fundo ultrawide. Leia docs/06-ALPHA9-JANELA-LAJES-E-LENTE.md.

A alpha.8 acrescentou Formato (Nativa/4:3/16:9), HUD 35% menor, Pokémon e bases
mais baixos e a grama ultrawide 2172×724 na tela inteira, ajustada pela altura.
Veja docs/05-ALPHA8-FORMATOS-E-ULTRAWIDE.md para controles e limites.

A versão anterior corrige a falha ao mudar opções em SELECT, substitui a HUD glass de
HP/nome pelo próprio desenho nativo executado na overlay e incorpora os fundos,
arenas e primeiros planos fornecidos em APrendizado. Preserva os comandos
animados e os layouts de golpes em lista/cartas da alpha.6.

## Instalação

Feche o jogo e copie somente floating_glass_frlg para sua pasta mods, ou use
INSTALAR.cmd no Windows. O caminho Windows permanece exatamente:
`H:\gen1recomp-0.3.51-windows\gen1recomp-win64\mods`.
O nome da pasta não muda para 0.3.91. No Linux, o destino informado é
`/home/vader/Documentos/pokemon/Criação do mod - gen1recomp /mods/`.

O instalador reconhece hashes alpha.2/3/4/5/6/7/8, mantém backup e recusa alterações
locais desconhecidas. Não altera KRS, outros mods, Gen1/Gen2 nem saves pessoais.
Reinicie a engine depois de atualizar para carregar os arquivos novos.

## Controles e escopo

SELECT durante a decisão de batalha abre os ajustes. Esquerda/direita altera,
cima/baixo muda a linha; A/B/SELECT fecha. Há cenário automático/nativo, cinco
arenas e opacidade do primeiro plano. A lógica de ações continua na BattleAPI.

As telas Journal HD existentes continuam na base. Pokédex/mapa de Hoenn,
Sevii e batalhas especiais/duplas usam caminhos nativos. Não há promessa de
port integral KRS, câmera/zoom ou compatibilidade validada com todos os mods.

## Documentação atual

- docs/01-ERRO-SELECT-E-CONTRATO-DE-OPCOES.md
- docs/02-HUD-ORIGINAL-EM-OVERLAY.md
- docs/03-FUNDOS-ARENAS-E-PRIMEIRO-PLANO.md
- docs/04-COMPATIBILIDADE-E-ROTEIRO-GEN3.md

docs/VALIDACAO.json distingue testes simulados de execução real. O erro da alpha.6
foi observado pelo usuário no FireRed; a alpha.9 ainda precisa do roteiro real.
Previews antigos são históricos e podem mostrar a antiga HUD glass.
