//
//  InitializerBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 04/11/23.
//

import SwiftUI

enum Fruits {
    case apple
    case orange
}

struct InitializerBootcamp: View {
    let title: String
    var backgroundColor: Color
    var count: Int
    init(fruit: Fruits, count: Int) {
        self.count = count
        if fruit == .apple {
            self.backgroundColor = .red
            self.title = "Apples"
        } else {
            self.backgroundColor = .orange
            self.title = "Apples"
        }
    }
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
            Text("\(count)")
        }
        .foregroundColor(.white)
        .frame(width: 100, height: 100)
        .background(backgroundColor)
        .cornerRadius(10)
    }
}

#Preview {
    HStack{
        InitializerBootcamp(fruit: .apple, count: 5)
        InitializerBootcamp(fruit: .orange, count: 3)
    }
}
