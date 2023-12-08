//
//  ForEachBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 04/11/23.
//

import SwiftUI

struct ForEachBootcamp: View {
    var data: [String] = ["Hi" , "Hiii"]
    
    var body: some View {
        ForEach(data.indices) { index in
            Text( "\(data[index]) \(index) ")
        }
        
        
    }
}

#Preview {
    ForEachBootcamp()
}
