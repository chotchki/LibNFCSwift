import Foundation
import libnfc
import nfc_swift

public class LibNFCSwift {
    private let max_device_count = 16 //From the examples
    
    private var context: OpaquePointer
    public init() throws {
        var initial_context: OpaquePointer?
        libnfc.nfc_init(&initial_context)
        
        guard let ctx = initial_context else {
            throw LibNFCError.initFailed
        }
        
        context = ctx
    }
    
    deinit {
        libnfc.nfc_exit(context)
    }
    
    public func list_devices() throws -> [String] {
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
}
