import SwiftUI

struct ContentView: SwiftUI.View {
    @State private var displayText = "Hello, world!"
    var body: some SwiftUI.View {
        SwiftUI.VStack {
            SwiftUI.Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            SwiftUI.Text(displayText)
            SwiftUI.Button("Bye") {
                let inputString = displayText
                let outputBufferSize = inputString.utf8.count
                var outputCString = Array<UInt8>(repeating: 0, count: outputBufferSize + 1)
                var outputSize = Int64(outputBufferSize)
                inputString.withCString { inputCString in
                    let result = foo(UnsafeRawPointer(inputCString).assumingMemoryBound(to: UInt8.self),
                                     Int64(inputString.utf8.count),
                                     &outputCString,
                                     &outputSize)
                    if result == 0 {
                        displayText = String(cString: outputCString)
                    } else {
                        displayText = String(cString: strerror(result))
                    }
                }
            }
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
