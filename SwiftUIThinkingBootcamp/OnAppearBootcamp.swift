//
//  OnAppearBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 07/11/23.
//

import SwiftUI

struct OnAppearBootcamp: View {
    
    @State private var count = 0
    @State private var title = "Title"
    var body: some View {
        NavigationView {
            ScrollView {
                Text(title)
                LazyVStack(spacing: 20) {
                    ForEach(0..<50) { _ in
                        Rectangle()
                            .frame(width: 200, height: 100)
                            .cornerRadius(10)
                            .onAppear {
                                count += 1
                            }
                            .onDisappear {
                                //count -= 1
                            }
                    }
                }
                
            }
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    title = "Second Title"
                }
            })
            .onDisappear(perform: {
                title = ""
            })
            .navigationTitle("Navigation Title: \(count)")
        }
    }
}

#Preview {
    OnAppearBootcamp()
}
