//
//  RecipeApp.swift
//  Recipe
//
//  Created by HS on 25/7/23.
//

import SwiftUI
import FirebaseCore

@main
struct RecipeApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        FirebaseApp.configure() // initialize firebase
    }

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
