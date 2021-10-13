////
////  RawAllLaunchesResponse.swift
////  SpaceX-Challenge
//
//import Foundation
//
//struct RawAllLaunchesResponse: Decodable {
//    enum CodingKeys: String, CodingKey {
//        case allLaunches
//    }
//    
//    enum EmbeddedCodingKeys: String, CodingKey {
//        case launch
//    }
//    
//    let allLaunches: [AllLaunches]
//    
//    init(from decoder: Decoder) throws {
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        let embedded =  try values.nestedContainer(keyedBy: EmbeddedCodingKeys.self, forKey: .allLaunches)
//    }
//}
