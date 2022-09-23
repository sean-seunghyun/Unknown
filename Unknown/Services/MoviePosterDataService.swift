//
//  MoviePosterDataService.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//


import Foundation
import SwiftUI
import Combine


class MoviePosterDataService{
    @Published var poster:UIImage? = nil
    private let movie: Movie
    private var moviePosterSubscription:AnyCancellable?
    
    let posterBaseURL: String = "https://image.tmdb.org/t/p/w500"
    let fileManger = LocalFileManager.instance
    let folderName: String = "movie_posters"
    let imageName: String

    init(movie: Movie){
        self.movie = movie
        self.imageName = String(movie.id)
        
        getMoviePoster()
    }
    
    private func getMoviePoster(){
        if let savedMoviePoster = fileManger.get(folderName: folderName, imageName: imageName){
            poster = savedMoviePoster
        }else{
            downloadMoviePoster()
        }
    }
    
    private func downloadMoviePoster(){
        guard
            let posterPath = movie.posterPath,
            let url = URL(string: "\(posterBaseURL)\(posterPath)") else { return }
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
                else { return }
                self.poster = downloadedPoster
                self.fileManger.add(image: downloadedPoster, folderName: self.folderName, imageName: self.imageName)
                self.moviePosterSubscription?.cancel()
            })
    }
    
    
}

