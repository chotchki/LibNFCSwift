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
        var devices_found = 0;
        var buffer_item_size = 0;
        let raw_connect_strings = nfc_swift.nfc_list_devices_swift(context, &devices_found, &buffer_item_size);
        
        guard let connect_strings = raw_connect_strings else {
            throw LibNFCError.listConnectStringFailure
        }
        
        var converted_con_strings: [String] = Array()
        for i in (0...devices_found){
            var str_buffer: [CChar] = Array()
            for j in (0...buffer_item_size){
                str_buffer.append(connect_strings[i * j])
            }
            
            converted_con_strings.append(String(cString: str_buffer))
        }
        
        return converted_con_strings
    }
}

//From https://forums.swift.org/t/convert-an-array-of-known-fixed-size-to-a-tuple/31432/13
func bindArrayToTuple<T, U>(array: Array<T>, tuple: inout U) {
  withUnsafeMutablePointer(to: &tuple) {
    $0.withMemoryRebound(to: T.self, capacity: array.count) {
      $0.update(from: array, count: array.count)
    }
  }
}
