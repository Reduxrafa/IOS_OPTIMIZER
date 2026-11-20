# Contrato de execução — App iOS Optimizer IA

Cole este documento como instrução inicial ao abrir o Cowork (ou Claude Code)
apontando para esta pasta. Ele define objetivo, escopo, formato de entrada e
saída, limites e critério de "pronto" — para a tarefa ser executada sem
ambiguidade e sem depender de decisões implícitas do agente.

**Contexto:** não há Mac disponível. O agente roda no Windows (Cowork ou
Claude Code); quem efetivamente compila é um runner macOS na nuvem via
GitHub Actions (`.github/workflows/ios-build.yml`). O agente nunca deve
tentar `xcodebuild` localmente — vai falhar, porque Xcode não existe fora de
macOS.

## 1. Objetivo

Finalizar o app iOS "Optimizer IA" (WebView nativo apontando para
`https://www.optimizer-ia.com.br`) a partir do esqueleto já existente nesta
pasta, deixando o pipeline de CI verde e, na sequência, pronto para
distribuição via TestFlight.

## 2. Escopo — o agente PODE

- Editar `project.yml` e os arquivos em `Sources/` (nome do app, cores,
  orientação, comportamento de erro/offline).
- Criar o `Assets.xcassets` com ícone do app a partir de um logotipo que eu
  fornecer (ou um placeholder com o nome "OIA" caso eu não forneça).
- Editar o workflow `.github/workflows/ios-build.yml` e o `CI-SETUP.md`.
- Fazer commit e **push para o repositório remoto do app** (não o de
  certificados) — é assim que o build roda.
- Consultar o status/log da GitHub Action (via `gh` CLI ou API) e reportar
  o resultado, incluindo erros completos de build.
- Montar o `Gemfile`/`fastlane/Fastfile` quando eu confirmar que a conta
  Apple Developer Program e a API key já existem — referenciando os
  secrets pelo *nome*, nunca pedindo o valor deles em texto.

## 3. Fora de escopo — o agente NÃO deve fazer sem eu aprovar explicitamente

- Submeter o app para revisão da Apple ou publicar na App Store.
- Criar contas Apple Developer, ou cadastrar/alterar GitHub Secrets — isso
  eu faço manualmente pela interface web.
- Pedir para eu colar senha, `.p8`, token ou qualquer credencial diretamente
  na conversa — se precisar de uma credencial, deve apontar para o nome do
  secret que falta e onde cadastrar.
- Alterar qualquer código do site Optimizer-IA (backend PHP/JS) — o app é só
  uma casca (webview), o site continua sendo a fonte da verdade.
- Fazer push para o repositório privado de certificados (`match`) ou para
  qualquer repositório que não seja explicitamente o deste app.
- Guardar, logar ou expor qualquer cookie/sessão/credencial capturada nos
  testes.

## 4. Formato de entrada

- Esta pasta (`OptimizerIA-iOS/`), como está, versionada em um repositório
  Git que eu já criei/vou criar no GitHub.
- Logotipo em PNG 1024×1024 com fundo, se/quando eu enviar.

## 5. Formato de saída esperado

Ao final (ou a cada etapa relevante), entregar:

1. Resumo curto (Markdown) do que foi feito e decisões tomadas.
2. Link e status da execução da GitHub Action (verde/vermelho).
3. Lista explícita do que ainda falta (ex: "falta a API key do App Store
   Connect nos Secrets") em vez de tentar contornar a falta.
4. Qualquer erro de build reportado com a mensagem completa, não resumida.

## 6. Limites de execução

- Reportar status a cada 3 tentativas de build sem sucesso, em vez de
  continuar tentando indefinidamente.
- Perguntar antes de qualquer ação irreversível (force-push, apagar
  workflow, sobrescrever configuração de assinatura).
- Se algo exigir decisão de produto (ex: cor do app, texto da tela de erro),
  usar um valor razoável e sinalizar como "provisório — revisar", em vez de
  travar esperando resposta.

## 7. Critérios de aceite ("pronto")

- [ ] Push no repositório dispara a Action e o build para simulador passa.
- [ ] Site carrega corretamente dentro do WebView (validado via log/print
      quando possível, já que não há simulador local).
- [ ] Ícone e nome "Optimizer IA" configurados no `Assets.xcassets`.
- [ ] `CI-SETUP.md` refletindo o que já foi configurado e o que falta
      (conta Apple, API key, secrets).
- [ ] Nenhuma credencial ou dado sensível aparece em arquivos do projeto,
      logs de build ou histórico de commits.
