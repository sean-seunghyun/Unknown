//
//  SearchBarView.swift
//  Unknown
//
//  Created by sean on 2022/09/28.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var textFieldText: String
    var handleSearchButton: () -> ()
    var handleXButton:() -> ()
    
    
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
        SearchBarView(textFieldText: .constant(""), handleSearchButton: {}, handleXButton: {})
            .previewLayout(.sizeThatFits)
    }
}


// MARK: - COMPONENTS

extension SearchBarView{
    private var xButton: some View{
        Button {
            self.handleXButton()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .opacity(textFieldText.isEmpty ? 0.0 : 1.0)
        }
    }
    
    private var searchButton: some View{
        Button{
            self.handleSearchButton()
        }label: {
            Image(systemName: "magnifyingglass")

        }
    }
}
