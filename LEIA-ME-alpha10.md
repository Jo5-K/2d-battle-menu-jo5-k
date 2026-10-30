# Floating Glass Gen3 — 1.2.0-alpha.10

HUD ancorada ao sprite: aliado abaixo, sobrepondo 1 pixel; inimigo acima e à
esquerda, com 8 pixels de distância. Medidas em pixels lógicos da janela.
Bordas da janela e fallbacks podem limitar esse espaçamento.

SELECT → Cores dos botões → Pastel nativo (padrão): azul, verde e coral claros,
creme/grafite, sem brilho metálico. Metálico continua disponível.
SELECT → Tamanho da vegetação: 65% (padrão), 80% ou original.
Movimento da lente: ciclo elástico suave de 4 segundos, ou desligado.

Leia docs/07-ALPHA10-ANCORAS-PASTEL-E-VEGETACAO.md para arquitetura e limites.
Reinicie a engine para carregar a atualização. Suporte experimental aos cinco
jogos Gen3; testes simulados não comprovam gameplay, GPU/LÖVE ou Windows.

ID floating_glass_frlg; engine v0.3.91. Atualização preserva baselines alpha.5
até alpha.9 e anteriores. Não altera KRS original, outros mods ou saves.
Destino Windows permanece H:\gen1recomp-0.3.51-windows\gen1recomp-win64\mods.
