//
//  CarnageReportHandler.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/26/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import Foundation
import UIKit

struct CarnageReportEssentials {

    func getTableColors(imageName: String) -> [UIColor] {
        if imageName == "vanguard-1" { return [UIColor(red: 5/255, green: 17/255, blue: 31/255, alpha: 1), UIColor(red: 67/255, green: 75/255, blue: 98/255, alpha: 1), UIColor(red: 39/255, green: 42/255, blue: 49/255, alpha: 1)] }
        else if imageName == "trials2" { return [UIColor.black, UIColor(red: 124/255, green: 124/255, blue: 37/255, alpha: 1)] }
        else if  imageName == "pvpcarnage" { return [UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1), UIColor(red: 144/255, green: 45/255, blue: 41/255, alpha: 1)] }
        else if  imageName == "gambit2" { return [UIColor(red: 41/255, green: 43/255, blue: 42/255, alpha: 1), UIColor(red: 38/255, green: 84/255, blue: 71/255, alpha: 1)] }
        else if  imageName == "patrol3" { return [UIColor(red: 27/255, green: 71/255, blue: 70/255, alpha: 1), UIColor(red: 20/255, green: 52/255, blue: 58/255, alpha: 1)] }
        else if  imageName == "managerie2" { return [UIColor(red: 25/255, green: 23/255, blue: 46/255, alpha: 1), UIColor(red: 45/255, green: 40/255, blue: 72/255, alpha: 1)] }
        else if  imageName == "nightmare2" { return [UIColor(red: 43/255, green: 28/255, blue: 21/255, alpha: 1), UIColor(red: 58/255, green: 26/255, blue: 6/255, alpha: 1)] }
        else if  imageName == "raid2" { return [UIColor(red: 27/255, green: 27/255, blue: 26/255, alpha: 1), UIColor(red: 36/255, green: 41/255, blue: 46/255, alpha: 1)] }
        else if  imageName == "forge2" { return [UIColor(red: 5/255, green: 17/255, blue: 31/255, alpha: 1), UIColor(red: 67/255, green: 75/255, blue: 98/255, alpha: 1)] }
        else if  imageName == "pvpcarnage" { return [UIColor(red: 108/255, green: 47/255, blue: 44/255, alpha: 1), UIColor(red: 172/255, green: 56/255, blue: 45/255, alpha: 1)] }
        else if imageName == "ironbanner2" { return [UIColor(red: 21/255, green: 19/255, blue: 20/255, alpha: 1), UIColor(red: 25/255, green: 29/255, blue: 28/255, alpha: 1)] }
        else if imageName == "pvpcompcarnage" { return [UIColor(red: 32/255, green: 21/255, blue: 29/255, alpha: 1), UIColor(red: 56/255, green: 43/255, blue: 115/255, alpha: 1)] }
        else {return [UIColor.black, UIColor(red: 36/255, green: 41/255, blue: 46/255, alpha: 1)]}
    }
}
