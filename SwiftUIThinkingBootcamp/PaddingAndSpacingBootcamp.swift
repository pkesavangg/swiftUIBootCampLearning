//
//  PaddingAndSpacingBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 02/11/23.
//

import SwiftUI

struct PaddingAndSpacingBootcamp: View {
    var body: some View {
        VStack(alignment: .leading, content: {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(.semibold)
                .padding(.bottom)
            Text("PaddingAndSpacingBootcamp.swift SwiftUIThinkingBootcamp Created by Kesavan Panchabakesan on 02/11/23.")
        })
        .padding()
        .padding(.vertical, 10)
        .background(
            Color.white
                .cornerRadius(10)
                .shadow(
                    color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.3), 
                    radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/,
                    x: 5,
                    y:5)
        
        )
        .padding()
        
    }
}

#Preview {
    PaddingAndSpacingBootcamp()
}
