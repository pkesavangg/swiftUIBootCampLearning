//
//  SheetBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 04/11/23.
//

import SwiftUI

struct SheetBootcamp: View {
    @State private var isSheetOpen = false
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack {
                Button("Present view") {
                    isSheetOpen = true
                }
                .foregroundColor(.white)
            }
            
            // To show the view to full screen
            .fullScreenCover(isPresented: $isSheetOpen, content: {
                SecondView()
            })
            
//            .sheet(isPresented: $isSheetOpen, content: {
//                // Do not add if condition to toggle the views use another .sheet modifier
//                SecondView()
//            })
            
        }
    }
}


struct SecondView : View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack(content: {
            Color.red
                .ignoresSafeArea()
            VStack{
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
                
            }
        })
    }
}

#Preview {
    SheetBootcamp()
}
