//
//  AlertBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 05/11/23.
//

import SwiftUI

struct AlertBootcamp: View {
    @State private var showAlert = false
    @State private var backgroundColor = Color.green
    var body: some View {
        
        ZStack(content: {
            backgroundColor
                .ignoresSafeArea()
            VStack{
                Button("Show Alert") {
                    showAlert = true
                }
//                .alert(isPresented: $showAlert, content: {
//                    Alert(title: Text("Alert Title"),
//                          message: Text("Alert is showing"),
//                          primaryButton: Alert.Button.default(Text("OK"), action: {
//                        backgroundColor = .yellow
//                    }),
//                          
//                          
//                          secondaryButton: .destructive(Text("Delete"), action: {
//                        backgroundColor = .white
//                    }))
//                })
                .alert("LocalizedStringKey", isPresented: $showAlert) {
                    Button("button1") {
                        
                    }
                   
                    Button("button1") {
                        
                    }
                    Button("button1") {
                        
                    }
                }
            }
        })
        

    }
}

#Preview {
    AlertBootcamp()
}
