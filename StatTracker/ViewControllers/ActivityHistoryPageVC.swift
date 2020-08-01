//
//  ActivityHistoryPageVC.swift
//  StatTracker
//
//  Created by Vrund Patel on 8/1/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit

class ActivityHistoryPageVC: UIViewController {
    
    var data = [ActivityInformation]()
    
    var currentUserBeingDisplayed = String()
    var currentUserIdentifier = String()
    var currentMode = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    func removeOverlayAndDisplayStats() {
        
    }
}
