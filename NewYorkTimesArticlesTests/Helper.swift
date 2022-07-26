//
//  Extension.swift
//  NewYorkTimesArticlesTests
//
//  Created by shairjeel ahmed on 26/07/2022.
//

import Foundation

class UnitTestHelper{
   static func loadJson(filename fileName: String) -> Data? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
