//
//  LaunchV4Doc.swift
//  spacexdata
//
//  Created by akin on 21.03.2023.
//

struct LaunchV4Doc: Codable {
    var links: LaunchV4Links?
    var staticFireDateUTC: String?
    var staticFireDateUnix: Int?
    var tbd: Bool?
    var net: Bool?
    var window: Int?
    var rocket: String?
    var success: Bool?
    var details: String?
    var crew: [String]?
    var ships: [String]?
    var capsules: [String]?
    var payloads: [String]?
    var launchpad: String?
    var autoUpdate: Bool?
    var launchLibraryId: String?
    var flightNumber: Int?
    var name: String?
    var dateUTC: String?
    var dateUnix: Int?
    var dateLocal: String?
    var datePrecision: String?
    var upcoming: Bool?
    var cores: [LaunchV4Core]?
    var id: String?

    enum CodingKeys: String, CodingKey {
        case links
        case staticFireDateUTC = "static_fire_date_utc"
        case staticFireDateUnix = "static_fire_date_unix"
        case tbd
        case net
        case window
        case rocket
        case success
        case details
        case crew
        case ships
        case capsules
        case payloads
        case launchpad
        case autoUpdate = "auto_update"
        case launchLibraryId = "launch_library_id"
        case flightNumber = "flight_number"
        case name
        case dateUTC = "date_utc"
        case dateUnix = "date_unix"
        case dateLocal = "date_local"
        case datePrecision = "date_precision"
        case upcoming
        case cores
        case id
    }
}
