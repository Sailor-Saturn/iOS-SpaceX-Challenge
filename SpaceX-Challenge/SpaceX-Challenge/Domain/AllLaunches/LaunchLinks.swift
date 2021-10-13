//
//  LaunchLinks.swift
//  SpaceX-Challenge
//
//  Created by Vera Dias on 12/10/2021.
//

import Foundation

struct LaunchLinks: Decodable, Equatable {
    let article: String
    let wikipedia: String
    let videoPages: [String]
    
    enum CodingKeys: String, CodingKey {
        case article = "links.article_link"
        case wikipedia = "links.wikipedia"
        case videoPages = "links.video_link"
    }
}
