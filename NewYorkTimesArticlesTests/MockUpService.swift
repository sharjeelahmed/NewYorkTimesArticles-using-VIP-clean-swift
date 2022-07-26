//
//  MockUpService.swift
//  NewYorkTimesArticlesTests
//
//  Created by shairjeel ahmed on 26/07/2022.
//

import Foundation
@testable import NewYorkTimesArticles

class MockUpService:Service{
    var returnSuccess:Bool = true
    func request(request: URLRequest, completion: @escaping ApiResponseCompletionHandler) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            if self.returnSuccess == true{
                completion(.success(Data()))
            }else{
                completion(.failure(ServiceError.noData))
            }
        }
    }
}
