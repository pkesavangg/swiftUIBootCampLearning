//
//  AnimationBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 04/11/23.
//

import SwiftUI

struct AnimationBootcamp: View {
    @State private var isAnimated: Bool = false
    var body: some View {
        VStack {
            Button("Toggle value") {
                withAnimation {
                    self.isAnimated.toggle()
                }
                
            }
            .padding()
            .padding(.horizontal)
            .background(Color.red)
            .cornerRadius(10)
            .foregroundColor(.white)
            
            Spacer()
            RoundedRectangle(cornerRadius: isAnimated ?  50 : 10)
                .fill(isAnimated ? Color.red : Color.blue)
                .frame(width: isAnimated ? 100: 300,
                       height: isAnimated ? 100: 300)
                .rotationEffect(Angle(degrees: isAnimated ? 360: 0))
                .offset(y: isAnimated ? 300 : 0)
                //.animation(Animation.default.repeatForever())
                .animation(Animation.default.repeatCount(2))
            Spacer()
        }
        
    }
}

#Preview {
    AnimationBootcamp()
}
