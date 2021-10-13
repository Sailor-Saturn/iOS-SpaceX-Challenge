//
//  RocketName.swift
//  SpaceX-Challenge

import Foundation

struct RocketName: Decodable, Equatable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "rocket.rocket_name"
    }
}

