import Foundation

@_silgen_name("mirror")
public func mirror(_ input: UnsafePointer<UInt8>?,
                   _ input_bytes: Int64,
                   _ output: UnsafeMutablePointer<UInt8>?,
                   _ output_bytes: UnsafeMutablePointer<Int64>?) -> Int32

struct Service {
    static let downloaded: @convention(c) (Int32, UnsafePointer<CChar>?) -> Void = { err, text in
        guard let cString = text else { return }
        let swiftString = String(cString: cString)
        print("Downloaded: \(swiftString), error: \(err)")
    }
    
    static let loaded: @convention(c) (Int32, UnsafePointer<CChar>?) -> Void = { err, text in
        guard let cString = text else { return }
        let swiftString = String(cString: cString)
        print("Loaded: \(swiftString), error: \(err)")
    }
    
    static let token: @convention(c) (UnsafePointer<CChar>?) -> Void = { token in
        guard let cString = token else { return }
        let swiftString = String(cString: cString)
        print("Generated token: \(swiftString)")
    }
    
    static let generated: @convention(c) () -> Void = {
        print("Generated")
    }
    
    static func ini() {
        service.downloaded = Service.downloaded
        service.loaded = Service.loaded
        service.token = Service.token
        service.generated = Service.generated
        service.ini()
    }
    
    static func download(url: String, file: String) {
        url.withCString { cUrl in
            file.withCString { cFile in
                service.download(cUrl, cFile)
            }
        }
    }
    
    static func load(file: String) {
        file.withCString { cFile in
            service.load(cFile)
        }
    }
    
    static func generate(prompt: String) {
        prompt.withCString { cPrompt in
            service.generate(cPrompt)
        }
    }
    
    static func fini() {
        service.fini()
    }
    
}

