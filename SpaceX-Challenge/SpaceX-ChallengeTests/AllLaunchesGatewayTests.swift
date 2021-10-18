
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

        var allLaunches: [Launch]?
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
        XCTAssertEqual(allLaunches?[0].rocket?.name, "Falcon 1")
        XCTAssertEqual(allLaunches?[0].rocket?.type, "Merlin A")
        XCTAssertEqual(allLaunches?[0].launch_success, false)
        XCTAssertEqual(allLaunches?[0].links?.article, "https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html")
        XCTAssertEqual(allLaunches?[0].links?.wikipedia, "https://en.wikipedia.org/wiki/DemoSat")
        XCTAssertEqual(allLaunches?[0].links?.videoPages, "https://www.youtube.com/watch?v=0a_00nJ_Y88")
        
        XCTAssertEqual(allLaunches?[0].mission_name, "FalconSat")
        
        XCTAssertEqual(allLaunches?[1].mission_name, "DemoSat")
    }
    
    // When rocket is nil
    func test_WHEN_getAllLaunches_request_is_called_with_no_rocket_THEN_the_response_does_not_contain_rocket () {
        networkSession.data = launchWithNullRocketResponse.data(using: .utf8)
        
        let fetchExpectation = expectation(description: "fetch expectation")

        var allLaunches: [Launch]?
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
        XCTAssertEqual(allLaunches?.count, 1)
        XCTAssertEqual(allLaunches?[0].launch_date_utc, "2006-03-24T22:30:00.000Z")
        XCTAssertEqual(allLaunches?[0].rocket,  nil)
        XCTAssertEqual(allLaunches?[0].rocket?.name,  nil)
        XCTAssertEqual(allLaunches?[0].rocket?.type,  nil)
        XCTAssertEqual(allLaunches?[0].launch_success, false)
        XCTAssertEqual(allLaunches?[0].links?.article, "https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html")
        XCTAssertEqual(allLaunches?[0].links?.wikipedia, "https://en.wikipedia.org/wiki/DemoSat")
        XCTAssertEqual(allLaunches?[0].links?.videoPages, "https://www.youtube.com/watch?v=0a_00nJ_Y88")
        
        XCTAssertEqual(allLaunches?[0].mission_name, "FalconSat")
    }
    // TODO: I dont have too much time left but there are tests missing for when the other elements cant be created, it's necessary to change the JSON and remove fields
}
