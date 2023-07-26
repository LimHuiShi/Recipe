//
//  EditRecipeView.swift
//  Recipe
//
//  Created by HS on 26/7/23.
//

import SwiftUI

struct EditRecipeView: View {
    @Environment(\.dismiss) var dismiss
    
    let editRecipe: (RecipeData) -> Void
    let deleteRecipe: (String) -> Void
    
    let recipeTypes: [String]
    @State var showAlert: AlertDialogState? = nil
    
    let recipeID: String
    @State private var recipeTitle = ""
    @State private var selectedRecipeType: String = ""
    @State private var recipeIngredients = ""
    @State private var recipeSteps = ""
    @State private var recipeImageURL = ""
    
    init(
        recipe: RecipeData,
        recipeTypes: [String],
        editRecipe: @escaping (RecipeData) -> Void,
        deleteRecipe: @escaping (String) -> Void
    ) {
        recipeID = recipe.id
        _recipeTitle = State(initialValue: recipe.title)
        _selectedRecipeType = State(initialValue: recipe.type)
        _recipeIngredients = State(initialValue: recipe.ingredients)
        _recipeSteps = State(initialValue: recipe.steps)
        _recipeImageURL = State(initialValue: recipe.imageURL)
        self.recipeTypes = recipeTypes
        self.editRecipe = editRecipe
        self.deleteRecipe = deleteRecipe
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Title")) {
                    TextField("Enter recipe title", text: $recipeTitle)
                }
                
                Section(header: Text("Image")) {
                    TextField("Enter a URL of image", text: $recipeImageURL)
                }
                
                Section(header: Text("Image Preview")) {
                    if recipeImageURL.isEmpty{
                        Text("Please enter a image url")
                            .foregroundColor(.gray)
                    }
                    else if let url = URL(string: recipeImageURL) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: 400)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        } placeholder: {
                            Color.white
                        }
                    }
                    else {
                        Text("Invalid URL")
                            .foregroundColor(.red)
                    }
                }
                
                Section(header: Text("Recipe Type")) {
                    Picker("Select recipe type", selection: $selectedRecipeType) {
                        ForEach(["(Select)"] + recipeTypes, id: \.self) { type in
                            Text(type)
                        }
                    }
                }
                
                Section(header: Text("Ingredients")) {
                    TextField("Enter recipe ingredients", text: $recipeIngredients)
                }
                
                Section(header: Text("Steps")) {
                    TextEditor(text: $recipeSteps)
                        .multilineTextAlignment(.leading)
                }
                
                Button(action: {
                    if recipeTitle.isEmpty || selectedRecipeType.isEmpty {
                        showAlert = AlertDialogState(title: NSLocalizedString("Incomplete recipe", comment: ""), message: NSLocalizedString("Title or Recipe Types is missing.", comment: ""), primaryButton: .default(Text("OK")))
                    } else {
                        editRecipe(RecipeData(id: recipeID, title: recipeTitle, type: selectedRecipeType, ingredients: recipeIngredients, steps: recipeSteps, imageURL: recipeImageURL))
                        dismiss()
                    }
                }) {
                    Text("Save").bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(20)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        deleteRecipe(recipeID)
                        dismiss()
                    } label: {
                        Label("Delete", systemImage: "trash.fill")
                            .foregroundColor(Color.pink)
                    }
                }
            }
            .alert(item: $showAlert) { alert in
                if let secondaryButton = alert.secondaryButton {
                    return Alert(title: Text(alert.title), message: Text(alert.message), primaryButton: alert.primaryButton, secondaryButton: secondaryButton)
                } else {
                    return Alert(title: Text(alert.title), message: Text(alert.message), dismissButton: alert.primaryButton)
                }
            }
        }
    }
}

struct EditRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        EditRecipeView(recipe: sampleRecipes[0], recipeTypes: ["Lunch", "Soup"], editRecipe: { _ in }, deleteRecipe: { _ in })
    }
}

