//
//  RocketName.swift
//  SpaceX-Challenge

import Foundation

struct Rocket: Decodable, Equatable {
    let name: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "rocket_name"
        case type = "rocket_type"
    }
}

