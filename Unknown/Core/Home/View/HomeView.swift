//
//  HomeView.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//

import SwiftUI

struct HomeView: View {
    
    @State var selectedMovie: Movie? = nil
    @State var showDetail: Bool = false
    @State var textFieldText: String = ""
    
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            ScrollView{
                VStack(alignment: .leading){
                    
                   
                    headerTitle
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    
//                    SearchBarView(vm: <#SearchViewModel#>, textFieldText: $textFieldText)
//                        .padding(.horizontal, 10)
                    
                    trendingMovies
                    tabItemTitles
                        .padding(.bottom, 15)
                    
                    tabItems()
                        .padding(.horizontal)
                }
                
            }
            
        }
        .background(
            NavigationLink(isActive: $showDetail) {
                if let selectedMovie = selectedMovie {
                    DetailView(movie: selectedMovie)
                }
            } label: {
                EmptyView()
            }
        )
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(dev.homeVM)
    }
    
}

// MARK: - FUNCTIONS

extension HomeView{
    func segue(movie: Movie){
        self.selectedMovie = movie
        self.showDetail = true
    }
}

// MARK: - COMPONENTS

extension HomeView{
    
    private var headerTitle: some View{
       
        Text("What do you want to watch?")
            .foregroundColor(Color.theme.white)
            .bold()
            .font(.title2)
    }
    
    private var trendingMovies: some View{
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(alignment: .top, spacing: 10){

                ForEach(Array(vm.trendingMovies.enumerated()), id: \.offset) { index, movie in
                    
             
                    PosterView(movie: movie, posterStorage: .localFileManager)
                            .frame(width: 160, height: 230)
                            .overlay(
                                RankNumberView(number: index+1)
                                    .position(x: 20, y: 220)
                                )
    
                            .onTapGesture {
                                segue(movie: movie)
                            }
                        
                }
                
                
            }
            .frame(height: 300)
            .padding(.leading)
            
        }
    }
    
    private var tabItemTitles: some View{
        HStack(spacing: 0){
            
            ForEach(vm.tabs, id: \.self) { tab in
                TabItemView(title: tab.rawValue, isSelected: vm.selectedTab == tab ? true : false)
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            vm.selectedTab = tab
                        }
                        
                    }
            }
            
        }
    }
    
    private func tabItems() -> some View{
        
           let columns: [GridItem] = [
               GridItem(.flexible()),
               GridItem(.flexible()),
               GridItem(.flexible())
           ]
        
        
        return LazyVGrid( columns: columns,
                   alignment: .center,
                   spacing: 20,
                   pinnedViews: []){
            
            switch vm.selectedTab{
            case .popular:
                ForEach(vm.popularMovies) { movie in
                    PosterView(movie: movie, posterStorage: .localFileManager)
                        .frame(width: 110, height: 150)
                }
            case .upcoming:
                ForEach(vm.upcomingMovies) { movie in
                    PosterView(movie: movie, posterStorage: .localFileManager)
                        .frame(width: 110, height: 150)
                }
            case .topRated:
                ForEach(vm.topRatedMovies) { movie in
                    PosterView(movie: movie, posterStorage: .localFileManager)
                        .frame(width: 110, height: 150)
                }
                
            }
            
            
        }
    }

}
