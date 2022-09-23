//
//  NowPlayingMoviesDataService.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//


import Foundation
import SwiftUI
import Combine


class NowPlayingMoviesDataService{
    @Published var nowPlayingMovies:[Movie] = []
  
    private var nowPlayingMoviesSubscription:AnyCancellable?
    
    static let instance = NowPlayingMoviesDataService()
    
    private init(){
        getNowPlayingMovies()
    }
    
    private func getNowPlayingMovies(){
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(Bundle.main.apiKey)&language=ko-KR&page=1&region=KR") else { return }
        
        nowPlayingMoviesSubscription =
        NetworkingManager.download(for: url)
            .decode(type: NowPlayingMovies.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] nowPlayingMovies in
                self?.nowPlayingMovies = nowPlayingMovies.results
                self?.nowPlayingMoviesSubscription?.cancel()
            })
    }
    
    
}

