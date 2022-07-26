//
//  ArticleListViewControllerTest.swift
//  NewYorkTimesArticlesTests
//
//  Created by shairjeel ahmed on 26/07/2022.
//


@testable import NewYorkTimesArticles
import XCTest

class ArticleListInteractorTests: XCTestCase
{
  // MARK: - Subject under test
  
  var sut: ArticleListInteractor!
  
  // MARK: - Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupArticleListInteractor()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: - Test setup
  
  func setupArticleListInteractor()
  {
    sut = ArticleListInteractor()
  }
  
  
  // MARK: - Tests
  
  func testFetchArticleShouldAsksArticleWorkerToFetchArticlesAndPresenterToFormatResult()
  {
    // Given
    let articleListPresentationLogicSpy = ArticleListPresentationLogicSpy()
    sut.presenter = articleListPresentationLogicSpy
      let mockUpService = MockUpService()
      let articleWorkerSpy = ArticleListWorkerSpy(service: mockUpService)
      sut.worker = articleWorkerSpy
      
      // When
      let request = ListArticles.fetchArticle.Request(periodSection: "1")
      sut.worker?.fetch(request: request, completion: { response in
          switch response{
          case .success(let articles):
              let response = ListArticles.fetchArticle.Response.init(articles: articles)
              articleListPresentationLogicSpy.presentFetchedArticles(response: response)
          case .failure(_):
              XCTAssertTrue(false, "worker should fetch artciles")
              //do nothung
              break;
          }
      })
      
      // Then
      XCTAssert(articleWorkerSpy.fetchArticleCalled, "FetchArticle() should ask ListArticleWorker to fetch articles")
      XCTAssert(articleListPresentationLogicSpy.presentFetchedArticlesCalled, "FetchArticle() should ask presenter to format article result")
  }
}

class ArticleListPresentationLogicSpy: ArticleListPresentationLogic
{
  // MARK: Method call expectations
  
  var presentFetchedArticlesCalled = false
  
  // MARK: Spied methods
  
  func presentFetchedArticles(response: ListArticles.fetchArticle.Response)
  {
      presentFetchedArticlesCalled = true
  }
}

// MARK: - Test doubles


class ArticleListWorkerSpy: ArticleListWorker
{
  // MARK: Method call expectations
  
  var fetchArticleCalled = false
  
  // MARK: Spied methods
    
    override func fetch(request: ListArticles.fetchArticle.Request, completion: @escaping ArticleFetchCompletionHandler) {
        fetchArticleCalled = true
        getDummyArticles { result in
            switch result{
            case .success(let articles):
                completion(.success(articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func getDummyArticles(completion:ArticleFetchCompletionHandler){
        let data = UnitTestHelper.loadJson(filename: "ArticleJsonResponse")!
        do{
            
            let jsonDecoder = JSONDecoder.init()
            let articleData = try jsonDecoder.decode(ArticleData.self, from: data)
            completion(.success(articleData.results ?? []))
        }catch{
            completion(.failure(ServiceError.invalidData))
        }
    }
}
