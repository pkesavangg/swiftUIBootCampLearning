//
//  ImageBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 30/10/23.
//

import SwiftUI

struct ImageBootcamp: View {
    var body: some View {
        Image("google-icon")
            .renderingMode(.original)
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)
            .clipShape(
                // Circle()
                RoundedRectangle(cornerRadius: 20)
            )
    }
}

#Preview {
    ImageBootcamp()
}
