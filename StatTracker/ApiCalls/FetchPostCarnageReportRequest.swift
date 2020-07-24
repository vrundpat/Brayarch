//
//  FetchPostCarnageReportRequest.swift
//  StatTracker
//
//  Created by Vrund Patel on 7/24/20.
//  Copyright © 2020 Vrund Patel. All rights reserved.
//

import Foundation

enum FetchPostCarnageReportRequestError: Error {
    case noDataAvailable
    case cannotProcessData
}


struct FetchPostCarnageReportRequest {
    
    var resourceURL: URLRequest
    let API_KEY = "ba1b26f5d69a4c1180a5686d4e5b2cf2"

    init(instanceId: String) {
        
        let resourceString = "https://bungie.net/Platform/Destiny2/Stats/PostGameCarnageReport/\(instanceId)/"

        guard let resourceURL = URL(string: resourceString) else {fatalError()}

        self.resourceURL = URLRequest(url: resourceURL)
        self.resourceURL.addValue(API_KEY, forHTTPHeaderField: "X-API-Key")
    }

    func getPostCarnageReport(completion: @escaping(Result<[DestinyPlayerEntry], FetchPostCarnageReportRequestError>) -> Void) {

        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in

            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }

            do {
                let decoder = JSONDecoder()
                let getPostCarnageReportResult = try decoder.decode(FetchPostCarnageReportResponse.self, from: jsonData)
                let portCarnageReport = getPostCarnageReportResult.Response.entries
                completion(.success(portCarnageReport))

            } catch {
                completion(.failure(.cannotProcessData))
            }
        }
        dataTask.resume()
    }
}

