//
//  PlatFormButtonStackView.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/13/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit

class PlatFormButtonStackView: UIStackView {
    
    let platformButtons = [PlatformButton(), PlatformButton(), PlatformButton(), PlatformButton()]
    let platformButtonTitles = ["Xbox", "PS4", "Steam", "Stadia"]
    var apiDataModel: APIEssentialsController!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        // Storyboard
            // super.init(coder: coder)
            // setUpStackView()
    }
    
    private func setUpStackView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.spacing = CGFloat(10)
        setUpPlatformButtons()
    }
    
    func setUpPlatformButtons() {
        for button in platformButtons {
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(self.platformButtonTitles[self.platformButtons.firstIndex(of: button)!], for: .normal)
            button.addTarget(self, action: #selector(platformButtonClicked), for: .touchUpInside)
            
            if button == self.platformButtons[0] {
                button.setUpButtonConstraints()
                button.isTriggered = true
            } else {
                button.setUpButtonConstraints()
                button.isTriggered = false
            }
            
            self.addArrangedSubview(button)
        }
    }
    
    @objc func platformButtonClicked(sender: PlatformButton) {
        sender.isTriggered = true
        for button in self.platformButtons { if button != sender { button.isTriggered = false } }
        self.apiDataModel.apiEssentials.memberShipType = self.platformButtons.firstIndex(of: sender)! + 1
    }
}
