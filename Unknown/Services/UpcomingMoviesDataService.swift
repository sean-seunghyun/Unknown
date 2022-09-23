//
//  UpcomingMoviesDataService.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//



import Foundation
import SwiftUI
import Combine


class UpcomingMoviesDataService{
    @Published var upcomingMovies:[Movie] = []
  
    private var upcomingMoviesSubscription:AnyCancellable?
    
    static let instance = UpcomingMoviesDataService()
    
    private init(){
        getUpcomingMovies()
    }
    
    private func getUpcomingMovies(){
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(Bundle.main.apiKey)&language=ko-KR&page=1&region=KR") else { return }
        
        upcomingMoviesSubscription =
        NetworkingManager.download(for: url)
            .decode(type: UpcomingMovies.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] upcomingMovies in
                
                let upcomingMovies = upcomingMovies.results
                var upcomingMoviesWithPoster: [Movie] = []
                
                for upcomingMovie in upcomingMovies{
                    if upcomingMovie.posterPath != nil {
                        upcomingMoviesWithPoster.append(upcomingMovie)
                    }
                }
                
                self?.upcomingMovies = upcomingMoviesWithPoster
                self?.upcomingMoviesSubscription?.cancel()
            })
    }
    
    
}

