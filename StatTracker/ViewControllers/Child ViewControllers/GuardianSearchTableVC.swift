//
//  GuardianTableViewController.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/11/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import UIKit


class GuardianSearchTableVC: UIViewController {
    
    var apiDataModel: APIEssentialsController!
    
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
        
    var data = [PlayerInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.guardianTableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
        
    func setUpTableView() {
        view.isHidden = true
        view.addSubview(guardianTableView)
        guardianTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        guardianTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        guardianTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        guardianTableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        guardianTableView.delegate = self
        guardianTableView.dataSource = self
        guardianTableView.register(UITableViewCell.self, forCellReuseIdentifier: "guardianCell")
    }
}


// Extension for the table view's functionality
extension GuardianSearchTableVC: UITableViewDelegate, UITableViewDataSource {
            
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return data.count }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "guardianCell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row].displayName
        
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { navigationController?.pushViewController(StatPageVC(), animated: true)
    }
}


// Extensions for the search bar's functionality
extension GuardianSearchTableVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            let searchPlayersStruct = SearchPlayersRequest(searchText: searchText.lowercased(), memberShipType: self.apiDataModel.apiEssentials.memberShipType)
            searchPlayersStruct.searchPlayers { [weak self] result in
                switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let players):
                        self?.data = players
                }
            }
        }  else { self.data = [] }
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.data = []
        view.isHidden = true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) { view.isHidden = false }
}
