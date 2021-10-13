//
//  RocketType.swift
//  SpaceX-Challenge

import Foundation

struct RocketType: Decodable, Equatable {
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case type = "rocket.rocket_type"
    }

}
