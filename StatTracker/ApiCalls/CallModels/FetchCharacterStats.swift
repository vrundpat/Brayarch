//
//  FetchCharacterStats.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/15/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import Foundation


// Make a sepearate PVE all time struct for stats
// Make seperarte gambit stat structs


struct FetchCharacterStats: Decodable {
    var Response: GameModes
}

struct GameModes: Decodable {
    var allPvE:             PVE_AllTime?
    var pvpQuickplay:       GameModeAllTime?
    var pvpCompetitive:     GameModeAllTime?
    var trials_of_osiris:   GameModeAllTime?
    var ironBanner:         GameModeAllTime?
    var pvecomp_gambit:     GameModeAllTime? // Gambit
    var pvecomp_mamba:      GameModeAllTime? // Gambit Prime
        
    private enum GameModeTypes: String, CodingKey {
        case allPvE             = "allPvE"
        case pvpQuickplay       = "pvpQuickplay"
        case pvpCompetitive     = "pvpCompetitive"
        case trials_of_osiris   = "trials_of_osiris"
        case ironBanner         = "ironBanner"
        case pvecomp_gambit     = "pvecomp_gambit"
        case pvecomp_mamba      = "pvecomp_mamba"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: GameModeTypes.self)
        
        allPvE              = try? values.decode(PVE_AllTime.self, forKey: .allPvE)
        pvpQuickplay        = try? values.decode(GameModeAllTime.self, forKey: .pvpQuickplay)
        pvpCompetitive      = try? values.decode(GameModeAllTime.self, forKey: .pvpCompetitive)
        trials_of_osiris    = try? values.decode(GameModeAllTime.self, forKey: .trials_of_osiris)
        ironBanner          = try? values.decode(GameModeAllTime.self, forKey: .ironBanner)
        pvecomp_gambit      = try? values.decode(GameModeAllTime.self, forKey: .pvecomp_gambit)
        pvecomp_mamba       = try? values.decode(GameModeAllTime.self, forKey: .pvecomp_mamba)
    }
}

struct GameModeAllTime: Decodable {
    var allTime: GameModeAllTimeStats
}


struct GameModeAllTimeStats: Decodable {
    var activitiesEntered:      StatsPGA
    var activitiesWon:          StatsPGA
    var averageScorePerLife:    StatsPGA
    var bestSingleGameKills:    StatsPGA
    var opponentsDefeated:      StatsPGA
    var efficiency:             StatsPGA
    var killsDeathsRatio:       StatsPGA
    var killsDeathsAssists:     StatsPGA
    
    var assists:                StatsNoPGA
    var kills:                  StatsNoPGA
    var deaths:                 StatsNoPGA
    var score:                  StatsNoPGA
    var precisionKills:         StatsNoPGA
    var suicides:               StatsNoPGA
}


// For PVE

struct PVE_AllTime: Decodable {
    var allTime: PVE_AllTimeStats
}

struct PVE_AllTimeStats: Decodable {
    var activitiesCleared: StatsNoPGA
    var activitiesEntered: StatsNoPGA
    var opponentsDefeated: StatsNoPGA
    var killsDeathsRatio: StatsNoPGA
    var highestLightLevel: StatsNoPGA
    
    
    var assists:                        StatsPGA
    var kills:                          StatsPGA
    var deaths:                         StatsPGA
    var precisionKills:                 StatsPGA
    var heroicPublicEventsCompleted:    StatsPGA
    var adventuresCompleted:            StatsPGA
    var suicides:                       StatsPGA
    var orbsDropped:                    StatsPGA
    
    var weaponKillsAutoRifle:           StatsPGA
    var weaponKillsBeamRifle:           StatsPGA
    var weaponKillsBow:                 StatsPGA
    var weaponKillsFusionRifle:         StatsPGA
    var weaponKillsHandCannon:          StatsPGA
    var weaponKillsTraceRifle:          StatsPGA
    var weaponKillsMachineGun:          StatsPGA
    var weaponKillsPulseRifle:          StatsPGA
    var weaponKillsRocketLauncher:      StatsPGA
    var weaponKillsScoutRifle:          StatsPGA
    var weaponKillsShotgun:             StatsPGA
    var weaponKillsSniper:              StatsPGA
    var weaponKillsSubmachinegun:       StatsPGA
    var weaponKillsRelic:               StatsPGA
    var weaponKillsSword:               StatsPGA
    var weaponKillsGrenade:             StatsPGA
    var weaponKillsGrenadeLauncher:     StatsPGA
    var weaponKillsSuper:               StatsPGA
    var weaponKillsMelee:               StatsPGA
}


// Common Structs

struct StatsPGA: Decodable {
    var basic: BasicStat
    var pga: PGAStat
}

struct StatsNoPGA: Decodable {
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

