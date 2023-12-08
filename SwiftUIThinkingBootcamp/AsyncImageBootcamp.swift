//
//  AsyncImageBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 10/11/23.
//

import SwiftUI

struct AsyncImageBootcamp: View {
    let url = URL(string: "https://picsum.photos/600")
    var body: some View {
//        AsyncImage(url: url) { image in
//            image
//                .resizable()
//                .ignoresSafeArea()
//        } placeholder: {
//            ProgressView()
//        }
        
        AsyncImage(url: url) { phase in
            
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .ignoresSafeArea()
                               
            case .failure(_):
                Image(systemName: "questionmark")
                    .font(.headline)
            default:
                Image(systemName: "questionmark")
                    .font(.headline)
            }
            
        }

    }
}

#Preview {
    AsyncImageBootcamp()
}
