//
//  MoviePosterData.swift
//  Unknown
//
//  Created by sean on 2022/09/29.
//

import Foundation
import SwiftUI
import Combine

class MoviePosterDataService{
//    @Published var poster: UIImage?
//    let passThroughPosterPublisher = PassthroughSubject<UIImage?, Error>()
        let posterPublisher = CurrentValueSubject<UIImage?, Error>(nil)

    
    private let movie: Movie
    private let posterStorage: PosterStorage
    private var moviePosterSubscription: AnyCancellable?
    let posterBaseURL: String = "https://image.tmdb.org/t/p/w500"
    
    let cacheManager = CacheManager.instance
    
    let fileManger = LocalFileManager.instance
    let folderName: String = "movie_posters"
    let imageName: String
    var cancellables = Set<AnyCancellable>()
    
    init(movie: Movie, posterStorage: PosterStorage){
        self.movie = movie
        self.posterStorage = posterStorage
        self.imageName = String(movie.id)
        
        getMoviePoster()
    }
    
    private func getMoviePoster(){
        let savedMoviePoster = getMoviePosterFromStorage()
        
        if let savedMoviePoster = savedMoviePoster {
            print("get saved movie poster: \(movie.title)")
            posterPublisher.send(savedMoviePoster)
        }else{
            downloadMoviePoster()
        }

    }
    
    private func getMoviePosterFromStorage() -> UIImage?{
        
        switch posterStorage {
        case .localFileManager:
            return fileManger.get(folderName: folderName, imageName: imageName)
            
        case .cache:
            return cacheManager.get(key: imageName)
        }
        
    }
    
    private func downloadMoviePoster(){
        guard
            let posterPath = movie.posterPath,
            let url = URL(string: "\(posterBaseURL)\(posterPath)") else {
            posterPublisher.send(completion: .finished)
            return
        }
        
        
        moviePosterSubscription =
        NetworkingManager.download(for: url)
        // 이미지는 decode할 필요 없음
        // 대신 tryMap으로 UIImage로 변환해주기
        
            .tryMap({UIImage(data: $0)})
         
            .receive(on: DispatchQueue.main) // decoing까지 background 스레드에서 진행, 이후에 main스레드에서 계속 작업
        
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedPoster in
                guard
                    let self = self,
                    let downloadedPoster = returnedPoster
                else {
                    print("downloaded Poster is nil")
                    return
                }
                self.posterPublisher.send(downloadedPoster)
                self.save(image: downloadedPoster, to: self.posterStorage)
                self.moviePosterSubscription?.cancel()
            })
    }
    
    private func save(image: UIImage, to posterStorage: PosterStorage){
        switch self.posterStorage {
        case .localFileManager:
            self.fileManger.add(image: image, folderName: self.folderName, imageName: self.imageName)
            
        case .cache:
            self.cacheManager.add(key: self.imageName, image: image)
            
        }
    }
    
    
}

