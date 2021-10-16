
import Foundation

import XCTest
@testable import SpaceX_Challenge

final class AllLaunchesGatewayTests: XCTestCase {
    var networkSession: MockNetworkSession!
    var gateway: AllLaunchesGateway!
    
    override func setUp() {
        super.setUp()
        
        networkSession = MockNetworkSession()
        gateway = AllLaunchesGateway(networkSession: networkSession)
    }
    
    func test_WHEN_getAllLaunches_request_is_called_THEN_the_response_is_correctly_created () {
        networkSession.data = getAllLaunchesResponse.data(using: .utf8)
        
        let fetchExpectation = expectation(description: "fetch expectation")

        var allLaunches: [AllLaunches]?
        var error: Error?

        gateway.getAllLaunches { result in
            if case .success(let allLaunchesResult) = result {
                allLaunches = allLaunchesResult
                
            } else if case .failure(let errorResult) = result {
                error = errorResult
            }

            fetchExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        
        XCTAssertNil(error)
        XCTAssertEqual(allLaunches?.count, 2)
        XCTAssertEqual(allLaunches?[0].launch_date_utc, "2006-03-24T22:30:00.000Z")
        XCTAssertEqual(allLaunches?[0].rocket.name, "Falcon 1")
        XCTAssertEqual(allLaunches?[0].rocket.type, "Merlin A")
        XCTAssertEqual(allLaunches?[0].launch_success, false)
//        XCTAssertEqual(allLaunches?[0].links.article, "https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html")
//        XCTAssertEqual(allLaunches?[0].links.wikipedia, "https://en.wikipedia.org/wiki/DemoSat")
//        XCTAssertEqual(allLaunches?[0].links.videoPages, "https://www.youtube.com/watch?v=0a_00nJ_Y88")
        
        XCTAssertEqual(allLaunches?[0].mission_name, "Falcon 1")
    }
    
    // TODO: Add test for when links are nil
}
