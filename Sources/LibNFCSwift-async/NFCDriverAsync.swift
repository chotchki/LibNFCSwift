import Foundation
import LibNFCSwift

public class NFCDriverAsync {
    private var driver: NFCDriver
    
    public init() throws {
        self.driver = try NFCDriver()
    }
    
    public func list_devices() async throws -> [String] {
        return try await withCheckedThrowingContinuation({ continuation in
            do {
                let devices = try self.driver.list_devices()
                continuation.resume(returning: devices)
            } catch {
                continuation.resume(throwing: error)
            }
        })
    }
    
    public func open(conn_desc: String) async throws -> NFCDeviceAsync {
        return try await withCheckedThrowingContinuation({ continuation in
            do {
                let device = try self.driver.open(conn_desc: conn_desc)
                continuation.resume(returning: NFCDeviceAsync(device: device))
            } catch {
                continuation.resume(throwing: error)
            }
        })
    }
}
