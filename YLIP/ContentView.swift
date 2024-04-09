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
                    .frame(maxWidth: .infinity, alignment: .topLeading) // Aligns the image to the top leading
                Text(displayText)
                    .lineLimit(nil)
                    .frame(maxWidth: .infinity, alignment: .topLeading) // Aligns the text to the top leading
                    .multilineTextAlignment(.leading)
                Spacer() // Pushes the button to the bottom
                Button("Mirror") {
                    let r = Service.mirror(input: displayText)
                    if r.err == 0 {
                        displayText = r.output
                    } else {
                        errorText = r.error
                        withAnimation { showError = true }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .bottom)
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Makes VStack fill the screen
            .onTapGesture { withAnimation { showError = false } }
            ToastView(message: errorText, isError: true, isVisible: $showError)
        }
        .onAppear {
            Service.ini()
            Service.download(url: "https://foo.bar", file: "foo.bar") { err, text in
                DispatchQueue.main.async {
                    if err == 0 {
                        downloaded()
                    } else {
                        print("Download error: \(text)")
                    }
                }
            }
        }
    }

    func downloaded() {
        print("Download successful")
        Service.load(file: "foo.bar") { err, text in
            DispatchQueue.main.async {
                if err == 0 {
                    loaded()
                } else {
                    print("Download error: \(text)")
                }
            }
        }
    }
    
    func loaded() {
        print("Load successful")
        Service.generate(prompt: "foo bar",
             token: { text in DispatchQueue.main.async { token(text) } },
             done: { DispatchQueue.main.async { done() } })
    }

    func token(_ token: String) {
        print("token: \(token)")
        displayText += " " + token
    }

    func done() {
        print("done")
        displayText += " done."
    }
}

struct ContentView_Previews: SwiftUI.PreviewProvider {
    static var previews: some SwiftUI.View {
        ContentView()
    }
}
