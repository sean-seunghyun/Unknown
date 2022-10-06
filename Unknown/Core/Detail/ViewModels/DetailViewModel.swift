//
//  DetailViewModel.swift
//  Unknown
//
//  Created by sean on 2022/09/27.
//

import Foundation
import Combine

class DetailViewModel:ObservableObject{
    @Published var movie: Movie
    let movieDetailDataService: MovieDetailDataService
    let bookmarkDataService: BookmarkDataService
    var cancellables = Set<AnyCancellable>()
    @Published var movieDetail: MovieDetail? = nil
    
    @Published var isBookmarked: Bool
  
    
    enum Tab: String{
        case aboutMovies = "About Movies"
        case reviews = "Reviews"
        case revenue = "Revenue"
    }
    
    @Published var selectedTab:Tab = .aboutMovies
    let tabs:[Tab] = [.aboutMovies, .reviews, .revenue]
    
    init(movie: Movie){
        self.movie = movie
        self.movieDetailDataService = MovieDetailDataService(movie: movie)
        self.bookmarkDataService = BookmarkDataService.instance
        self.isBookmarked = bookmarkDataService.isBookmarked(movie: movie)
        
        addSubscribers()
    }
    
    func addSubscribers(){
        movieDetailDataService.$movieDetail
            .sink { [weak self] returnedMovieDetail in
                self?.movieDetail = returnedMovieDetail
            }
            .store(in: &cancellables)
        
        bookmarkDataService.$bookmarkedMovieEntities
            .map(isBookmarkedMovie)
            .sink { [weak self] isBookmarked in
                self?.isBookmarked = isBookmarked
            }
            .store(in: &cancellables)
    }
    
    
    func updateBookmark(_ movie: Movie){
        bookmarkDataService.updateBookmark(movie: movie)
    }
    
    private func isBookmarkedMovie(entities: [BookmarkedMovieEntity]) -> Bool{
        if entities.first(where: { $0.movieID == self.movie.id }) != nil{
            return true
        }
        else {
            return false
        }
    }
}
