//
//  ActivityHistoryPageVC.swift
//  StatTracker
//
//  Created by Vrund Patel on 8/1/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Charts

class ActivityHistoryPageVC: UIViewController {
    
    var data = [ActivityInformation]() {didSet {
        self.setUpChartDataEntries()
    }}
    let loading = NVActivityIndicatorView(frame: .zero, type: .audioEqualizer, color: .white, padding: 0)
    let handler = ActivityCellHandler()
    var chartData = [[ChartDataEntry]]()
    var chartColors = [[UIColor]]()
    var chartLabels = ["Kills", "Assists", "Deaths", "K/D"]

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
    
    lazy var chartCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChartCell.self, forCellWithReuseIdentifier: "chartCell")
        return collectionView
    }()
    
    lazy var tableViewTitle: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "DINAlternate-Bold", size: 22)
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.textAlignment = .left
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
        activityHistoryTableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
        
        activityHistoryTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        activityHistoryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        activityHistoryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        activityHistoryTableView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
    }
    
    func setUpChartDataEntries() {
        var temp = [ChartDataEntry]()
        var colors = [UIColor]()
        for i in 0..<4 {
            for j in 0..<data.count {
                var value: ChartDataEntry?
                if (i == 0) {
                    value = ChartDataEntry(x: Double(j), y: Double((data[j].values.kills?.basic.value)!))
                } else if (i == 1) {
                    value = ChartDataEntry(x: Double(j), y: Double((data[j].values.assists?.basic.value)!))
                } else if (i == 2) {
                    value = ChartDataEntry(x: Double(j), y: Double((data[j].values.deaths?.basic.value)!))
                } else {
                    value = ChartDataEntry(x: Double(j), y: Double((data[j].values.killsDeathsRatio?.basic.value)!))
                }
                
                temp.append(value!)
                colors.append(UIColor.white)
            }
            
            self.chartData.append(temp)
            self.chartColors.append(colors)
            temp.removeAll()
            colors.removeAll()
        }
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
    
    // Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return CGFloat(395) }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 395))
        
        headerView.addSubview(chartCollectionView)
        headerView.addSubview(tableViewTitle)
        
        chartCollectionView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        chartCollectionView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
        chartCollectionView.widthAnchor.constraint(equalTo: headerView.widthAnchor).isActive = true
        chartCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(350)).isActive = true
        
        tableViewTitle.topAnchor.constraint(equalTo: chartCollectionView.bottomAnchor).isActive = true
        tableViewTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        tableViewTitle.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
        tableViewTitle.widthAnchor.constraint(equalTo: headerView.widthAnchor).isActive = true
        tableViewTitle.heightAnchor.constraint(equalToConstant: CGFloat(45)).isActive = true
        
        tableViewTitle.text = "Recent \(currentMode) Activity"
        
        return headerView
    }
}


extension ActivityHistoryPageVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return 4 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chartCell", for: indexPath) as! ChartCell
        cell.mode = self.currentMode
        cell.valueColors = self.chartColors[indexPath.row]
        cell.chartTitle = self.chartLabels[indexPath.row]
        cell.data = self.chartData[indexPath.row]
        cell.chartView.animate(xAxisDuration: 0.75, easingOption: .easeInCubic)
        return cell
    }
}
