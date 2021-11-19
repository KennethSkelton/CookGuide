//
//  RecipeInformationView.swift
//  CookGuide
//
//  Created by Kenneth Skelton on 9/30/21.
//

import SwiftUI

struct RecipeInformationView: View {
    
    @State var recipe = RecipeObject()
    @State var ingredients = [IngredientObject]()
    @State var instructions = [InstructionObject]()
    
    @State var instructionTimerStrings = [String]()
    
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
                ForEach(0..<ingredients.count, id: \.self){
                    idx in
                    TextEditor(text: $ingredients[idx].ingredient)
                }
            }
            Spacer()
            Text("Instructions")
            List(){
                ForEach(0..<instructions.count, id: \.self){
                    idx in
                    HStack{
                        TextEditor(text: $instructions[idx].instruction)
                        TextEditor(text: $instructionTimerStrings[idx])
                    }
                }
                
            }
            Button(
                action: {
                    
                    
                
            },
                label: {
                    Text("Save")
            })
            Button(action: {}, label: {})
        }
        .background(primaryColor).ignoresSafeArea()
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct RecipeInformationView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeInformationView()
    }
}
