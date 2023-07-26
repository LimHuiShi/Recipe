//
//  SplashView.swift
//  Recipe
//
//  Created by HS on 26/7/23.
//

import SwiftUI
import FirebaseAuth

struct SplashView: View {
    
    @State private var state: SplashState = .loading
    
    var body: some View {
        Group {
            switch state {
            case .loading:
                ZStack {
                    Color("Beige")
                    LogoView()
                }
                .edgesIgnoringSafeArea(.all)
            case .home:
                HomeView()
            case .login:
                LoginView()
            }
        }.onAppear {
            checkLoginState()
        }
    }
    
    private func checkLoginState() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                state = .login
            } else {
                state = .home
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

enum SplashState {
    case loading, home, login
}
