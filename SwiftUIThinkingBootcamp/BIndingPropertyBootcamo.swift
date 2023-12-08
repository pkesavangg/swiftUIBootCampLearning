//
//  BIndingPropertyBootcamo.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 04/11/23.
//

import SwiftUI

struct BIndingPropertyBootcamo: View {
    @State var backgroundColor: Color = .green
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                VStack {
                    MyNewItem(title: "Title", count: 2, backgroundColor: $backgroundColor)
                }
            }
        }
        
        
    }
}

#Preview {
    BIndingPropertyBootcamo()
}


struct MyNewItem: View {
    let title: String;
    let count: Int;
   @Binding var backgroundColor: Color
    @State var buttonColor: Color = .yellow
    var body: some View {
        VStack(content: {
            Button("Button") {
                backgroundColor = .red
                buttonColor = .pink
            }
            .padding()
            .padding(.horizontal)
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .foregroundColor(.white)
            .background(buttonColor)
            .cornerRadius(15)
        })
    }
}
