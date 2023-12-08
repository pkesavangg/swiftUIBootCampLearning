//
//  SystemMaterialsBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 10/11/23.
//

import SwiftUI

struct SystemMaterialsBootcamp: View {
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 60, height: 5)
                    .padding()
                Spacer()
            }
            .frame(height: 350)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .cornerRadius(30)
            .overlay {
                PoppopView()
            }
        }
        .ignoresSafeArea()
        .background(
            Image("google-icon")
                .resizable()
                .ignoresSafeArea()
        )
        
    }
}

struct PoppopView: View {
    var body: some View {
        Text("Hello World!")
            .frame(height: 50)
            .frame(maxWidth: 200)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal, 60)
    }
}

#Preview {
    SystemMaterialsBootcamp()
}
