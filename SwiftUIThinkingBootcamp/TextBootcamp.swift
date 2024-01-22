//
//  TextBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 30/10/23.
//

import SwiftUI

struct TextBootcamp: View {
    var body: some View {
        Text("Hello, World!".lowercased())
        
            .foregroundColor(.red)
            .font(.largeTitle)
            .font(.system(size: 24, weight: .black))
            .overlay(
                 Rectangle()
                     .stroke(Color.yellow, style: StrokeStyle(lineWidth: 5.0,lineCap: .round, lineJoin: .bevel, dash: [60, 15], dashPhase: 29))
             )
        
    }
}

#Preview {
    TextBootcamp()
}
