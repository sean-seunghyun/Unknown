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
    
    let movieDisplayCount: Int = 18
    
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
        
        
        //original
        //        bookmarkCoreDataService.$bookmarkedMovieEntities
        //                .map (handleBookmarkedMovieEntity)
        //                .map(handleMovieIDs)
        //                .sink { _ in }
        //                .store(in: &cancellables)
        //
        
        
        
        //https://stackoverflow.com/questions/58675046/how-to-process-an-array-of-task-asynchronously-with-swift-combine
        /*
         let subscriber = Just(userIds)
         .setFailureType(to: Error.self)
         .flatMap { (values) -> Publishers.MergeMany<AnyPublisher<User, Error>> in
         let tasks = values.map { (userId) -> AnyPublisher<User, Error> in
         let requestURL = URL(string: "https://jsonplaceholder.typicode.com/users/\(userId)")!
         
         return URLSession.shared.dataTaskPublisher(for: requestURL)
         .map { $0.data }
         .decode(type: User.self, decoder: JSONDecoder())
         .eraseToAnyPublisher()
         }
         return Publishers.MergeMany(tasks)
         }.collect().sink(receiveCompletion: { (completion) in
         if case .failure(let error) = completion {
         print("Got error: \(error.localizedDescription)")
         }
         }) { (allUsers) in
         print("Got users:")
         allUsers.map { print("\($0)") }
         }
         */
        bookmarkCoreDataService.$bookmarkedMovieEntities
            .setFailureType(to: Error.self)
            .map (handleBookmarkedMovieEntity)
            .flatMap { (values) -> Publishers.MergeMany<AnyPublisher<Movie, Error>> in
                let tasks = values.map { (movieId) -> AnyPublisher<Movie, Error> in
                    let requestURL = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(Bundle.main.apiKey)&language=ko-KR")!
                    
                    return URLSession.shared.dataTaskPublisher(for: requestURL)
                        .map { $0.data }
                        .decode(type: Movie.self, decoder: JSONDecoder())
                        .eraseToAnyPublisher()
                }
                self.bookmarkedMovies = []
                return Publishers.MergeMany(tasks)
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Got error: \(error.localizedDescription)")
                }
            } receiveValue: { returnedMovies in
                self.bookmarkedMovies.append(returnedMovies)
            }
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
    
    //    private func requestMovieForTest(id: Int){
    //        let urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=\(Bundle.main.apiKey)&language=ko-KR"
    //        guard let url = URL(string: urlString) else { return }
    //
    //        let publisher = URLSession.shared.dataTaskPublisher(for: url)
    //           .receive(on: DispatchQueue.main)
    //           .tryMap({ (data, response) -> Data in
    //
    //               self.bookmarkedMovies = []
    //
    //               guard
    //                   let response = response as? HTTPURLResponse,
    //                   response.statusCode >= 200 else {
    //                   throw URLError(.badServerResponse)
    //               }
    //               return data
    //           })
    //           .decode(type: Movie.self, decoder: JSONDecoder())
    //           .sink { completion in
    //               print("completion: \(completion)")
    //           } receiveValue: { movie in
    //               print(movie.title)
    //               self.bookmarkedMovies.append(movie)
    //           }
    //
    //    }
    
    
}
