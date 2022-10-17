//
//  LaunchViewModel.swift
//  Unknown
//
//  Created by sean on 2022/10/17.
//

import Foundation

class LaunchViewModel: ObservableObject{
    
    
    let loadingString:[String] = "Loading...".map({String($0)})
    let timer = Timer.publish(every: 0.1 , on: .main, in: .common).autoconnect()
    @Published var count: Int = 0
    @Published var loop: Int = 0
    @Published var showLoadingText: Bool = false
    
    
}
