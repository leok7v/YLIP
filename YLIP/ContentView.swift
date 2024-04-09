import SwiftUI

struct ContentView: View {
    @State private var displayText = "Hello, world!"
    @State private var errorText = ""
    @State private var showError = false
    
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text(displayText)
                Button("Bye") {
                    let r = mirrorText(input: displayText)
                    if r.err == 0 {
                        displayText = r.output
                    } else {
                        errorText = r.error
                        withAnimation { showError = true }
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture { withAnimation { showError = false } }
            ToastView(message: errorText, isError: true, isVisible: $showError)
        }
    }
}

struct ContentView_Previews: SwiftUI.PreviewProvider {
    static var previews: some SwiftUI.View {
        ContentView()
    }
}
