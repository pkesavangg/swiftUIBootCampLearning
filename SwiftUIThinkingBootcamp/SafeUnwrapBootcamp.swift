//
//  SafeUnwrapBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 07/11/23.
//

import SwiftUI

struct SafeUnwrapBootcamp: View {
    @State private var title: String? = nil
    var body: some View {
        VStack {
            if let newTitle = title {
                Text(newTitle)
            } else {
                ProgressView()
            }
            Text(title ?? "")
            
            //Do not force unwrap the optional values
            //Text(newTitle!)
        }
        .onAppear {
            guard let titleValue = title else {
                return
            }
            title = "New Title" + titleValue
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                title = "New Title"
            }
        }
    }
}

#Preview {
    SafeUnwrapBootcamp()
}
