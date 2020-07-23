//
//  ActivityCell.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/22/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {
    
    var activity: ActivityInformation? {
        didSet {
            if let completion = activity?.values.completed?.basic.displayValue {
                if completion == "Yes" { standingStatusBar.backgroundColor = .green }
                else { standingStatusBar.backgroundColor = .darkGray }
            }
            
            if let outcome = activity?.values.standing?.basic.displayValue {
                if outcome == "Victory" { standingStatusBar.backgroundColor = .green }
                else { standingStatusBar.backgroundColor = .red }
            }
            
            statRow.titles = ["Kills", "Assists", "Deaths", "KD"]
            statRow.vals.removeAll()
            
            if let history = activity {
                if let kills = history.values.kills { statRow.vals.append(kills.basic.displayValue) }
                if let assists = history.values.assists { statRow.vals.append(assists.basic.displayValue) }
                if let deaths = history.values.deaths { statRow.vals.append(deaths.basic.displayValue) }
                if let kd = history.values.killsDeathsRatio { statRow.vals.append(kd.basic.displayValue) }
                statField.image = UIImage(named: imageName)
            }
            
            statRow.setUpStack()
        }
    }
    
    var imageName = String()
    let statRow = StackViewText()
    
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
    
    lazy var statField: UIImageView  = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    lazy var statStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        self.backgroundColor = .black
        return stackView
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
        self.activityHistroyStackView.addArrangedSubview(statStackView)
        
        standingStatusBar.widthAnchor.constraint(equalTo: activityHistroyStackView.widthAnchor, multiplier: 0.01).isActive = true
        statField.widthAnchor.constraint(equalTo: activityHistroyStackView.widthAnchor, multiplier: 0.39).isActive = true
        statStackView.widthAnchor.constraint(equalTo: activityHistroyStackView.widthAnchor, multiplier: 0.6).isActive = true
                
        statRow.bgColor = .black
        statRow.textColor = .white
        statRow.titles = ["Kills", "Assists", "Deaths", "KD"]
        statRow.vals = ["", "", "", ""]
        statRow.topInset = CGFloat(25)
        statRow.setUpStack()
        
        statStackView.addArrangedSubview(statRow)

    }
}
