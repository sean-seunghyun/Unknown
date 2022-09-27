//
//  DetailViewModel.swift
//  Unknown
//
//  Created by sean on 2022/09/27.
//

import Foundation
import Combine

class DetailViewModel:ObservableObject{
    let movie: Movie
    let movieDetailDataService: MovieDetailDataService
    var cancellables = Set<AnyCancellable>()
    @Published var movieDetail: MovieDetail? = nil
    
    enum Tab: String{
        case aboutMovies = "About Movies"
        case reviews = "Reviews"
        case cost = "Cost"
    }
    
    @Published var selectedTab:Tab = .aboutMovies
    let tabs:[Tab] = [.aboutMovies, .reviews, .cost]
    
    init(movie: Movie){
        self.movie = movie
        self.movieDetailDataService = MovieDetailDataService(movie: movie)
        addSubscribers()
    }
    
    func addSubscribers(){
        movieDetailDataService.$movieDetail
            .sink { [weak self] returnedMovieDetail in
                self?.movieDetail = returnedMovieDetail
            }
            .store(in: &cancellables)
    }
    
}
