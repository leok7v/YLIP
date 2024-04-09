import Foundation

@_silgen_name("mirror")
public func mirror(_ input: UnsafePointer<UInt8>?,
                   _ input_bytes: Int64,
                   _ output: UnsafeMutablePointer<UInt8>?,
                   _ output_bytes: UnsafeMutablePointer<Int64>?) -> Int32

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
