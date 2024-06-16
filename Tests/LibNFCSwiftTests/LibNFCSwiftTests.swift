import XCTest
@testable import LibNFCSwift
import libnfc
import OSLog

final class LibNFCSwiftTests: XCTestCase {
    let log = Logger()
    
    func testListDevices() throws {
        let wrapper = try? NFCDriver();
        
        let connection_strings = try wrapper?.list_devices();
        
        guard let connection_strings = connection_strings else {
            assertionFailure("Unable to check for list of devices");
            return;
        }
        
        print("Found count \(connection_strings.count) strings")
        
        for con in connection_strings {
            print("Connection String: \(con)")
        }
    }
    
    func testGetName() throws {
        let wrapper = try? NFCDriver();
        
        let connection_strings = try wrapper?.list_devices();
        
        guard let connection_strings = connection_strings else {
            assertionFailure("Unable to check for list of devices");
            return;
        }
        
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
    }
    
    func testGetTagInfo() throws {
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
        
        let targets = try device.listPassiveTargets(modulation: NFCModulation.iSO14443A())
        
        for t in targets {
            let info = try? t.getInfo()
            log.debug("Target Info \(info!)")
        }
    }
}
