//
//  TopRatedDataService.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//

import Foundation
import SwiftUI
import Combine


class TopRatedMoviesDataService{
    @Published var topRatedMovies:[Movie] = []
  
    private var topRatedMoviesSubscription:AnyCancellable?
    
    static let instance = TopRatedMoviesDataService()
    
    private init(){
        getTopRatedMovies()
    }
    
    private func getTopRatedMovies(){
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(Bundle.main.apiKey)&language=ko-KR&page=1&region=KR") else { return }
        
        topRatedMoviesSubscription =
        NetworkingManager.download(for: url)
            .decode(type: TopRatedMovies.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] topRatedMovies in
                self?.topRatedMovies = topRatedMovies.results
                self?.topRatedMoviesSubscription?.cancel()
            })
    }
    
    
}
