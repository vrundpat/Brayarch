//
//  CarnageReportVC.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/24/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CarnageReportPageVC: UIViewController {
    
    var data: [DestinyPlayerEntry]? { didSet { print("Received Carnage Report") } }
    var currentUserDisplayName = String()
    var currentUserIdentifier = String()
    let loading = NVActivityIndicatorView(frame: .zero, type: .audioEqualizer, color: .white, padding: 0)
    var currentActivity: ActivityInformation?
    var currentMode = String()
    var activityHandler2 = ActivityCellHandler()
    var carnageEssentials = CarnageReportEssentials()
    
    lazy var carnageReportTableView: UITableView = {
        let table_view = UITableView(frame: .zero, style: .grouped)
        table_view.translatesAutoresizingMaskIntoConstraints = false
        table_view.backgroundColor = .black
        table_view.separatorColor = .white
        table_view.contentInsetAdjustmentBehavior = .never
        table_view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        table_view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        table_view.insetsContentViewsToSafeArea = false
        return table_view
    }()
    
    lazy var navigationTiteView: UITextView = {
        let textView = UITextView()
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = true
        textView.font = UIFont(name: "DINAlternate-Bold", size: 24)
        textView.text = "Post Carnage Report"
        textView.backgroundColor = .clear
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false
        return textView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpNVActivityIndiacatorView()
        loading.startAnimating()
    }
    
    func setUpNVActivityIndiacatorView() {
        loading.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loading)
        
        loading.widthAnchor.constraint(equalToConstant: 50).isActive = true
        loading.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loading.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func removeOverlayAndDisplayStats() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.loading.stopAnimating()
            self.loading.isHidden = true
            self.setUpCarnageReportTableView()
            self.navigationItem.titleView = self.navigationTiteView
        })
    }
    
    func setUpCarnageReportTableView() {
        self.view.addSubview(carnageReportTableView)
        
        carnageReportTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        carnageReportTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        carnageReportTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        carnageReportTableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        carnageReportTableView.delegate = self
        carnageReportTableView.dataSource = self
        carnageReportTableView.register(CarnageReportPlayerCell.self, forCellReuseIdentifier: "carnageReportCell")
        carnageReportTableView.register(CarnageReportTableviewHeader.self, forHeaderFooterViewReuseIdentifier: "header")
    }
    
    func getUserStats(userDisplayMembershipId: String) -> [String] {
        for player in self.data! {
            if player.player.destinyUserInfo.membershipId == userDisplayMembershipId {
                let stats = player.values
                return ["\(stats.kills.basic.displayValue)", "\(stats.deaths.basic.displayValue)", "\(stats.assists.basic.displayValue)", "\(stats.killsDeathsRatio.basic.displayValue)"]
            }
        }
        return []
    }
    
    func getStandingStatus(activity: ActivityInformation) -> [Any] {
        if activity.values.standing == nil {
            if activity.values.completed?.basic.displayValue == "Yes" { return ["Victory", UIColor(red: 14/255, green: 94/255, blue: 46/255, alpha: 1)] }
            else { return ["Uncompleted", UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)] }
        } else {
            return [(activity.values.standing?.basic.displayValue)!, (activity.values.standing?.basic.displayValue)! == "Victory" ? UIColor(red: 14/255, green: 94/255, blue: 46/255, alpha: 1) : UIColor(red: 193/255, green: 44/255, blue: 44/255, alpha: 1)]
        }
    }
}

extension CarnageReportPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return data!.count }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return CGFloat(75) }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return CGFloat(350) }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! CarnageReportTableviewHeader
        let result = self.getStandingStatus(activity: self.currentActivity!)
        let image_gamemode = activityHandler2.getImageName(i: self.currentActivity!, currentMode: self.currentMode)
        header.currentUserDisplayName = self.currentUserDisplayName
        header.currentUserIdentifier = self.currentUserIdentifier
        header.bgImage = image_gamemode[2]
        header.overlayImage = image_gamemode[0] != "patrol2" && image_gamemode[0] != "nightmare5" ? image_gamemode[0] : image_gamemode[0] == "patrol2" ? "patrol2" : "nightmare"
        header.gamemodeCategory = image_gamemode[1].uppercased()
        header.standingText = (result[0] as! String).uppercased()
        header.standingViewColor = result[1] as! UIColor
        header.playerStats = self.getUserStats(userDisplayMembershipId: currentUserIdentifier)
        header.tableViewTitlesBgColor = carnageEssentials.getTableColors(imageName: image_gamemode[2])[0]
        header.setUpHeader()
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carnageReportCell", for: indexPath) as! CarnageReportPlayerCell
        let topImage = activityHandler2.getImageName(i: self.currentActivity!, currentMode: self.currentMode)[2]
        cell.playerDisplayName = self.data![indexPath.row].player.destinyUserInfo.displayName
        cell.playerStats = self.getUserStats(userDisplayMembershipId: self.data![indexPath.row].player.destinyUserInfo.membershipId)
        let colors = carnageEssentials.getTableColors(imageName: topImage)
        
        if indexPath.row % 2 == 0 {
            cell.bgColor = colors[1]
            cell.textcolor = .white
            cell.backgroundColor = colors[1]
        } else {
            cell.bgColor = colors[0]
            cell.textcolor = .white
            cell.backgroundColor = colors[0]
        }
        
        if self.data![indexPath.row].player.destinyUserInfo.membershipId == self.currentUserIdentifier && self.data!.count > 1 {
            cell.bgColor = UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1)
            cell.textcolor = .black
            cell.backgroundColor = UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1)
            cell.playerDisplayNameTextView.text = "Sample User"
            cell.playerDisplayNameTextView.textColor = .black
        }
        
        cell.player = self.data![indexPath.row]
        return cell
    }
}
