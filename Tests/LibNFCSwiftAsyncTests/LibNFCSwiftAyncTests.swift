//
//  File.swift
//  
//
//  Created by Christopher Hotchkiss on 6/16/24.
//

import Foundation
import OSLog
import XCTest
@testable import LibNFCSwiftAsync
/*
@MainActor
final class LibNFCSwiftAsyncTests: XCTestCase {
    let log = Logger()
    
    func testListDevices() async throws {
        let wrapper = try? NFCDriverAsync();
        
        let connection_strings = try await wrapper?.list_devices();
        
        guard let connection_strings = connection_strings else {
            assertionFailure("Unable to check for list of devices");
            return;
        }
        
        print("Found count \(connection_strings.count) strings")
        
        for con in connection_strings {
            print("Connection String: \(con)")
        }
    }
}
*/
