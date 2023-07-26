//
//  AddRecipeView.swift
//  Recipe
//
//  Created by HS on 25/7/23.
//

import SwiftUI

struct AddRecipeView: View {
    @Environment(\.dismiss) var dismiss
    
    let addRecipe: (RecipeData) -> Void
    let recipeTypes: [String]
    @State var showAlert: AlertDialogState?
    
    @State private var recipeTitle = ""
    @State private var selectedRecipeType: String = ""
    @State private var recipeIngredients = ""
    @State private var recipeSteps = ""
    @State private var recipeImageURL = ""
    
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
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel").bold()
                            .frame(width: 70, height: 35)
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if recipeTitle.isEmpty || recipeTypes.isEmpty {
                            showAlert = AlertDialogState(title: NSLocalizedString("Incomplete recipe", comment: ""), message: NSLocalizedString("Please fill in all fields.", comment: ""), primaryButton: .default(Text("OK")))
                        } else {
                            addRecipe(RecipeData(id: UUID().uuidString, title: recipeTitle, type: selectedRecipeType, ingredients: recipeIngredients, steps: recipeSteps, imageURL: recipeImageURL))
                            dismiss()
                        }
                    } label: {
                        Text("Save").bold()
                            .frame(width: 70, height: 35)
                            .foregroundColor(Color.white)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
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

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView(addRecipe: { recipe in }, recipeTypes: ["Lunch", "Soup"]) // pass in a closure that did nth
    }
}
