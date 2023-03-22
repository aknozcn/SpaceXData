//
//  LaunchV4Links.swift
//  spacexdata
//
//  Created by akin on 21.03.2023.
//

struct LaunchV4Links: Codable {
    let patch: Patch
    var presskit: String?
    var webcast: String?
    var youtubeId: String?
    var article: String?
    var wikipedia: String?

    enum CodingKeys: String, CodingKey {
        case patch
        case presskit
        case webcast
        case youtubeId = "youtube_id"
        case article
        case wikipedia
    }
}

struct Patch: Codable {
    let small, large: String?
}
