//
//  loading.swift
//  IntercorpTest
//

import Foundation
import SwiftUI

enum TimerMode {
    case running
    case paused
    case initial
}

class TimerManager: ObservableObject {
    @Published var timerMode: TimerMode = .initial
    @Published var secondsLeft = 15
    
    @Published var timer  = Timer()
    
    func start() {
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if self.secondsLeft == 0 {
                self.timerMode = .initial
                self.secondsLeft = 15
                timer.invalidate()
            } else {
                self.secondsLeft -= 1
            }
        })
    }
}

struct AnimationShape: View {
    
    @State var scale: CGFloat = 1
    @State var opacity: Double = 0
    
    var body: some View {
        ZStack {
            ZStack {
                Color.gray
            }
            .clipped()
            .ignoresSafeArea(.all)
            .opacity(0.9)
            
            Circle()
                .frame(width: 70, height: 70)
                .foregroundColor(.blue)
                .scaleEffect(scale)
                .opacity(opacity)
                .blur(radius: 1.5)
                .onAppear{
                    let baseAnimate = Animation.easeInOut(duration: 1)
                    let repeated = baseAnimate.repeatForever(autoreverses: true)
                    
                    withAnimation(repeated) {
                        scale = 2.9
                        opacity = 0.5
                    }
                }
            
            Circle()
                .frame(width: 70,
                       height: 70,
                       alignment: .center)
                .foregroundColor(.blue)
            
            
            VStack {
                Text("IntercorpTest")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.top, 60)
                
                Text("Un momento por favor..")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
            }.frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .top
            )
            
    
        }
        
    }
}

struct AnimationShape_Previews: PreviewProvider {
    static var previews: some View {
        AnimationShape()
    }
}

