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
    @State var showLaunchView:Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
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
                                Text("Bookmark")
                            }
                            .tag(2)
                            .navigationTitle("")
                            .navigationBarHidden(true)

                    }
                    .accentColor(Color.theme.accent)
                    .onAppear {
                        UITabBar.appearance().backgroundColor = UIColor(Color.theme.darkGray)
                        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.theme.gray)
                        UINavigationBar.appearance().tintColor = UIColor(Color.theme.white)
                        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.white)]
                }
                    
                }
                .environmentObject(HomeViewModel.instance)
                
                
                ZStack{
                    if showLaunchView{
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(AnyTransition.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
            
        }
    }
}
