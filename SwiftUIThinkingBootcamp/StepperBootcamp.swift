//
//  StepperBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 06/11/23.
//

import SwiftUI

struct StepperBootcamp: View {
    
    @State private var stepperValue = 10
    @State private var widthValue = 0
    var body: some View {
        Text("\(stepperValue)")
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/ + CGFloat(widthValue), height: 200)
            .background(Color.red)
        Stepper("Stepper", value: $stepperValue)
            .padding()
        
        
        
        Stepper("Stepper") {
            withAnimation {
                widthValue += 10
            }
        } onDecrement: {
            withAnimation {
                widthValue -= 10
            }
        }

        
    }
}

#Preview {
    StepperBootcamp()
}
