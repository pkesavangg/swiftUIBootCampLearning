//
//  SliderBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 06/11/23.
//

import SwiftUI

struct SliderBootcamp: View {
    @State private var sliderValue = 3.0
    @State private var color: Color = .red
    var body: some View {
        VStack {
            Text(String(format: "%.2f", sliderValue))
            Slider(value: $sliderValue,
                   in: 1...5, step: 1)
            .accentColor(.red)
        }
    }
}

#Preview {
    SliderBootcamp()
}
