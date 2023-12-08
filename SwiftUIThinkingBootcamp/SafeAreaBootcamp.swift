//
//  SafeAreaBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 04/11/23.
//

import SwiftUI

struct SafeAreaBootcamp: View {
    var body: some View {
        ScrollView(showsIndicators: false, content: {
            VStack {
                Text("Title")
                    .foregroundColor(.white)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                ForEach(0..<10) { index in
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 100)
                }
            }
            .padding()
        })
        .background(
            Color.red
                .ignoresSafeArea()
        )
    }
}

#Preview {
    SafeAreaBootcamp()
}
