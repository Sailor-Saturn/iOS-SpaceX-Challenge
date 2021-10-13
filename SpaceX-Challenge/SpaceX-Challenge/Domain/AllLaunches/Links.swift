//
//  LaunchLinks.swift
//  SpaceX-Challenge
//
//  Created by Vera Dias on 12/10/2021.
//

import Foundation

struct Links: Decodable, Equatable {
    let article: String
    let wikipedia: String
    let videoPages: String
    
    enum CodingKeys: String, CodingKey {
        case article = "article_link"
        case wikipedia = "wikipedia"
        case videoPages = "video_link"
    }
}
