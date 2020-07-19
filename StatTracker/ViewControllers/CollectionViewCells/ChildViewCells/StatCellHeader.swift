//
//  StatCellHeader.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/18/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit

class StatCellHeader: UICollectionReusableView {
    
    let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let title: UILabel = {
        let titleLbl = UILabel()
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.text = "PvP: Quickplay & Competitive"
        titleLbl.textColor = .red
        titleLbl.backgroundColor = .yellow
        return titleLbl
    }()
    
    let swipeText: UITextView = {
        let textView = UITextView()
        textView.text = "Swipe >>"
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .red
        textView.textAlignment = .right
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpHeader() {
        self.addSubview(headerStackView)
        
        headerStackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        headerStackView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        headerStackView.addArrangedSubview(title)
        headerStackView.addArrangedSubview(swipeText)
        
        title.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8).isActive = true
        swipeText.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
    }
    
}
