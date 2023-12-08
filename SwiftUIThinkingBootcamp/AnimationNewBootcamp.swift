//
//  AnimationNewBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 11/11/23.
//

import SwiftUI

struct AnimationNewBootcamp: View {
    @State private var animation1 = false
    @State private var animation2 = false
    var body: some View {
        NavigationView {
            VStack {
                Button("Action 1") {
                    animation1.toggle()
                }
                Button("Action 2") {
                    animation2.toggle()
                }
                VStack {
                    ZStack {
                        Color.white
                            .ignoresSafeArea()
                        VStack {
                            Rectangle()
                                .fill(Color.purple)
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                                .cornerRadius(20)
                                .frame(maxWidth: .infinity, alignment: animation1 ? .leading : .trailing)
                                .frame(maxHeight: .infinity, alignment: animation2 ? .top : .bottom)
                                .ignoresSafeArea()
                        }
                    }
                }
            }
            .animation(.smooth, value: animation1)
            .animation(.spring(), value: animation2)
        }
    }
}

#Preview {
    AnimationNewBootcamp()
}
