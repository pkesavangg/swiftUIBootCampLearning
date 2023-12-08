//
//  StacksBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 02/11/23.
//

import SwiftUI

struct StacksBootcamp: View {
    var body: some View {
        VStack(spacing: 30, content: {
            ZStack(content: {
                Circle()
                    .frame(width: 50, height: 50)
                Text("1")
                    .foregroundColor(.white)
            })
            
            Text("1")
                .foregroundColor(.white)
                .background(
                    Circle()
                        .frame(width: 50, height: 50)
                    
                )
            
            HStack{
                ZStack{
                    Circle()
                        .frame(width: 50, height: 50)
                    Text("1")
                        .foregroundColor(.white)
                }

                
                ZStack{
                    Circle()
                        .frame(width: 50, height: 50)
                    Text("1")
                        .foregroundColor(.white)
                }
            }
            
        })
    }
}

#Preview {
    StacksBootcamp()
}
