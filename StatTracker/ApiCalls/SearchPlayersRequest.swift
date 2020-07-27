//
//  SearchPlayersRequest.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/12/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import Foundation


enum SearchPlayerRequestError: Error {
    case noDataAvailable
    case cannotProcessData
}


struct SearchPlayersRequest {
    var resourceURL: URLRequest
    let API_KEY = "ba1b26f5d69a4c1180a5686d4e5b2cf2"
    
    init(searchText: String, memberShipType: Int) {
        let resourceString = "https://bungie.net/Platform/Destiny2/SearchDestinyPlayer/\(memberShipType)/\(searchText)/?returnOriginalProfile=false"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = URLRequest(url: resourceURL)
        self.resourceURL.addValue(API_KEY, forHTTPHeaderField: "X-API-Key")
    }
    
    func searchPlayers(completion: @escaping(Result<[PlayerInfo], SearchPlayerRequestError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
                
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let searchPlayersResponse = try decoder.decode(SearchPlayerResponse.self, from: jsonData)
                
                let found_players = searchPlayersResponse.Response
                completion(.success(found_players))
                
            } catch {
                completion(.failure(.cannotProcessData))
            }
        }
        dataTask.resume()
    }
}
