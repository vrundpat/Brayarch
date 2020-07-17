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
    
    var lbl: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "rootBg3")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 25
        iv.clipsToBounds = true
        return iv
    }()
    
    var statHolderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .yellow
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    var rootStackView: UIStackView = {
        let rootSV = UIStackView()
        rootSV.translatesAutoresizingMaskIntoConstraints = false
        rootSV.axis = .vertical
        rootSV.backgroundColor = .white
        return rootSV
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
        
        let sample1 = StackViewText()
        let sample2 = StackViewText()
        
        if let pvp = self.pvpStats[0].pvpQuickplay {
            sample1.vals = ["\(pvp.allTime.kills.basic.displayValue)", "\(pvp.allTime.assists.basic.displayValue)", "\(pvp.allTime.deaths.basic.displayValue)"]

        } else { sample1.vals = ["0", "0", "0"] }
        
        sample1.titles = ["Kills", "Assists", "Deaths"]
        sample2.titles = ["test1", "test2", "test3"]
        sample2.vals = ["1", "2", "3"]
        
        sample1.setUpStack()
        sample2.setUpStack()
        
        sample2.textLabel1.layer.masksToBounds = true
        sample2.textLabel3.layer.masksToBounds = true
        sample2.textLabel1.roundCorners(corners: [.layerMinXMaxYCorner], radius: CGFloat(25))
        sample2.textLabel3.roundCorners(corners: [.layerMaxXMaxYCorner], radius: CGFloat(25))


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



class StackViewText: UIStackView {
    
    var titles = [String]()
    var vals = [String]()
    
    let textLabel1 = UILabel()
    let textLabel2 = UILabel()
    let textLabel3 = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpStack() {
                        
        axis = .horizontal
        distribution = .fillEqually
        translatesAutoresizingMaskIntoConstraints = false
        
        addArrangedSubview(textLabel1)
        addArrangedSubview(textLabel2)
        addArrangedSubview(textLabel3)
        
        textLabel1.backgroundColor = UIColor.yellow
        textLabel1.text  = "\(self.titles[0]): \(self.vals[0])"
        textLabel1.textAlignment = .center
        textLabel1.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel2.backgroundColor = UIColor.yellow
        textLabel2.text  = "\(self.titles[1]): \(self.vals[1])"
        textLabel2.textAlignment = .center
        textLabel2.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel3.text  = "\(self.titles[2]): \(self.vals[2])"
        textLabel3.textAlignment = .center
        textLabel3.translatesAutoresizingMaskIntoConstraints = false
        textLabel3.backgroundColor = .blue
        textLabel3.layer.masksToBounds = false
    }
    
}
