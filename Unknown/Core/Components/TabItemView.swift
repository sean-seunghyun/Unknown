//
//  Tab.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//

import SwiftUI

struct TabItemView: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 5){
            Text(title)
                .foregroundColor(Color.theme.white)
                .font(.subheadline)
            Rectangle()
                .frame(height: 5)
                .foregroundColor(Color.theme.gray)
                .padding(.horizontal)
                .opacity(isSelected ? 1.0 : 0.0)
        }
        .frame(width: UIScreen.main.bounds.width / 3)
    }
}

struct Tab_Previews: PreviewProvider {
    static var previews: some View {
        TabItemView(title: "Popular", isSelected: true)
            .background(Color.theme.background)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
