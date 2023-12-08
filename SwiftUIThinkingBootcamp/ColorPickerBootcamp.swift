//
//  ColorPickerBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 05/11/23.
//

import SwiftUI

struct ColorPickerBootcamp: View {
    @State private var backgroundColor: Color = .green
    var body: some View {
        ZStack(content: {
            backgroundColor
                .ignoresSafeArea()
            VStack {
                ColorPicker("Select a color:",
                            selection: $backgroundColor,
                            supportsOpacity: true)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .font(.title2)
                    .padding()
            }
        })
    }
}

#Preview {
    ColorPickerBootcamp()
}
