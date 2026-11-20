# Configurando assinatura e TestFlight sem Mac

O workflow `.github/workflows/ios-build.yml` já compila o app num Mac virtual
da GitHub a cada push — isso valida que o código está correto, mas ainda
**sem assinatura**, então não instala em iPhone nenhum. Para chegar a um
build instalável (TestFlight ou App Store), faltam estas etapas:

## 1. Conta Apple Developer Program

- Cadastro 100% pelo navegador em https://developer.apple.com — funciona
  normalmente no Windows. Custa US$ 99/ano.

## 2. Registrar o app no App Store Connect

- Criar o app em https://appstoreconnect.apple.com com o mesmo Bundle ID
  usado no `project.yml` (`br.com.optimizer-ia.webview`) — ou ajuste o
  `project.yml` para o Bundle ID que preferir, contanto que seja o mesmo dos
  dois lados.

## 3. Chave de API do App Store Connect

- Em App Store Connect → **Users and Access → Integrations → App Store
  Connect API**, gere uma chave e baixe o arquivo `.p8`. Isso substitui o
  login manual e funciona de qualquer sistema operacional.

## 4. Certificados e perfis via Fastlane match

Em vez de gerar certificado manualmente (que tradicionalmente pede o
Keychain do Mac), o **Fastlane match** cria e guarda os certificados
automaticamente, rodando dentro do próprio runner macOS da GitHub Actions —
você não precisa gerar nada na sua máquina Windows. Passos:

1. Criar um repositório Git **privado** separado só para guardar os
   certificados criptografados (ex: `optimizer-ia-certs`).
2. Adicionar o Fastlane ao projeto (`Gemfile` + `fastlane/Fastfile`) — posso
   gerar isso quando você tiver a conta Apple Developer pronta.
3. Guardar como **GitHub Secrets** (Settings → Secrets and variables →
   Actions, no repositório do app):
   - `APP_STORE_CONNECT_API_KEY` (conteúdo do `.p8`)
   - `MATCH_PASSWORD` (senha que você escolhe para criptografar os
     certificados no repositório privado)
   - `MATCH_GIT_URL` (URL do repositório privado de certificados)

**Importante:** essas credenciais devem ser cadastradas por você, direto na
interface web do GitHub — nunca cole senha, `.p8` ou token em uma conversa
com o Cowork ou com o Claude. O agente só precisa saber que os *nomes* dos
secrets existem, não os valores.

## 5. Depois disso

- Descomentar o passo final do `ios-build.yml` (build assinado + upload
  TestFlight) — o app passa a chegar automaticamente no seu iPhone via app
  TestFlight a cada push na branch principal.

## Sobre testar durante o desenvolvimento

Sem Mac local, você não tem simulador iOS para ver a tela enquanto codifica
— o feedback vem do log de build da Action e, mais adiante, de instalar de
fato no iPhone via TestFlight. Se quiser iteração visual mais rápida durante
os ajustes de ícone/tela de erro, uma opção é alugar um Mac por hora (ex:
MacinCloud, ~US$ 1/hora) só nas sessões em que isso importa — não precisa
assinatura anual disso, só para visualizar.
