
import Foundation
@testable import SpaceX_Challenge

public class MockNetworkSession: NetworkSession {
    public var data: Data?
    public var error: Error?

    public init() {}

    public func loadData(from request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
}

