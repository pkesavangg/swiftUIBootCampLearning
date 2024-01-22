//
//  TimersHighlightView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 18/01/24.
//

import SwiftUI

struct TimersHighlightView: View {
    let recipeSteps = "While potatoes are boiling, heat oil in a large skillet. Cook ground beef with onion, red pepper, and garlic until beef is evenly brown. Stir in beef broth, ketchup, soy sauce, Worcestershire sauce, and curry powder. Bring to a boil, and simmer 3 to 4 minutes. Mix cornstarch with a little water to form a paste, then stir into skillet with tomatoes, peas and carrots. Cook until thickened; 1 minute season with salt and pepper. Spoon into a casserole dish."
        
    let highlightTerms = ["3 to 4 minutes", "1 minute"]

        var body: some View {
            VStack(spacing: 0) {
                HStack(alignment: .top) {
                    Text("1.")
                        .padding(.top, 6)
                    TextView(text: recipeSteps, highlightTerms: highlightTerms)
                        .baselineOffset(4)

                }
                HStack(alignment: .top) {
                    Text("1.")
                    TextView(text: recipeSteps, highlightTerms: highlightTerms)
                }
                HStack(alignment: .top) {
                    Text("1.")
                    TextView(text: recipeSteps, highlightTerms: highlightTerms)
                }
                HStack(alignment: .top) {
                    Text("1.")
                    TextView(text: recipeSteps, highlightTerms: highlightTerms)
                }
                Spacer()
            }
        }
}

#Preview {
    TimersHighlightView()
}

struct TextView: UIViewRepresentable {
    var text: String
    var highlightTerms: [String]

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        let attributedString = NSMutableAttributedString(string: text)

        for term in highlightTerms {
            let range = (text as NSString).range(of: term)
            attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: range)
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: uiView.font?.pointSize ?? 14.0), range: range)

        }
       
        uiView.attributedText = attributedString
        uiView.font = UIFont.systemFont(ofSize: 14)
    }
}
