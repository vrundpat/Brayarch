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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
