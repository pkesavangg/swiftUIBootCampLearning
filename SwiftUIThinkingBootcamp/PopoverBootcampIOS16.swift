//
//  PopoverBootcampIOS16.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 11/11/23.
//

import SwiftUI

struct PopoverBootcampIOS16: View {
    @State private var showPopver = false
    var body: some View {
        
        
        Text("Show Popover")
            .onTapGesture {
                self.showPopver = true
            }
            .popover(isPresented: $showPopver, attachmentAnchor: .point(.bottom) ,  content: {
                Button("button") {
                    
                }
            })
           // .presentationCompactAdaptation(.popover) // For iOS 16.4
    }
}

#Preview {
    PopoverBootcampIOS16()
}
