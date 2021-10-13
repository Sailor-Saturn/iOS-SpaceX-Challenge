//
//  MissionName.swift
//  SpaceX-Challenge

import Foundation

struct MissionName: Decodable, Equatable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "mission_name"
    }
}

