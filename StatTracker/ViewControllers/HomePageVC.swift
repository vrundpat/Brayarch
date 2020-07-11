//
//  HomeViewController.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/10/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpGuardianSearchBar_TableView()
    }
    
    func setUpGuardianSearchBar_TableView() {
        let tableSearchview = GuardianTableVC()
        addChildViewController(child: tableSearchview)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.searchController = tableSearchview.guardianSearchController
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






