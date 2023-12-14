//
//  AlertBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 05/11/23.
//

import SwiftUI

//struct AlertBootcamp: View {
//    @State private var showAlert = false
//    @State private var backgroundColor = Color.green
//    @State private var password = ""
//    var body: some View {
//        
//        ZStack(content: {
//            backgroundColor
//                .ignoresSafeArea()
//            VStack{
//                Button("Show Alert") {
//                    showAlert = true
//                }
//                //                .alert(isPresented: $showAlert, content: {
//                //                    Alert(title: Text("Alert Title"),
//                //                          message: Text("Alert is showing"),
//                //                          primaryButton: Alert.Button.default(Text("OK"), action: {
//                //                        backgroundColor = .yellow
//                //                    }),
//                //
//                //
//                //                          secondaryButton: .destructive(Text("Delete"), action: {
//                //                        backgroundColor = .white
//                //                    }))
//                //                })
//                .alert("Enter your name", isPresented: $showAlert) {
//                    SecureField("******", text: $password)
//                    Button("OK", action: {})
//                    Button("Forgot Password?", action: {})
//                } message: {
//                    Text("Xcode will print whatever you type.")
//                }
//            }
//        })
//        
//        
//    }
//}

#Preview {
    AlertBootcamp()
}


import SwiftUI

import SwiftUI

struct AlertBootcamp: View {
    @State private var showAlert = false
    @State private var password = ""
    @State private var isPasswordVisible = false

    var body: some View {
        Button("Show Alert") {
            showAlert.toggle()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Enter your password"),
                message: Text("Xcode will print whatever you type."),
                primaryButton: .default(Text("OK")) {
                    // Handle OK button action
                },
                secondaryButton: .default(Text("Forgot Password?")) {
                    // Handle Forgot Password button action
                }
            )
        }
    }
}


