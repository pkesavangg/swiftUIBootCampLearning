//
//  BackgroundAndOverlayBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 02/11/23.
//

import SwiftUI

struct BackgroundAndOverlayBootcamp: View {
    var body: some View {
        Image(systemName: "heart.fill")
            .font(.system(size: 40))
            .foregroundColor (Color.white)
            .background(
                Circle()
                    .fill(Color.red)
                    .frame(width: 100, height: 100)
                    .shadow(color: Color(.red), radius: 10, x: 0.0, y: 10)
                    
            )
            .frame(width: 100, height: 100)
            .overlay(
                Circle()
                    .fill(Color.blue)
                    .frame(width: 35, height: 35)
                    .overlay(
                        Text("5")
                            .font(.headline)
                            .foregroundColor(.white)
                            .shadow(color: Color(.blue), radius: 10, x: 5, y: 5)
                           )
                , alignment: .bottomTrailing)
    }
}
#Preview {
    BackgroundAndOverlayBootcamp()
}



