//
//  CarnageReportPlayerCell.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/25/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit

class CarnageReportPlayerCell: UITableViewCell {
    
    var player: DestinyPlayerEntry? {
        didSet {
            playerDisplayNameTextView.text = playerDisplayName
            statRow.vals = self.playerStats
            statRow.bgColor = self.bgColor
            statRow.textColor = self.textcolor
            statRow.setUpStack()
        }
    }
    
    var bgColor = UIColor()
    var textcolor = UIColor()
    var statRow = StackViewText()
    var playerDisplayName = String()
    var playerStats = [String]()
    var fontSize = CGFloat(15)
    
    var playerEntryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.backgroundColor = .clear
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var playerDisplayNameTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "DINAlternate-Bold", size: 20)
        textView.textContainerInset = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
        textView.backgroundColor = .clear
        textView.textAlignment = .center
        textView.isEditable = false
        
        textView.isScrollEnabled = false
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpCellStackView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCellStackView() {
        contentView.addSubview(playerEntryStackView)
        
        playerEntryStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        playerEntryStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        playerEntryStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        playerEntryStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        self.setUpStackViewSubviews()
    }
    
    func setUpStackViewSubviews() {
        playerEntryStackView.addArrangedSubview(playerDisplayNameTextView)
        playerEntryStackView.addArrangedSubview(statRow)
        
        playerDisplayNameTextView.widthAnchor.constraint(equalTo: playerEntryStackView.widthAnchor, multiplier: 0.40).isActive = true
        statRow.widthAnchor.constraint(equalTo: playerEntryStackView.widthAnchor, multiplier: 0.60).isActive = true
        
        statRow.titles = ["Kills", "Deaths", "Assists", "KD"]
        statRow.topInset = CGFloat(20)
        statRow.fontSize = self.fontSize
    }
}
