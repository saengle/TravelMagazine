//
//  APIManager.swift
//  TravelMagazine
//
//  Created by 쌩 on 6/19/24.
//

import Foundation

import Alamofire

class APIManager {
    func callRequest(cor: Int, completion: @escaping ((Result<Weather, Error>) -> Void)) {
        
        let parameters = [
                "lat" : "44.34",
                "lon" : "10.99",
                "appid": "\(APIKey.key)"
            ]
            
        AF.request(APIKey.url, method: .get, parameters: parameters ,encoding: URLEncoding.default).responseDecodable(of: Weather.self) { response in
            switch response.result {
            case .success(let repositories):
                completion(.success(repositories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
