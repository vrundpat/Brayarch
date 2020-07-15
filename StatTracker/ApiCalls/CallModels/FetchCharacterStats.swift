//
//  FetchCharacterStats.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/15/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import Foundation


struct FetchCharacterStats: Decodable {
    var Response: GameModes
}

struct GameModes: Decodable {
    var pvpQuickplay: GameModeAllTime?
    var pvpCompetitive: GameModeAllTime?
    var trials_of_osiris: GameModeAllTime?
    var ironBanner: GameModeAllTime?
    var pvecomp_gambit: GameModeAllTime? // Gambit
    var pvecomp_mamba: GameModeAllTime? // Gambit Prime
        
    private enum GameModeTypes: String, CodingKey {
        case pvpQuickplay = "pvpQuickplay"
        case pvpCompetitive = "pvpCompetitive"
        case trials_of_osiris = "trials_of_osiris"
        case ironBanner = "ironBanner"
        case pvecomp_gambit = "pvecomp_gambit"
        case pvecomp_mamba = "pvecomp_mamba"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: GameModeTypes.self)
        
        pvpQuickplay = try? values.decode(GameModeAllTime.self, forKey: .pvpQuickplay)
        pvpCompetitive = try? values.decode(GameModeAllTime.self, forKey: .pvpCompetitive)
        trials_of_osiris = try? values.decode(GameModeAllTime.self, forKey: .trials_of_osiris)
        ironBanner = try? values.decode(GameModeAllTime.self, forKey: .ironBanner)
        pvecomp_gambit = try? values.decode(GameModeAllTime.self, forKey: .pvecomp_gambit)
        pvecomp_mamba = try? values.decode(GameModeAllTime.self, forKey: .pvecomp_mamba)
    }
}

struct GameModeAllTime: Decodable {
    var allTime: GameModeAllTimeStats
}

struct GameModeAllTimeStats: Decodable {
    var activitiesEntered: GameModeStats_NoPGA
    var activitiesWon: GameModeStats_NoPGA
    var assists: GameModeStats_PGA
    var kills: GameModeStats_PGA
    var deaths: GameModeStats_PGA
    var score: GameModeStats_PGA
    var averageScorePerLife: GameModeStats_NoPGA
    var bestSingleGameKills: GameModeStats_NoPGA
    var opponentsDefeated: GameModeStats_NoPGA
    var efficiency: GameModeStats_NoPGA
    var killsDeathsRatio: GameModeStats_NoPGA
    var killsDeathsAssists: GameModeStats_NoPGA
    var precisionKills: GameModeStats_PGA
    var suicides: GameModeStats_PGA
}

struct GameModeStats_PGA: Decodable {
    var basic: BasicStat
    var pga: PGAStat
}

struct GameModeStats_NoPGA: Decodable {
    var basic: BasicStat
}

struct BasicStat: Decodable {
    var value: Double
    var displayValue: String
}

struct PGAStat: Decodable {
    var value: Double
    var displayValue: String
}

