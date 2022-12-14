//
//  BackdropViewModels.swift
//  Unknown
//
//  Created by sean on 2022/09/27.
//

import Foundation
import SwiftUI
import Combine

class BackdropViewModel: ObservableObject{
    let movie: Movie
    let backdropDataService: MovieBackdropDataService
    let posterDataService :MoviePosterDataService
    @Published var backdrop: UIImage? = nil
    @Published var poster: UIImage? = nil
    private var cancellables = Set<AnyCancellable>()
    
    init(movie: Movie){
        self.movie = movie
        backdropDataService = MovieBackdropDataService(movie: movie)
        posterDataService = MoviePosterDataService(movie: movie, posterStorage: .localFileManager)
        addSubscribers()
    }
    
    func addSubscribers(){
        backdropDataService.$backdrop
            .sink { [weak self] receivedBackdrop in
                self?.backdrop = receivedBackdrop
            }
            .store(in: &cancellables)
        
        posterDataService.posterPublisher
            .sink { completion in
                switch completion{
                case .finished : break
                case .failure(let error) :
                    print("error occured: \(error.localizedDescription)")
                }
            } receiveValue: {[weak self] receivedPoster in
                self?.poster = receivedPoster
            }
            .store(in: &cancellables)
    }
    
}
