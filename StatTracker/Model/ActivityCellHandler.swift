//
//  ActivityCellHandler.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/23/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import Foundation

struct ActivityCellHandler {
    
    func getYValue(activity: ActivityInformation, row: Int) -> Double {
        if row == 0      { return (activity.values.kills?.basic.value)! }
        else if row == 1 { return (activity.values.deaths?.basic.value)! }
        else if row == 2 { return (activity.values.assists?.basic.value)! }
        else {
            if ((activity.values.killsDeathsRatio?.basic.value)! == 0.0) { return 0.0 }
            let divisor = pow(10.0, Double(2))
            return ((activity.values.killsDeathsRatio?.basic.value)! * divisor).rounded() / divisor
        }
    }
    
    func getImageName(i: ActivityInformation, currentMode: String) -> [String] {
        
        if currentMode == "Iron Banner"         { return ["ironbanner-1", "Iron Banner", "ironbanner2"] }
        if currentMode == "Trials of Osiris"    { return ["trials-1", "Trials of Osiris", "trials2"] }
        if currentMode == "PvP: Competitive"    { return ["survival", "Competitive PvP", "pvpcarnage"] }
        if currentMode == "Gambit/Gambit Prime" { return i.activityDetails.mode == 63 ? ["gambit-1", "Gambit", "gambit2"] : ["gambit-1", "Gambit Prime", "gambit2"] }
        if currentMode == "PvE"                 { return getPvEImage(activity: i) }
        if currentMode == "PvP: Quickplay"      { return getPvPImage(activity: i) }
        return [""]
    }
    
    func getPvEImage(activity: ActivityInformation) -> [String] {
        if activity.activityDetails.mode == 2           { return ["strike", "Story", "vanguard-1"] }
        else if activity.activityDetails.mode == 3      { return ["strike", "Strike", "vanguard-1"] }
        else if activity.activityDetails.mode == 7      { return ["strike", "General PvE", "vanguard-1"] }
        else if activity.activityDetails.mode == 18     { return ["strike", "Strike", "vanguard-1"] }
        else if activity.activityDetails.mode == 58     { return ["strike", "Heroic Adventure", "vanguard-1"] }

        else if activity.activityDetails.mode == 6      { return ["patrol2", "Patrol", "patrol3"] }
        else if activity.activityDetails.mode == 16     { return ["nightfall", "Nightfall", "vanguard-1"] }
        else if activity.activityDetails.mode == 17     { return ["nightfall", "Heroic Nightfall", "vanguard-1"] }
        else if activity.activityDetails.mode == 46     { return ["nightfall", "Scored Nightfall", "vanguard-1"] }

        else if activity.activityDetails.mode == 77     { return ["managerie-1", "Menagerie", "managerie2"] }
        else if activity.activityDetails.mode == 79     { return ["nightmare5", "Nightmare Hunt", "nightmare2"] }
        else if activity.activityDetails.mode == 4      { return ["raid", "Raid", "raid2"] }
        else if activity.activityDetails.mode == 82     { return ["raid", "Dungeon", "raid2"] }
        else if activity.activityDetails.mode == 78     { return ["raid", "Vex Offensive", "raid2"] }

        else if activity.activityDetails.mode == 66     { return ["forge", "Forge Ignition", "forge2"] }
        else { return ["strike", "General PvE", "vanguard-1"] }
    }
    
    func getPvPImage(activity: ActivityInformation) -> [String] {
        if activity.activityDetails.mode == 48          { return ["rumble", "Rumble", "pvpcarnage"] }
        else if activity.activityDetails.mode == 37     { return ["survival", "Survival", "pvpcarnage"] }
        else if activity.activityDetails.mode == 59     { return ["survival", "Showdown", "pvpcarnage"] }
        else if activity.activityDetails.mode == 60     { return ["survival", "Lockdown", "pvpcarnage"] }

        else if activity.activityDetails.mode == 71     { return ["clash", "Clash", "pvpcarnage"] }
        else if activity.activityDetails.mode == 81     { return ["clash", "Momentum", "pvpcarnage"] }
        else if activity.activityDetails.mode == 67     { return ["clash", "Salvage", "pvpcarnage"] }
        else if activity.activityDetails.mode == 62     { return ["clash", "Scorched", "pvpcarnage"] }

        else if activity.activityDetails.mode == 73 { return ["control", "Control", "pvpcarnage"] }
        else if activity.activityDetails.mode == 80 { return ["elimination", "Elimination", "pvpcarnage"] }
        else {return ["clash", "PvP Quickplay", "pvpcarnage"]}
    }
}
