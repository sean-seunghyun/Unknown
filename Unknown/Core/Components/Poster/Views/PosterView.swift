//
//  PosterView.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//

import SwiftUI

struct PosterView: View {
    private let movie:Movie
    @StateObject private var vm:PosterViewModel
    
    init(movie: Movie){
        self.movie = movie
        _vm = StateObject(wrappedValue: PosterViewModel(movie: movie))
    }
    
    var body: some View {
        if let poster = vm.poster{
            Image(uiImage: poster)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }else{
            ProgressView()
        }
        
    }
}

struct PosterView_Previews: PreviewProvider {
    static var previews: some View {
        PosterView(movie: dev.movie)
            .previewLayout(.sizeThatFits)
    }
}
