import Foundation
import SwiftUI


import Foundation
import SwiftUI

struct ToastView: View {
    let message: String
    let isError: Bool
    @Binding var isVisible: Bool

    var body: some View {
        GeometryReader { geometry in
            VStack {
                if isVisible {
                    Text(isError ? "💣 \(message)" : message)
                        .foregroundColor(.white)
                        .padding()
                        .background(isError ? Color.red.opacity(0.4) : Color.green.opacity(0.4))
                        .clipShape(RoundedBottomRectangle(cornerRadius: 5))
                        .transition(.move(edge: .top))
                        .zIndex(1)
                        .padding(.top, isVisible ? -geometry.size.height / 2 : -100)
                        .animation(.easeInOut, value: isVisible)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    isVisible = false
                                }
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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

/*
func mirrorText(input: String, output: inout String, error: inout String) -> Int32 {
    var r: Int32 = 0
    var output_cstr = Array<UInt8>(repeating: 0, count: input.utf8.count + 1)
    var output_bytes = Int64(input.utf8.count + 1)
    input.withCString { input_cstr in
        r = mirror(UnsafeRawPointer(input_cstr).assumingMemoryBound(to: UInt8.self),
                   Int64(input.utf8.count), &output_cstr, &output_bytes)
        if r == 0 {
            output = String(cString: output_cstr)
        } else {
            error = String(cString: strerror(r))
        }
    }
    return r
}
*/

func mirrorText(input: String) -> (output: String, err: Int32, error: String) {
    var r: Int32 = 0
    var output_cstr = Array<UInt8>(repeating: 0, count: input.utf8.count + 1)
    var output_bytes = Int64(input.utf8.count + 1)
    var output = ""
    var error = ""
    input.withCString { input_cstr in
        r = mirror(UnsafeRawPointer(input_cstr).assumingMemoryBound(to: UInt8.self),
                   Int64(input.utf8.count), &output_cstr, &output_bytes)
        if r == 0 {
            output = String(cString: output_cstr)
        } else {
            error = String(cString: strerror(r))
        }
    }
    return (output, r, error)
}
