//
//  TapGestureBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 07/11/23.
//

import SwiftUI

struct TapGestureBootcamp: View {
    @State private var color: Color = .blue
    var body: some View {
        VStack {
            
            Rectangle()
                .fill(color)
                .frame(width: 200, height: 200)
                .cornerRadius(15)
            
            
            Button(action: {
                color = .green
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    
            })
            
            Text("Tap gesture")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal, 20)
                .onTapGesture(count: 2) {
                    color = .green
                }
        }
    }
}

#Preview {
    TapGestureBootcamp()
}
