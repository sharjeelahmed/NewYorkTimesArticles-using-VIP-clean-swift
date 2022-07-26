//
//  ArticleListWorkerTest.swift
//  NewYorkTimesArticlesTests
//
//  Created by shairjeel ahmed on 26/07/2022.
//

import XCTest
@testable import NewYorkTimesArticles

class ArticleListWorkerTest: XCTestCase {
    
    var sut: ArticleListWorker!
    static var articles: [Article]!
    var mockUpService:MockUpService!
    // MARK: - Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupArticleWorker()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupArticleWorker()
    {
        mockUpService = MockUpService.init()
        sut = ArticleListWorker.init(service: mockUpService)
    }
    
    func testfetchArticles_SuccessfulCompletionHandler(){
        //given
        let request = ListArticles.fetchArticle.Request.init(periodSection: "1")
        self.mockUpService.returnSuccess = true
        //when
        sut.fetch(request: request) { response in
            switch response{
            case .success(_):
                //then
                XCTAssertTrue(true, "response successfull")
            case .failure(_):
                XCTAssertTrue(false, "response failed")
            }
        }
    }
    
    func testfetchArticles_FailureCompletionHandler(){
        //given
        let request = ListArticles.fetchArticle.Request.init(periodSection: "1")
        self.mockUpService.returnSuccess = false
        //when
        sut.fetch(request: request) { response in
            switch response{
            case .success(_):
                XCTAssertTrue(false, "response should be failure")
            case .failure(_):
                //then
                XCTAssertTrue(true)
            }
        }
    }
    
    func testParseGetArticleApiData(){
        //given
        let data = UnitTestHelper.loadJson(filename: "ArticleJsonResponse")!
        //when
        sut.parseGetArticleApiData(data: data) { apiResponse in
            switch apiResponse{
            case .success( _):
                //then
                XCTAssertTrue(true,"Successfully Parse response Data To [Article] type")
            case .failure( _):
                XCTAssertTrue(false,"response Data cannot parse to [Article] type")
            }
        }
    }
}
