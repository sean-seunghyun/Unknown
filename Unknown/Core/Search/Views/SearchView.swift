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
                SearchBarView(vm: vm, textFieldText: $vm.searchText)
                    .padding()
                
                if let movieList = vm.searchedMovieList,
                   movieList.totalResults > 0{
                    Text("총 \(movieList.totalResults) 건의 검색결과가 있습니다.")
                        .foregroundColor(Color.theme.gray)
                    
                    ScrollView {
                        LazyVStack{
                            ForEach(vm.searchedMovies) { movie in
                                    SearchedMovieRow(movie: movie)
                                        .onAppear {
                                            if vm.searchedMovies.last == movie{
                                                onScrolledAtBottom()
                                            }
                                        }
                                }
                        }
                    }
                    
                }else{
                    Spacer()
                    VStack {
                        Text("🤔")
                            .font(.largeTitle)
                        
                        Text("We are sorry. \n We cannot find the movie :( ")
                            .multilineTextAlignment(.center)
                            .font(.title)
                        
                    }
                    .foregroundColor(Color.theme.gray)
                }
                
                
                Spacer()
            }
            
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(dev.homeVM)
    }
}


extension SearchView{
    func onScrolledAtBottom(){
        print("fetchNextPageIfPossible")
        vm.searchMovieIfPossible()
        
    }
}
