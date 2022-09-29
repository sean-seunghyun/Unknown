//
//  MovieList.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//

import Foundation
struct MovieList: Codable, Identifiable {
    let id: String = UUID().uuidString
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
