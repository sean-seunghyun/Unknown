//
//  HomeViewModel.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    enum Tab: String{
        case popular = "Popular"
        case upcoming = "Upcoming"
        case topRated = "Top Rated"
    }
    
    @Published var selectedTab:Tab = .popular
    let tabs:[Tab] = [.popular, .upcoming, .topRated]

    
    @Published var trendingMovies:[Movie] = []
    @Published var upcomingMovies:[Movie] = []
    @Published var popularMovies:[Movie] = []
    @Published var topRatedMovies:[Movie] = []

    
    let nowPlayingMoviesDataService = NowPlayingMoviesDataService.instance
    let upcomingMoviesDataService = UpcomingMoviesDataService.instance
    let popularMoviesDataService = PopularMoviesDataService.instance
    let topRatedMoviesDataService = TopRatedMoviesDataService.instance
    
    @Published var selectedMovie: Movie? = nil
    @Published var showDetail: Bool = false
    
    @Published var textFieldText: String = ""
    
//    @Published var searchText: String = ""
    
//    let movieSearchDataService = MovieSearchDataService.instance
//    @Published var searchedMovies: [Movie] = []
//    @Published var searchedMovieList: MovieList? = nil
//
    var cancellables = Set<AnyCancellable>()
    
    static let instance = HomeViewModel()
    
    private init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        nowPlayingMoviesDataService.$nowPlayingMovies
            .sink { [weak self] trendingMovies in
                self?.trendingMovies = trendingMovies
            }
            .store(in: &cancellables)
        
        upcomingMoviesDataService.$upcomingMovies
            .sink { [weak self] upcomingMovies in
                self?.upcomingMovies = upcomingMovies
            }
            .store(in: &cancellables)
        
        popularMoviesDataService.$popularMovies
            .sink { [weak self] popularMovies in
                self?.popularMovies = popularMovies
            }
            .store(in: &cancellables)
        
        topRatedMoviesDataService.$topRatedMovies
            .sink { [weak self] topRatedMovies in
                self?.topRatedMovies = topRatedMovies
            }
            .store(in: &cancellables)
        
   
    }
    
//    func searchMovie(key: String, page: Int = 1){
//        movieSearchDataService.searchMovie(key: key, page: page)
//    }
//    
//    func searchMovieIfPossible(){
//        guard
//            let searchedMovieList = searchedMovieList        else {
//            return
//        }
//        
//        let currentPage = searchedMovieList.page
//        let totalPage = searchedMovieList.totalPages
//        if currentPage < totalPage {
//            movieSearchDataService.searchMovie(key: searchText, page: currentPage+1)
//        }
//        
//    }
}
