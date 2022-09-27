//
//  MovieBackdropDataService.swift
//  Unknown
//
//  Created by sean on 2022/09/27.
//
//


import Foundation
import SwiftUI
import Combine


class MovieBackdropDataService{
    @Published var backdrop:UIImage? = nil
    private let movie: Movie
    private var movieBackdropSubscription:AnyCancellable?
    
    let posterBaseURL: String = "https://image.tmdb.org/t/p/w500"
    
    let fileManger = LocalFileManager.instance
    let folderName: String = "movie_backdrops"
    let imageName: String
    
    init(movie: Movie){
        self.movie = movie
        self.imageName = String(movie.id)
        
        getMovieBackdrop()
    }
    
    private func getMovieBackdrop(){
        if let savedMovieBackdrop = fileManger.get(folderName: folderName, imageName: imageName){
            backdrop = savedMovieBackdrop
        }else{
            downloadMoviePoster()
        }
    }
    
    private func downloadMoviePoster(){
        guard
            let backdropPath = movie.backdropPath,
            let url = URL(string: "\(posterBaseURL)\(backdropPath)") else { return }
        movieBackdropSubscription = NetworkingManager.download(for: url)
        // 이미지는 decode할 필요 없음
        // 대신 tryMap으로 UIImage로 변환해주기
            .tryMap({UIImage(data: $0)})
            .receive(on: DispatchQueue.main) // decoing까지 background 스레드에서 진행, 이후에 main스레드에서 계속 작업
        
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedBackdrop in
                guard
                    let self = self,
                    let downloadedBackdrop = returnedBackdrop
                else { return }
                self.backdrop = downloadedBackdrop
                self.fileManger.add(image: downloadedBackdrop, folderName: self.folderName, imageName: self.imageName)
                self.movieBackdropSubscription?.cancel()
            })
    }
    
    
}


