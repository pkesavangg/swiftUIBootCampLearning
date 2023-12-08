//
//  ButtonStyleBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 10/11/23.
//

import SwiftUI

struct ButtonStyleBootcamp: View {
    @State private var buttonText = "Button"
    var body: some View {
        VStack {
            Button(action: {
                buttonText = "Save Button"
            }, label: {
                Text(buttonText)
//                    .frame(height: 55)
//                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            })
            .buttonStyle(.borderedProminent)
//            .buttonStyle(.automatic)
//            .buttonStyle(.borderless)
//            .buttonStyle(.bordered)
//            .buttonStyle(.plain)
            .controlSize(.large)
//            .controlSize(/*@START_MENU_TOKEN@*/.regular/*@END_MENU_TOKEN@*/)
//            .controlSize(.mini)
//            .controlSize(.small)
            
//            .buttonBorderShape(.capsule)
            .buttonBorderShape(.roundedRectangle(radius: 20))

        }
        .padding()
    }
}

#Preview {
    ButtonStyleBootcamp()
}
