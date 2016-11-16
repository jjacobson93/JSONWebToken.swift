import XCTest
import Foundation
@testable import JWT

class JWTTests: XCTestCase {
    static var allTests: [(String, (JWTTests) -> () throws -> ())] = [
        ("testEncode", testEncode),
        ("testDecode", testDecode)
    ]
    
    func testEncode() throws {
        let payload: Payload = ["hello": "world"]
        guard let secret = "secret".data(using: .utf8) else {
            XCTFail("Could not encoded string into UTF8")
            return
        }
        
        _ = JWT.encode(payload, algorithm: .hs256(secret))
    }
    
    func testDecode() throws {
        let payload: Payload = ["hello": "world"]
        guard let secret = "secret".data(using: .utf8) else {
            XCTFail("Could not encoded string into UTF8")
            return
        }
        
        let token = JWT.encode(payload, algorithm: .hs256(secret))
        let payloadActual = try JWT.decode(token, algorithm: .hs256(secret))
        
        XCTAssertEqual(payload["hello"] as? String, payloadActual["hello"] as? String)
    }
}
