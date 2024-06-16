//
//  File.swift
//  
//
//  Created by Christopher Hotchkiss on 6/16/24.
//

import Foundation
import libnfc

public class NFCDevice {
    private var device: OpaquePointer
    
    public init(device: OpaquePointer) {
        self.device = device
    }
    
    deinit {
        libnfc.nfc_close(device)
    }
    
    public func getName() throws -> String {
        let name = libnfc.nfc_device_get_name(device)
        guard let name = name else {
            throw LibNFCError.unableToGetName
        }
        
        return String(cString: name)
    }
}
