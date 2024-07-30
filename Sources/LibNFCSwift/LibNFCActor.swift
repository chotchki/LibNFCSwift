import Foundation
import libnfc
import nfc_swift

@available(iOS 16.0, *)
@available(macOS 13.0, *)
@available(macCatalyst 16.0, *)
@globalActor
public actor LibNFCActor: GlobalActor {
    public static let shared = LibNFCActor()
    
    private let max_device_count = 16 //From the examples
    private let max_targets = 16
    private var context: OpaquePointer?
    private var device: OpaquePointer?
        
    public init() {}
        
    deinit {
        if let device = device {
            libnfc.nfc_close(device)
        }
        
        if  let context = context {
            libnfc.nfc_exit(context)
        }
    }
        
    private func create_context() throws {
        if context == nil {
            libnfc.nfc_init(&context)
        }
        
        if context == nil {
            throw LibNFCError.initFailed
        }
    }
    
    private func open_device() throws {
        try create_context()
        
        if device == nil {
            device = libnfc.nfc_open(context!, nil)
        }
        
        if device == nil {
            throw LibNFCError.deviceConnectFailed
        }
    }
        
    public func list_devices() throws -> [String] {
        try create_context()
        
        var raw_buffer_ptr: UnsafeMutablePointer<CChar>? = nil
        var buffer_item_size = 0
        let devices_found = nfc_swift.nfc_list_devices_swift(context, &raw_buffer_ptr, &buffer_item_size)
        
        if devices_found == 0 {
            return []
        }
        
        guard let buffer_ptr = raw_buffer_ptr else {
            throw LibNFCError.listConnectStringFailure
        }
        
        let buffer = UnsafeMutableBufferPointer(start: buffer_ptr, count: devices_found * buffer_item_size)
        
        var converted_buffer: [CChar] = Array()
        for c in buffer {
            converted_buffer.append(c)
        }
        
        var connection_strings: [String] = Array()
        for i in (0..<devices_found){
            let device_buffer = Array(converted_buffer[(i * buffer_item_size)..<((i + 1) * buffer_item_size)])
            connection_strings.append(String(cString: device_buffer))
        }
        
        nfc_swift.free_nfc_connstring_array(&raw_buffer_ptr)
        
        return connection_strings
    }
    
    public func findFirstTag(modulation: NFCModulation, clock: ContinuousClock, timeout: Int) async throws -> [UInt8] {
        let end = clock.now.advanced(by: .seconds(timeout))
        return try await withCheckedThrowingContinuation({ continuation in
            do {
                try open_device()
                
                guard let device = device else {
                    throw LibNFCError.deviceConnectFailed
                }
                
                while true {
                    if Task.isCancelled {
                        continuation.resume(throwing: LibNFCError.cancelled)
                        break
                    }
                    
                    if clock.now > end {
                        continuation.resume(throwing: LibNFCError.pollTimeout)
                        break
                    }
                    
                    var targets: [nfc_target] = Array(repeating: nfc_target(), count: 1)
                    let count = libnfc.nfc_initiator_list_passive_targets(device, modulation.modulation, &targets, 1)
                    
                    if count == 0 {
                        Thread.sleep(forTimeInterval: 0.5)
                        continue
                    } else if count > 0 {
                        var array: [UInt8] {
                            withUnsafeBytes(of: targets[0].nti.nai.abtUid) { buf in
                                [UInt8](buf)
                            }
                        }
                        
                        let trimmed = Array(array[0..<targets[0].nti.nai.szUidLen])
                        continuation.resume(returning: trimmed)
                        break
                    }
                }
            } catch {
                continuation.resume(throwing: error)
            }
        })
    }
    
    
}
