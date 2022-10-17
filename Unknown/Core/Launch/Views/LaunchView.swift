//
//  LaunchView.swift
//  Unknown
//
//  Created by sean on 2022/10/11.
//

import SwiftUI

struct LaunchView: View {
    
    @Binding var showLaunchView: Bool
    @StateObject var vm = LaunchViewModel()
    
    
    var body: some View {
        ZStack{
            Color.theme.background.ignoresSafeArea()
            logo
            ZStack{
                if vm.showLoadingText{
                    HStack(spacing: 0.5){
                        ForEach(vm.loadingString.indices, id: \.self) { index in
                            Text(vm.loadingString[index])
                                .foregroundColor(Color.theme.white)
                                .font(.headline)
                                .bold()
                                .offset(y: vm.count == index ? -5 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeInOut))

                }

            }
            .offset(y: 150)
        }
        .onAppear(perform: {
            vm.showLoadingText = true
        })
        .onReceive(vm.timer) { _ in

                 //count와 관련한 애니메이션
                    withAnimation(.spring()){
                        if vm.count > vm.loadingString.count{
                            vm.count = 0
                            vm.loop += 1
                            
                            if vm.loop == 2{
                                showLaunchView.toggle()
                            }
                        }else{
                            vm.count += 1
                        }
                        
                    }
                }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}


extension LaunchView{
    private var logo: some View{
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 300, height: 300)
        }
        
    }
    
}
