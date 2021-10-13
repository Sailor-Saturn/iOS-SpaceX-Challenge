//
//  AllLaunches.swift
//  SpaceX-Challenge

import Foundation

struct AllLaunches: Decodable, Equatable {
    let missionName: MissionName
    let launchDateUtc: DateLaunch
    let rocketName: RocketName
    let rocketType: RocketType
    let launchSuccess: MissionStatus
    let links: LaunchLinks
}
