//
//  PvEStatDisplayCell.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/17/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit

class PvPStatDisplayCollectionView: UICollectionViewCell {
    
    let cellId = "pveCell"
    let cellPadding = 16
    
    lazy var  CellCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: self.contentView.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .darkGray
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCellCollectionView()
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


extension PvPStatDisplayCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width - CGFloat(2 * cellPadding), height: (contentView.frame.height - CGFloat(cellPadding)))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .blue
        cell.layer.cornerRadius = 25
        return cell
    }
}
