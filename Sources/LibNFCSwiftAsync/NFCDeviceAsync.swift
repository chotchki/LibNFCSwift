//
//  File.swift
//  
//
//  Created by Christopher Hotchkiss on 6/16/24.
//

import Foundation
import LibNFCSwift

public class NFCDeviceAsync {
    private var device: NFCDevice
    
    public init(device: NFCDevice) {
        self.device = device
    }
}
