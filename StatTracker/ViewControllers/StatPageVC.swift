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
            // print(UserCharacterStats[0].pvpQuickplay)
            print("Stats Received")
            UserCharacterStats.sort(by: self.sortCharacters(this:that:))
        }
    }
    
    var currentUserBeingDisplayed = String()
    var currentDisplayedCharacterIndex = Int() {
        didSet {
            rootCollectionView.reloadData()
        }
    }
    
    let cellId = "statCell"
    let headerId = "statCellHeader"
    let rootCV_CellPadding = 16
    
    lazy var  rootCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PvPStatDisplayCollectionView.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(StatCellHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        return collectionView
    }()

    @objc func toggle() {
        if currentDisplayedCharacterIndex != UserCharacterStats.count - 1 { currentDisplayedCharacterIndex += 1 }
        else { currentDisplayedCharacterIndex = 0 }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        navigationItem.title = self.currentUserBeingDisplayed
        currentDisplayedCharacterIndex = 0
        setUpRootCollectionView()
    }
    
    func setUpRootCollectionView() {
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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: CGFloat(400))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PvPStatDisplayCollectionView
        
        if indexPath.section == 0 {
            let stats = self.UserCharacterStats[currentDisplayedCharacterIndex].pvpQuickplay
            let statArray = [stats, self.UserCharacterStats[currentDisplayedCharacterIndex].pvpCompetitive]
            cell.pvpStats = statArray
            cell.currentIndex = self.currentDisplayedCharacterIndex
            cell.img = ["valor", "glory"]
            cell.bgColor = [.black, .black]
            cell.textColor = [.orange, .red]
        }
        else if indexPath.section == 1 {
            let stats = self.UserCharacterStats[currentDisplayedCharacterIndex].trials_of_osiris
            let statArray = [stats]
            cell.pvpStats = statArray
            cell.currentIndex = self.currentDisplayedCharacterIndex
            cell.img = ["trials2"]
            cell.bgColor = [.black]
            cell.textColor = [.yellow]
        }
        else if indexPath.section == 2 {
            let stats = self.UserCharacterStats[currentDisplayedCharacterIndex].ironBanner
            let statArray = [stats]
            cell.pvpStats = statArray
            cell.currentIndex = self.currentDisplayedCharacterIndex
            cell.img = ["ironbanner"]
            cell.bgColor = [.black]
            cell.textColor = [.yellow]
        }
        
        cell.setUpCellCollectionView()
        return cell
    }
    
    // Header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! StatCellHeader
        header.setUpHeader()
        return header
    }
}
