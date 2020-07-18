//
//  PvPStats.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/17/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit

class PvPStats: UICollectionViewCell {
    
    var cornerRadiusFromParent = CGFloat() {
        didSet {
            self.layer.cornerRadius = cornerRadiusFromParent
        }
    }
    
    var pvpStats = [GameModes]()
    var currentIndex = Int()
    
    let sample1 = StackViewText()
    let sample2 = StackViewText()
    
    var lbl: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "rootBg4")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 25
        iv.clipsToBounds = true
        return iv
    }()
    
    var rootStackView: UIStackView = {
        let rootSV = UIStackView()
        rootSV.translatesAutoresizingMaskIntoConstraints = false
        rootSV.axis = .vertical
        rootSV.backgroundColor = .white
        return rootSV
    }()
    
    var statHolderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .yellow
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpRootStackView() {
        
        contentView.addSubview(rootStackView)
        
        rootStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        rootStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        rootStackView.addArrangedSubview(lbl)
        rootStackView.addArrangedSubview(statHolderStackView)
        
        lbl.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: CGFloat(25))
        lbl.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6).isActive = true
        lbl.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true

        statHolderStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4).isActive = true
        statHolderStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        if let pvp = self.pvpStats[currentIndex].pvpQuickplay {
            sample1.vals = ["\(pvp.allTime.kills.basic.displayValue)", "\(pvp.allTime.assists.basic.displayValue)", "\(pvp.allTime.deaths.basic.displayValue)", "\(pvp.allTime.activitiesEntered.basic.displayValue)"]
            
            sample2.vals = ["\(pvp.allTime.suicides.basic.displayValue)", "\(pvp.allTime.killsDeathsRatio.basic.displayValue)", "\(pvp.allTime.killsDeathsAssists.basic.displayValue)", "\(pvp.allTime.efficiency.basic.displayValue)"]

        } else {
            sample1.vals = ["0", "0", "0", "0"]
            sample2.vals = ["0", "0", "0", "0"]
        }
        
        sample1.titles = ["Kills", "Assists", "Deaths", "Matches"]
        sample2.titles = ["Suicides", "KD", "KAD", "Efficiency"]
        sample1.setUpStack()
        sample2.setUpStack()
        
        // Corner Radius
        sample2.sample1.textLabel2.roundCorners(corners: [.layerMinXMaxYCorner], radius: CGFloat(20))
        sample2.sample4.textLabel2.roundCorners(corners: [.layerMaxXMaxYCorner], radius: CGFloat(20))
        
        statHolderStackView.addArrangedSubview(sample1)
        statHolderStackView.addArrangedSubview(sample2)
    }
}


extension UIView {

   func roundCorners(corners:CACornerMask, radius: CGFloat) {
      self.layer.cornerRadius = radius
      self.layer.maskedCorners = corners
   }
}
