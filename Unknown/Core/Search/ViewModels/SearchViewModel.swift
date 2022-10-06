//
//  SearchViewModel.swift
//  Unknown
//
//  Created by sean on 2022/09/29.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject{
    
    @Published var searchText: String = ""
    var previouslySearchedKey: String = ""
    
    let movieSearchDataService = MovieSearchDataService.instance
    
    @Published var searchedMovies: [Movie] = []
    @Published var searchedMovieList: MovieList? = nil
    
    private var isFirstSearch: Bool = true
    
    @Published var selectedMovie: Movie? = nil
    @Published var showDetail: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    static let instance = SearchViewModel()
    
    private init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        movieSearchDataService.$searchedMovieList
            .sink { [weak self] searchedMovieList in
                guard let self = self else { return }
                
                self.searchedMovieList = searchedMovieList
                
                if self.isFirstSearch{
                    self.searchedMovies = searchedMovieList?.results ?? []
                }else{
                    self.searchedMovies.append(contentsOf: searchedMovieList?.results ?? [])
                }
            }
            .store(in: &cancellables)
    }
    
    func searchMovie(key: String, page: Int = 1){
        isFirstSearch = true
        previouslySearchedKey = key
        movieSearchDataService.searchMovie(key: key, page: page)
    }
    
    func searchMovieIfPossible(){
        guard
            let searchedMovieList = searchedMovieList else { return }
        isFirstSearch = false
        let currentPage = searchedMovieList.page
        let totalPage = searchedMovieList.totalPages
        if currentPage < totalPage {
            movieSearchDataService.searchMovie(key: previouslySearchedKey, page: currentPage + 1)
        }
    }
}
