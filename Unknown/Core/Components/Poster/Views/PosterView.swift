//
//  PosterView.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//

import SwiftUI

struct PosterView: View {
    private let movie:Movie
    private let posterStorage: PosterStorage
    @StateObject private var vm:PosterViewModel
    
    init(movie: Movie, posterStorage: PosterStorage){
        self.movie = movie
        self.posterStorage = posterStorage
        _vm = StateObject(wrappedValue: PosterViewModel(movie: movie, posterStorage: posterStorage))
    }
    
    var body: some View {
        if let poster = vm.poster{
            Image(uiImage: poster)
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }else if vm.isLoading{
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.theme.white))
        }else {

            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.theme.gray)
        }
        
    }
}

struct PosterView_Previews: PreviewProvider {
    static var previews: some View {
        PosterView(movie: dev.movie, posterStorage: .localFileManager)
            .previewLayout(.sizeThatFits)
    }
}
