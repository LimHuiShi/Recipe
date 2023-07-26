//
//  ContentView.swift
//  Recipe
//
//  Created by HS on 25/7/23.
//

import SwiftUI
import CoreData
import XMLCoder

private let ALL = "All"

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \RecipeEntity.timestamp, ascending: true)],
        animation: .default)
    private var recipes: FetchedResults<RecipeEntity>
    
    @State private var recipeTypes:[String] = []
    @State private var selectedRecipeType:String = ALL
    
    // MARK: sheets
    @State private var showAddRecipe: Bool = false
    @State private var showEditRecipe: RecipeData? = nil //Showing single recipe...
    @State private var showSetting: Bool = false
    
    var body: some View {
        NavigationView {
            
            VStack {
                Picker("Select recipe type", selection: $selectedRecipeType) {
                    ForEach([ALL] + recipeTypes, id: \.self) { type in
                        Text(type)
                    }
                }
                
                let comparisonSymbol = computeComparisonSymbol(selectedRecipeType: selectedRecipeType)
                FetchedObjects(
                    predicate: NSPredicate(format: "type \(comparisonSymbol) %@", selectedRecipeType),
                    sortDescriptors: [
                        NSSortDescriptor(keyPath: \RecipeEntity.timestamp, ascending: true)
                    ])
                { (filteredRecipeEntities: [RecipeEntity]) in
                    if filteredRecipeEntities.isEmpty {
                        EmptyListView()
                            .toolbar {
                                ToolbarItem {
                                    Button(action: showAddRecipeScreen) {
                                        Label("Add Item", systemImage: "plus")
                                    }
                                }
                            }
                    } else {
                        List {
                            ForEach(filteredRecipeEntities) { recipeEntity in
                                NavigationLink {
                                    EditRecipeView(recipe: RecipeData.fromEntity(entity: recipeEntity), recipeTypes: recipeTypes, editRecipe: editRecipe, deleteRecipe: deleteItem
                                    )
                                } label: {
                                    Text(recipeEntity.title!)
                                }
                                
                            }
                            .onDelete(perform: deleteItems)
                        }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: showSettingScreen) {
                                    Label("Setting", systemImage: "gearshape.fill")
                                }
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                EditButton()
                            }
                            ToolbarItem {
                                Button(action: showAddRecipeScreen) {
                                    Label("Add Item", systemImage: "plus")
                                }
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showAddRecipe, content: {
            AddRecipeView(addRecipe: addRecipe, recipeTypes: recipeTypes)
        })
        .sheet(item: $showEditRecipe) { recipeData in
            EditRecipeView(recipe: recipeData, recipeTypes: recipeTypes, editRecipe: editRecipe, deleteRecipe: deleteItem)
        }
        .sheet(isPresented: $showSetting, content: {
            SettingView()
        })
        .onAppear {
            parseRecipeTypesXML()
        }
    }
    
    func parseRecipeTypesXML() {
        // Get the file URL for your recipetypes.xml
        guard let xmlURL = Bundle.main.url(forResource: "recipetypes", withExtension: "xml") else {
            print("recipetypes.xml not found.")
            return
        }
        
        do {
            // Read the contents of the XML file
            let xmlData = try Data(contentsOf: xmlURL)
            
            // Decode the XML data into your data model
            let decoder = XMLDecoder()
            let recipeTypesData = try decoder.decode(RecipeTypes.self, from: xmlData)
            
            // Access the recipe types
            let xmlRecipeTypes = recipeTypesData.RecipeType
            recipeTypes = xmlRecipeTypes //update recipe type State
        } catch {
            print("Error parsing XML: \(error)")
        }
    }
    
    private func computeComparisonSymbol(selectedRecipeType: String) -> String {
        if selectedRecipeType == ALL {
            return "!="
        } else {
            return "=="
        }
    }
    
    // show the screen
    private func showAddRecipeScreen() {
        showAddRecipe = true
    }
    
    // save the new recipe to core data
    private func addRecipe(recipe: RecipeData) {
        withAnimation {
            let newItem = RecipeEntity(context: viewContext)
            newItem.id = recipe.id
            newItem.title = recipe.title
            newItem.type = recipe.type
            newItem.ingredients = recipe.ingredients
            newItem.steps = recipe.steps
            newItem.imageURL = recipe.imageURL
            newItem.timestamp = Date()
            
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
    
    private func showEditRecipeScreen(recipe: RecipeData) {
        showEditRecipe = recipe
    }
    
    private func editRecipe(recipe: RecipeData) {
        withAnimation {
            let recipeToBeUpdated = recipes.first(where: { recipeEntity in
                recipeEntity.id == recipe.id
            })
            
            recipeToBeUpdated!.title = recipe.title
            recipeToBeUpdated!.type = recipe.type
            recipeToBeUpdated!.ingredients = recipe.ingredients
            recipeToBeUpdated!.steps = recipe.steps
            recipeToBeUpdated!.imageURL = recipe.imageURL
            recipeToBeUpdated!.timestamp = Date()
            
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
    
    // show the Setting screen
    private func showSettingScreen() {
        showSetting = true
    }
    
    private func deleteItem(id: String) {
        withAnimation {
            let recipeToBeDeleted = recipes.first(where: { recipeEntity in
                recipeEntity.id == id
            })
            viewContext.delete(recipeToBeDeleted!)
            
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
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { recipes[$0] }.forEach(viewContext.delete)
            
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
