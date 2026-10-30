# Alpha.13.1 — requisito mínimo da engine

Por solicitação do usuário, manifesto e bootstrap agora exigem somente Gen1Recomp >=0.3.93, sem teto. A API do manifesto permanece 2. O bootstrap usa o comparador Semver nativo e registra a versão real da engine. 0.3.91, 0.3.92 e 0.0.0-dev não são mais aceitas; pré-release 0.3.93-beta também é inferior ao mínimo.

Esta alteração permite carregar versões futuras, mas não comprova compatibilidade gráfica ou de comportamento com elas. Os testes anteriores usam contratos 0.3.91; a consulta e as limitações da pesquisa 0.3.93 permanecem documentadas. Não houve validação real em ROM/GPU/Windows.

A alpha.13 é preservada como baseline de upgrade, assim como a alpha.5. A instalação Windows continua H:\gen1recomp-0.3.51-windows\gen1recomp-win64\mods.
