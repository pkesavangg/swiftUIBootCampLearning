//
//  StatePropertyBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 04/11/23.
//

import SwiftUI

struct StatePropertyBootcamp: View {
    @State var count = 0;
    @State var backgroundColor = Color.green
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Count: \(count)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.white)
                
                HStack {
                    Spacer()
                    Button("Button 1") {
                        self.count += 1;
                        self.backgroundColor = .red;
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                    Button("Button 2") {
                        self.count += 1;
                        self.backgroundColor = .purple;
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                }
                
                Button("Reset") {
                    self.count = 0;
                    self.backgroundColor = .green;
                }
                .buttonStyle(.borderedProminent)
                
            }
        }
    }
}

#Preview {
    StatePropertyBootcamp()
}
