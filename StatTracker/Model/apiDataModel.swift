//
//  apiDataModel.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/13/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import Foundation

struct APIEssentials {
    var memberShipType: Int
}

class APIEssentialsController {
    var apiEssentials = APIEssentials(memberShipType: 3)
}
