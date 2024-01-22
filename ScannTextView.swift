//
//  ScannTextView.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 02/01/24.
//

import SwiftUI

struct ScannTextView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ScanTextButton(title: .constant("title")) {
        
    }
}


class ScanTextResponder: UIResponder, UIKeyInput {
  var hasText: Bool = false
  @Binding var title: String
  init(title: Binding<String>, action: @escaping (() -> Void)) {
    _title = title
    self.action = action
  }
  var action: (() -> Void)
  func insertText(_ text: String) {
    title = text
    hasText = true
    action()
  }
  func deleteBackward() {}
}
struct ScanTextButton: View {
  private let action: (() -> Void)
  private var responder: ScanTextResponder
  init(title: Binding<String>, action: @escaping (() -> Void)) {
    self.responder = ScanTextResponder(title: title, action: action)
    self.action = action
  }
  var body: some View {
    Button("Scan", systemImage: "text.viewfinder") {
      responder.title = ""
      responder.captureTextFromCamera(self)
    }
  }
}
