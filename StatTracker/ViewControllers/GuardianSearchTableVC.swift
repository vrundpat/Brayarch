//
//  GuardianTableViewController.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/11/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit

class GuardianSearchTableVC: UIViewController {
    
    lazy var guardianTableView: UITableView = {
        
        let table_view = UITableView()
        table_view.translatesAutoresizingMaskIntoConstraints = false
        table_view.backgroundColor = .black
        table_view.separatorColor = .black
        return table_view
        
    }()
    
    lazy var  guardianSearchController: UISearchController = {
           
        let search_controller = UISearchController()
        search_controller.searchBar.placeholder = "Search.."
        search_controller.searchBar.sizeToFit()
        search_controller.searchBar.delegate = self
        search_controller.obscuresBackgroundDuringPresentation = false
        search_controller.searchBar.tintColor = .black
        return search_controller
        
    }()
    
    var data: [String] = ["Apples", "Oranges", "Pears", "Bananas", "Plums"]
    var filteredData: [String] = []
    var isFiltering = false
    var height: CGFloat!
           
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isHidden = true
        view.addSubview(guardianTableView)
        setUpTableView()
        guardianTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey] {
                let contentHeight: CGFloat = guardianTableView.contentSize.height
                height = contentHeight
                
            }
        }
    }
        
    func setUpTableView() {
        guardianTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        guardianTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        guardianTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        guardianTableView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        guardianTableView.delegate = self
        guardianTableView.dataSource = self
        guardianTableView.register(UITableViewCell.self, forCellReuseIdentifier: "guardianCell")
    }
}


// Extension for the table view's functionality
extension GuardianSearchTableVC: UITableViewDelegate, UITableViewDataSource {
            
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredData.count
        } else {
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "guardianCell", for: indexPath)
        if isFiltering {
            cell.textLabel?.text = filteredData[indexPath.row]
        } else {
            cell.textLabel?.text = data[indexPath.row]
        }
        
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(StatPageVC(), animated: true)
    }
}


// Extensions for the search bar's functionality
extension GuardianSearchTableVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredData = data
            isFiltering = false
            
        } else {
            filteredData = []
            isFiltering = true
            
            for test in data {
                if test.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(test)
                }
            }
        }
        
        guardianTableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
        filteredData = data
        guardianTableView.reloadData()
        view.isHidden = true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.isHidden = false
    }
}
