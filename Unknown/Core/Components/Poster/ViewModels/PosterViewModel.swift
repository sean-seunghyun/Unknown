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
//    private var cancellables = Set<AnyCancellable>()
    private var moviePosterSubscription: AnyCancellable?
    
    @Published var poster: UIImage? = nil
    
    
    @Published var isLoading: Bool
    
    
    
    
    init(movie: Movie, posterStorage: PosterStorage){
        self.movie = movie
        self.posterStorage = posterStorage
        isLoading = true
        dataService = MoviePosterDataService(movie: movie, posterStorage: posterStorage)
        addSubscribers()
    }

    
    
    private func addSubscribers(){           
        moviePosterSubscription = dataService.posterPublisher
            .sink { [weak self] completion in
                switch completion{
                case .finished :
                    self?.isLoading = false
                    break
                case .failure(let error) :
                    print("error occured: \(error)")
                }
            } receiveValue: {[weak self] receivedPoster in
                self?.poster = receivedPoster
            }
    }
    
}


