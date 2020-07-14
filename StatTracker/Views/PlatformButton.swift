//
//  PlatformButton.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/13/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit

class PlatformButton: UIButton {
    
    var isTriggered = Bool() {
        didSet {
            if isTriggered { DispatchQueue.main.async { self.clickedAppearance() } }
            else { DispatchQueue.main.async { self.normalAppearance() } }
        }
    }
    
    
    func setUpButtonConstraints() {
        self.widthAnchor.constraint(equalToConstant: CGFloat(70)).isActive = true
        self.heightAnchor.constraint(equalToConstant: CGFloat(40)).isActive = true
    }
    
    func setUpButton() {
        
        self.titleLabel?.font = UIFont(name: "APpleSDGothicNeo-SemiBold", size: 16)
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 5
        self.alpha = CGFloat(0.8)

        self.isTriggered == true ? self.clickedAppearance() : self.normalAppearance()
    }
    
    func normalAppearance() {
        self.backgroundColor = .black
        self.setTitleColor(.white, for: .normal)
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    func clickedAppearance() {
        self.backgroundColor = .white
        self.setTitleColor(.black, for: .normal)
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        // Storyborad
            // super.init(coder: coder)
            // setUpButton()
    }
}
