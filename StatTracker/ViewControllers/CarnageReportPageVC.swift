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
    
    lazy var carnageReportTableView: UITableView = {
        let table_view = UITableView(frame: .zero, style: .grouped)
        table_view.translatesAutoresizingMaskIntoConstraints = false
        table_view.backgroundColor = .black
        table_view.separatorColor = .white
        table_view.contentInsetAdjustmentBehavior = .never
        table_view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        table_view.contentInset = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
        return table_view
    }()
    
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
}

extension CarnageReportPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return data!.count }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return CGFloat(50) }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return CGFloat(350) }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! CarnageReportTableviewHeader
        header.currentUserDisplayName = self.currentUserDisplayName
        header.currentUserIdentifier = self.currentUserIdentifier
        header.bgImage = "statBg-1"
        header.overlayImage = "nightfall"
        header.gamemodeCategory = "Gamemode"
        header.playerStats = self.getUserStats(userDisplayMembershipId: currentUserIdentifier)
        header.setUpHeader()
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carnageReportCell", for: indexPath) as! CarnageReportPlayerCell
        cell.playerDisplayName = self.data![indexPath.row].player.destinyUserInfo.displayName
        cell.playerStats = self.getUserStats(userDisplayMembershipId: self.data![indexPath.row].player.destinyUserInfo.membershipId)
        cell.backgroundColor = .black
        cell.player = self.data![indexPath.row]
        return cell
    }
}
