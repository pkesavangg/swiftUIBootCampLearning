//
//  CustomModelBootcamp.swift
//  SwiftUIThinkingBootcamp
//
//  Created by Kesavan Panchabakesan on 07/11/23.
//

struct UserModel: Identifiable {
    let id: String = UUID().uuidString
    let displayName: String
    let userName: String
    let followersCount: Int
    let isVerified: Bool
}

import SwiftUI

struct CustomModelBootcamp: View {
    
    @State private var users: [UserModel] = [
    UserModel(displayName: "K7", userName: "Kesavan", followersCount: 100, isVerified: true),
    UserModel(displayName: "Mag", userName: "Magesh", followersCount: 230, isVerified: true),
    UserModel(displayName: "Sur", userName: "Suresh", followersCount: 80, isVerified: true),
    UserModel(displayName: "Elan", userName: "Elango", followersCount: 40, isVerified: true)
    
    ]
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            ForEach(users) { user in
                HStack {
                    Text(user.displayName)
                    Text(user.userName)
                    Text("\(user.followersCount)")
                    Text(user.isVerified ? "Verified": "Not Verified")
                }

                
            }
        }
        
    }
}

#Preview {
    CustomModelBootcamp()
}
