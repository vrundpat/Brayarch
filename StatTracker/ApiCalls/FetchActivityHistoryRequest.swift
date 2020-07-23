//
//  FetchActivityHistoryRequest.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/21/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import Foundation

enum FetchActivityHistoryRequestError: Error {
    case noDataAvailable
    case cannotProcessData
}


struct FetchActivityHistoryRequest {
    
    var resourceURL: URLRequest
    let API_KEY = "ba1b26f5d69a4c1180a5686d4e5b2cf2"

    init(memberShipType: Int, destinyMembershipId: String, characterId: String, mode: String) {
        
        let resourceString = "https://bungie.net/Platform/Destiny2/\(memberShipType)/Account/\(destinyMembershipId)/Character/\(characterId)/Stats/Activities/?mode=\(mode)&count=20"

        guard let resourceURL = URL(string: resourceString) else {fatalError()}

        self.resourceURL = URLRequest(url: resourceURL)
        self.resourceURL.addValue(API_KEY, forHTTPHeaderField: "X-API-Key")
    }

    func getActivityHistory(completion: @escaping(Result<Activities, FetchActivityHistoryRequestError>) -> Void) {

        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in

            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }

            do {
                let decoder = JSONDecoder()
                let getActivityHistoryResponse = try decoder.decode(FetchActivityHistoryResponse.self, from: jsonData)
                let activityHistory = getActivityHistoryResponse.Response
                completion(.success(activityHistory ?? Activities(activities: [])))

            } catch {
                completion(.failure(.cannotProcessData))
            }
        }
        dataTask.resume()
    }
}
