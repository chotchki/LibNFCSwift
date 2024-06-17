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
    
    public func listPassiveTargets(modulation: NFCModulation) async throws -> [NFCTarget] {
        return try await withCheckedThrowingContinuation({ continuation in
            do {
                let targets = try self.device.listPassiveTargets(modulation: modulation)
                continuation.resume(returning: targets)
            } catch {
                continuation.resume(throwing: error)
            }
        })
    }
}
