//
//  ToolbarBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 11/11/23.
//

import SwiftUI

struct ToolbarBootcamp: View {
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false, content: {
                VStack {
                    ForEach(0..<10) { index in
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.purple)
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                        
                    }
                }
               
                .navigationTitle("Numbers")
//                .toolbar{
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button(action: {
//                            
//                        }, label: {
//                            Image(systemName: "heart.fill")
//                                .foregroundColor(.red)
//                        })
//                    }
//                    
//                    ToolbarItem(placement: .bottomBar) {
//                        HStack {
//                            Spacer()
//                            Button(action: {
//                                
//                            }, label: {
//                                Image(systemName: "heart.fill")
//                                    .foregroundColor(.red)
//                            })
//                        }
//
//                    }
//                }
                //.toolbarBackground(.hidden, for: .navigationBar) //FOR iOS 16
            })
            .safeAreaInset(edge: .bottom, spacing: nil, content: {
                VStack(content: {
                    
                    Text("Hii")
                         .foregroundColor(.white)
                         .padding()
                })

                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(Color.red)
            })
        }
    }
}

#Preview {
    ToolbarBootcamp()
}
