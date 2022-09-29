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
    
    var cancellables = Set<AnyCancellable>()
    
    static let instance = SearchViewModel()
    
    private init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        movieSearchDataService.$searchedMovieList
            .sink { [weak self] searchedMovieList in
                self?.searchedMovieList = searchedMovieList
                self?.searchedMovies.append(contentsOf: searchedMovieList?.results ?? [])
            }
            .store(in: &cancellables)
    }
    
    func searchMovie(key: String, page: Int = 1){
        previouslySearchedKey = key
        movieSearchDataService.searchMovie(key: key, page: page)
    }
    
    func searchMovieIfPossible(){
        guard
            let searchedMovieList = searchedMovieList else { return }
        let currentPage = searchedMovieList.page
        let totalPage = searchedMovieList.totalPages
        if currentPage < totalPage {
            movieSearchDataService.searchMovie(key: previouslySearchedKey, page: currentPage + 1)
        }
    }
}
