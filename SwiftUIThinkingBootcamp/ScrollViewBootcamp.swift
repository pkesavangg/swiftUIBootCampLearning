//
//  ScrollView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 04/11/23.
//

import SwiftUI

struct ScrollViewBootcamp: View {
    var body: some View {
        ScrollView(showsIndicators: false, content: {
            LazyVStack {
                ForEach(0..<20) { index in
                    ScrollView(.horizontal,showsIndicators: false, content: {
                        LazyHStack {
                            ForEach(0..<20) { index in
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .fill(Color.white)
                                    .frame(width: 200, height: 200)
                                    .shadow(radius: 10)
                                    .padding()
                            }
                        }
                    })
                }
            }
        })
        .padding(.vertical)
    }
}

#Preview {
    ScrollViewBootcamp()
}
