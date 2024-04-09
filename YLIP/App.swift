import SwiftUI
import Combine

@main
struct App: SwiftUI.App {
    @StateObject private var appState = AppState()
    var body: some SwiftUI.Scene {
        SwiftUI.WindowGroup {
            ContentView()
                .environmentObject(appState)
                .onReceive(NotificationCenter.default.publisher(for: NSApplication.willTerminateNotification)) { _ in
                    appState.saveState()
                }
        }
    }
}

class AppState: ObservableObject {
    
    func saveState() {
        UserDefaults.standard.set("foo", forKey: "bar")
    }
    
    func loadState() {
        let foo = UserDefaults.standard.string(forKey: "bar") ?? "foo"
        assert(foo == "foo")
    }
    
}
