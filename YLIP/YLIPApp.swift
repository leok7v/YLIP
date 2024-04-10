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
        .onChange(of: scenePhase) { // Assuming you want to save state when moving to inactive or background
            if scenePhase == .inactive || scenePhase == .background {
                appState.saveState()
            } else if scenePhase == .active {
                appState.loadState()
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
