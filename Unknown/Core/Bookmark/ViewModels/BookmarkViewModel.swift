//
//  BookmarkViewModel.swift
//  Unknown
//
//  Created by sean on 2022/10/06.
//

import Foundation
import Combine

class BookmarkViewModel: ObservableObject{
    @Published var bookmarkedMovies: [Movie] = []
    
    private var homeViewModel = HomeViewModel.instance
    private var cancellables = Set<AnyCancellable>()

    static let instance = BookmarkViewModel()
    
    private init(){
        addSubscribers()
    }
    
    func addSubscribers(){
        homeViewModel.$bookmarkedMovies
            .sink { [weak self] receivedMovies in
                self?.bookmarkedMovies = receivedMovies
            }
            .store(in: &cancellables)

    }
    
}
