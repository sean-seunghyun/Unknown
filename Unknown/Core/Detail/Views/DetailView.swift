//
//  DetailView.swift
//  Unknown
//
//  Created by sean on 2022/09/27.
//

import SwiftUI



struct DetailView: View {
    
    private let movie: Movie
    @StateObject private var vm: DetailViewModel
    
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
                    backdrop
                    posterAndTitle
                    
                    movieBriefInfo
                    
                    movieTabItems
                    movieTabContents
                    
                }
                .frame(maxWidth: UIScreen.screenWidth)
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(movie: dev.movie)
    }
}


extension DetailView{
    
    private var backdrop: some View{
        BackdropView(movie: movie)
            .frame(width: UIScreen.main.bounds.width, height: 250)
            .overlay(
                movieRating
                    .padding()
                ,alignment: .bottomTrailing
            )
    }
    
    private var movieRating: some View{
        Capsule(style: .continuous)
            .frame(width: 80, height: 30)                   .foregroundColor(Color.black.opacity(0.4))
            .addBorder(Color.orange, cornerRadius: 15)
            .overlay(
                HStack{
                    Image(systemName: "star")
                    Text(vm.movieDetail?.voteAverage.asNumberString() ?? "0.0")
                    
                }
                    .font(.subheadline)
                    .foregroundColor(Color.orange)
            )
    }
    
    
    private var posterAndTitle: some View{
        HStack(alignment: .bottom, spacing: 0) {
            PosterView(movie: movie, posterStorage: .localFileManager)
                .frame(width: 110, height: 150)
            Spacer()
            Text(movie.title)
                .fontWeight(.semibold)
                .font(.title)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .foregroundColor(Color.theme.white)
                .padding(.bottom, 20)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .offset(y: -100)
        .padding(.bottom, -100)
    }
    
    private var movieBriefInfo: some View{
        HStack(spacing: 20){
            HStack {
                Image(systemName: "calendar")
                if let releaseDate = movie.releaseDate,
                   releaseDate != ""
                {
                    Text(releaseDate.prefix(4))
                }else{
                    Text("n/a")
                }
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
                }else{
                    Text("n/a")
                }
                
            }
            
        }
        .padding(.vertical, 20)
        .font(.headline)
        .foregroundColor(Color.theme.gray)
        
    }
    
    private var movieTabItems: some View{
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
    }
    
    private var movieTabContents: some View{
        
        ZStack{
            switch vm.selectedTab{
                
            case .aboutMovies:
                Text(vm.movieDetail?.overview ?? "n/a")
            case .reviews:
                VStack(spacing: 20){
                    HStack {
                        Text("Rating")
                        Spacer()
                        Text(vm.movieDetail?.voteAverage.asNumberString() ?? "0.0")
                            .bold()
                    }
                    Divider()
                    HStack {
                        Text("Voting count")
                        Spacer()
                        Text(String(vm.movieDetail?.voteCount ?? 0))
                            .bold()
                    }
                    Divider()
                    HStack {
                        Text("Popularity")
                        Spacer()
                        Text(vm.movieDetail?.popularity.asNumberString() ?? "0")
                            .bold()
                    }
                }
                
            case .revenue:
                HStack {
                    Text("Total Revenue")
                    Spacer()
                    
                    if let revenue = vm.movieDetail?.revenue{
                        if revenue != 0{
                            Text("$ \(revenue)")
                        }else{
                            Text("0")
                                .bold()
                        }
                    }else{
                        Text("0")
                    }
                    
                }
            }
        }
        .padding()
        .foregroundColor(Color.theme.white)
        
    }
    
    
    
}


