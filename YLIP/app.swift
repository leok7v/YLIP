import SwiftUI

@main 
struct app: App {
    var body: some Scene {
        Window("YLIP", id: "mainWindow") {
            ContentView()
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowToolbarStyle(UnifiedCompactWindowToolbarStyle())
        .commands { // Removes unused menu items
            CommandGroup(replacing: .newItem) {}
            CommandGroup(replacing: .help) {}
            CommandGroup(replacing: .systemServices) {}
        }
    }
}
