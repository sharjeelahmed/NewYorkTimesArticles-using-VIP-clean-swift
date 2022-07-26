//
//  Service.swift
//  NewYorkTimesArticles
//
//  Created by shairjeel ahmed on 25/07/2022.
//

import Foundation



typealias ApiResponseCompletionHandler = (ApiResponse<Data,Error>) -> Void

enum ServiceError:Error{
    case noData
    case invalidData
}

protocol Service{
    func request(request:URLRequest,completion: @escaping ApiResponseCompletionHandler)
}

class NetworkService:Service{
   
    func request(request: URLRequest, completion: @escaping ApiResponseCompletionHandler) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            guard let data = data else{
                completion(.failure(ServiceError.invalidData))
                return
            }
            completion(.success(data))
        }.resume()
    }
    
   
}

// MARK: - Usage of Generics

enum ApiResponse<Success, Failure> where Failure : Error {
    case success(Success)
    case failure(Failure)
}




