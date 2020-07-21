//
//  PvEStatDisplayCell.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/17/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit

class StatCellCollectionView: UICollectionViewCell {
    
    let pvpCellId = "pvpCell"
    let gambitCellId = "gambitCell"
    let pveCellId = "pveCell"
    let cellPadding = 16
    var pvpStats = [PVPGameModeAllTime?]()
    var gambitStats = [GambitModeAllTime?]()
    var pveStats = [PVE_AllTime?]()
    var img = [String]()
    var bgColor = [UIColor]()
    var textColor = [UIColor]()
    var currentIndex = Int() {
        didSet {
            CellCollectionView.reloadData()
        }
    }
    
    lazy var  CellCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 51
        let collectionView = UICollectionView(frame: self.contentView.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(PvPStats.self, forCellWithReuseIdentifier: pvpCellId)
        collectionView.register(GambitStats.self, forCellWithReuseIdentifier: gambitCellId)
        collectionView.register(PvEStats.self, forCellWithReuseIdentifier: pveCellId)

        //collectionView.backgroundColor = UIColor(red: 36/255, green: 41/255, blue: 46/255, alpha: 1)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        // setUpCellCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCellCollectionView() {
        contentView.addSubview(CellCollectionView)
        
        // Constriants
        CellCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        CellCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        CellCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        CellCollectionView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        // Delegate & Data Source
        CellCollectionView.delegate = self
        CellCollectionView.dataSource = self
    }
}


extension StatCellCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !pvpStats.isEmpty { return pvpStats.count }
        else if !gambitStats.isEmpty { return gambitStats.count }
        return pveStats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width - CGFloat(cellPadding), height: (contentView.frame.height - CGFloat(cellPadding)))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !pvpStats.isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pvpCellId, for: indexPath) as! PvPStats
            cell.cornerRadiusFromParent = 25
            cell.pvpStats = self.pvpStats[indexPath.row]
            cell.currentIndex = self.currentIndex
            cell.imageName = img[indexPath.row]
            cell.bgColor = self.bgColor[indexPath.row]
            cell.textColor = self.textColor[indexPath.row]
            cell.setUpRootStackView()
            return cell

        } else if !gambitStats.isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gambitCellId, for: indexPath) as! GambitStats
            cell.cornerRadiusFromParent = 25
            cell.gambitStats = self.gambitStats
            cell.currentIndex = self.currentIndex
            cell.imageName = img[indexPath.row]
            cell.bgColor = self.bgColor[indexPath.row]
            cell.textColor = self.textColor[indexPath.row]
            cell.setUpRootStackView()
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pveCellId, for: indexPath) as! PvEStats
            cell.cornerRadiusFromParent = 25
            cell.pveStats = self.pveStats[indexPath.row]
            cell.currentIndex = self.currentIndex
            cell.imageName = img[indexPath.row]
            cell.bgColor = self.bgColor[indexPath.row]
            cell.textColor = self.textColor[indexPath.row]
            cell.setUpRootStackView()
            return cell
        }
    }
}
