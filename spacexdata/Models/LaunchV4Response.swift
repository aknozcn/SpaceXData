//
//  LaunchV4Response.swift
//  spacexdata
//
//  Created by akin on 20.03.2023.
//

struct LaunchV4Response: Codable {
    var docs: [LaunchV4Doc]?
    var limit: Int?
    var totalPages: Int?
    var page: Int?
    var pagingCounter: Int?

    enum CodingKeys: String, CodingKey {
        case docs
        case limit
        case totalPages
        case page
        case pagingCounter
    }
}
