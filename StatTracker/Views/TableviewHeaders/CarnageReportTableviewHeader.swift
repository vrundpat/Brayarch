//
//  CarnageReportTableviewHeader.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/25/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit

class CarnageReportTableviewHeader: UITableViewHeaderFooterView {
    
    var bgImage = String()
    var overlayImage = String()
    var gamemodeCategory = String()
    var playerStats = [String]()
    var statsStackView = StackViewText()
    var currentUserDisplayName = String()
    var currentUserIdentifier = String()
    
    lazy var headerBgImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    lazy var overlayImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    lazy var gamemodeTitle: UITextView = {
        let textView = UITextView()
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "DINAlternate-Bold", size: 20)
        textView.backgroundColor = .clear
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false
        return textView
    }()
        
    lazy var standIndicationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpHeader() {
        
        headerBgImageView.image = UIImage(named: bgImage)
        overlayImageView.image = UIImage(named: overlayImage)
        gamemodeTitle.text = gamemodeCategory
        standIndicationView.backgroundColor = .green
        
        contentView.addSubview(headerBgImageView)
        contentView.addSubview(standIndicationView)
        
        setUpHeaderView()
        
        headerBgImageView.addSubview(overlayImageView)
        headerBgImageView.addSubview(gamemodeTitle)
        setUpOverlayImageText()
    }
    
    func setUpOverlayImageText() {
        overlayImageView.widthAnchor.constraint(equalToConstant: CGFloat(125)).isActive = true
        overlayImageView.heightAnchor.constraint(equalToConstant: CGFloat(125)).isActive = true
        overlayImageView.centerXAnchor.constraint(equalTo: headerBgImageView.centerXAnchor).isActive = true
        overlayImageView.centerYAnchor.constraint(equalTo: headerBgImageView.centerYAnchor).isActive = true
        
        gamemodeTitle.widthAnchor.constraint(equalToConstant: CGFloat(200)).isActive = true
        gamemodeTitle.heightAnchor.constraint(equalToConstant: CGFloat(50)).isActive = true
        gamemodeTitle.centerXAnchor.constraint(equalTo: headerBgImageView.centerXAnchor).isActive = true
        gamemodeTitle.centerYAnchor.constraint(equalTo: headerBgImageView.centerYAnchor, constant: 75).isActive = true
    }
    
    func setUpHeaderView() {
        headerBgImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        headerBgImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        headerBgImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        headerBgImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.99).isActive = true
        
        standIndicationView.topAnchor.constraint(equalTo: headerBgImageView.bottomAnchor).isActive = true
        standIndicationView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        standIndicationView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        standIndicationView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.01).isActive = true
    }
}
