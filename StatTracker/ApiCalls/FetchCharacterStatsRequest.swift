//
//  FetchCharacterStatsRequest.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/15/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import Foundation


enum FetchCharacterStatsRequestError: Error {
    case noDataAvailable
    case cannotProcessData
}


struct FetchCharacterStatsRequest {
    
    var resourceURL: URLRequest
    let API_KEY = "ba1b26f5d69a4c1180a5686d4e5b2cf2"

    init(memberShipType: Int, destinyMembershipId: String, characterId: String) {
        
        let resourceString = "https://bungie.net/Platform/Destiny2/\(memberShipType)/Account/\(destinyMembershipId)/Character/\(characterId)/Stats/?modes=5,7,19,63,75,69,84"

        guard let resourceURL = URL(string: resourceString) else {fatalError()}

        self.resourceURL = URLRequest(url: resourceURL)
        self.resourceURL.addValue(API_KEY, forHTTPHeaderField: "X-API-Key")
    }

    func getCharacterStats(completion: @escaping(Result<GameModes, FetchCharacterStatsRequestError>) -> Void) {

        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in

            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }

            do {
                let decoder = JSONDecoder()
                let getCharacterStatsResponse = try decoder.decode(FetchCharacterStats.self, from: jsonData)
                let characterStats = getCharacterStatsResponse.Response
                completion(.success(characterStats))

            } catch {
                completion(.failure(.cannotProcessData))
            }
        }
        dataTask.resume()
    }
}
