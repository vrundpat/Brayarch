//
//  StatPageVC.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/10/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class StatPageVC: UIViewController {
    
    var test = StatHandler()
    
    var UserCharacterStats = [GameModes]() {
        didSet {
            print("Stats Received")
            //UserCharacterStats.sort(by: self.sortCharacters(this:that:))
            print(currentUserCharacterIds) // Somehow sort the characterIds array based on the order the UserCharacterStats was sorted
        }
    }
    
    lazy var navigationTitle: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = true
        textView.font = UIFont(name: "DINAlternate-Bold", size: 20)
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false 
        return textView
    }()
    
    lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "statBg-1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var currentUserBeingDisplayed = String()
    var currentUserDestinyMembershipId = String()
    var currentUserMembershipType = Int()
    var currentUserCharacterIds = [String]()

    
    var currentDisplayedCharacterIndex = Int() {
        didSet {
            pvpEssentialStats = [
                [],
                [UserCharacterStats[currentDisplayedCharacterIndex].allPvP],
                [UserCharacterStats[currentDisplayedCharacterIndex].pvpCompetitive],
                [UserCharacterStats[currentDisplayedCharacterIndex].trials_of_osiris],
                [UserCharacterStats[currentDisplayedCharacterIndex].ironBanner]
            ]
            
            gambitEssentialStats = [
                [UserCharacterStats[currentDisplayedCharacterIndex].pvecomp_gambit, UserCharacterStats[currentDisplayedCharacterIndex].pvecomp_mamba]
            ]
            
            pveEssentialStats = [[UserCharacterStats[currentDisplayedCharacterIndex].allPvE]]
            
            rootCollectionView.reloadData()
    
            if let light_level = UserCharacterStats[currentDisplayedCharacterIndex].allPvE?.allTime.highestLightLevel.basic.displayValue {
                navigationTitle.text = "\(currentUserBeingDisplayed) : \(light_level)"
            }
        }
    }
    
    let cellId = "statCell"
    let pvpCellId = "pvpCell"
    let headerId = "statCellHeader"
    
    let cellEssentialsImages: [[String]] = [
        ["vanguard"],
        ["valor"],
        ["glory"],
        ["trials"],
        ["ironbanner"],
        ["gambit"],
    ]
    let cellEssentialsBgColor: [[UIColor]] = [
        [UIColor(red: 58/255, green: 74/255, blue: 99/255, alpha: 1)],
        [UIColor(red: 11/255, green: 11/255, blue: 11/255, alpha: 1)],
        [UIColor(red: 5/255, green: 5/255, blue: 0/255, alpha: 1)],
        [UIColor(red: 21/255, green: 21/255, blue: 21/255, alpha: 1)],
        [UIColor(red: 52/255, green: 87/255, blue: 70/255, alpha: 1)],
        [UIColor(red: 33/255, green: 38/255, blue: 44/255, alpha: 1)],
    ]
    let cellEssentialsTextColor: [[UIColor]] = [
        [UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)],
        [UIColor.orange],
        [UIColor.red],
        [UIColor(red: 196/255, green: 193/255, blue: 37/255, alpha: 1)],
        [UIColor(red: 149/255, green: 203/255, blue: 175/255, alpha: 1)],
        [UIColor(red: 113/255, green: 200/255, blue: 158/255, alpha: 1)],
    ]
        
    var pvpEssentialStats = [[PVPGameModeAllTime?]]()
    var gambitEssentialStats = [[GambitModeAllTime?]]()
    var pveEssentialStats = [[PVE_AllTime?]]()
    let rootCV_CellPadding = 16
    let loading = NVActivityIndicatorView(frame: .zero, type: .audioEqualizer, color: .white, padding: 0)
    
    lazy var  rootCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(GenericStatCell.self, forCellWithReuseIdentifier: pvpCellId)
        collectionView.register(StatCellHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        return collectionView
    }()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpNVActivityIndiacatorView()
        loading.startAnimating()
    }
    
    func removeOverlayAndDisplayStats() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.loading.stopAnimating()
            self.loading.isHidden = true
            self.view.backgroundColor = .clear
            self.currentDisplayedCharacterIndex = 0
            self.setUpRootCollectionView()
        })
    }
    
    func setUpNVActivityIndiacatorView() {
        loading.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loading)
        
        loading.widthAnchor.constraint(equalToConstant: 50).isActive = true
        loading.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loading.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func toggle() {
        if currentDisplayedCharacterIndex == 0 && UserCharacterStats.count == 1 { return }
        if currentDisplayedCharacterIndex != UserCharacterStats.count - 1 { currentDisplayedCharacterIndex += 1 }
        else { currentDisplayedCharacterIndex = 0 }
    }
    
    func setUpRootCollectionView() {
        
        view.addSubview(bgImageView)
        
        navigationItem.titleView = navigationTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(toggle))

        view.addSubview(rootCollectionView)
        //rootCollectionView.backgroundColor = .black
        rootCollectionView.backgroundColor = .clear
        
        // Constriants
        rootCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        rootCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        rootCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        rootCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        
        // Delegate & Data Source
        rootCollectionView.delegate = self
        rootCollectionView.dataSource = self
    }
    
    func sortCharacters(this: GameModes, that: GameModes) -> Bool {
        return Int((this.allPvE?.allTime.kills.basic.value)!) > Int((that.allPvE?.allTime.kills.basic.value)!)
    }
}


