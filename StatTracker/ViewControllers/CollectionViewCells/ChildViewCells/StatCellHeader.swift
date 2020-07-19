//
//  StatCellHeader.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/18/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit

class StatCellHeader: UICollectionReusableView {
    
    var headerTitle = String()
    var swipetext = String()
        
    let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func setUpTextView(titleView: UITextView) {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.textColor = .white
        titleView.backgroundColor = UIColor(red: 36/255, green: 41/255, blue: 46/255, alpha: 1)
        titleView.textAlignment = .center
        titleView.layer.masksToBounds = true
        titleView.isEditable = false
        titleView.showsHorizontalScrollIndicator = false
        titleView.showsVerticalScrollIndicator = false
    }
    
    let title: UITextView = {
        let titleView = UITextView()
        titleView.font = UIFont(name: "DINAlternate-Bold", size: 25)
        titleView.textContainerInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        return titleView
    }()

    let swipeText: UITextView = {
        let swipeText = UITextView()
        swipeText.font = UIFont(name: "DINAlternate-Bold", size: 12)
        return swipeText
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpHeader() {
        
        self.setUpTextView(titleView: title)
        self.setUpTextView(titleView: swipeText)
        
        self.addSubview(headerStackView)
        
        headerStackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        headerStackView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        title.text = self.headerTitle
        swipeText.text = self.swipetext
        
        headerStackView.addArrangedSubview(title)
        headerStackView.addArrangedSubview(swipeText)
        
        title.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75).isActive = true
        swipeText.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
    }
}
