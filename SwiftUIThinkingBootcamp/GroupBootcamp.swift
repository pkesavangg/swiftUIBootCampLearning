//
//  GroupBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 11/11/23.
//

import SwiftUI

struct GroupBootcamp: View {
    var body: some View {
        VStack(spacing: 30, content: {
            Text("Hello World!")
            Text("Hello World!")
            Text("Hello World!")
            Group {
                Text("Hello World!")
                Text("Hello World!")
            }
            .foregroundColor(.green)
            .font(.caption)
        })
        .foregroundColor(.red)
        .font(.largeTitle)
    }
}

#Preview {
    GroupBootcamp()
}
