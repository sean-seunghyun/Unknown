//
//  LaunchView.swift
//  Unknown
//
//  Created by sean on 2022/10/11.
//

import SwiftUI

struct LaunchView: View {
    
    @Binding var showLaunchView: Bool
    let loadingString:[String] = "Loading...".map({String($0)})
    let timer = Timer.publish(every: 0.1 , on: .main, in: .common).autoconnect()
    @State var count: Int = 0
    @State var loop: Int = 0
    @State var showLoadingText: Bool = false
    
    
    var body: some View {
        ZStack{
            Color.theme.background.ignoresSafeArea()
            logo
            ZStack{
                if showLoadingText{
                    HStack(spacing: 0.5){
                        ForEach(loadingString.indices, id: \.self) { index in
                            Text(loadingString[index])
                                .foregroundColor(Color.theme.white)
                                .font(.headline)
                                .bold()
                                .offset(y: count == index ? -5 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeInOut))

                }

            }
            .offset(y: 150)
        }
        .onAppear(perform: {
            showLoadingText = true
        })
        .onReceive(timer) { _ in

                 //count와 관련한 애니메이션
                    withAnimation(.spring()){
                        if count > loadingString.count{
                            count = 0
                            loop += 1
                            
                            if loop == 2{
                                showLaunchView.toggle()
                            }
                        }else{
                            count += 1
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
