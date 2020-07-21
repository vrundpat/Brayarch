//
//  File.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/21/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import Foundation

struct FetchActivityHistoryResponse: Decodable {
    var Response: Activities
}

struct Activities: Decodable {
    var activities: [ActivityInformation]
}

struct ActivityInformation: Decodable {
    var activityDetails: ActivityDetails
    var values: ActivityValues
}

struct ActivityValues: Decodable {
    var assists: StatsNoPGA
    var kills: StatsNoPGA
    var deaths: StatsNoPGA
    var killsDeathsRatio: StatsNoPGA
    var killsDeathsAssists: StatsNoPGA
    var standing: StatsNoPGA
}

struct ActivityDetails: Decodable {
    var mode: Int
}
