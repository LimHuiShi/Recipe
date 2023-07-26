//
//  SettingView.swift
//  Recipe
//
//  Created by HS on 26/7/23.
//

import SwiftUI
import FirebaseAuth

struct SettingView: View {
    var body: some View {
        NavigationView {
            
            VStack(){
                
                Text("Setting")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 30)
                
                LogoView()
                
                Spacer()
                
                // logout button
                Button(action: {
                    logout()
                }) { Text("Log out")
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.brown) // Brown button color
                        .cornerRadius(10)
                        .padding(.horizontal, 50)
                }
            }
            .background(Color("Beige"))
        }
    }
}

private func logout() {
    try! Auth.auth().signOut()
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
