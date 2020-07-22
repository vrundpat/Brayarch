//
//  TextStackView.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/17/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit

class StackViewText: UIStackView {
    
    var titles = [String]()
    var vals = [String]()
    
    var topInset: CGFloat?
    
    var textColor = UIColor()
    var bgColor = UIColor()
        
    let sample1 = OverlappedText()
    let sample2 = OverlappedText()
    let sample3 = OverlappedText()
    let sample4 = OverlappedText()
        
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
        
        let overLappedTextArray = [sample1, sample2, sample3, sample4]
        
        for overlappedTextPosition in 0...self.titles.count - 1 {
            let sample1 = overLappedTextArray[overlappedTextPosition]
            sample1.titles = self.titles[overlappedTextPosition]
            sample1.vals = self.vals[overlappedTextPosition]
            sample1.textColor = self.textColor
            sample1.bgColor = self.bgColor
            sample1.topInset = self.topInset
            sample1.setUpOverlayText()
            addArrangedSubview(sample1)
        }
    }
}



class OverlappedText: UIStackView {
    
    let textLabel1 = UITextView()
    let textLabel2 = UITextView()
    
    var titles = String()
    var vals = String()
    var textColor = UIColor()
    var bgColor = UIColor()
    var topInset: CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpOverlayText() {
        
        axis = .vertical
        distribution = .fillProportionally
        translatesAutoresizingMaskIntoConstraints = false
        spacing = 0
        
        addArrangedSubview(textLabel1)
        addArrangedSubview(textLabel2)
        
        textLabel1.isEditable = false
        textLabel1.backgroundColor = UIColor.yellow
        textLabel1.text  = "\(self.vals)"
        textLabel1.font = UIFont(name: "DINAlternate-Bold", size: 20)
        textLabel1.textAlignment = .center
        textLabel1.translatesAutoresizingMaskIntoConstraints = false
        textLabel1.textContainer.lineFragmentPadding = 0
        textLabel1.textContainerInset = UIEdgeInsets(top: topInset!, left: 0, bottom: 0, right: 0)
        textLabel1.showsVerticalScrollIndicator = false
        textLabel1.showsHorizontalScrollIndicator = false
        textLabel1.textColor = self.textColor
        textLabel1.backgroundColor = self.bgColor
        
        textLabel2.isEditable = false
        textLabel2.backgroundColor = UIColor.yellow
        textLabel2.text  = "\(self.titles)"
        textLabel2.textAlignment = .center
        textLabel2.translatesAutoresizingMaskIntoConstraints = false
        textLabel2.textContainer.lineFragmentPadding = 0
        textLabel2.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textLabel2.showsVerticalScrollIndicator = false
        textLabel2.showsHorizontalScrollIndicator = false
        textLabel2.textColor = self.textColor
        textLabel2.backgroundColor = self.bgColor
    }
}
