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
    var standingText = String()
    var standingViewColor: UIColor = .green
    var tableViewTitlesBgColor: UIColor = .white
    
    lazy var headerBgImageView: UIImageView = {
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
    
    lazy var carnageTableTitles: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var standingIndicationTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "DINAlternate-Bold", size: 16)
        textView.backgroundColor = .clear
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false
        return textView
    }()
    
    lazy var statsticsTitleView: UITextView = {
        let textView = UITextView()
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "DINAlternate-Bold", size: 21)
        textView.text = "Post Match Statistics".uppercased()
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        textView.backgroundColor = .clear
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false
        return textView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpHeader() {
        
        headerBgImageView.image = UIImage(named: bgImage)
        gamemodeTitle.text = gamemodeCategory.uppercased()
        standIndicationView.backgroundColor = self.standingViewColor
        standingIndicationTextView.textColor = self.standingViewColor
        standingIndicationTextView.text = self.standingText
            
        contentView.addSubview(headerBgImageView)
        contentView.addSubview(standIndicationView)
        contentView.addSubview(carnageTableTitles)
        
        setUpHeaderView()
        setUpStackViews()
        
        //headerBgImageView.addSubview(overlayImageView)
        headerBgImageView.addSubview(gamemodeTitle)
        setUpOverlayImageText()
    }
    
    func setUpOverlayImageText() {
        gamemodeTitle.widthAnchor.constraint(equalToConstant: CGFloat(200)).isActive = true
        gamemodeTitle.heightAnchor.constraint(equalToConstant: CGFloat(50)).isActive = true
        gamemodeTitle.centerXAnchor.constraint(equalTo: headerBgImageView.centerXAnchor).isActive = true
        gamemodeTitle.centerYAnchor.constraint(equalTo: headerBgImageView.centerYAnchor, constant: 85).isActive = true
    }
    
    func setUpHeaderView() {
        headerBgImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        headerBgImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        headerBgImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        headerBgImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75).isActive = true
                
        standIndicationView.topAnchor.constraint(equalTo: headerBgImageView.bottomAnchor).isActive = true
        standIndicationView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        standIndicationView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        standIndicationView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.01).isActive = true
        
        carnageTableTitles.topAnchor.constraint(equalTo: standIndicationView.bottomAnchor).isActive = true
        carnageTableTitles.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        carnageTableTitles.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        carnageTableTitles.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.24).isActive = true
    }
    
    func setUpStackViews() {
        carnageTableTitles.addArrangedSubview(standingIndicationTextView)
        carnageTableTitles.addArrangedSubview(statsticsTitleView)
        
        standingIndicationTextView.backgroundColor = self.tableViewTitlesBgColor
        statsticsTitleView.backgroundColor = self.tableViewTitlesBgColor
        
        standingIndicationTextView.heightAnchor.constraint(lessThanOrEqualTo: carnageTableTitles.heightAnchor, multiplier: 0.40).isActive = true
        statsticsTitleView.heightAnchor.constraint(lessThanOrEqualTo: carnageTableTitles.heightAnchor, multiplier: 0.60).isActive = true
        
    }
}
