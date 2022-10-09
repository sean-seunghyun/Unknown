//
//  SearchedMovieRow.swift
//  Unknown
//
//  Created by sean on 2022/09/28.
//

import SwiftUI

struct SearchedMovieRow: View {
    let movie: Movie
    let genreFinder = GenreFinder.instance
    var body: some View {
        HStack{
            PosterView(movie: movie, posterStorage: .cache)
                .frame(width: 100, height: 130)
                .clipped()
                .padding(.trailing, 10)
                .padding(.leading, 10)
            
            VStack(alignment: .leading){
                
                title
                rating
                category
                releaseDate
            }
            Spacer()
        }
        .padding(.bottom, 5)
        .background(Color.theme.background)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SearchedMovieRow_Previews: PreviewProvider {
    static var previews: some View {
            SearchedMovieRow(movie: dev.movie)
                .previewLayout(.sizeThatFits)
    }
}

extension SearchedMovieRow{
    private var title: some View{
        Text(movie.title)
            .bold()
            .font(.title3)
            .padding(.bottom)
            .foregroundColor(Color.theme.white)
    }
    
    private var rating: some View{
        HStack {
            Image(systemName: "star")
                .frame(width: 20)
            Text(movie.voteAverage.asNumberString())
                .bold()
        }
        .foregroundColor(Color.theme.orange)
    }
    
    private var category: some View{
        HStack {
            Image(systemName: "ticket")
                .frame(width: 20)
            Text(genreFinder.getGenreName(id: movie.genreIDS?.first ?? 0) ?? "n/a")
            
        }
        .font(.subheadline)
        .foregroundColor(Color.theme.white)
    }
    
    private var releaseDate: some View{
        HStack {
            Image(systemName: "calendar")
                .frame(width: 20)
            
            if let releaseDate = movie.releaseDate,
               releaseDate != ""
            {
                Text(releaseDate.prefix(4))
            }else{
                Text("n/a")
            }
            
        }
        .font(.subheadline)
        .foregroundColor(Color.theme.white)
    }
}
