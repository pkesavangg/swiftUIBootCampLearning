//
//  NavigationStackBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 09/12/23.
//

import SwiftUI

struct NavigationStackBootcamp: View {
    let fruits = ["Apple", "Banana"]
    @State private var stackPath: [String] = []
    var body: some View {
        NavigationStack(path: $stackPath) {
            ScrollView {
                VStack(spacing: 40){
                    
                    Button("Super Segue!") {
                        stackPath.append(contentsOf: ["Coconut", "Mango"])
                    }
                    
                    ForEach(fruits, id: \.self) { fruit in
                        NavigationLink(value: fruit) {
                            Text("Click Me: \(fruit)")
                        }
                    }
                    
                    ForEach(0..<10) { x in
                        NavigationLink(value: x) {
                            Text("Click Me: \(x)")
                        }
                    }
                }
                .navigationTitle("Main Screen")
                .navigationDestination(for: Int.self) { value in
                    Text("Value is: \(value)")
                }
                .navigationDestination(for: String.self) { value in
                    Text("Value is: \(value)")
                }
            }

        }
        
    }
}

#Preview {
    NavigationStackBootcamp()
}
