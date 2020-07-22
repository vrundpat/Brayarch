//
//  ActivityCell.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/22/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {
    
    var activityHistroyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.backgroundColor = .black
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var standingStatusBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    lazy var statField: UITextView = {
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "Testing the cell"
        textField.textColor = .white
        textField.backgroundColor = .black
        textField.textAlignment = .center
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpCellStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCellStackView() {
        
        contentView.addSubview(activityHistroyStackView)
        
        activityHistroyStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        activityHistroyStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        activityHistroyStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        activityHistroyStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        self.setUpStackViewSubviews()
    }
    
    func setUpStackViewSubviews() {
        self.activityHistroyStackView.addArrangedSubview(standingStatusBar)
        self.activityHistroyStackView.addArrangedSubview(statField)
        
        //standingStatusBar.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        standingStatusBar.widthAnchor.constraint(equalTo: activityHistroyStackView.widthAnchor, multiplier: 0.01).isActive = true
        
        //statField.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        statField.widthAnchor.constraint(equalTo: activityHistroyStackView.widthAnchor, multiplier: 0.99).isActive = true
        
//        self.activityHistroyStackView.addArrangedSubview(standingStatusBar)
//        self.activityHistroyStackView.addArrangedSubview(statField)
    }
}
