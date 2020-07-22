//
//  PvPStats.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/17/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit

class GenericStatCell: UICollectionViewCell {
    
    var cornerRadiusFromParent = CGFloat() {
        didSet {
            self.layer.cornerRadius = cornerRadiusFromParent
        }
    }
    
    var imageName = String()
    var bgColor = UIColor()
    var textColor = UIColor()
    var swipetext = String()
    var titles = [[String]]()
    var values = [[String]]()
    
    let sample1 = StackViewText()
    let sample2 = StackViewText()
    
    var gameModeImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    var swipeText: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Swipe"
        textView.textColor = .white
        return textView
    }()
    
    var rootStackView: UIStackView = {
        let rootSV = UIStackView()
        rootSV.translatesAutoresizingMaskIntoConstraints = false
        rootSV.axis = .vertical
        rootSV.backgroundColor = UIColor.clear
        return rootSV
    }()

    var statHolderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
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
        
        rootStackView.addArrangedSubview(gameModeImage)
        rootStackView.addArrangedSubview(statHolderStackView)
        
        gameModeImage.image = UIImage(named: imageName)
        gameModeImage.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: CGFloat(25))
        gameModeImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6).isActive = true
        gameModeImage.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        statHolderStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4).isActive = true
        statHolderStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        self.setUpStatTextStackView()
        
        // Corner Radius
        sample2.sample1.textLabel2.roundCorners(corners: [.layerMinXMaxYCorner], radius: CGFloat(20))
        sample2.sample4.textLabel2.roundCorners(corners: [.layerMaxXMaxYCorner], radius: CGFloat(20))
        
        statHolderStackView.addArrangedSubview(sample1)
        statHolderStackView.addArrangedSubview(sample2)
    }
    
    func setUpStatTextStackView() {
        sample1.vals = self.values[0]
        sample2.vals = self.values[1]
        
        sample1.titles = self.titles[0]
        sample2.titles = self.titles[1]
        
        sample1.bgColor = self.bgColor
        sample2.bgColor = self.bgColor
        
        sample1.textColor = self.textColor
        sample2.textColor = self.textColor
        
        sample1.topInset = CGFloat(15)
        sample2.topInset = CGFloat(15)
        
        sample1.setUpStack()
        sample2.setUpStack()
    }
}


extension UIView {

    func roundCorners(corners:CACornerMask, radius: CGFloat) {
      self.layer.cornerRadius = radius
      self.layer.maskedCorners = corners
    }
}
