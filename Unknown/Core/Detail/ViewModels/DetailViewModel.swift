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
    let movieSearchDataService: MovieSearchDataService
    let bookmarkCoreDataService: BookmarkCoreDataService
    
    var bookmarkedMovieIDs:[Int] = []
    
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
        self.bookmarkCoreDataService = BookmarkCoreDataService.instance
        self.isBookmarked = bookmarkCoreDataService.isBookmarked(movie: movie)
        self.movieSearchDataService = MovieSearchDataService.instance
        
        addSubscribers()
    }
    
    func addSubscribers(){
        movieDetailDataService.$movieDetail
            .sink { [weak self] returnedMovieDetail in
                self?.movieDetail = returnedMovieDetail
            }
            .store(in: &cancellables)
        
        
        // bookmarkDataService의 북마크 되어있는 Entity의 값이 변화할 때마다 detailView에 해당하는 movie의 id가 Entity의 id와 같은지 확인해 북마크되어있는지 여부를 판단함
        bookmarkCoreDataService.$bookmarkedMovieEntities
            .map(isBookmarkedMovie)
            .sink { [weak self] isBookmarked in
                self?.isBookmarked = isBookmarked
            }
            .store(in: &cancellables)
    }
    
    
    func updateBookmark(_ movie: Movie){
        bookmarkCoreDataService.updateBookmark(movie: movie)
    }
    
    
    private func isBookmarkedMovie(entities: [BookmarkedMovieEntity]) -> Bool{
        print(entities)
        
        if entities.first(where: { $0.movieID == self.movie.id }) != nil{
            return true
        }
        else {
            return false
        }
    }
}
