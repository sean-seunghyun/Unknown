//
//  PosterViewModel.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//

import Foundation
import SwiftUI
import Combine

enum PosterStorage{
    case localFileManager
    case cache
}

class PosterViewModel: ObservableObject{
    
    private let posterStorage: PosterStorage
    private let movie: Movie
    private let dataService: MoviePosterDataService
    private var cancellables = Set<AnyCancellable>()
    @Published var poster: UIImage? = nil
    
    
    init(movie: Movie, posterStorage: PosterStorage){
        self.movie = movie
        self.posterStorage = posterStorage
        dataService = MoviePosterDataService(movie: movie, posterStorage: posterStorage)
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
