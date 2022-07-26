//
//  ArticleListUITest.swift
//  NewYorkTimesArticlesUITests
//
//  Created by shairjeel ahmed on 26/07/2022.
//

import XCTest
@testable import NewYorkTimesArticles

class ArticleListUITest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }


    func testWhenEditButtonPressedKeyBoardBecomeActive() throws {
                                
       
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
