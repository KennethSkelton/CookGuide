//
//  RecipeInformationView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/30/21.
//

import SwiftUI

struct RecipeInformationView: View {
    
    var recipe = RecipeObject()
    
    var body: some View {
        VStack{
            HStack{
                Text(recipe.recipeName)
                NavigationLink(destination: EditRecipeView(recipe: recipe)){
                    Text("Edit")
                }
            }
            Spacer()
            Text("Ingredients")
            List(){
                ForEach(0..<localdb.ingredients.count, id: \.self){
                    idx in
                    if(localdb.ingredients[idx].recipeID == recipe.recipeID){
                        Text(localdb.ingredients[idx].ingredient)
                        
                    }
                }
            }
            Spacer()
            Text("Instructions")
            List(){
                ForEach(0..<localdb.instructions.count, id: \.self){
                    idx in
                    if(localdb.instructions[idx].recipeID == recipe.recipeID){
                        Text(localdb.instructions[idx].instruction)
                        
                    }
                }
                
            }
        }
    }
}

struct RecipeInformationView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeInformationView()
    }
}
