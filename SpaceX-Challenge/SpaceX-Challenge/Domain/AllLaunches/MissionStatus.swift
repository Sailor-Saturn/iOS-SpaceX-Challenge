//
//  MissionStatus.swift
//  SpaceX-Challenge

import Foundation

struct MissionStatus: Decodable, Equatable {
    let status: Bool
    
    enum CodingKeys: String, CodingKey {
        case status = "launch_success"
    }
}

