//
//  AddRecipeView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 10/1/21.
//

import SwiftUI



struct AddRecipeView: View {
   
    @State var recipeName = ""
    @State var linkIsActive = false
    @State var recipe = RecipeObject()
    
    
    var body: some View {
            VStack{
                HStack{
                    Text("Recipe Name")
                    TextField(
                        "name",
                        text: $recipeName

                    )
                }
                NavigationLink(destination: AddIngredientView(recipe: recipe), isActive: $linkIsActive){
                    Button(action: {
                        recipe = RecipeObject(recipeName: recipeName, userID: app.currentUser?.id ?? "None")
                        linkIsActive = true
                    },
                        label: {Text("Submit")
                        
                    })
                }
                        
            }
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
