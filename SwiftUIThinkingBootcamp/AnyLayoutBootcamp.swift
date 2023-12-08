//
//  AnyLayoutBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 11/11/23.
//

import SwiftUI

struct AnyLayoutBootcamp: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    var body: some View {
        VStack {
            Text("Horizontal: \(horizontalSizeClass.debugDescription)")
            Text("Vertical: \(verticalSizeClass.debugDescription)")
//            
//            let layout: AnyLayout = horizontalSizeClass === .compact ?  AnyLayout(VStackLayout()) : AnyLayout(HStackLayout())
            
            
            VStack {
                Text("Alpha")
                Text("Beta")
                Text("Gamma")
            }
            
            Button("testing") {
                
            }
            .padding(.top)

//            if horizontalSizeClass === .compact {
//                
//            }
            
            
        }
    }
}

#Preview {
    AnyLayoutBootcamp()
}
