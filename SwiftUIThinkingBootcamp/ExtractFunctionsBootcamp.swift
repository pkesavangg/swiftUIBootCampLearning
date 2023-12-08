//
//  ExtractFunctionsBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 04/11/23.
//

import SwiftUI

struct ExtractFunctionsBootcamp: View {
    @State var backgroundColor = Color.red
    var body: some View {
        
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            contents
        }
        
        
    }
    
    var contents: some View {
        VStack {
           Text("Title")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
            
            Button(action: {
                buttonPressed()
            }, label: {
                Text("Press me")
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
            })
            
            
        }
    }
    
    func buttonPressed() {
        self.backgroundColor = .green
    }
}

#Preview {
    ExtractFunctionsBootcamp()
}
