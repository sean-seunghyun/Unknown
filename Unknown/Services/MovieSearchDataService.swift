//
//  MovieSearchDataService.swift
//  Unknown
//
//  Created by sean on 2022/09/28.
//

import Foundation
import Combine

class MovieSearchDataService{
    
    @Published var searchedMovieList:MovieList? = nil
    private var movieSearchSubscription:AnyCancellable?
    
    static let instance = MovieSearchDataService()
    
    private init(){

    }
    
    func searchMovie(key: String, page: Int){
        guard let url = URL(string:"https://api.themoviedb.org/3/search/movie?api_key=\(Bundle.main.apiKey)&language=ko-KR&query=\(key)&page=\(page)&include_adult=false") else { return }
        
        
        movieSearchSubscription = NetworkingManager
            .download(for: url)
            .decode(type: MovieList.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] receivedMovieList in
                self?.searchedMovieList = receivedMovieList
                self?.movieSearchSubscription?.cancel()
            })
        
    }
    
    
    
    
    
}
