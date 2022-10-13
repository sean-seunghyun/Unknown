//
//  BookmarkView.swift
//  Unknown
//
//  Created by sean on 2022/10/06.
//

import SwiftUI

struct BookmarkView: View {
    @StateObject var vm = BookmarkViewModel.instance
    @Binding var tabSelection: Int
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            ScrollView {
                LazyVStack{
                    
                    ForEach(vm.bookmarkedMovies) { movie in
                            SearchedMovieRow(movie: movie)
                                .onTapGesture {
                                    vm.selectedMovie = movie
                                    vm.showDetail = true
                                }
                        }
                }
            }
            .padding(.top, 1)
        }
        
        .background(
            NavigationLink(isActive: $vm.showDetail) {
                if let selectedMovie = vm.selectedMovie {
                    DetailView(movie: selectedMovie)
                }
            } label: {
                EmptyView()
            }
        )
        
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView(tabSelection: .constant(2))
            .environmentObject(dev.homeVM)
    }
}
