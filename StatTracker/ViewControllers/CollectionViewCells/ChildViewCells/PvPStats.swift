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
    
    var pvpStats: PVPGameModeAllTime?
    var currentIndex = Int()
    var imageName = String()
    var bgColor = UIColor()
    var textColor = UIColor()
    var swipetext = String()
    
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
        // gameModeImage.addTextToImage(drawText: "", atPoint: CGPoint(x: contentView.frame.width - 100, y: 10), imgView: gameModeImage)
        
        statHolderStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4).isActive = true
        statHolderStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        if let pvp = self.pvpStats {
            sample1.vals = ["\(pvp.allTime.kills.basic.displayValue)", "\(pvp.allTime.assists.basic.displayValue)", "\(pvp.allTime.deaths.basic.displayValue)", "\(pvp.allTime.activitiesEntered.basic.displayValue)"]
            
            sample2.vals = ["\(round((pvp.allTime.activitiesWon.basic.value / pvp.allTime.activitiesEntered.basic.value) * 100))%", "\(pvp.allTime.killsDeathsRatio.basic.displayValue)", "\(pvp.allTime.killsDeathsAssists.basic.displayValue)", "\(pvp.allTime.secondsPlayed.basic.displayValue)"]
        } else {
            sample1.vals = ["0", "0", "0", "0"]
            sample2.vals = ["0", "0", "0", "0"]
        }
        
        sample1.titles = ["Kills", "Assists", "Deaths", "Matches"]
        sample2.titles = ["W/L", "KD", "KAD", "Time Played"]
        
        sample1.bgColor = self.bgColor
        sample2.bgColor = self.bgColor
        
        sample1.textColor = self.textColor
        sample2.textColor = self.textColor
        
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
    
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.white
        let textFont = UIFont(name: "DINAlternate-Bold", size: 12)!

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
    func addTextToImage(drawText text: String, atPoint point: CGPoint, imgView: UIImageView) {
        let lblNew = UITextView()
        lblNew.frame = CGRect(x: point.x, y: point.y, width: 100, height: 40)
        lblNew.textAlignment = .right
        lblNew.font = UIFont(name: "DINAlternate-Bold", size: 12)
        lblNew.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        lblNew.text = text
        lblNew.textColor = UIColor.white
        lblNew.backgroundColor = .clear
        imgView.addSubview(lblNew)
    }
}
