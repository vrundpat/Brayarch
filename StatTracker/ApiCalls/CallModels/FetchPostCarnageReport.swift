//
//  FetchPostCarnageReport.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/24/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import Foundation

struct FetchPostCarnageReportResponse: Decodable {
    var Response: CarnageReportEntries
}

struct CarnageReportEntries: Decodable {
    var entries: [DestinyPlayerEntry]
}

struct DestinyPlayerEntry: Decodable {
    var player: DestinyPlayer
    var values: DestinyPlayerStatistics
}

struct DestinyPlayer: Decodable {
    var destinyUserInfo: DestinyPlayerInfo
    var characterClass: String
    var lightLevel: Int
}

struct DestinyPlayerInfo: Decodable {
    var displayName: String
    var membershipId: String
    var membershipType: Int
}


struct DestinyPlayerStatistics: Decodable {
    var completed: StatsNoPGA
    var assists: StatsNoPGA
    var deaths: StatsNoPGA
    var kills: StatsNoPGA
    var killsDeathsRatio: StatsNoPGA
}