// Collection View Extenstions
extension StatPageVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 6 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return 1 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: CGFloat(400))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pvpCellId, for: indexPath) as! GenericStatCell
        
        cell.cornerRadiusFromParent = 25
        cell.imageName = self.cellEssentialsImages[indexPath.section][0]
        cell.bgColor = self.cellEssentialsBgColor[indexPath.section][0]
        cell.textColor = self.cellEssentialsTextColor[indexPath.section][0]
        
        if indexPath.section == 0 {
            cell.titles = [["Kills", "Assists", "Deaths", "Activities"], ["Orbs Made", "KD", "Suicides", "Time Played"]]
            cell.values = self.test.pveValues(mode: self.pveEssentialStats[0][0])
        }
        
        if indexPath.section >= 1 && indexPath.section <= 4 {
            cell.titles = [["Kills", "Assists", "Deaths", "Matches"], ["W/L", "KD", "KAD", "Time Played"]]
            cell.values = self.test.pvpValues(mode: self.pvpEssentialStats[indexPath.section][0])
        }
        
        if indexPath.section == 5 {
            cell.titles = [["Kills", "Assists", "Deaths", "Matches"], ["W/L", "Motes Banked", "Invasions", "Time Played"]]
            cell.values = self.test.gambitValues(mode: self.gambitEssentialStats[0])
        }
        
        cell.setUpRootStackView()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var mode = String()
        
        if indexPath.section == 0 { mode = "7" }
        if indexPath.section == 1 { mode = "5" }
        if indexPath.section == 2 { mode = "69" }
        if indexPath.section == 3 { mode = "84" }
        if indexPath.section == 4 { mode = "19" }
        if indexPath.section == 5 { mode = "64" }

        print("Mode: \(mode)")
        let destinationVC = ActivityHistoryPageVC()
        self.navigationController?.pushViewController(destinationVC, animated: true)

        let group = DispatchGroup()
        group.enter()
        
        let characterActivityHistory = FetchActivityHistoryRequest(memberShipType: self.currentUserMembershipType, destinyMembershipId: self.currentUserDestinyMembershipId, characterId: self.currentUserCharacterIds[currentDisplayedCharacterIndex], mode: mode)
    
        characterActivityHistory.getActivityHistory { [weak self] result in
            switch result {
                case .failure(let error):
                    print(error)
                    group.leave()

                case .success(let activityHistory):
                    print(activityHistory.activities.count)
                    destinationVC.data = activityHistory.activities
                    group.leave()
            }
        }
        
        group.notify(queue: .main) {
            destinationVC.removeOverlayAndDisplayStats()
        }
    }
}
