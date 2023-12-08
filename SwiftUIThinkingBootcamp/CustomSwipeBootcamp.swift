//
//  CustomSwipeBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 10/11/23.
//

import SwiftUI

struct CustomSwipeBootcamp: View {
    @State private var fruits = ["Apple", "Orange", "Peach"]
    var body: some View {
        List {
            ForEach(fruits, id: \.self ) { fruit in
                Text(fruit)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button("Save") {
                            
                        }
                        .tint(.green)
                        Button("Delete") {
                            
                        }
                        .tint(.red)
                        Button("Share") {
                            
                        }
                        .tint(.yellow)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button("Save") {
                            
                        }
                        .tint(.green)
                        Button("Delete") {
                            
                        }
                        .tint(.red)
                        Button("Share") {
                            
                        }
                        .tint(.yellow)
                    }
            }
        }
    }
}

#Preview {
    CustomSwipeBootcamp()
}
