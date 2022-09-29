//
//  RankNumberView.swift
//  Unknown
//
//  Created by sean on 2022/09/28.
//

import SwiftUI


struct RankNumberView: View {
    let number: Int
    
    
    var body: some View{

            
            
            Text("\(number)")
                .font(
                    .custom(
                        "AppleSDGothicNeo-Bold",
                        fixedSize: 90)
                    .weight(.black)
    
                )
                .foregroundColor(Color.white)
                .shadow(color: Color.theme.accent, radius: 2, x: 4, y: 4)
            
   
    }
    
    
    
}

struct RankNumberView_Previews: PreviewProvider {
    static var previews: some View {
        RankNumberView(number: 6)
            .previewLayout(.sizeThatFits)
    }
}
