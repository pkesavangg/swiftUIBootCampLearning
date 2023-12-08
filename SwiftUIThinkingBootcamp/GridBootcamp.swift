//
//  GridBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 04/11/23.
//

import SwiftUI

struct GridBootcamp: View {
    let columns: [GridItem] =  [GridItem(.adaptive(minimum: 1500, maximum: 200), spacing: nil, alignment: nil),
                                ]
    var body: some View {
        ScrollView {
            Rectangle()
                .fill(Color.white)
                .frame(height: 400)
            //            LazyVGrid(columns: columns) {
            //                ForEach(0..<50) { index in
            //                    Rectangle()
            //                        .frame(height: 150)
            //                }
            //
            //            }
            
            LazyVGrid(columns: columns,
                      pinnedViews: [.sectionHeaders],
                      content: {
                Section(header:
                            Text("Section 1")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.blue)
                ) {
                    ForEach(0..<50) { index in
                        Rectangle()
                            .fill(Color.green)
                            .frame(height: 150)
                            
                    }
                }
                
                Section(header:
                            Text("Section 2")
                    .font(.title)
                    .foregroundColor(.blue)
                ) {
                    ForEach(0..<50) { index in
                        Rectangle()
                            .fill(Color.red)
                            .frame(height: 150)
                            
                    }
                }
                
            })
            
        }
        
    }
    
}

#Preview {
    GridBootcamp()
}


