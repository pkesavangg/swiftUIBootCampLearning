//
//  PopoverBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 04/11/23.
//

import SwiftUI

struct PopoverBootcamp: View {
    @State private var showPopover = false
    var body: some View {
        ZStack(content: {
            Color.red
                .ignoresSafeArea()
            
            VStack {
                Button("Show popover") {
                    showPopover = true
                }
            }
//            .sheet(isPresented: $showPopover, content: {
//                SecondPopoverView()
//            })
            
            // We have better control on screen
//            ZStack {
//                if showPopover {
//                    SecondPopoverView(showPopover: $showPopover)
//                        .padding(.top, 100)
//                        .transition(.move(edge: .bottom))
//                        .animation(.spring())
//                }
//            }
//            .zIndex(2)
            
//            SecondPopoverView(showPopover: $showPopover)
//                .padding(.top, 100)
//                .offset(y: showPopover ? 0 : UIScreen.main.bounds.height)
//                .animation(.spring())
            
        })
    }
}

struct SecondPopoverView: View {
    @Environment(\.presentationMode) private var presentationMode;
    @Binding public var showPopover: Bool
    var body: some View {
        ZStack(content: {
            Color.blue
                .ignoresSafeArea()
            VStack {
                Button(action: {
                    //presentationMode.wrappedValue.dismiss()
                    showPopover.toggle()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.largeTitle)
                    
                })
                .foregroundColor(.white)
            }
        })
        
    }
}

#Preview {
    PopoverBootcamp()
}
