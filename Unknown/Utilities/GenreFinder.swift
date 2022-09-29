//
//  GenreFinder.swift
//  Unknown
//
//  Created by sean on 2022/09/28.
//

import Foundation

struct GenreFinder{
    
    static let instance = GenreFinder()
    
    let genres:[Genre] = [
        
        Genre(id: 28, name: "액션"),
        Genre(id: 12, name: "모험"),
        Genre(id: 16, name: "애니메이션"),
        Genre(id: 35, name: "코미디"),
        Genre(id: 80, name: "범죄"),
        Genre(id: 99, name: "다큐멘터리"),
        Genre(id: 18, name: "드라마"),
        Genre(id: 10751, name: "가족"),
        Genre(id: 14, name: "판타지"),
        Genre(id: 36, name: "역사"),
        Genre(id: 27, name: "공포"),
        Genre(id: 10402 , name: "음악"),
        Genre(id: 9648, name: "미스터리"),
        Genre(id: 10749, name: "로맨스"),
        Genre(id: 878, name: "SF"),
        Genre(id: 10770, name: "TV 영화"),
        Genre(id: 53, name: "스릴러"),
        Genre(id: 10752, name: "전쟁"),
        Genre(id: 37, name: "서부")
    ]
    
    private init(){
        
    }
    
    func getGenreName(id: Int) -> String?{
        
        let genre = genres.first(where: {$0.id == id})
        guard let genre = genre else {
            return nil
        }
        
        return genre.name
    }
    
    
}
