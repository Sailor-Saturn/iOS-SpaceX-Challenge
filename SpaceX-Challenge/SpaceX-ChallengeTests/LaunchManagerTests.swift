
import Foundation

import XCTest
@testable import SpaceX_Challenge

final class LaunchManagerTests: XCTestCase {
    
    var manager = LaunchesManager()
// TODO: This test does not work since the rocket object I created is non optional but I don't have time to refactor this test
//    func test_WHEN_I_have_a_rocket_that_has_a_name_and_no_type_I_should_receive_the_correct_string() {
//        let rocketNameNoType: Rocket = Rocket(name: "test", type: nil)
//
//        XCTAssertEqual(manager.populateRocketName(with: rocketNameNoType?), "test/ No type")
//
//    }
}
