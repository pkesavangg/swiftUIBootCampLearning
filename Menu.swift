//
//  Menu.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 31/12/23.
//

import SwiftUI

struct MenuForEach: View {
    var body: some View {
        VStack {
            ForEach(RecipeField.allCases, id: \.self) { field in
                Button {
//                    selectedField = field
//                    getText()
                } label: {
                    Text(field.rawValue.capitalized)
                }
            }
        }
    }
}

#Preview {
    MenuForEach()
}
