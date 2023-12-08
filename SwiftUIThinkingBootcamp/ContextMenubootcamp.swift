//
//  ContextMenubootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 05/11/23.
//

import SwiftUI

struct ContextMenubootcamp: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack(content: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray)
                    .frame(width: 300, height: 200)
                    .overlay {
                        VStack {
                            HStack{
                                Image(systemName: "person.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                Text("Kesavan")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding(.leading)
                            Spacer()
                        }
                        .padding(.top)
                    }
            })
            .contextMenu(menuItems: {
                Button("Share", action: {})
                Button("Repost", action: {})
                Button("like", action: {})
            })
        }
        
    }
}

#Preview {
    ContextMenubootcamp()
}
