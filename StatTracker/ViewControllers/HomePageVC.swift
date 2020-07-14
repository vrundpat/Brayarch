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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpRootView()
        setUpPlatformButtonsStackView()
        setUpGuardianSearchTableVC()
        setUpNavigationSearchController()
    }
    
    func setUpRootView() {
        let backgroundImg = UIImage(named: "rootBg3")
        let backgroundImageView = UIImageView(frame: self.view.frame)
        backgroundImageView.image = backgroundImg
        view.insertSubview(backgroundImageView, at: 0)
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
    
    func setUpPlatformButtonsStackView() {
        let platformButtonStackView = PlatFormButtonStackView()
        platformButtonStackView.apiDataModel = self.apiDataModel

        view.addSubview(platformButtonStackView)
        platformButtonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        platformButtonStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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
