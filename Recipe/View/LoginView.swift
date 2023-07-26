//
//  LoginView.swift
//  Recipe
//
//  Created by HS on 26/7/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State var showAlert: AlertDialogState? = nil
    
    var body: some View {
        NavigationView {
            ZStack() {
                Color("Beige") // Beige background color
                
                VStack(spacing: 30) {
                    
                    Text("Welcome Back!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    LogoView()
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 50)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 50)
                    
                    Button(action: {
                        // Perform login action
                        login()
                    }) {
                        Text("Log in")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.brown) // Brown button color
                            .cornerRadius(10)
                            .padding(.horizontal, 50)
                    }
                }
                .foregroundColor(.black)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func login() {
        // Check if username, password, and email are valid
        if password.isEmpty || email.isEmpty {
            // Show an error message
            showAlert = AlertDialogState(title: NSLocalizedString("Incomplete form", comment: ""), message: NSLocalizedString("Please fill in all fields.", comment: ""), primaryButton: .default(Text("OK")))
        } else {
            // Proceed with login
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    // Show an error message
                    showAlert = AlertDialogState(title: NSLocalizedString("Login failed", comment: ""), message: NSLocalizedString("Something went wrong, please check your email and/or password.", comment: ""), primaryButton: .default(Text("OK")))
                }
            }
        }
        
        // Clear the text fields
        password = ""
        email = ""
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

