//
//  HomeViewController.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/10/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController {
    
    var apiDataModel: APIEssentialsController!
    let tableSearchview = GuardianSearchTableVC()
    let platformButtons = [PlatformButton(), PlatformButton(), PlatformButton()]
    let platformFormButtonTitles = ["Xbox", "PS4", "Steam"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpPlatformButtons()
        setUpGuardianSearchTableVC()
        setUpNavigationSearchController()
    }
        
    func setUpGuardianSearchTableVC() {
        addChildViewController(child: tableSearchview)
        tableSearchview.apiDataModel = self.apiDataModel
    }
    
    func setUpNavigationSearchController() {
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
                        
        navigationItem.searchController = tableSearchview.guardianSearchController

        navigationItem.title = "StatTracker"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
    }
    
    func setUpPlatformButtons() {
        var i = 0
        for button in self.platformButtons {
            view.addSubview(button)
            button.isTriggered = false
            button.setTitle(self.platformFormButtonTitles[self.platformButtons.firstIndex(of: button)!], for: .normal)
            button.addTarget(self, action: #selector(platformButtonClicked), for: .touchUpInside)
            button.frame = CGRect(x: 50 + i, y: 350, width: 100, height: 50)
            i += 110
        }
    }
    
    @objc func platformButtonClicked(sender: PlatformButton) {
        sender.isTriggered = true
        for button in self.platformButtons {
            if button != sender { button.isTriggered = false }
        }
        
        self.apiDataModel.apiEssentials.memberShipType = self.platformButtons.firstIndex(of: sender)! + 1
    }
    
    func addChildViewController(child: UIViewController) {
        
        // Add child to current view controller
        self.addChild(child)
        self.view.addSubview(child.view)
        child.view.frame = view.bounds
        
        // Register child view controller
        child.didMove(toParent: self)
    }
}

