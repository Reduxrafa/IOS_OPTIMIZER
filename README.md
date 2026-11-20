# Optimizer IA — App iOS (WebView nativo)

Esqueleto de app iOS que exibe **https://www.optimizer-ia.com.br** dentro de um
`WKWebView` nativo (SwiftUI), com:

- persistência de sessão/cookies entre aberturas do app;
- tela de carregamento e tratamento de erro/offline com botão "Tentar novamente";
- links externos ao domínio abrindo no Safari em vez de dentro do app.

O projeto usa **XcodeGen**, então não existe um `.xcodeproj` versionado — ele é
gerado a partir do `project.yml`. Isso evita arquivos de projeto corrompidos e
facilita qualquer agente (Cowork, Claude Code) editar a estrutura sem mexer em
XML gigante.

## Sem Mac? Build via GitHub Actions

Este projeto já vem com `.github/workflows/ios-build.yml`: a cada push, um
Mac virtual temporário da GitHub (runner `macos-14`, com Xcode já instalado)
roda `xcodegen generate` e compila o app — você acompanha tudo pelo navegador,
sem precisar de Xcode local.

1. Crie um repositório no GitHub e suba esta pasta.
2. Qualquer push na branch `main` já dispara o build automaticamente — veja
   o resultado na aba **Actions** do repositório.
3. Para chegar a um build instalável (TestFlight/App Store), siga o roteiro
   em `CI-SETUP.md` (conta Apple Developer, API key, assinatura via
   Fastlane match — tudo configurável sem precisar de um Mac).

## Se você tiver acesso a um Mac (próprio ou alugado por hora)

```bash
brew install xcodegen
cd OptimizerIA-iOS
xcodegen generate
open OptimizerIA.xcodeproj
```

No Xcode: selecione um simulador de iPhone no topo e aperte **Cmd+R** para
rodar. Útil para conferir visualmente ícone/tela de erro antes de depender
só dos logs da Action.

## O que falta para publicar (não incluído aqui de propósito)

- Ícone do app (1024×1024 px) em `Assets.xcassets/AppIcon` — o XcodeGen ainda
  não gera esse catálogo, precisa ser adicionado no Xcode ou por um agente.
- Cadastro no **App Store Connect** (nome, descrição, screenshots, política
  de privacidade — obrigatória mesmo para apps simples).
- Certificado/perfil de assinatura de distribuição, se for publicar.

Veja `CONTRATO-AGENTE.md` para o briefing que define exatamente o que um
agente (Cowork ou Claude Code, rodando no Windows) pode fazer a partir
daqui, e `CI-SETUP.md` para o roteiro completo de assinatura/TestFlight.
