//
//  File.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/21/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import Foundation

struct FetchActivityHistoryResponse: Decodable {
    var Response: Activities?
    
    private enum FetchAHResponse: String, CodingKey {
        case Response = "Response"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: FetchAHResponse.self)
        Response = try? values.decode(Activities.self, forKey: .Response)
    }
}

struct Activities: Decodable {
    var activities: [ActivityInformation]
}

struct ActivityInformation: Decodable {
    var activityDetails: ActivityDetails
    var values: ActivityValues
}

struct ActivityValues: Decodable {
    var assists: StatsNoPGA?
    var kills: StatsNoPGA?
    var deaths: StatsNoPGA?
    var killsDeathsRatio: StatsNoPGA?
    var killsDeathsAssists: StatsNoPGA?
    var standing: StatsNoPGA?
    var completed: StatsNoPGA?
    
    private enum ActivityHistoryValues: String, CodingKey {
        case assists                = "assists"
        case kills                  = "kills"
        case deaths                 = "deaths"
        case killsDeathsRatio       = "killsDeathsRatio"
        case killsDeathsAssists     = "killsDeathsAssists"
        case standing               = "standing"
        case completed              = "completed"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ActivityHistoryValues.self)
        
        assists             = try? values.decode(StatsNoPGA.self, forKey: .assists)
        kills               = try? values.decode(StatsNoPGA.self, forKey: .kills)
        deaths              = try? values.decode(StatsNoPGA.self, forKey: .deaths)
        killsDeathsRatio    = try? values.decode(StatsNoPGA.self, forKey: .killsDeathsRatio)
        killsDeathsAssists  = try? values.decode(StatsNoPGA.self, forKey: .killsDeathsAssists)
        standing            = try? values.decode(StatsNoPGA.self, forKey: .standing)
        completed           = try? values.decode(StatsNoPGA.self, forKey: .completed)
    }
}

struct ActivityDetails: Decodable {
    var mode: Int
    var instanceId: String
}
