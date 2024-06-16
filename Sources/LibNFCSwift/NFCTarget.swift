//
//  File.swift
//  
//
//  Created by Christopher Hotchkiss on 6/16/24.
//

import Foundation
import libnfc

public class NFCTarget {
    private var target: nfc_target
    
    public init(target: nfc_target) {
        self.target = target
    }
    
    public func getInfo() throws -> String {
        var raw_buffer_ptr: UnsafeMutablePointer<CChar>? = nil
        
        let size = libnfc.str_nfc_target(&raw_buffer_ptr, &target, true)
        
        if size == 0 {
            return ""
        }
        
        guard let buffer_ptr = raw_buffer_ptr else {
            throw LibNFCError.tagPrintError
        }
        
        let buffer = UnsafeBufferPointer(start: buffer_ptr, count: Int(size))
        
        var string_buffer: [CChar] = []
        for b in buffer{
            string_buffer.append(b)
        }
        string_buffer.append(CChar(0))
        
        let info = String(cString: string_buffer)
        
        libnfc.nfc_free(raw_buffer_ptr)
        
        return info
    }
}
