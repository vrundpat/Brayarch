//
//  ActivityHistoryPageVC.swift
//  StatTracker
//
//  Created by Vrund Patel on 8/1/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ActivityHistoryPageVC: UIViewController {
    
    var data = [ActivityInformation]()
    let loading = NVActivityIndicatorView(frame: .zero, type: .audioEqualizer, color: .white, padding: 0)
    let handler = ActivityCellHandler()

    var currentUserBeingDisplayed = String()
    var currentUserIdentifier = String()
    var currentMode = String()
    
    lazy var activityHistoryTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.separatorColor = .white
        return tableView
    }()
    
    lazy var navigationTitle: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = true
        textView.font = UIFont(name: "DINAlternate-Bold", size: 20)
        textView.textColor = .white
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
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
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
            self.view.backgroundColor = .clear
            self.setUpRootTableView()
            self.navigationTitle.text = "\(self.currentUserBeingDisplayed)'s Activity History"
            self.navigationItem.titleView = self.navigationTitle
        })
    }
    
    func setUpRootTableView() {
        self.view.addSubview(activityHistoryTableView)
        
        activityHistoryTableView.delegate = self
        activityHistoryTableView.dataSource = self
        activityHistoryTableView.register(ActivityCell.self, forCellReuseIdentifier: "activityCell")
        
        activityHistoryTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        activityHistoryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        activityHistoryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        activityHistoryTableView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
    }
}


extension ActivityHistoryPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return data.count }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return CGFloat(100) }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.imageName = handler.getImageName(i: self.data[indexPath.row], currentMode: self.currentMode)[0]
        cell.activity = self.data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = CarnageReportPageVC()
        destinationVC.currentUserDisplayName = self.currentUserBeingDisplayed
        destinationVC.currentUserIdentifier = self.currentUserIdentifier
        destinationVC.currentMode = self.currentMode
        destinationVC.currentActivity = self.data[indexPath.row]
        self.navigationController?.pushViewController(destinationVC, animated: true)
        
        let group = DispatchGroup()
        group.enter()
        
        let activityCarnageReport = FetchPostCarnageReportRequest(instanceId: self.data[indexPath.row].activityDetails.instanceId)
        
            activityCarnageReport.getPostCarnageReport { [weak self] result in
                switch result {
                    case .failure(let error):
                        print(error)
                        group.leave()

                    case .success(let carnageReport):
                        destinationVC.data = carnageReport
                        group.leave()
                }
            }
            
            group.notify(queue: .main) {
                destinationVC.removeOverlayAndDisplayStats()
            }
    }
}
