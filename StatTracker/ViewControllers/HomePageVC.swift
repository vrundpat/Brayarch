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
    
    lazy var navigationTitle: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Brayarch Statistics"
        textView.font = UIFont(name: "DINAlternate-Bold", size: 33)
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false 
        return textView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        setUpBackground()
        setUpDescriptionLabel()
        setUpPlatformButtonsStackView()
        setUpGuardianSearchTableVC()
        setUpNavigationSearchController()
    }
    
    @objc func playerItemDidReachEnd() {
        player!.seek(to: CMTime.zero)
    }
    
    func setUpBackground() {
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
        
    func setUpGuardianSearchTableVC() {
        addChildViewController(child: tableSearchview)
        tableSearchview.apiDataModel = self.apiDataModel
    }

    func setUpNavigationSearchController() {
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
        
        navigationItem.titleView = navigationTitle
        navigationItem.searchController = tableSearchview.guardianSearchController
            
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
    
    func setUpDescriptionLabel() {
        let descriptionText = UILabel()
        
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionText.text = "Choose your platform, and find your Guardian."
        descriptionText.font = UIFont(name: "DINAlternate-Bold", size: 16)
        descriptionText.textColor = .white
        descriptionText.alpha = CGFloat(0.8)
        
        view.addSubview(descriptionText)

        descriptionText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionText.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        descriptionText.heightAnchor.constraint(equalToConstant: CGFloat(50)).isActive = true
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
