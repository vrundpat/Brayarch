//
//  FindPlayers.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/12/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import Foundation


struct SearchPlayerResponse: Decodable {
    var Response: [PlayerInfo]
}


struct PlayerInfo: Decodable {
    var iconPath: String
    var crossSaveOverride: Int
    var isPublic: Bool
    var membershipType: Int
    var membershipId: String
    var displayName: String
}
