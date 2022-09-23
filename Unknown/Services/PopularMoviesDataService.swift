//
//  PopularMoviesDataService.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//


import Foundation
import SwiftUI
import Combine


class PopularMoviesDataService{
    @Published var popularMovies:[Movie] = []
  
    private var popularMoviesSubscription:AnyCancellable?
    
    static let instance = PopularMoviesDataService()
    
    private init(){
        getPopularMovies()
    }
    
    private func getPopularMovies(){
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(Bundle.main.apiKey)&language=ko-KR&page=1&region=KR") else { return }
        
        popularMoviesSubscription =
        NetworkingManager.download(for: url)
            .decode(type: PopularMovies.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] popularMovies in
                self?.popularMovies = popularMovies.results
                self?.popularMoviesSubscription?.cancel()
            })
    }
    
    
}

