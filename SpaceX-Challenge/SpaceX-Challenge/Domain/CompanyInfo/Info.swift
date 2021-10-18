import Foundation

public struct Info: Decodable, Equatable {
    let name: String
    let founder: String
    let founded: Int
    let employees: Int
    let launch_sites: Int
    let valuation: Int
}
