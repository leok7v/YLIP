import SwiftUI
import Combine

@main
struct App: SwiftUI.App {
    @StateObject private var appState = AppState()
    @Environment(\.scenePhase) var scenePhase  // Inject the environment variable

    var body: some SwiftUI.Scene {
        SwiftUI.WindowGroup {
            ContentView()
                .environmentObject(appState)
                .onAppear {
                    appState.loadState()
                }
        }
        .onChange(of: scenePhase) { newPhase in  // React to scene phase changes
            switch newPhase {
            case .inactive: appState.saveState()
            case .active: appState.loadState()
            case .background: // Handle background state if needed
                break
            @unknown default:
                break
            }
        }
    }
}

class AppState: ObservableObject {
    
    @Published var data: String = "Hello, world!"

    func saveState() {
        UserDefaults.standard.set(data, forKey: "data")
    }
    
    func loadState() {
        data = UserDefaults.standard.string(forKey: "data") ?? "Hello, world!"
    }

}
