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
        titleView.textColor = .white
        titleView.backgroundColor = UIColor(red: 36/255, green: 41/255, blue: 46/255, alpha: 1)
        titleView.font = UIFont(name: "DINAlternate-Bold", size: 25)
        titleView.textContainerInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        titleView.textAlignment = .center
        titleView.layer.masksToBounds = true
        titleView.isEditable = false
        titleView.showsHorizontalScrollIndicator = false
        titleView.showsVerticalScrollIndicator = false
        return titleView
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
        
        title.text = self.headerTitle
        headerStackView.addArrangedSubview(title)
    }
}
