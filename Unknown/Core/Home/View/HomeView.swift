//
//  HomeView.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    @State var selectedTab:Int = 0
    
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            ScrollView{
                VStack(alignment: .leading){
                    
                    // header title
                    Text("What do you want to watch?")
                        .foregroundColor(Color.theme.white)
                        .bold()
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    // search bar
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.theme.darkGray)
                        .frame(height: 50)
                    
                    
                    // trending
                    trendingMovies
                    
                    // sorting title
                    HStack(spacing: 0){
                        TabItemView(title: "Popular", isSelected: true)
                        TabItemView(title: "Upcoming", isSelected: false)
                        TabItemView(title: "Top Rated", isSelected: false)
                    }
                    
                    // Sorted Lists
                    LazyVGrid( columns: columns,
                               alignment: .center,
                               spacing: 20,
                               pinnedViews: []){
                        
                        
//                                                ForEach(vm.upcomingMovies) { movie in
//                                                    PosterView(movie: movie)
//                                                        .frame(width: 110, height: 150)
//                                                }
//
                        
                        ForEach(vm.topRatedMovies) { movie in
                            PosterView(movie: movie)
                                .frame(width: 110, height: 150)
                        }
                        
                    }
                    .padding(.horizontal)
                }
                
                
            }
            
        }
        .navigationBarHidden(true)
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(dev.homeVM)
    }
}

extension HomeView{
    private var trendingMovies: some View{
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack{
                
                ForEach(vm.trendingMovies) { movie in
                    PosterView(movie: movie)
                        .frame(width: 160, height: 230)
                }
                
                
            }
            .padding(.leading)
            
        }
    }
}
