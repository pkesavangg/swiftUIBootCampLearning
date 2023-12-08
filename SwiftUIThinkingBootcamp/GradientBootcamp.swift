//
//  GradientBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 30/10/23.
//

import SwiftUI

struct GradientBootcamp: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(
//                LinearGradient(
//                    gradient: Gradient(colors: [Color.red, Color.green, Color.blue]),
//                    startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/,
//                    endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                
                
//                RadialGradient(
//                    gradient: Gradient(colors: [Color.red, Color.green, Color.blue]),
//                    center: .center,
//                    startRadius: 0, endRadius: 100)
                
                AngularGradient.init(
                    gradient: Gradient(colors: [Color.red, Color.blue]),
                    center: .topLeading,
                    angle: .degrees(180))
            )
            .frame(width: 300, height: 200)
    }
}

#Preview {
    GradientBootcamp()
}
