//
//  HomeView.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            ScrollView{
                VStack(alignment: .leading){
                    
                   
                    headerTitle
                        .padding(.horizontal)
                    // search bar
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color.theme.darkGray)
                        .padding(.horizontal)
                        .frame(height: 40)
            
                    trendingMovies
                    tabItemTitles
                    
                    tabItems()
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
    
    private var headerTitle: some View{
       
        Text("What do you want to watch?")
            .foregroundColor(Color.theme.white)
            .bold()
            .font(.title2)
//            .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
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
                    PosterView(movie: movie)
                        .frame(width: 110, height: 150)
                }
            case .upcoming:
                ForEach(vm.upcomingMovies) { movie in
                    PosterView(movie: movie)
                        .frame(width: 110, height: 150)
                }
            case .topRated:
                ForEach(vm.topRatedMovies) { movie in
                    PosterView(movie: movie)
                        .frame(width: 110, height: 150)
                }
                
            }
            
            
        }
    }

}
