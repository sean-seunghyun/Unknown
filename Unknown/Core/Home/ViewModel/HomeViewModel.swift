//
//  HomeViewModel.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    
    @Published var selectedTab: Int = 0
    
    enum MovieFilterTab: String{
        case popular = "Popular"
        case upcoming = "Upcoming"
        case topRated = "Top Rated"
    }
    
    @Published var selectedMovieFilterTab:MovieFilterTab = .popular
    let movieFilterTabs:[MovieFilterTab] = [.popular, .upcoming, .topRated]

    
    @Published var nowPlayingMovies:[Movie] = []
    @Published var upcomingMovies:[Movie] = []
    @Published var popularMovies:[Movie] = []
    @Published var topRatedMovies:[Movie] = []
    
    @Published var bookmarkedMovies:[Movie] = []

    let nowPlayingMoviesDataService = NowPlayingMoviesDataService.instance
    let upcomingMoviesDataService = UpcomingMoviesDataService.instance
    let popularMoviesDataService = PopularMoviesDataService.instance
    let topRatedMoviesDataService = TopRatedMoviesDataService.instance


    let bookmarkCoreDataService = BookmarkCoreDataService.instance
    let movieSearchDataService = MovieSearchDataService.instance

    @Published var selectedMovie: Movie? = nil
    @Published var showDetail: Bool = false
    
    @Published var searchText: String = ""
    
    
    var cancellables = Set<AnyCancellable>()
    
    static let instance = HomeViewModel()
    
    private init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        nowPlayingMoviesDataService.$nowPlayingMovies
            .sink { [weak self] nowPlayingMovies in
                self?.nowPlayingMovies = nowPlayingMovies
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
        
        bookmarkCoreDataService.$bookmarkedMovieEntities
                .map (handleBookmarkedMovieEntity)
                .map(handleMovieIDs)
                .sink { _ in }
                .store(in: &cancellables)
        
    }
    
    private func handleBookmarkedMovieEntity(movieEntites: [BookmarkedMovieEntity]) -> [Int]{
        let ids = movieEntites.map({Int($0.movieID)})
        return ids
    }
    
    private func handleMovieIDs(ids: [Int]){
        self.bookmarkedMovies = [] // init array
        let _ = ids.map(requestMovie)
    }
    
    private func requestMovie(id: Int) -> (){
        movieSearchDataService.searchMovie(id: id, completionHandler: { [weak self] movie in
            DispatchQueue.main.async {
                self?.bookmarkedMovies.append(movie)
            }
        })
    }
    
}
