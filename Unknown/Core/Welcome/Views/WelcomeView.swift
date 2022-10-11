//
//  WelcomeView.swift
//  Unknown
//
//  Created by sean on 2022/10/11.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack{
            Color.theme.background.ignoresSafeArea()
            
            VStack{
//                Spacer()
                
                logo
                
//                Spacer()
                
//                login
                
            }
            
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}


extension WelcomeView{
    private var logo: some View{
        VStack {
            Image(systemName: "list.and.film")
                .resizable()
                .foregroundColor(Color.theme.gray)
                .frame(width: 70, height: 40)
                .padding(40)
                .overlay(
                    Circle()
                        .stroke(Color.theme.gray, lineWidth: 5)
            )
            Text("Unknown")
                .foregroundColor(Color.theme.gray)
                .font(.title)
                .bold()
        }
        

    }
    
    
    private var login: some View{
        VStack(spacing: 15) {

            
            RoundedRectangle(cornerRadius: 15)
                .frame(height: 50)
                .overlay(
                    
                    HStack {
                        
                        Image(systemName: "applelogo")
                        
                        Text("Sign in with Apple")

                    }
                        .foregroundColor(Color.theme.white)
                    
                    
                )
            RoundedRectangle(cornerRadius: 15)
                .frame(height: 50)
                .foregroundColor(Color.theme.kakao)
                .overlay(
                    
                    HStack {
                        Image("kakao")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                        Text("Sign in with Kakao")
                    }
                        .foregroundColor(Color.black)
                    
                    
                )
                    
        }
        .padding(.horizontal)
    }
}
