//
//  BookmarkView.swift
//  Unknown
//
//  Created by sean on 2022/10/06.
//

import SwiftUI

struct BookmarkView: View {
    @StateObject var vm = BookmarkViewModel.instance
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            ScrollView {
                LazyVStack{
                    
                    ForEach(vm.bookmarkedMovies) { movie in
                        Text(String(movie.title))
//                            SearchedMovieRow(movie: movie)
//                                .onAppear {
//                                    if vm.searchedMovies.last == movie{
//                                        onScrolledAtBottom()
//                                    }
//                                }
//                                .onTapGesture {
//                                    vm.selectedMovie = movie
//                                    vm.showDetail = true
//                                }
                        }
                }
            }
        }
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
            .environmentObject(dev.homeVM)
    }
}
