//
//  PosterViewModel.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//

import Foundation
import SwiftUI
import Combine

class PosterViewModel: ObservableObject{
    private let movie: Movie
    private let dataService: MoviePosterDataService
    private var cancellables = Set<AnyCancellable>()
    @Published var poster: UIImage? = nil
    
    
    init(movie: Movie){
        self.movie = movie
        dataService = MoviePosterDataService(movie: movie)
        addSubscribers()
    }
    
    private func addSubscribers(){
        dataService.$poster
            .sink { [weak self] receivedPoster in
                self?.poster = receivedPoster
            }
            .store(in: &cancellables)
    }
}
