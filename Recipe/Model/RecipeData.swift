//
//  RecipeData.swift
//  Recipe
//
//  Created by HS on 25/7/23.
//

import Foundation

struct RecipeData : Identifiable {
    let id: String
    var title: String
    var type: String
    var ingredients: String
    var steps: String
    var imageURL: String
}

extension RecipeData {
    static func fromEntity(entity: RecipeEntity) -> RecipeData {
        return RecipeData(id: entity.id! ,title: entity.title!, type: entity.type!, ingredients: entity.ingredients!, steps: entity.steps!, imageURL: entity.imageURL!)
    }
}

var sampleRecipes: [RecipeData] = [
    RecipeData(id: UUID().uuidString,
               title: "Pancakes",
               type: "Breakfast",
               ingredients: "Flour, Milk, Eggs, Sugar",
               steps: "1. Mix ingredients \n2. Cook on a griddle",
               imageURL:"https://recipegirl.com/wp-content/uploads/2007/07/Buttermilk-Pancakes-1.jpg"),
    
    RecipeData(id: UUID().uuidString,
               title: "Spaghetti Bolognese",
               type: "Dinner",
               ingredients: "Spaghetti, Ground Beef, Tomato Sauce, Onion, Garlic",
               steps: "1. Cook spaghetti. \n2. Brown beef and onion. \n3. Add sauce and simmer",
               imageURL: "https://www.slimmingeats.com/blog/wp-content/uploads/2010/04/spaghetti-bolognese-36-720x720.jpg"),
    
    RecipeData(id: UUID().uuidString,
               title: "Avocado and Tomato Salad",
               type: "Lunch",
               ingredients: "2 ripe avocados, diced, 1 cup cherry tomatoes, halved, 1/4 red onion, thinly sliced, 2 tablespoons fresh cilantro, chopped, 2 tablespoons lime juice, 1 tablespoon olive oil, salt and pepper",
               steps: "Step 1: In a large bowl, combine the diced avocados, cherry tomatoes, and red onion. \n Step 2: In a small bowl, whisk together the lime juice, olive oil, salt, and pepper. \n Step 3: Pour the dressing over the avocado mixture and gently toss to coat. \n Step 4: Sprinkle fresh cilantro on top and serve immediately.",
               imageURL:"https://www.budgetbytes.com/wp-content/uploads/2022/08/Avocado-Tomato-Salad-above.jpg"),
    
    RecipeData(id: UUID().uuidString,
               title: "Chocolate Banana Smoothie",
               type: "Dessert",
               ingredients: "2 ripe bananas, 1 cup milk, 2 tablespoons cocoa powder, 1 tablespoon honey, 1/2 teaspoon vanilla extract, Ice cubes (optional)",
               steps: " Step 1: Peel and slice the bananas. \n Step 2: In a blender, combine the sliced bananas, milk, cocoa powder, honey or maple syrup, and vanilla extract. \n Step 3: Blend until smooth and creamy. If you prefer a thicker smoothie, add some ice cubes and blend again. \n Step 4: Pour the chocolate banana smoothie into glasses and enjoy!",
               imageURL: "https://celebratingsweets.com/wp-content/uploads/2014/04/Chocolate-Peanut-Butter-Banana-Smoothie-2.jpg"),
    // Add more sample recipes here
]

