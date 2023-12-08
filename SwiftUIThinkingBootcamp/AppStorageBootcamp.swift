//
//  AppStorageBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 10/11/23.
//

import SwiftUI

struct AppStorageBootcamp: View {
    //@State var userName: String? = nil
    
    @AppStorage("name") var userName: String?
    var body: some View {
        
        VStack(spacing: 30) {
                Text(userName ?? "")
            
            if let name = userName {
                Text(name)
            }
            
            Button("Save") {
                userName = "Emily"
//                UserDefaults.standard.setValue(userName, forKey: "user_name")
            }
        }
        .font(.largeTitle)
        .onAppear{
              //  UserDefaults.standard.string(forKey: "user_name")
         }
    }
}

#Preview {
    AppStorageBootcamp()
}
