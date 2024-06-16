import XCTest
@testable import LibNFCSwift

final class LibNFCSwiftTests: XCTestCase {
    func testListDevices() throws {
        let wrapper = try? LibNFCSwift();
        
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
}
