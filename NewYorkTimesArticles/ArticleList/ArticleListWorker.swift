//
//  ArticleListWorker.swift
//  NewYorkTimesArticles
//
//  Created by shairjeel ahmed on 24/07/2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit


typealias ArticleFetchCompletionHandler = (ApiResponse<[Article],Error>) -> Void

class ArticleListWorker{
    
    var service:Service
    
    init(service:Service){
        self.service = service
    }
      
    func fetch(request:ListArticles.fetchArticle.Request ,completion:@escaping ArticleFetchCompletionHandler)
    {
        // NOTE: Do the work
        //call network etc.
        
        let period = request.periodSection
        let urlStr = "http://api.nytimes.com/svc/mostpopular/v2/viewed/\(period).json?api-key=zXWkJiyJfuRmpARWPkMwvHWhXLbJbvAA"
        guard let url = URL.init(string: urlStr) else {
            return
        }
        let urlRequest = URLRequest.init(url: url)
        service.request(request:urlRequest) { result in
            switch result{
            case .success(let data):
                self.parseGetArticleApiData(data: data) { response in
                    switch response{
                    case .success(let articles):
                        completion(.success(articles))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                /*do{
                let jsonDecoder = JSONDecoder.init()
                let articleData = try jsonDecoder.decode(ArticleData.self, from: data)
                    completion(.success(articleData.results ?? []))
                }catch{
                    completion(.failure(ServiceError.invalidData))}*/
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func parseGetArticleApiData(data:Data,completion:ArticleFetchCompletionHandler){
        do{
        let jsonDecoder = JSONDecoder.init()
        let articleData = try jsonDecoder.decode(ArticleData.self, from: data)
            completion(.success(articleData.results ?? []))
        }catch{
            completion(.failure(ServiceError.invalidData))
        }
    }
}


