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
    
    let title: UITextView = {
        let titleView = UITextView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = "PvP: Quickplay & Competitive"
        titleView.textColor = .white
        titleView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.6)
        titleView.font = UIFont(name: "DINAlternate-Bold", size: 28)
        titleView.textContainerInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        titleView.textAlignment = .center
        titleView.layer.masksToBounds = true
        return titleView
    }()
    
    let swipeText: UITextView = {
        let textView = UITextView()
        textView.text = "Swipe >>"
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "DINAlternate-Bold", size: 14)
        textView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.6)
        textView.textAlignment = .right
        return textView
    }()
    
    let underline: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return view
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
        headerStackView.addArrangedSubview(underline)
        headerStackView.addArrangedSubview(swipeText)

        title.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.73).isActive = true
        underline.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.02).isActive = true
        swipeText.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
    }
    
}
