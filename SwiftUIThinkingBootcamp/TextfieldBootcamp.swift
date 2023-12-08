//
//  TextfieldBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 05/11/23.
//

import SwiftUI

struct TextfieldBootcamp: View {
    @State private var textfieldValue = ""
    @State private var data = ["Hello"]
    var body: some View {
        NavigationView(content: {
            VStack(content: {
                VStack(spacing: 20, content: {
                    
                    TextField("Type something here", text: $textfieldValue)
                        .padding()
                        .background(Color.gray.opacity(0.34))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                    
                    Button(action: {
                        data.append(textfieldValue)
                        textfieldValue = ""
                    }, label: {
                        Text("Save".uppercased())
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(textfieldValue.count < 3 ? Color.gray : Color.blue)
                            .cornerRadius(10)
                    })
                    .disabled(textfieldValue.count < 3)
                    
                })
                .padding()
                List{
                    
                    Section(header: Text("Inserted values".capitalized)
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                    ) {
                        ForEach(data, id: \.self) { value in
                            Text(value)
                        }
                    }
                    
                   
                }
            })
            
            
            

            .navigationTitle("Text field learning")
        })
    }
}

#Preview {
    TextfieldBootcamp()
}
