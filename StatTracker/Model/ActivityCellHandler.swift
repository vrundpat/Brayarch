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
    
    func getImageName(i: ActivityInformation, currentMode: String) -> String {
        
        if currentMode == "Iron Banner"         { return "ironbanner-1" }
        if currentMode == "Trials of Osiris"    { return "trials-1" }
        if currentMode == "PvP: Competitive"    { return "survival" }
        if currentMode == "Gambit/Gambit Prime" { return "gambit-1" }
        if currentMode == "PvE"                 { return getPvEImage(activity: i) }
        if currentMode == "PvP: Quickplay"      { return getPvPImage(activity: i) }
        return ""
    }
    
    func getPvEImage(activity: ActivityInformation) -> String {
        if activity.activityDetails.mode == 2           { return "strike" }
        else if activity.activityDetails.mode == 3      { return "strike" }
        else if activity.activityDetails.mode == 7      { return "strike" }
        else if activity.activityDetails.mode == 18     { return "strike" }
        else if activity.activityDetails.mode == 58     { return "strike" }

        else if activity.activityDetails.mode == 6      { return "patrol2" }
        else if activity.activityDetails.mode == 16     { return "nightfall" }
        else if activity.activityDetails.mode == 17     { return "nightfall" }
        else if activity.activityDetails.mode == 46     { return "nightfall" }

        else if activity.activityDetails.mode == 77     { return "managerie-1" }
        else if activity.activityDetails.mode == 79     { return "nightmare5" }
        else if activity.activityDetails.mode == 4      { return "raid" }
        else if activity.activityDetails.mode == 82     { return "raid" }
        else if activity.activityDetails.mode == 78     { return "raid" }

        else if activity.activityDetails.mode == 66     { return "forge" }
        else { return "strike" }
    }
    
    func getPvPImage(activity: ActivityInformation) -> String {
        if activity.activityDetails.mode == 48          { return "rumble" }
        else if activity.activityDetails.mode == 37     { return "survival" }
        else if activity.activityDetails.mode == 59     { return "survival" }
        else if activity.activityDetails.mode == 60     { return "survival" }

        else if activity.activityDetails.mode == 71     { return "clash" }
        else if activity.activityDetails.mode == 81     { return "clash" }
        else if activity.activityDetails.mode == 67     { return "clash" }
        else if activity.activityDetails.mode == 62     { return "clash" }

        else if activity.activityDetails.mode == 73 { return "control" }
        else if activity.activityDetails.mode == 80 { return "elimination" }
        else {return "clash"}
    }
}
