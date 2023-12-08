//
//  TransistionBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 04/11/23.
//

import SwiftUI
//
//struct TransistionBootcamp: View {
//    @State private var showModal = false;
//    var body: some View {
//        ZStack(alignment: .bottom, content: {
//            
//            VStack {
//                Button("Show Modal") {
//                    withAnimation {
//                        self.showModal.toggle()
//                    }
//                   
//                }
//                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                Spacer()
//            }
//            if showModal {
//                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
//                    .fill(Color.blue)
//                    .frame(height: UIScreen.main.bounds.height * 0.5)
//                   // .transition(.slide.animation(.easeInOut(duration: 1)))
////                    .transition(.asymmetric(
////                        insertion: .move(edge: .bottom),
////                        removal: AnyTransition.animation(.easeIn)))
//                    .transition(.move(edge: .bottom))
//                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
//                  //  .animation(.easeInOut)
//                
//            }
//            
//        })
//        .edgesIgnoringSafeArea(.bottom)
//    }
//}

struct TransistionBootcamp: View {
    @State private var showModal = false
    
    var body: some View {
        ZStack(alignment: .bottom, content: {
            VStack {
                Button("Show Modal") {
                    withAnimation {
                        self.showModal.toggle()
                    }
                }
                .foregroundColor(.blue)
                Spacer()
            }
            
            if showModal {
                // Use a background tap gesture to close the modal
                Color.white.opacity(0.3)
                    .onTapGesture {
                        withAnimation {
                            self.showModal.toggle()
                        }
                    }
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .frame(height: UIScreen.main.bounds.height * 0.5)
                    .transition(.move(edge: .bottom))
                    .shadow(radius: 10)
                    .onTapGesture {
                        // Add this to prevent tapping inside the modal from closing it
                    }
                    .contentShape(Rectangle()) // Ensures that taps outside the RoundedRectangle also trigger the onTapGesture
            }
        })
        .edgesIgnoringSafeArea(.bottom)
    }
}


#Preview {
    TransistionBootcamp()
}
