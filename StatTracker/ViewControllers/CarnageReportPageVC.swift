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
        carnageReportTableView.register(UITableViewCell.self, forCellReuseIdentifier: "carnageReportCell")
    }
}


extension CarnageReportPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return data!.count }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return CGFloat(100) }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return CGFloat(535) }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 535))
        headerView.backgroundColor = .red
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carnageReportCell", for: indexPath)
        cell.textLabel?.text = "Testing"
        cell.backgroundColor = .black
        return cell
    }
}
