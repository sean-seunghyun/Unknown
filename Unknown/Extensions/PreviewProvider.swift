//
//  PreviewProvider.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//

import Foundation
import SwiftUI


extension PreviewProvider{
    
    static var dev:DeveloperPreview{
        return DeveloperPreview.instance
    }
}


struct DeveloperPreview{
    
    static let instance = DeveloperPreview()
    
    private init(){ }
    
    let movie = Movie(adult: false,
                      backdropPath: "/aCaqCvYn48b3lfGKGnUdVAE1yeB.jpg",
                      id: 814800,
                      title: "Goodnight Mommy",
                      originalLanguage: "en",
                      originalTitle: "Goodnight Mommy",
                      overview: "When twin brothers arrive home to find their mother’s demeanor altered and face covered in surgical bandages, they begin to suspect the woman beneath the gauze might not be their mother.",
                      posterPath: "/oHhD5jD4S5ElPNNFCDKXJAzMZ5h.jpg",
                      mediaType: "movie",
                      genreIDS: [
                        27,
                        18,
                        53
                      ], popularity: 493.591,
                      releaseDate: "2022-09-16",
                      video: false,
                      voteAverage: 5.963, voteCount: 67)
    
    let homeVM = HomeViewModel.instance
    
}
