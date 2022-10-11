//
//  UnknownApp.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//

import SwiftUI

@main
struct UnknownApp: App {
    @State private var tabSelection = 0
   
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                TabView(selection: $tabSelection) {
                    HomeView(tabSelection: $tabSelection)
                        .tabItem{
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .tag(0)
                        .navigationTitle("")
                        .navigationBarHidden(true)
                       
                    SearchView(tabSelection: $tabSelection)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                        .tag(1)
                        .navigationTitle("")
                        .navigationBarHidden(true)
                    
                    BookmarkView(tabSelection: $tabSelection)
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
                
            }
            .environmentObject(HomeViewModel.instance)
        }
    }
}
