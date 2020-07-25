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
        
        if currentMode == "Iron Banner"         { return ["ironbanner-1", "Iron Banner"] }
        if currentMode == "Trials of Osiris"    { return ["trials-1", "Trials of Osiris"] }
        if currentMode == "PvP: Competitive"    { return ["survival", "Competitive PvP"] }
        if currentMode == "Gambit/Gambit Prime" { return i.activityDetails.mode == 63 ? ["gambit-1", "Gambit"] : ["gambit-1", "Gambit Prime"] }
        if currentMode == "PvE"                 { return getPvEImage(activity: i) }
        if currentMode == "PvP: Quickplay"      { return getPvPImage(activity: i) }
        return [""]
    }
    
    func getPvEImage(activity: ActivityInformation) -> [String] {
        if activity.activityDetails.mode == 2           { return ["strike", "Story"] }
        else if activity.activityDetails.mode == 3      { return ["strike", "Strike"] }
        else if activity.activityDetails.mode == 7      { return ["strike", "General PvE"] }
        else if activity.activityDetails.mode == 18     { return ["strike", "Strike"] }
        else if activity.activityDetails.mode == 58     { return ["strike", "Heroic Adventure"] }

        else if activity.activityDetails.mode == 6      { return ["patrol2", "Patrol"] }
        else if activity.activityDetails.mode == 16     { return ["nightfall", "Nightfall"] }
        else if activity.activityDetails.mode == 17     { return ["nightfall", "Heroic Nightfall"] }
        else if activity.activityDetails.mode == 46     { return ["nightfall", "Scored Nightfall"] }

        else if activity.activityDetails.mode == 77     { return ["managerie-1", "Menagerie"] }
        else if activity.activityDetails.mode == 79     { return ["nightmare5", "Nightmare Hunt"] }
        else if activity.activityDetails.mode == 4      { return ["raid", "Raid"] }
        else if activity.activityDetails.mode == 82     { return ["raid", "Dungeon"] }
        else if activity.activityDetails.mode == 78     { return ["raid", "Vex Offensive"] }

        else if activity.activityDetails.mode == 66     { return ["forge", "Forge Ignition"] }
        else { return ["strike", "General PvE"] }
    }
    
    func getPvPImage(activity: ActivityInformation) -> [String] {
        if activity.activityDetails.mode == 48          { return ["rumble", "Rumble"] }
        else if activity.activityDetails.mode == 37     { return ["survival", "Survival"] }
        else if activity.activityDetails.mode == 59     { return ["survival", "Showdown"] }
        else if activity.activityDetails.mode == 60     { return ["survival", "Lockdown"] }

        else if activity.activityDetails.mode == 71     { return ["clash", "Clash"] }
        else if activity.activityDetails.mode == 81     { return ["clash", "Momentum"] }
        else if activity.activityDetails.mode == 67     { return ["clash", "Salvage"] }
        else if activity.activityDetails.mode == 62     { return ["clash", "Scorched"] }

        else if activity.activityDetails.mode == 73 { return ["control", "Control"] }
        else if activity.activityDetails.mode == 80 { return ["elimination", "Elimination"] }
        else {return ["clash", "PvP Quickplay"]}
    }
}
