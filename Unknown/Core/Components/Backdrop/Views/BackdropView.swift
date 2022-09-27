//
//  BackdropView.swift
//  Unknown
//
//  Created by sean on 2022/09/27.
//

import SwiftUI

struct BackdropView: View {
    let movie: Movie
    @StateObject var vm: BackdropViewModel
    
    init(movie: Movie){
        self.movie = movie
        _vm = StateObject(wrappedValue: BackdropViewModel(movie: movie))
    }
    
    var body: some View {
        if let backdropImage = vm.backdrop{
            Image(uiImage: backdropImage)
                .resizable()
                .scaledToFill()
        }else{
            ProgressView()
        }
        
    }
}

struct BackdropView_Previews: PreviewProvider {
    static var previews: some View {
        BackdropView(movie: dev.movie)
    }
}
