//
//  SearchView.swift
//  Unknown
//
//  Created by sean on 2022/09/28.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var vm = SearchViewModel.instance
    
    var body: some View {
        
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            VStack{
                SearchBarView(textFieldText: $vm.searchText, handleSearchButton: handleSearchButton, handleXButton: handleSearchBarXButton)
                    .padding()
                
                if let movieList = vm.searchedMovieList,
                   movieList.totalResults > 0{
                    Text("총 \(movieList.totalResults) 건의 검색결과가 있습니다.")
                        .foregroundColor(Color.theme.gray)
                    
                    searchedResults
                    
                }else{
                    Spacer()
                    emptyResults
                }
                
                Spacer()
                Spacer()
            }
            
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(dev.homeVM)
    }
}

// MARK: - COMPONENTS
extension SearchView{
    private var searchedResults: some View {
        ScrollView {
            LazyVStack{
                ForEach(vm.searchedMovies) { movie in
                        SearchedMovieRow(movie: movie)
                            .onAppear {
                                if vm.searchedMovies.last == movie{
                                    onScrolledAtBottom()
                                }
                            }
                            .onTapGesture {
                                vm.selectedMovie = movie
                                vm.showDetail = true
                            }
                    }
            }
        }
    }
    
    private var emptyResults: some View{
        VStack {
            Text("🤔")
                .font(.largeTitle)
            
            Text("We are sorry. \n We couldn't find the movie :( ")
                .multilineTextAlignment(.center)
                .font(.title)
            
        }
        .foregroundColor(Color.theme.gray)

    }
}


// MARK: - FUNCTIONS
extension SearchView{
    private func onScrolledAtBottom(){
        print("fetchNextPageIfPossible")
        vm.searchMovieIfPossible()
    }
    
    private func handleSearchButton(){
        if vm.searchText == "" {
            return
        }
        var key = vm.searchText.lowercased()
        key = key.replacingOccurrences(of: " ", with: "+")
        vm.searchMovie(key: key)
    }
    
    private func handleSearchBarXButton(){
        vm.searchText = ""
        vm.searchedMovieList = nil
        vm.searchedMovies = []
    }
    
}


