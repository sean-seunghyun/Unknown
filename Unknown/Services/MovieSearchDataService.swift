//
//  MovieSearchDataService.swift
//  Unknown
//
//  Created by sean on 2022/09/28.
//

import Foundation
import Combine

class MovieSearchDataService{
    
    @Published var searchedMovieList:MovieList? = nil

    private var movieSearchSubscription:AnyCancellable?
    private var moiveSearchByIdSubscription: AnyCancellable? //
    private var cancellables = Set<AnyCancellable>()
    
    static let instance = MovieSearchDataService()
    
    private init(){
        
    }
    
    
    func searchMovie(key: String, page: Int){
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(Bundle.main.apiKey)&language=ko-KR&query=\(key)&page=\(page)&include_adult=false"
        
        guard
            let encodedURLString = urlString.encodeUrl(),
            let url = URL(string:encodedURLString) else {
            return
        }
        
        movieSearchSubscription = NetworkingManager
            .download(for: url)
            .decode(type: MovieList.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] receivedMovieList in
                self?.searchedMovieList = receivedMovieList
                self?.movieSearchSubscription?.cancel()
            })
    }
    

    func searchMovie(id: Int, completionHandler: @escaping (_ movie: Movie)->()){
        let urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=\(Bundle.main.apiKey)&language=ko-KR"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            guard
                let data = data,
                let urlResponse = urlResponse as? HTTPURLResponse,
                  urlResponse.statusCode >= 200 && urlResponse.statusCode < 300 else {
                return
            }

            let decoder = JSONDecoder()
            do{
                let returnedMovie = try decoder.decode(Movie.self, from: data)
                completionHandler(returnedMovie)
            }catch{
                print(error)
            }

        }
        .resume()
    }
    
    func searchMovie(id: Int){
        let urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=\(Bundle.main.apiKey)&language=ko-KR"
        guard let url = URL(string: urlString) else { return }
        
        
        moiveSearchByIdSubscription = NetworkingManager
            .download(for: url)
            .decode(type: Movie.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { receivedMovie in
                print(receivedMovie.title)
                self.movieSearchSubscription?.cancel()
            })
        
    }

    
}
