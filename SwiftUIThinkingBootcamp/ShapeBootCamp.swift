//
//  ShapeBootCamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 30/10/23.
//

import SwiftUI

struct ShapeBootCamp: View {
    var body: some View {
        Circle()
            .stroke(Color.red, style: StrokeStyle(lineWidth: 20, lineCap: .square, dash: [40]))
            .frame(width: 200)
    }
}

#Preview {
    ShapeBootCamp()
}
