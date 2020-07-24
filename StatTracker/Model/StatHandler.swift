//
//  StatHandler.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/21/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import Foundation

struct StatHandler {
    
    func pvpValues(mode: PVPGameModeAllTime?) -> [[String]] {
        var statEssentials = [[String]]()
        
        if let pvp = mode {
            statEssentials.append(["\(pvp.allTime.kills.basic.displayValue)", "\(pvp.allTime.assists.basic.displayValue)", "\(pvp.allTime.deaths.basic.displayValue)", "\(pvp.allTime.activitiesEntered.basic.displayValue)"])
            
            statEssentials.append(["\(round((pvp.allTime.activitiesWon.basic.value / pvp.allTime.activitiesEntered.basic.value) * 100))%", "\(pvp.allTime.killsDeathsRatio.basic.displayValue)", "\(pvp.allTime.killsDeathsAssists.basic.displayValue)", "\(pvp.allTime.secondsPlayed.basic.displayValue)"])
        } else {
           statEssentials = [["0", "0", "0", "0"], ["0", "0", "0", "0"]]
        }
        
        return statEssentials
    }
    
    
    
    func pveValues(mode: PVE_AllTime?) -> [[String]] {
        var statEssentials = [[String]]()
        
        if let pve = mode {
            statEssentials.append(["\(pve.allTime.kills.basic.displayValue)", "\(pve.allTime.assists.basic.displayValue)", "\(pve.allTime.deaths.basic.displayValue)", "\(pve.allTime.activitiesEntered.basic.displayValue)"])
            
            statEssentials.append(["\(pve.allTime.orbsDropped.basic.displayValue)", "\(pve.allTime.killsDeathsRatio.basic.displayValue)", "\(pve.allTime.suicides.basic.displayValue)", "\(pve.allTime.secondsPlayed.basic.displayValue)"])
        } else {
            statEssentials = [["0", "0", "0", "0"], ["0", "0", "0", "0"]]
        }
        
        return statEssentials
    }
    
    
    
    func gambitValues(mode: [GambitModeAllTime?]) -> [[String]] {
        var statEssentials = [[String]]()
        
        
        if let gambit = mode[0] {
            statEssentials.append(["\(gambit.allTime.kills.basic.displayValue)", "\(gambit.allTime.assists.basic.displayValue)", "\(gambit.allTime.deaths.basic.displayValue)", "\(gambit.allTime.activitiesEntered.basic.displayValue)"])
            
            statEssentials.append(["\(round((gambit.allTime.activitiesWon.basic.value / gambit.allTime.activitiesEntered.basic.value) * 100))%", "\(gambit.allTime.motesDeposited.basic.displayValue)", "\(gambit.allTime.invasions.basic.displayValue)", "\(gambit.allTime.secondsPlayed.basic.displayValue)"])
        }
        
        
        if let gambit_prime = mode[1] {
            statEssentials.append(["\(gambit_prime.allTime.kills.basic.displayValue)", "\(gambit_prime.allTime.assists.basic.displayValue)", "\(gambit_prime.allTime.deaths.basic.displayValue)", "\(gambit_prime.allTime.activitiesEntered.basic.displayValue)"])
            
            statEssentials.append(["\(round((gambit_prime.allTime.activitiesWon.basic.value / gambit_prime.allTime.activitiesEntered.basic.value) * 100))%", "\(gambit_prime.allTime.motesDeposited.basic.displayValue)", "\(gambit_prime.allTime.invasions.basic.displayValue)", "\(gambit_prime.allTime.secondsPlayed.basic.displayValue)"])
        }
        
        
        if let gambit = mode[0] {
                if let gambit_prime = mode[1] {
                    
                    statEssentials.removeAll()
                    
                    statEssentials.append( [
                        "\(Int(gambit.allTime.kills.basic.value + gambit_prime.allTime.kills.basic.value))",
                        "\(Int(gambit.allTime.assists.basic.value + gambit_prime.allTime.assists.basic.value))",
                        "\(Int(gambit.allTime.deaths.basic.value + gambit_prime.allTime.deaths.basic.value))",
                        "\(Int(gambit.allTime.activitiesEntered.basic.value + gambit_prime.allTime.activitiesEntered.basic.value))"
                    ])
        
                    statEssentials.append([
                        "\(round(((gambit.allTime.activitiesWon.basic.value + gambit_prime.allTime.activitiesWon.basic.value) / (gambit.allTime.activitiesEntered.basic.value + gambit_prime.allTime.activitiesEntered.basic.value)) * 100))%",
                        "\(Int(gambit.allTime.motesDeposited.basic.value + gambit_prime.allTime.motesDeposited.basic.value))",
                        "\(Int(gambit.allTime.invasions.basic.value + gambit_prime.allTime.invasions.basic.value))",
                        secondsToHoursMinutesSeconds(seconds: Int(gambit.allTime.secondsPlayed.basic.value + gambit_prime.allTime.secondsPlayed.basic.value))
                    ])
                    
                    return statEssentials
                }
            }
        
        if statEssentials.isEmpty {
            return [["0", "0", "0", "0"], ["0", "0", "0", "0"]]
        }
        
        return statEssentials
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> String {
        return castTimeToString(h: seconds / 3600, m: (seconds % 3600) / 60, s: (seconds % 3600) % 60)
    }
    
    func castTimeToString(h: Int, m: Int, s: Int) -> String {
        if h == 0 && m == 0 { return "\(s)s" }
        else if h == 0 { return "\(m)m \(s)s" }
        else if h < 24 { return "\(h)h \(m)m" }
        else {
            if h % 24 == 0 { return "\(h / 24)d" }
            else {
                let d = h / 24
                return "\(d)d \(h - (d * 24))h"
            }
        }
    }
}
