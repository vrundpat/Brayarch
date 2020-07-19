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
    var allPvP:             PVPGameModeAllTime?
    var pvpCompetitive:     PVPGameModeAllTime?
    var trials_of_osiris:   PVPGameModeAllTime?
    var ironBanner:         PVPGameModeAllTime?
    var pvecomp_gambit:     GambitModeAllTime? // Gambit
    var pvecomp_mamba:      GambitModeAllTime? // Gambit Prime
    
    private enum GameModeTypes: String, CodingKey {
        case allPvE             = "allPvE"
        case allPvP             = "allPvP"
        case pvpCompetitive     = "pvpCompetitive"
        case trials_of_osiris   = "trials_of_osiris"
        case ironBanner         = "ironBanner"
        case pvecomp_gambit     = "pvecomp_gambit"
        case pvecomp_mamba      = "pvecomp_mamba"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: GameModeTypes.self)
        
        allPvE              = try? values.decode(PVE_AllTime.self, forKey: .allPvE)
        allPvP              = try? values.decode(PVPGameModeAllTime.self, forKey: .allPvP)
        pvpCompetitive      = try? values.decode(PVPGameModeAllTime.self, forKey: .pvpCompetitive)
        trials_of_osiris    = try? values.decode(PVPGameModeAllTime.self, forKey: .trials_of_osiris)
        ironBanner          = try? values.decode(PVPGameModeAllTime.self, forKey: .ironBanner)
        pvecomp_gambit      = try? values.decode(GambitModeAllTime.self, forKey: .pvecomp_gambit)
        pvecomp_mamba       = try? values.decode(GambitModeAllTime.self, forKey: .pvecomp_mamba)
    }
}

struct PVPGameModeAllTime: Decodable {
    var allTime: PVPGameModeAllTimeStats
}


struct PVPGameModeAllTimeStats: Decodable {
    var activitiesEntered:      StatsNoPGA
    var activitiesWon:          StatsNoPGA
    var bestSingleGameKills:    StatsNoPGA
    var opponentsDefeated:      StatsNoPGA
    var efficiency:             StatsNoPGA
    var killsDeathsRatio:       StatsNoPGA
    var killsDeathsAssists:     StatsNoPGA
    var winLossRatio:           StatsNoPGA
    
    var assists:                StatsPGA
    var kills:                  StatsPGA
    var deaths:                 StatsPGA
    var precisionKills:         StatsPGA
    var suicides:               StatsPGA
    var secondsPlayed:          StatsPGA
}


// For PVE

struct PVE_AllTime: Decodable {
    var allTime: PVE_AllTimeStats
}

struct PVE_AllTimeStats: Decodable {
    var activitiesCleared: StatsNoPGA
    var activitiesEntered: StatsNoPGA
    var opponentsDefeated: StatsNoPGA
    var killsDeathsRatio:  StatsNoPGA
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


// For Gambit

struct GambitModeAllTime: Decodable {
    var allTime: GambitModeAllTimeStats
}

struct GambitModeAllTimeStats: Decodable {
    var activitiesEntered:              StatsNoPGA
    var activitiesWon:                  StatsNoPGA
    var bestSingleGameKills:            StatsNoPGA
    var opponentsDefeated:              StatsNoPGA
    var weaponBestType:                 StatsNoPGA
    var winLossRatio:                   StatsNoPGA

    // Gambit specific stats
    var invasions:                      StatsNoPGA
    var invasionKills:                  StatsNoPGA
    var invasionDeaths:                 StatsNoPGA
    var invaderKills:                   StatsNoPGA
    var invaderDeaths:                  StatsNoPGA
    var primevalKills:                  StatsNoPGA
    var blockerKills:                   StatsNoPGA
    var mobKills:                       StatsNoPGA
    var highValueKills:                 StatsNoPGA
    var motesPickedUp:                  StatsNoPGA
    var motesDeposited:                 StatsNoPGA
    var motesDenied:                    StatsNoPGA
    var motesLost:                      StatsNoPGA
    var primevalDamage:                 StatsNoPGA
    var roundsPlayed:                   StatsNoPGA
    var roundsWon:                      StatsNoPGA

    
    var assists:                        StatsPGA
    var kills:                          StatsPGA
    var deaths:                         StatsPGA
    var precisionKills:                 StatsPGA
    var suicides:                       StatsPGA
    var orbsDropped:                    StatsPGA
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

