//
//  DetailView.swift
//  Unknown
//
//  Created by sean on 2022/09/27.
//

import SwiftUI

struct DetailView: View {
    
    let movie: Movie
    @StateObject var vm: DetailViewModel
    
    init(movie: Movie){
        self.movie = movie
        _vm = StateObject(wrappedValue: DetailViewModel(movie: movie))
        
    }
    
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            
            
            ScrollView {
                VStack{
                    BackdropView(movie: movie)
                        .frame(width: UIScreen.main.bounds.width, height: 250)
                        .overlay(
                            Capsule(style: .continuous)
                                .frame(width: 80, height: 30)                   .foregroundColor(Color.black.opacity(0.4))
                                .addBorder(Color.orange, cornerRadius: 15)
                                .overlay(
                                    HStack{
                                        Image(systemName: "star")
                                        Text(vm.movieDetail?.voteAverage.asNumberString() ?? "")
                                        
                                    }
                                        .font(.subheadline)
                                        .foregroundColor(Color.orange)
                                )
                            
                            ,alignment: .bottomTrailing
                        )
                    
                    
                    HStack(alignment: .bottom, spacing: 0) {
                        PosterView(movie: movie)
                            .frame(width: 110, height: 150)
                        
                        Text(movie.title)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.theme.white)
                            .padding(.bottom, 20)
                    }
                    
                    .offset(y: -100)
                    .padding(.bottom, -100)
                    
                    
                    HStack(spacing: 20){
                        HStack {
                            Image(systemName: "calendar")
                            Text(movie.releaseDate.prefix(4))
                        }
                        Text("|")
                        HStack{
                            Image(systemName: "clock")
                            Text("\(vm.movieDetail?.runtime ?? 0)")
                        }
                        Text("|")
                        HStack{
                            Image(systemName: "ticket")
                            
                            if let movieDetail = vm.movieDetail,
                               let genre = movieDetail.genres.first{
                                Text(genre.name)
                            }
                            
                        }
                        
                    }
                    
                    .padding(.vertical, 20)
                    .font(.headline)
                    .foregroundColor(Color.theme.gray)
                    
                    HStack {
                        ForEach(vm.tabs, id: \.self) { tab in
                            TabItemView(title: tab.rawValue, isSelected: vm.selectedTab == tab ? true : false)
                                .onTapGesture {
                                    withAnimation(.easeOut) {
                                        vm.selectedTab = tab
                                    }
                                    
                                }
                        }
                       
                    }
//                    .padding(.horizontal)
                    
                    
                    
                    ZStack {
                        Text(vm.movieDetail?.overview ?? "")
                            .foregroundColor(Color.theme.white)
                    }
                    .padding()
                    
                    
                    
                }
                .frame(maxWidth: UIScreen.screenWidth)
            }
            
            
        }
        
        
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(movie: dev.movie)
    }
}
