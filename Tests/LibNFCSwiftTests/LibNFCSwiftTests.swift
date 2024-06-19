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
    
    /*
    func testGetName() throws {
        let wrapper = LibNFCActor.shared;
        
        let connection_strings = try await wrapper.list_devices();
        
        if connection_strings.isEmpty {
            assertionFailure("No devices found")
            return
        }
        
        let device = try wrapper?.open(conn_desc: connection_strings[0])
        guard let device = device else {
            assertionFailure("Unable to open \(connection_strings[0])")
            return
        }
        
        let name = try? device.getName()
        XCTAssertNotNil(name)
        print(name!)
    }
    
    func testGetInfo() throws {
        let wrapper = try? NFCDriver();
        
        let connection_strings = try wrapper?.list_devices();
        
        guard let connection_strings = connection_strings else {
            assertionFailure("Unable to check for list of devices");
            return;
        }
        
        guard let con_string = connection_strings.first else {
            assertionFailure("No devices found")
            return
        }
        
        let device = try wrapper?.open(conn_desc: con_string)
        guard let device = device else {
            assertionFailure("Unable to open \(con_string)")
            return
        }
        
        let info = try? device.getInfoAbout()
        XCTAssertNotNil(info)
        log.debug("\(info!)")
    }*/
    
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
            let target = try await wrapper.findFirstTag(modulation: mod, clock: ContinuousClock(), timeout: 30)
        }
        
        try await Task.sleep(nanoseconds: 2000000)
        
        t.cancel() //Need to ensure this releases the hardware right
        
        print("Second scan")
        
        let mod = NFCModulation.iSO14443A()
        let target = try await wrapper.findFirstTag(modulation: mod, clock: ContinuousClock(), timeout: 30)
        
        print("Found tag UID \(target)")

    }
}
