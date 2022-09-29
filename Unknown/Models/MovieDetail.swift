//
//  MovieDetail.swift
//  Unknown
//
//  Created by sean on 2022/09/27.
//

/*
 {
     "adult": false,
     "backdrop_path": "/aCaqCvYn48b3lfGKGnUdVAE1yeB.jpg",
     "belongs_to_collection": null,
     "budget": 0,
     "genres": [
         {
             "id": 27,
             "name": "공포"
         },
         {
             "id": 18,
             "name": "드라마"
         },
         {
             "id": 53,
             "name": "스릴러"
         }
     ],
     "homepage": "",
     "id": 814800,
     "imdb_id": "tt9000184",
     "original_language": "en",
     "original_title": "Goodnight Mommy",
     "overview": "엄마의 시골집으로 찾아온 쌍둥이 형제가 얼굴을 붕대로 감고 있는 엄마와 마주한다. 다름 아닌 최근 받은 성형 수술 때문이라고 하는데… 갈수록 변덕스럽고 특이해지는 엄마의 행동에 거즈로 가린 여자는 자신의 엄마가 아니라는 끔찍한 의심이 형제의 마음속에 자리 잡는다.",
     "popularity": 564.782,
     "poster_path": "/oHhD5jD4S5ElPNNFCDKXJAzMZ5h.jpg",
     "production_companies": [
         {
             "id": 20881,
             "logo_path": null,
             "name": "Playtime",
             "origin_country": "FR"
         },
         {
             "id": 26995,
             "logo_path": "/acHyNRG9qZKvr4ZlhsKlojhYeey.png",
             "name": "Animal Kingdom",
             "origin_country": "US"
         }
     ],
     "production_countries": [
         {
             "iso_3166_1": "FR",
             "name": "France"
         },
         {
             "iso_3166_1": "US",
             "name": "United States of America"
         }
     ],
     "release_date": "2022-09-16",
     "revenue": 0,
     "runtime": 91,
     "spoken_languages": [
         {
             "english_name": "English",
             "iso_639_1": "en",
             "name": "English"
         }
     ],
     "status": "Released",
     "tagline": "",
     "title": "굿나잇 마미",
     "video": false,
     "vote_average": 6.266,
     "vote_count": 107
 }
 
 */

import Foundation

struct MovieDetail: Codable, Identifiable {
    
    let adult: Bool
    let backdropPath: String
    
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

struct ProductionCountry: Codable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
