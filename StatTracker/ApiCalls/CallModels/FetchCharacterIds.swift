//
//  FetchPlayerStats.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/14/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import Foundation


struct FetchCharacterIdsResponse: Decodable {
    var Response: FetchCharacterIdsProfile
}


struct FetchCharacterIdsProfile: Decodable {
    var profile: FetchCharacterIdsData
}


struct FetchCharacterIdsData: Decodable {
    var data: FetchCharacterIds
    var privacy: Int
}

struct FetchCharacterIds: Decodable {
    var userInfo: UserInfo
    var dateLastPlayed: String
    var versionsOwned: Int
    var characterIds: [String]
    var seasonHashes: [Int]
    var currentSeasonHash: Int
    var currentSeasonRewardPowerCap: Int
}

struct UserInfo: Decodable {
    var crossSaveOverride: Int
    var applicableMembershipTypes: [Int]
    var isPublic: Bool
    var membershipType: Int
    var membershipId: String
    var displayName: String
}

