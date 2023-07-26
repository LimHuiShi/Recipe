//
//  Persistence.swift
//  Recipe
//
//  Created by HS on 25/7/23.
//

import CoreData

struct PersistenceController {
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        prepopulateSampleData(viewContext: result.container.viewContext)
        return result
    }()

    static var shared: PersistenceController = {
        let result = PersistenceController(inMemory: false)
        
        // store key value pair
        let userDefaults = UserDefaults.standard

        if userDefaults.value(forKey: "hasPopulated") == nil {
            userDefaults.set(true, forKey: "hasPopulated")
            prepopulateSampleData(viewContext: result.container.viewContext)
        }
        
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Recipe")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    private static func prepopulateSampleData(viewContext: NSManagedObjectContext) {
        // add samplerecipes(from RecipeData) to core data
        for recipe in sampleRecipes {
            let newItem = RecipeEntity(context: viewContext)
            newItem.id = recipe.id
            newItem.timestamp = Date()
            newItem.title = recipe.title
            newItem.type = recipe.type
            newItem.ingredients = recipe.ingredients
            newItem.steps = recipe.steps
            newItem.imageURL = recipe.imageURL
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
