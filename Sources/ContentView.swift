import SwiftUI

struct ContentView: View {
    @State private var isLoading = true
    @State private var loadFailed = false
    @State private var reloadToken = UUID()

    private let siteURL = URL(string: "https://www.optimizer-ia.com.br")!

    var body: some View {
        ZStack {
            WebView(url: siteURL, isLoading: $isLoading, loadFailed: $loadFailed)
                .id(reloadToken)
                .ignoresSafeArea(edges: .bottom)

            if isLoading && !loadFailed {
                ProgressView("Carregando…")
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
            }

            if loadFailed {
                VStack(spacing: 16) {
                    Image(systemName: "wifi.slash")
                        .font(.system(size: 40))
                    Text("Não foi possível carregar o Optimizer-IA.\nVerifique sua conexão.")
                        .multilineTextAlignment(.center)
                    Button("Tentar novamente") {
                        loadFailed = false
                        isLoading = true
                        reloadToken = UUID()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(24)
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
