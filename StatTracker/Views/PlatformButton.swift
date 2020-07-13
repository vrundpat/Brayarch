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
            if isTriggered {
                DispatchQueue.main.async {
                    self.backgroundColor = .blue
                    self.setTitleColor(.white, for: .normal)
                }
            } else {
                DispatchQueue.main.async {
                    self.backgroundColor = .white
                    self.setTitleColor(.black, for: .normal)
                }
            }
        }
    }
    
    func setUpButtonConstraints(diff: Int, parent: UIViewController) {
        self.leadingAnchor.constraint(equalTo: parent.view.leadingAnchor, constant: CGFloat(45 + diff)).isActive = true
        self.widthAnchor.constraint(equalToConstant: CGFloat(100)).isActive = true
        self.heightAnchor.constraint(equalToConstant: CGFloat(50)).isActive = true
        self.centerYAnchor.constraint(equalTo: parent.view.centerYAnchor).isActive = true
    }
}
