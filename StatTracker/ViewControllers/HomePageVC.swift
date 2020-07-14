//
//  HomeViewController.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/10/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit
import AVFoundation

class HomePageVC: UIViewController {
    
    
    // For Background Video
    var player: AVPlayer?
    
    
    var apiDataModel: APIEssentialsController!
    let tableSearchview = GuardianSearchTableVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        setUpBackground()
        setUpPlatformButtonsStackView()
        setUpGuardianSearchTableVC()
        setUpNavigationSearchController()
    }
    
    func setUpBackground() {
//        let backgroundImg = UIImage(named: "rootBg3")
//        let backgroundImageView = UIImageView(frame: self.view.frame)
//        backgroundImageView.image = backgroundImg
//        view.insertSubview(backgroundImageView, at: 0)
        
        let path = Bundle.main.path(forResource: "bgVideo", ofType: "mp4")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        player!.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.insertSublayer(playerLayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
        player!.seek(to: CMTime.zero)
        player!.play()
        self.player?.isMuted = true
    }
    
    @objc func playerItemDidReachEnd() {
        player!.seek(to: CMTime.zero)
    }
        
    func setUpGuardianSearchTableVC() {
        addChildViewController(child: tableSearchview)
        tableSearchview.apiDataModel = self.apiDataModel
    }
    
    func setUpNavigationSearchController() {
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
        
        navigationItem.searchController = tableSearchview.guardianSearchController
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Find your Guardian...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        

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
        platformButtonStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
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
