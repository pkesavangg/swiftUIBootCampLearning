//
//  DarkModeBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 07/11/23.
//

import SwiftUI

struct DarkModeBootcamp: View {
    
    @Environment(\.colorScheme) private var colorScheme
    var body: some View {
        
        VStack {
            Text("This is a Primary Color")
                .foregroundColor(.primary)
            Text("This is a Secondary Color")
                .foregroundColor(.secondary)
            Text("This is a White Color")
                .foregroundColor(.white)
            Text("This is a Black Color")
                .foregroundColor(.black)
            
            Text("This is a Custom Color")
                .foregroundColor(Color("custom-color"))
            
            Text("This is a Color Scheme color")
                .foregroundColor(colorScheme == .light ? .yellow : .purple)
        }
        
    }
}

#Preview {
    Group {
        DarkModeBootcamp()
    }
    
}
