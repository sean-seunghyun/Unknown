//
//  Movie.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//

import Foundation

// API Request
/*
 RequestURL: https://www.omdbapi.com/?i=tt3896198&apikey=ec275d39#
 
 JSON response:
 {
     "adult": false,
     "backdrop_path": "/aCaqCvYn48b3lfGKGnUdVAE1yeB.jpg",
     "id": 814800,
     "title": "Goodnight Mommy",
     "original_language": "en",
     "original_title": "Goodnight Mommy",
     "overview": "When twin brothers arrive home to find their mother’s demeanor altered and face covered in surgical bandages, they begin to suspect the woman beneath the gauze might not be their mother.",
     "poster_path": "/oHhD5jD4S5ElPNNFCDKXJAzMZ5h.jpg",
     "media_type": "movie",
     "genre_ids": [
     27,
     18,
     53
     ],
     "popularity": 493.591,
     "release_date": "2022-09-16",
     "video": false,
     "vote_average": 5.963,
     "vote_count": 67
 }
 */

struct Movie: Codable, Identifiable, Equatable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let title: String
    let originalLanguage, originalTitle, overview: String
    let posterPath: String?
    let mediaType: String?
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
