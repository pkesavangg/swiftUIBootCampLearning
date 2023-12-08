//
//  SearchableModifierBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 20/11/23.
//

import SwiftUI

struct SearchableModifierBootcamp: View {
    @State private var searchValue = ""
    
    init() {
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)

        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.gray

                UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
    }
    var body: some View {
        NavigationView {
            
            VStack {
                Text("Search value: \(searchValue)")
                    .searchable(text: $searchValue)
            }
               
        }

        
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    SearchableModifierBootcamp()
}
