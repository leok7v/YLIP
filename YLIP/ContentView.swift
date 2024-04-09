import SwiftUI

struct ContentView: SwiftUI.View {
    @State private var displayText = "Hello, world!"
    @State private var errorText = ""
    @State private var showError = false
    var body: some SwiftUI.View {
        GeometryReader { geometry in
            SwiftUI.ZStack {
                SwiftUI.VStack {
                    SwiftUI.Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    SwiftUI.Text(displayText)
                    SwiftUI.Button("Bye") {
                        var mirror: String = "";
                        var error: String = "";
                        if mirrorText(input: displayText, output: &mirror, error: &error) == 0 {
                            displayText = mirror
                        } else {
                            errorText = error
                            withAnimation { showError = true }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation { showError = false }
                            }
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onTapGesture { withAnimation { showError = false } }
                SwiftUI.VStack(alignment: .center) {
                    if showError {
                        Text("💣 \(errorText)")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red.opacity(0.4))
                            .clipShape(RoundedBottomRectangle(cornerRadius: 5))
                            .transition(.move(edge: .top))
                            .zIndex(1)
                            .padding(.top, showError ? -geometry.size.height / 2 : -100)
                            .animation(.easeInOut, value: showError)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct RoundedBottomRectangle: Shape {

    var cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.origin.y)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.origin.x, y: rect.maxY)
        path.move(to: topLeft)
        path.addLine(to: topRight)
        path.addLine(to: bottomRight)
        path.addArc(center: CGPoint(x: bottomRight.x - cornerRadius, y: bottomRight.y - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        path.addLine(to: CGPoint(x: bottomLeft.x + cornerRadius, y: bottomLeft.y))
        path.addArc(center: CGPoint(x: bottomLeft.x + cornerRadius, y: bottomLeft.y - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        path.addLine(to: topLeft)
        return path
    }
}


struct ContentView_Previews: SwiftUI.PreviewProvider {
    static var previews: some SwiftUI.View {
        ContentView()
    }
}
