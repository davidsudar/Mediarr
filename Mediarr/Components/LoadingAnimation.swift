//
//  LoadingAnimation.swift
//  Mediarr v2
//
//  Created by David Sudar on 17/6/2022.
//
import SwiftUI

struct LoadingAnimation: View {
    
    @State private var shouldAnimate = false
    
    var body: some View {
        HStack {
            
            Circle()
                .fill(Color.accentColor)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever(), value: shouldAnimate)
            Circle()
                .fill(Color.accentColor)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3), value: shouldAnimate)
            Circle()
                .fill(Color.accentColor)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6), value: shouldAnimate)
        }
        .background(.clear)
        .onAppear {
            DispatchQueue.main.async {
            self.shouldAnimate = true
            }
        }
    }
    
}
