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
//                SearchView()
                HomeView()
                .navigationBarHidden(true)
            }
            .environmentObject(HomeViewModel.instance)
        }
    }
}
