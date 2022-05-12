//
//  APICaller.swift
//  SpaceX
//
//  Created by Dumitru Rahmaniuc on 11.05.2022.
//

import Foundation


struct Constants{
    static let baseURL = "https://api.spacexdata.com"
}

enum APIError: Error{
    case failedTogetData
}


class APICaller {
    static let shared = APICaller()
    

    
    
    
    
    func getLaunchInfo(completion: @escaping (Result<[Launch], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/v4/launches") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode([Launch].self, from: data)
                completion(.success(results))
            }catch{
                print(error)
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
}
