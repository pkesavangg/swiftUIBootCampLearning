//
//  ActinViewButton.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 16/06/24.
//

import SwiftUI

struct ActionMenuButtonView: View {
    @State private var showOptions = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button(action: {
                withAnimation {
                    showOptions.toggle()
                }
            }) {
                Image(systemName: !showOptions ? "ellipsis.circle" : "ellipsis.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.black)
            }
            .overlay {
                if showOptions {
                    VStack(alignment: .leading, spacing: 0) {
                        Group {
                            Text("Nutrition Label")
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.brown.opacity(0.5))
                                .foregroundColor(.black)
                                .background(Color.white.shadow(radius: 5))
                                .cornerRadius(5)
                                .onTapGesture {
                                    print("Nutrition Label")
                                    withAnimation {
                                        showOptions = false
                                    }
                                }
                            
                            Divider()
                            Text("My Food Log")
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.brown.opacity(0.5))
                                .foregroundColor(.black)
                                .background(Color.white.shadow(radius: 5))
                                .cornerRadius(5)
                                .onTapGesture {
                                    print("My Food Log")
                                    withAnimation {
                                        showOptions = false
                                    }
                                }
                        }
                        .background(Color.brown.opacity(0.5))
                        .frame(width: 300)

                    }
                    .cornerRadius(10)
                    .offset(x: -140, y: 75)
                }
            }
            
        }
    }
}

struct MainListViews: View {
    var body: some View {
        VStack {
            HStack {
                Text("Session History")
                Spacer()
                ActionMenuButtonView()
            }
            .padding(.horizontal)
        }

    }
}

#Preview(body: {
    MainListViews()
})


str
