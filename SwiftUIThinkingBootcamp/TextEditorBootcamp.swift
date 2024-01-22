//
//  TextEditorBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 05/11/23.
//

import SwiftUI

struct TextEditorBootcamp: View {
    @State private var textEditorValue = "ssssss"
    init() {
        UITextView.appearance().textContainerInset =
                 UIEdgeInsets(top: 10, left: 12, bottom: 0, right: 12)   // << !!
    }
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $textEditorValue)
                    .frame(height: 200)
                    .colorMultiply(Color.gray)
                    .cornerRadius(20)
                    .padding()
                
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Save")
                       
                })
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .padding()
                Spacer()
                
                Text(textEditorValue)
            }
        }
    }
}

#Preview {
    TextEditorBootcamp()
}
