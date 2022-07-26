//
//  ArticleListPresenterTest.swift
//  NewYorkTimesArticlesTests
//
//  Created by shairjeel ahmed on 26/07/2022.
//

import XCTest
@testable import NewYorkTimesArticles

class ArticleListPresenterTest: XCTestCase
{
    // MARK: - Subject under test
    
    var sut: ArticleListPresenter!
    
    // MARK: - Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupListArticlePresenter()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupListArticlePresenter()
    {
        sut = ArticleListPresenter()
    }
    
    // MARK: - Test doubles
    
    class ListArticleDisplayLogicSpy: ArticleListDisplayLogic
    {
        // MARK: Method call expectations
        
        var displayFetchedArticlesCalled = false
        
        // MARK: Argument expectations
        
        var viewModel: ListArticles.fetchArticle.ViewModel!
        
        // MARK: Spied methods
        
        func displayFetchedArticles(viewModel: ListArticles.fetchArticle.ViewModel)
        {
            displayFetchedArticlesCalled = true
            self.viewModel = viewModel
        }
    }
    
    // MARK: - Tests
    
    func testPresentFetchedArticlesShouldFormatFetchedArticlesForDisplay()
    {
        // Given
        let listArticlesDisplayLogicSpy = ListArticleDisplayLogicSpy()
        sut.viewController = listArticlesDisplayLogicSpy
        
        // When
       
        let articles = [Article.init(title: "title", published_date: "12-07-2022", byline: "by john")]
        let response = ListArticles.fetchArticle.Response(articles: articles)
        sut.presentFetchedArticles(response: response)
        
        // Then
        let displayedArticles = listArticlesDisplayLogicSpy.viewModel.displayedArticles
        for displayArticle in displayedArticles {
            XCTAssertEqual(displayArticle.title, "title", "Presenting fetched article should properly format article title")
            XCTAssertEqual(displayArticle.date, "12-07-2022", "Presenting fetched article should properly format article date")
            XCTAssertEqual(displayArticle.authorNames, "by john", "Presenting fetched article should properly format authorNames")
        }
    }
    
    func testPresentFetchedArticleShouldAskViewControllerToDisplayFetchedArticles()
    {
        // Given
        let listArticleDisplayLogicSpy = ListArticleDisplayLogicSpy()
        sut.viewController = listArticleDisplayLogicSpy
        
        // When
        let articles = [Article.init(title: "title", published_date: "12-07-2022", byline: "by john")]
        let response = ListArticles.fetchArticle.Response(articles: articles)
        sut.presentFetchedArticles(response: response)
        
        // Then
        XCTAssert(listArticleDisplayLogicSpy.displayFetchedArticlesCalled, "Presenting fetched articles should ask view controller to display them")
    }
}

