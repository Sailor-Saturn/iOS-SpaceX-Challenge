import Foundation
import XCTest

@testable import SpaceX_Challenge

final class GetCompanyInfoRequest: XCTestCase {
    func test_WHEN_GET_All_Launches_request_is_made_then_the_URL_is_correctly_built () {
        let request = GetAllLaunchesRequest()
        
        XCTAssertEqual(request.url.absoluteString, "https://api.spacexdata.com/v3/info")
        
    }
}
