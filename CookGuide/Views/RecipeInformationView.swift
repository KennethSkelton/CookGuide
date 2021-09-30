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
                ForEach(0..<recipe.ingredients.count, id: \.self){
                    idx in
                    Text(recipe.ingredients[idx].ingredient)
                }
            }
            Spacer()
            Text("Instructions")
            List(){
                ForEach(0..<recipe.instructions.count, id: \.self){
                    idx in
                    HStack{
                        Text(recipe.instructions[idx].instruction)
                        Text("timer: \(recipe.instructions[idx].timerDuration)")
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
