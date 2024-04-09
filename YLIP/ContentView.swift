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
                    let r = Service.mirror(input: displayText)
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
//          Service.load(file: "foo.bar")
//          Service.generate(prompt: "some text prompt")
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
        Service.generate(prompt: "foo bar"){ text in
            DispatchQueue.main.async {
                token(text)
            }
        }
    }

    func token(_ token: String) {
        print("token: \(token)")
    }
}

struct ContentView_Previews: SwiftUI.PreviewProvider {
    static var previews: some SwiftUI.View {
        ContentView()
    }
}
