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
    var characterStatArray = [GameModes]()
    
    lazy var  guardianSearchController: UISearchController = {

        let search_controller = UISearchController()
        search_controller.searchBar.placeholder = "Find your Guradian..."
        search_controller.searchBar.sizeToFit()
        search_controller.searchBar.delegate = self
        search_controller.obscuresBackgroundDuringPresentation = false
        search_controller.searchBar.tintColor = .black
        
        if let textField = search_controller.searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .white
            textField.backgroundColor = .black
            textField.alpha = CGFloat(0.4)
        }
        
        return search_controller
    }()
    
    lazy var guardianTableView: UITableView = {
        
        let table_view = UITableView()
        table_view.translatesAutoresizingMaskIntoConstraints = false
        table_view.backgroundColor = .black
        table_view.separatorColor = .black
        table_view.alpha = CGFloat(0.7)
        return table_view
    
    }()
        
    var data = [PlayerInfo]() { didSet { DispatchQueue.main.async { self.guardianTableView.reloadData() } } }
        
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
    
    func makeFetchCharacterIdsRequest(destinyMembershipId: String) {
        let characterIdsStruct = FetchCharacterIdsRequest(memberShipType: Int(self.apiDataModel.apiEssentials.memberShipType), destinyMembershipId: destinyMembershipId)
            characterIdsStruct.getCharacterIds { [weak self] result in
                switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let characterIds):
                        
                        for id in characterIds {
                            self?.makeFetchCharacterStatsRequest(memberShipId: destinyMembershipId, char_id: id)
                        }
                }
            }
    }
    
    func makeFetchCharacterStatsRequest(memberShipId: String, char_id: String) {

        let characterStatsStruct = FetchCharacterStatsRequest(memberShipType: Int(self.apiDataModel.apiEssentials.memberShipType), destinyMembershipId: memberShipId, characterId: char_id)
            characterStatsStruct.getCharacterStats { [weak self] result in
                switch result {
                    case .failure(let error):
                        print(error)
                case .success(let characterStats):
                    print("Get character stats call was made!")
                    self?.characterStatArray.append(characterStats)
                }
            }
    }
}


// Extension for the table view's functionality
extension GuardianSearchTableVC: UITableViewDelegate, UITableViewDataSource {
            
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return data.count }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // return UITableView.automaticDimension
        return 65
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "guardianCell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row].displayName
        cell.textLabel?.font = UIFont(name: "APpleSDGothicNeo-SemiBold", size: 16)
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.makeFetchCharacterIdsRequest(destinyMembershipId: self.data[indexPath.row].membershipId)
        do { sleep(4) }
        print("After all API async Calls: \(self.characterStatArray.count)")
        let destinationVC = StatPageVC()
        destinationVC.UserCharacterStats = self.characterStatArray
        navigationController?.pushViewController(destinationVC, animated: true)
        self.characterStatArray.removeAll()
    }
}


// Extensions for the search bar's functionality
extension GuardianSearchTableVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            let searchPlayersStruct = SearchPlayersRequest(searchText: searchText, memberShipType: self.apiDataModel.apiEssentials.memberShipType)
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
