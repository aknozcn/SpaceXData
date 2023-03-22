//
//  LaunchV4Core.swift
//  spacexdata
//
//  Created by akin on 21.03.2023.
//

struct LaunchV4Core: Codable {
    var core: String?
    var flight: Int?
    var gridfins: Bool?
    var legs: Bool?
    var reused: Bool?
    var landingAttempt: Bool?
    var landingSuccess: Bool?
    var landingType: String?
    var landpad: String?

    enum CodingKeys: String, CodingKey {
        case core
        case flight
        case gridfins
        case legs
        case reused
        case landingAttempt = "landing_attempt"
        case landingSuccess = "landing_success"
        case landingType = "landing_type"
        case landpad
    }
}
