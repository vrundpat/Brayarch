//
//  FetchCharacterIds.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/14/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import Foundation

enum FetchCharacterIdsRequestError: Error {
    case noDataAvailable
    case cannotProcessData
}


struct FetchCharacterIdsRequest {
    
    var resourceURL: URLRequest
    let API_KEY = "ba1b26f5d69a4c1180a5686d4e5b2cf2"

    init(memberShipType: Int, destinyMembershipId: String) {
        let resourceString = "https://bungie.net/Platform/Destiny2/\(memberShipType)/Profile/\(destinyMembershipId)/?components=100"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}

        self.resourceURL = URLRequest(url: resourceURL)
        self.resourceURL.addValue(API_KEY, forHTTPHeaderField: "X-API-Key")
    }

    func getCharacterIds(completion: @escaping(Result<[String], FetchCharacterIdsRequestError>) -> Void) {

        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in

            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }

            do {
                let decoder = JSONDecoder()
                let getCharacterIdsResponse = try decoder.decode(FetchCharacterIdsResponse.self, from: jsonData)

                let characterIds = getCharacterIdsResponse.Response.profile.data.characterIds
                completion(.success(characterIds))

            } catch {
                completion(.failure(.cannotProcessData))
            }
        }
        dataTask.resume()
    }
}
