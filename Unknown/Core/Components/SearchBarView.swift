//
//  SearchBarView.swift
//  Unknown
//
//  Created by sean on 2022/09/28.
//

import SwiftUI

struct SearchBarView: View {
//    @EnvironmentObject var vm:HomeViewModel
    @ObservedObject var vm:SearchViewModel
    
    @Binding var textFieldText: String
    var body: some View {
        HStack{
            TextField("Search", text: $textFieldText)
                .padding(.leading, 10)
            xButton
            searchButton
        }
        .foregroundColor(Color.theme.white)
        .padding()
        .background(
            Capsule()
                .fill(Color.theme.darkGray)
                .frame(height: 40)
        )
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(vm: dev.serachVM, textFieldText: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}


// MARK: - COMPONENTS

extension SearchBarView{
    private var xButton: some View{
        Button {
            textFieldText = ""
            vm.searchedMovieList = nil
            vm.searchedMovies = []
        } label: {
            Image(systemName: "xmark.circle.fill")
                .opacity(textFieldText.isEmpty ? 0.0 : 1.0)
        }
    }
    
    private var searchButton: some View{
        Button{
            if textFieldText == "" {
                return
            }
            var key = textFieldText.lowercased()
            key = key.replacingOccurrences(of: " ", with: "+")
            vm.searchMovie(key: key)
            
        }label: {
            Image(systemName: "magnifyingglass")

        }
    }
}
