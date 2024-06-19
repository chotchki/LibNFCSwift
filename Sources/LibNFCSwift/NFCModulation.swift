//
//  File.swift
//  
//
//  Created by Christopher Hotchkiss on 6/16/24.
//

import Foundation
import libnfc

public struct NFCModulation: Sendable {
    public var modulation: nfc_modulation
    
    public init(){
        modulation = nfc_modulation()
    }
    
    public init(mod_type: nfc_modulation_type, baud_rate: nfc_baud_rate){
        modulation = nfc_modulation(nmt: mod_type, nbr: baud_rate)
    }
    
    public static func iSO14443A() -> NFCModulation {
        return NFCModulation(mod_type: NMT_ISO14443A, baud_rate: NBR_106)
    }
}
