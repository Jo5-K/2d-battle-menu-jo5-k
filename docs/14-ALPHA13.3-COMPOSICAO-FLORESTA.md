# Alpha.13.3 — composição corrigida da clareira

O fundo permanece com preenchimento proporcional pela altura da janela, conforme escolha explícita do usuário. Não há recorte vertical adicional no compositor: escala=altura/821, y=0. O arquivo da clareira já contém copas cortadas no topo; a largura excedente continua recortada ao centro. O enquadramento não foi trocado por imagem inteira/faixas.

A imagem de duas arenas deixou de ser ampliada como uma camada única. Cada círculo agora é isolado geometricamente na textura original, com tamanho próprio e proporções preservadas. As larguras máximas são 29% da área projetada / 50% da altura para aliado e 24% / 40% para inimigo. Limites adicionais mantêm os círculos dentro da janela. Os pontos de apoio são ancorados ao centro horizontal e à base visível fixa de cada sprite. Sem medição pronta, usa-se um ponto nominal provisório. As arenas acompanham redimensionamento; não oscilam com a animação ociosa.

Na clareira, a camada nativa de Pokémon, treinadores, partículas e Pokébolas recebe uma transformação uniforme: translação (24,32), escala 0,8, seguida da queda de câmera configurada, no espaço 240×160. Isso reduz os sprites em 20% e aproxima o conjunto do chão, conservando proporções e relações espaciais dos efeitos. Não modifica coordenadas da lógica, estado dos Pokémon, comandos, saves ou transações. As HUDs ficam fora da transformação e mantêm as posições relativas solicitadas.

A transformação é restaurada antes de HUD/painel/overlay e no encerramento da cena, inclusive sem HUD ou após falha. Trocar o cenário invalida as âncoras anteriores. Cenários diferentes, Safari e duplas conservam o caminho anterior. As arenas são exclusivas da clareira e da interface de batalha simples controlada pelo mod.

O PNG fornecido permanece byte a byte intacto. O recorte usa malha texturizada; hosts sem malha usam faixas de textura. A prévia 35 usa renderizador e imagens reais com coordenadas/dados simulados: não é captura do jogo e não valida todos os sprites de outros mods.

Versão mínima >=0.3.93, API 2, ID floating_glass_frlg. Baseline alpha.13.2 preservada, assim como alpha.5 e demais upgrades. Nenhuma alteração em KRS, outros mods ou referências antigas. Validar em jogo a composição com os mods ativos, entrada, captura e golpes com deslocamento; execução real de GPU/ROM/Windows segue pendente.
