//
//  ContentView.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//

import SwiftUI

struct ContentView: View {
    @State var tabSelection: Int = 0
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem{
                    
                    Image(systemName: "house")
                    Text("Login")
                    
                }
                .tag(0)
                
            Text("bb")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Hello")
                }
                .tag(1)
            Text("cc")
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("Setting")
                }
                .tag(2)
               
        }
        .accentColor(Color.theme.accent)
        
        .onAppear {
            // 향후 init에서 처리
            UITabBar.appearance().backgroundColor = UIColor(Color.theme.darkGray)
            UITabBar.appearance().unselectedItemTintColor = UIColor(Color.theme.gray)

            
        }
        
        
        
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ContentView()
        }
        
    }
}
