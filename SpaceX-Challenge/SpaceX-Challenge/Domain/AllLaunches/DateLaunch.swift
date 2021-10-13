//
//  DateLaunch.swift
//  SpaceX-Challenge

import Foundation

struct DateLaunch: Decodable, Equatable {
    let date: String
    let time: String
    
    enum CodingKeys: String, CodingKey {
        case date = "launch_date_utc"
        case time = "flight_number"
    }
}
