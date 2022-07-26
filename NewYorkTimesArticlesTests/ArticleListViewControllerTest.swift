//
//  ArticleListViewControllerTest.swift
//  NewYorkTimesArticlesTests
//
//  Created by shairjeel ahmed on 26/07/2022.
//

import XCTest
@testable import NewYorkTimesArticles

class ArticleListViewControllerTest: XCTestCase {
    // MARK: - Subject under test
    
    var sut: ArticleListViewController!
    var window: UIWindow!
    
    // MARK: - Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        window = UIWindow()
        setupArticleListController()
    }
    
    override func tearDown()
    {
        window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupArticleListController()
    {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "ArticleListViewController") as? ArticleListViewController
    }
    
    func loadView()
    {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Test doubles
    
    class ListArticleBusinessLogicSpy: ArticleListBusinessLogic
    {
        var articles: [Article]?
        
        // MARK: Method call expectations
        
        var fetchArticlesCalled = false
        
        // MARK: Spied methods
        
        func getArticlesFromApi(request: ListArticles.fetchArticle.Request) {
            fetchArticlesCalled = true
        }
    }
    
    class TableViewSpy: UITableView
    {
        // MARK: Method call expectations
        
        var reloadDataCalled = false
        
        // MARK: Spied methods
        
        override func reloadData()
        {
            reloadDataCalled = true
        }
    }
    
    // MARK: - Tests
    
    func testShouldFetchArticleWhenViewDidAppear()
    {
        // Given
        let listArticlesBusinessLogicSpy = ListArticleBusinessLogicSpy()
        sut.interactor = listArticlesBusinessLogicSpy
        loadView()
        
        // When
        sut.viewDidAppear(true)
        
        // Then
        XCTAssert(listArticlesBusinessLogicSpy.fetchArticlesCalled, "Should fetch articles right after the view appears")
    }
}
