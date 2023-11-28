//
//  Results.swift
//  BucketList
//
//  Created by Sparsh Paliwal on 11/28/23.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    var description: String {
        terms?["description"]?.first ?? "No further description"
    }
    
    /// this functions enable Comparable, similar to == enabling Equatable. This function returns true if the first should be sorted before the second
    static func <(lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
}
