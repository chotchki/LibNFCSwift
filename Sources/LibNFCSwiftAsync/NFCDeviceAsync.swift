//
//  File.swift
//  
//
//  Created by Christopher Hotchkiss on 6/16/24.
//

import Foundation
import LibNFCSwift
/*
public actor NFCDeviceAsync {
    private var device: NFCDevice
    
    public init(device: NFCDevice) {
        self.device = device
    }
    
    public func listPassiveTargets(modulation: NFCModulation) async throws -> [NFCTarget] {
        return try await self.device.listPassiveTargets(modulation: modulation)
    }
    
    //Infinite polling
    public func pollForATag(modulation: NFCModulation) async throws -> NFCTarget {
        while true {
            let targets = try await listPassiveTargets(modulation: modulation)
            if let target = targets.first {
                return target
            }
        }
    }
    
    //Method to poll until the timeout is reached, returning the first tag found
    //from https://stackoverflow.com/a/75039407
    public func searchForATag(modulation: NFCModulation, timeout: Int = 30) async throws -> NFCTarget {
        let pollTask = Task {
            let taskResult = try await pollForATag(modulation: modulation)
            try Task.checkCancellation()
            // without the above line, search() kept going until server responded long after deadline.
            return taskResult
        }
            
        let timeoutTask = Task {
            try await Task.sleep(nanoseconds: UInt64(timeout) * NSEC_PER_SEC)
            pollTask.cancel()
        }
            
        do {
            let result = try await pollTask.value
            timeoutTask.cancel()
            return result
        } catch {
            throw LibNFCError.pollTimeout
        }
    }
}
*/
