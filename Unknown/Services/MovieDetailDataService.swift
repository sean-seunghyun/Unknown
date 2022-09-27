//
//  MovieDetailDataService.swift
//  Unknown
//
//  Created by sean on 2022/09/27.
//

import Foundation
import Combine

class MovieDetailDataService: ObservableObject{
    private let movie: Movie
    @Published var movieDetail: MovieDetail? = nil
    private let movieDetailBaseURL: String = "https://image.tmdb.org/t/p/w500"
    private var movieDetailSubscription:AnyCancellable?
    
    init(movie: Movie){
        self.movie = movie
        getMovieDetail()
    }
    
    private func getMovieDetail(){
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)?api_key=\(Bundle.main.apiKey)&language=ko-KR#") else { return }
        
        movieDetailSubscription = NetworkingManager.download(for: url)
            .decode(type: MovieDetail.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion(completion:)) { [weak self] receivedMovieDetail in
                self?.movieDetail = receivedMovieDetail
                self?.movieDetailSubscription?.cancel()
            }
    }
}
