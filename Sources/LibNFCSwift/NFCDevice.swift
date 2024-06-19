//
//  File.swift
//  
//
//  Created by Christopher Hotchkiss on 6/16/24.
//

import Foundation
import libnfc

@LibNFCActor
public class NFCDevice {
    private let MAX_TARGETS = 16 //Matches the examples
    
    @LibNFCActor
    private var device: OpaquePointer
    
    public init(device: OpaquePointer) async {
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
    
    public func getInfoAbout() throws -> String {
        var raw_buffer_ptr: UnsafeMutablePointer<CChar>? = nil
        let size = libnfc.nfc_device_get_information_about(device, &raw_buffer_ptr)
        
        guard let buffer_ptr = raw_buffer_ptr else {
            throw LibNFCError.unableToGetDeviceInfo
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
    
    public func listPassiveTargets(modulation: NFCModulation) throws -> [NFCTarget] {
        var targets: [nfc_target] = Array(repeating: nfc_target(), count: MAX_TARGETS)
        
        let count = libnfc.nfc_initiator_list_passive_targets(device, modulation.modulation, &targets, MAX_TARGETS)
        
        if count == 0 {
            return []
        }
        
        var found_targets: [NFCTarget] = []
        for t in (0..<count) {
            found_targets.append(NFCTarget(target: targets[Int(t)]))
        }
        
        return found_targets
    }
    
}
