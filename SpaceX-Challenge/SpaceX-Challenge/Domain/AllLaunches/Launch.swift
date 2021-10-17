//
//  AllLaunches.swift
//  SpaceX-Challenge

import Foundation

public struct Launch: Decodable, Equatable {
    let mission_name: String
    let launch_date_utc: String?
    let rocket: Rocket?
    let launch_success: Bool?
    let links: Links?
}
