//
//  TextBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 30/10/23.
//

import SwiftUI

struct TextBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/.lowercased())
            .foregroundColor(.red)
            .font(.largeTitle)
            .font(.system(size: 24, weight: .black))
        
    }
}

#Preview {
    TextBootcamp()
}
