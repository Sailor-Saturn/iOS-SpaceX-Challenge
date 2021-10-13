//
//  AllLaunchesGateway.swift
//  SpaceX-ChallengeTests

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

        var allLaunches: AllLaunches?
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
        
        //XCTAssertEqual(allLaunches?.count, 1)
        
        XCTAssertEqual(allLaunches?.missionName.name, "FalconSat")
    }
}
