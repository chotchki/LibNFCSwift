import XCTest
@testable import LibNFCSwift
import libnfc
import OSLog

final class LibNFCSwiftTests: XCTestCase {
    let log = Logger()
    
    func testListDevices() async throws {
        let wrapper = LibNFCActor.shared;
        
        let connection_strings = try await wrapper.list_devices();
                
        print("Found count \(connection_strings.count) strings")
        
        for con in connection_strings {
            print("Connection String: \(con)")
        }
    }
    
    func testFindFirstTag() async throws {
        let wrapper = LibNFCActor.shared;
        
        let mod = NFCModulation.iSO14443A()
        let target = try await wrapper.findFirstTag(modulation: mod, clock: ContinuousClock(), timeout: 30)
        
        print("Found tag UID \(target)")

    }
    
    func testCancelAndCallAgain() async throws {
        let wrapper = LibNFCActor.shared;
        
        let t = Task {
            let mod = NFCModulation.iSO14443A()
            let _ = try await wrapper.findFirstTag(modulation: mod, clock: ContinuousClock(), timeout: 30)
        }
        
        try await Task.sleep(nanoseconds: 2000000)
        
        t.cancel() //Need to ensure this releases the hardware right
        
        print("Second scan")
        
        let mod = NFCModulation.iSO14443A()
        let target = try await wrapper.findFirstTag(modulation: mod, clock: ContinuousClock(), timeout: 30)
        
        print("Found tag UID \(target)")

    }
}
