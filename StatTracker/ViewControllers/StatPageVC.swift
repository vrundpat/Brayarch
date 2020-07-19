//
//  StatPageVC.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/10/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit

class StatPageVC: UIViewController {
    
    var UserCharacterStats = [GameModes]() {
        didSet {
            print("Stats Received")
            UserCharacterStats.sort(by: self.sortCharacters(this:that:))
        }
    }
    
    var currentUserBeingDisplayed = String()
    var currentDisplayedCharacterIndex = Int() {
        didSet {
            pvpEssentialStats = [
                [UserCharacterStats[currentDisplayedCharacterIndex].allPvP, UserCharacterStats[currentDisplayedCharacterIndex].pvpCompetitive],
                [UserCharacterStats[currentDisplayedCharacterIndex].trials_of_osiris],
                [self.UserCharacterStats[currentDisplayedCharacterIndex].ironBanner]
            ]
            rootCollectionView.reloadData()
            
            gambitEssentialStats = [
                [UserCharacterStats[currentDisplayedCharacterIndex].pvecomp_gambit, UserCharacterStats[currentDisplayedCharacterIndex].pvecomp_mamba]
            ]
        }
    }
    
    let cellId = "statCell"
    let headerId = "statCellHeader"
    var headerSwipeText = ["Swipe >>", "", "", "Swipe >>"]
    let headerEssentials: [String] = ["PvP: Quickplay & Competitive", "Crucible: Trials of Osiris", "Cruciible: Iron Banner", "Gambit & Gambit Prime"]
    let cellEssentialsImages: [[String]] = [["valor", "glory"], ["trials2"], ["ironbanner"], ["gambit", "gambitprime"]]
    let cellEssentialsBgColor: [[UIColor]] = [[UIColor.black, UIColor.black], [UIColor.black], [UIColor.black], [UIColor(red: 15/255, green: 32/255, blue: 42/255, alpha: 1), UIColor(red: 19/255, green: 78/255, blue: 60/255, alpha: 1)]]
    let cellEssentialsTextColor: [[UIColor]] = [[UIColor.orange, UIColor.red], [UIColor.yellow], [UIColor.yellow], [UIColor.white, UIColor.white]]
    var pvpEssentialStats = [[PVPGameModeAllTime?]]()
    var gambitEssentialStats = [[GambitModeAllTime?]]()
    let rootCV_CellPadding = 16
    
    lazy var  rootCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(StatCellCollectionView.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(StatCellHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        currentDisplayedCharacterIndex = 0
        setUpRootCollectionView()
    }
    
    @objc func toggle() {
        if currentDisplayedCharacterIndex == 0 && UserCharacterStats.count == 1 { return }
        if currentDisplayedCharacterIndex != UserCharacterStats.count - 1 { currentDisplayedCharacterIndex += 1 }
        else { currentDisplayedCharacterIndex = 0 }
    }
    
    func setUpRootCollectionView() {
        navigationItem.title = self.currentUserBeingDisplayed
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(toggle))
        
        view.addSubview(rootCollectionView)
        rootCollectionView.backgroundColor = .black
        
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: CGFloat(400))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StatCellCollectionView
        
        cell.pvpStats.removeAll()
        cell.gambitStats.removeAll()
        
        cell.currentIndex   =   self.currentDisplayedCharacterIndex
        cell.img            =   self.cellEssentialsImages[indexPath.section]
        cell.bgColor        =   self.cellEssentialsBgColor[indexPath.section]
        cell.textColor      =   self.cellEssentialsTextColor[indexPath.section]
        
        if indexPath.section < 3 {
            cell.pvpStats = self.pvpEssentialStats[indexPath.section]
        } else { cell.gambitStats = self.gambitEssentialStats[0] }
 
        cell.setUpCellCollectionView()
        return cell
    }
    
    // Header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! StatCellHeader
        header.headerTitle = self.headerEssentials[indexPath.section]
        header.swipetext = self.headerSwipeText[indexPath.section]
        header.setUpHeader()
        return header
    }
}
