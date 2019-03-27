#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import Foundation

public func validateStatus(_ status: OSStatus, domain: String, method: String) throws {
    if status != noErr {
        throw NSError(domain: domain,
                      code: Int(status),
                      userInfo: [NSLocalizedDescriptionKey: "Failed while excecuting \"\(method)\""])
    }
}
#endif
