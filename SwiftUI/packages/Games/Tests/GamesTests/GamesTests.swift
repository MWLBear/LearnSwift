import XCTest
@testable import Games

final class GamesTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Games().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
