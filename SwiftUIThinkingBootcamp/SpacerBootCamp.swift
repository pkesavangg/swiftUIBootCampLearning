//
//  SpacerBootCamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 02/11/23.
//

import SwiftUI

struct SpacerBootCamp: View {
    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(Color.red)
                .frame(width: 50,height: 50)
            
            /*
             * Min length property behaviour when make them value 0
             **/
            
            Spacer(minLength: 0)
                .frame(height: 10)
                .background(Color.red)
            
            Rectangle()
                .fill(Color.gray)
                .frame(width: 50,height: 50)
            
            Rectangle()
                .fill(Color.blue)
                .frame(width: 50,height: 50)
            
            Rectangle()
                .fill(Color.green)
                .frame(width: 50,height: 50)
            
            /*
             * Min length property behaviour
             **/
            
            Spacer()
                .frame(height: 10)
                .background(Color.red)
            
            Rectangle()
                .fill(Color.yellow)
                .frame(width: 50,height: 50)
        }
        .padding(.horizontal, 200)
        .background(Color.purple)
        
    }
}

#Preview {
    SpacerBootCamp()
}
