//
//  UnknownApp.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//

import SwiftUI

@main
struct UnknownApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                TabView {
                    HomeView()
                        .tabItem{
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .tag(0)
                        .navigationTitle("")
                        .navigationBarHidden(true)
                       
                    SearchView()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                        .tag(1)
                        .navigationTitle("")
                        .navigationBarHidden(true)
                    
                    Text("cc")
                        .tabItem {
                            Image(systemName: "bookmark")
                            Text("Setting")
                        }
                        .tag(2)
                        .navigationTitle("")
                        .navigationBarHidden(true)

                }
                .accentColor(Color.theme.accent)
                .onAppear {
                    // 향후 init에서 처리
                    UITabBar.appearance().backgroundColor = UIColor(Color.theme.darkGray)
                    UITabBar.appearance().unselectedItemTintColor = UIColor(Color.theme.gray)
                    
                 
            }
                
//                .navigationBarHidden(true)
            }
            .environmentObject(HomeViewModel.instance)
        }
    }
}
