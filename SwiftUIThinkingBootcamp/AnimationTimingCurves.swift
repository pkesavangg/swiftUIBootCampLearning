//
//  AnimationTimingCurves.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 04/11/23.
//

import SwiftUI

struct AnimationTimingCurves: View {
    @State private var isAnimated = false
    var body: some View {
        VStack {
            Button("Button") {
                self.isAnimated.toggle()
            }
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: isAnimated ? 100 : 300, height: 100)
                .animation(.spring())
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: isAnimated ? 100 : 300, height: 100)
                .animation(Animation.default)
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: isAnimated ? 100 : 300, height: 100)
                .animation(Animation.easeIn)
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: isAnimated ? 100 : 300, height: 100)
                .animation(Animation.easeInOut)
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: isAnimated ? 100 : 300, height: 100)
                .animation(Animation.easeOut)
        }
        
    }
}

#Preview {
    AnimationTimingCurves()
}
